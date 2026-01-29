using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce_ASP.Net.Checkout_Payment
{
    public partial class checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCheckoutDetails();
            }
        }

        private void LoadCheckoutDetails()
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

        protected void contBtn_Click(object sender, EventArgs e)
        {
            try
            {
                // Create order
                int userId = GetUserID();
                int orderId = CreateOrder(userId);
                AddOrderDetails(orderId);

                // Redirect to Payment.aspx with the OrderID
                Response.Redirect($"~/Checkout_Payment/payment.aspx?orderID={orderId}");
            }
            catch (Exception ex)
            {
                // Handle and log errors
                Response.Write($"<script>alert('Error during checkout: {ex.Message}')</script>");
            }
        }

        private int CreateOrder(int userId)
        {
            int orderId = 0;
            decimal grandTotal = GetGrandTotalFromCart(userId); // Fetch GrandTotal from the cart
            decimal tax = CalculateTax(grandTotal); // Calculate tax

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "INSERT INTO Orders (UserID, OrderDate, tax) OUTPUT INSERTED.OrderID VALUES (@UserID, @OrderDate, @Tax)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Tax", tax);

                    orderId = (int)cmd.ExecuteScalar();
                }
            }

            return orderId;
        }

        private void AddOrderDetails(int orderId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = @"
        INSERT INTO ORDER_DETAILS (orderID, productID, quantity, price, VariantID)
        SELECT @OrderID, ci.productID, ci.quantity, pv.Price, ci.variantID
        FROM CART_ITEM ci
        INNER JOIN PRODUCT_VARIANTS pv ON ci.variantID = pv.VariantID
        INNER JOIN CART c ON ci.cartID = c.cartID
        WHERE c.userID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    cmd.Parameters.AddWithValue("@UserID", GetUserID());
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private int GetUserID()
        {
            string username = Session["Username"].ToString();
            string query = "SELECT userID FROM Users WHERE Username = @Username";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                conn.Open();

                return (int)cmd.ExecuteScalar();
            }
        }

        private decimal CalculateTax(decimal grandTotal)
        {
            return grandTotal * 0.06m; // Calculate tax as 6% of the GrandTotal
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

        protected void rbSameAddress_CheckedChanged(object sender, EventArgs e)
        {
            if (rbSameAddress.Checked)
            {
                // Retrieve account information from the database
                //string username = Session["Username"].ToString(); // Replace with actual session logic
                //AddressDataSource.InsertParameters["Username"].DefaultValue = username;
                DataView dv = (DataView)AddressDataSource.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    DataRowView row = dv[0];

                    billName.Text = row["Name"].ToString();
                    billTelephone.Text = row["Tel"].ToString();
                    billEmail.Text = row["Email"].ToString();
                    billAddress.Text = row["addressLine"].ToString();
                    ExtractAddressDetails(row["addressLine"].ToString());
                    //ddlBillCity.SelectedValue = row["cityName"].ToString();
                    //ddlBillState.SelectedValue = row["stateName"].ToString();
                }
            }
        }

        protected void rbSameBillAddr_CheckedChanged(object sender, EventArgs e)
        {
            deliveryAddressDiv.Visible = !rbSameBillAddr.Checked;

        }

        protected void ExtractPostcode(string address)
        {
            // Regular expression to match a 5-digit number (postcode)
            string pattern = @"\b\d{5}\b";

            // Find the postcode using Regex
            Match match = Regex.Match(address, pattern);

            if (match.Success)
            {
                string postcode = match.Value;
                // Assign the postcode to a TextBox
                billPostcode.Text = postcode;
            }
            else
            {
                // Handle cases where no postcode is found
                billPostcode.Text = "";
            }
        }

        protected void ExtractAddressDetails(string address)
        {
            // Split by the first comma to separate the first part
            string[] parts = address.Split(',');

            // Check if the first part is present
            if (parts.Length > 0)
            {
                string firstPart = parts[0].Trim();

                // Assign the first part to a textbox (assumed to be for door/floor)
                billDoor.Text = firstPart;
            }
            else
            {
                billDoor.Text = "";
            }

            ExtractPostcode(address);

        }

    }
}