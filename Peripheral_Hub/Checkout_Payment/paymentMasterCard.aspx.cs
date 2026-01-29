using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce_ASP.Net.Checkout_Payment
{
    public partial class paymentMasterCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                LoadPaymentDetails();

                string script = @"
            var cCvvI = document.getElementById('" + txtCVV.ClientID + @"');
            var cFontB = document.querySelector('.front');
            var cBackB = document.querySelector('.back');

            if (cCvvI) {
                cCvvI.onmouseenter = function () {
                    cFontB.style.transform = 'perspective(1000px) rotateY(-180deg)';
                    cBackB.style.transform = 'perspective(1000px) rotateY(0deg)';
                };

                cCvvI.onmouseleave = function () {
                    cFontB.style.transform = 'perspective(1000px) rotateY(0deg)';
                    cBackB.style.transform = 'perspective(1000px) rotateY(180deg)';
                };

                cCvvI.oninput = function () {
                    var cCvvB = document.querySelector('.cvv-box');
                    if (cCvvB) {
                        cCvvB.innerText = cCvvI.value;
                    }
                };
            }

            var cNumberI = document.getElementById('" + txtCardNo.ClientID + @"');
            var cNumberB = document.querySelector('.card-number-box');
            cNumberI.oninput = () => {
                cNumberB.innerText = cNumberI.value;
            }

            var cHolderI = document.getElementById('" + txtCardName.ClientID + @"');
            var cHolderB = document.querySelector('.card-holder-name');
            cHolderI.oninput = () => {
                cHolderB.innerText = cHolderI.value;
            }

            var cMonthI = document.getElementById('" + ddlMonth.ClientID + @"');
            var cMonthB = document.querySelector('.exp-month');

            cMonthI.oninput = () => {
                cMonthB.innerText = cMonthI.value + "" /"";
            }

            var cYearI = document.getElementById('" + ddlYear.ClientID + @"');
            var cYearB = document.querySelector('.exp-year');

            cYearI.oninput = () => {
                cYearB.innerText = cYearI.value;
            }
        ";

                Page.ClientScript.RegisterStartupScript(this.GetType(), "CardInteraction", script, true);


            }
        }

        private void LoadPaymentDetails()
        {
            int userId = GetUserID();
            decimal grandTotal = GetGrandTotalFromCart(userId);
            decimal tax = CalculateTax(grandTotal);
            decimal deliveryCharges = 5.00m; // Static delivery charge
            decimal finalTotal = grandTotal + tax + deliveryCharges;

            // Update labels
            LblItemCount.Text = GetCartItemCount(userId).ToString();
            LblGrandTotal.Text = $"RM {grandTotal:F2}";
            LblTax.Text = $"RM {tax:F2}";
            LblDeliveryCharges.Text = $"RM {deliveryCharges:F2}";
            LblTotal.Text = $"RM {finalTotal:F2}";
        }

        private int GetCartItemCount(int userId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = @"
                    SELECT COUNT(*)
                    FROM CART_ITEM ci
                    INNER JOIN CART c ON ci.CartID = c.CartID
                    WHERE c.UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private decimal GetGrandTotalFromCart(int userId)
        {
            decimal grandTotal = 0;

            string query = @"
        SELECT SUM(ci.Quantity * pv.Price) AS GrandTotal
        FROM CART_ITEM ci
        INNER JOIN PRODUCT_VARIANTS pv ON ci.VariantID = pv.VariantID
        INNER JOIN CART c ON ci.CartID = c.CartID
        WHERE c.UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                conn.Open();

                object result = cmd.ExecuteScalar();
                grandTotal = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            }

            return grandTotal;
        }

        private decimal CalculateTax(decimal grandTotal)
        {
            return grandTotal * 0.06m; // Calculate tax as 6% of the GrandTotal
        }

        protected void contBtn_Click(object sender, EventArgs e)
        {
            try
            {
                int orderId = Convert.ToInt32(Request.QueryString["orderID"]);
                decimal totalAmount = GetOrderTotal(orderId);

                // Save payment
                SavePayment(orderId, totalAmount);

                // Clear cart after successful payment
                ClearCart();

                // Redirect to an invoice or success page
                Response.Redirect($"~/Checkout_Payment/invoice.aspx?orderID={orderId}");
            }
            catch (Exception ex)
            {
                // Handle payment errors
                Response.Write($"<script>alert('Error during payment: {ex.Message}')</script>");
            }
        }

        private decimal GetOrderTotal(int orderId)
        {
            decimal total = 0;

            string query = @"
        SELECT SUM(od.price * od.quantity) + COALESCE(o.tax, 0) AS TotalAmount
        FROM Orders o
        INNER JOIN ORDER_DETAILS od ON o.OrderID = od.orderID
        WHERE o.OrderID = @OrderID
        GROUP BY o.OrderID, o.tax";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                conn.Open();

                object result = cmd.ExecuteScalar();
                total = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            }

            return total + 5;
        }

        private void SavePayment(int orderId, decimal totalAmount)
        {
            string query = "INSERT INTO PAYMENT (paymentDate, paymentAmount, paymentMethod, orderID) VALUES (@PaymentDate, @PaymentAmount, @PaymentMethod, @OrderID)";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PaymentDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@PaymentAmount", totalAmount);
                    cmd.Parameters.AddWithValue("@PaymentMethod", "MasterCard");
                    cmd.Parameters.AddWithValue("@OrderID", orderId);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ClearCart()
        {
            string query = @"
        DELETE ci
        FROM CART_ITEM ci
        INNER JOIN CART c ON ci.cartID = c.cartID
        WHERE c.userID = @UserID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", GetUserID());
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }


        private int GetUserID()
        {
            // Replace with logic to fetch UserID from Session["Username"]
            string username = Session["Username"].ToString();
            string query = "SELECT userID FROM Users WHERE Username = @Username";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                conn.Open();

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

    }
}
