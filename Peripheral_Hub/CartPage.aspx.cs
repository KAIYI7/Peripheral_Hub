using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce_ASP.Net
{
    public partial class CartPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCartData();
                UpdateGrandTotal();
            }
        }

        private void LoadCartData()
        {
            string username = Session["Username"]?.ToString();
            if (string.IsNullOrEmpty(username))
            {
                Response.Redirect("SignIn.aspx?Error=1");
                return;
            }

            int userId = GetUserIdByUsername(username);
            if (userId == 0)
            {
                LblMsg.Text = "Unable to retrieve user information. Please log in again.";
                return;
            }

            string query = @"
                WITH FirstProductImages AS (
                    SELECT 
                        ProductID, 
                        urlImage, 
                        ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY imageID) AS RowNum
                    FROM PRODUCT_IMAGES
                )
                SELECT 
                    ci.CartItemID,
                    p.ProductName, 
                    fpi.urlImage AS ProductImage, 
                    STRING_AGG(CONCAT(v.VariantOption, ': ', v.VariantValue), ', ') AS Specifications,
                    ci.Quantity,
                    (ci.Quantity * v.Price) AS Subtotal
                FROM CART_ITEM ci
                INNER JOIN CART c ON ci.CartID = c.CartID
                INNER JOIN Products p ON ci.ProductID = p.ProductID
                INNER JOIN PRODUCT_VARIANTS v ON ci.VariantID = v.VariantID
                LEFT JOIN FirstProductImages fpi ON p.ProductID = fpi.ProductID AND fpi.RowNum = 1
                WHERE c.UserID = @UserID
                GROUP BY ci.CartItemID, p.ProductName, fpi.urlImage, ci.Quantity, v.Price";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    if (dt.Rows.Count > 0)
                    {
                        CartGridView.DataSource = dt;
                        CartGridView.DataBind();

                        //// Calculate Grand total
                        //decimal grandTotal = 0;
                        //foreach (DataRow row in dt.Rows)
                        //{
                        //    grandTotal += Convert.ToDecimal(row["Subtotal"]);
                        //}

                        //LblGrandTotal.Text = $"Grand Total: RM {grandTotal:0.00}";
                    }
                    else
                    {
                        LblMsg.Text = "Your cart is empty.";

                    }
                }
            }
            catch (Exception ex)
            {
                LblMsg.Text = "An error occurred while loading the cart: " + ex.Message;
            }
        }

        protected void CartGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            if (e.CommandName == "RemoveItem")
            {
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                HiddenField hiddenCartItemID = (HiddenField)row.FindControl("HiddenCartItemID");
                int cartItemId = Convert.ToInt32(hiddenCartItemID.Value);

                //int cartItemId = Convert.ToInt32(e.CommandArgument);

                string deleteQuery = "DELETE FROM CART_ITEM WHERE CartItemID = @CartItemID";

                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(deleteQuery, con))
                {
                    cmd.Parameters.AddWithValue("@CartItemID", cartItemId);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        LblMsg.Text = "SQL Error: " + ex.Message;
                    }
                }

                LoadCartData();
                UpdateGrandTotal();
            }

            if (e.CommandName == "UpdateQuantity")
            {
                //int cartItemId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                TextBox txtQuantity = (TextBox)row.FindControl("TxtQuantity");
                HiddenField hiddenCartItemID = (HiddenField)row.FindControl("HiddenCartItemID");
                int cartItemId = Convert.ToInt32(hiddenCartItemID.Value);

                if (int.TryParse(txtQuantity.Text, out int newQuantity) && newQuantity > 0)
                {
                    string updateQuery = "UPDATE CART_ITEM SET Quantity = @Quantity WHERE CartItemID = @CartItemID";

                    using (SqlConnection con = new SqlConnection(connectionString))
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Quantity", newQuantity);
                        cmd.Parameters.AddWithValue("@CartItemID", cartItemId);

                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException ex)
                        {
                            LblMsg.Text = "SQL Error: " + ex.Message;
                        }
                    }

                    LoadCartData();
                    UpdateGrandTotal();
                    LblMsg.Text = "";
                }
                else
                {
                    LblMsg.Text = "Please enter a valid quantity.";
                }
            }
        }

        private void UpdateGrandTotal()
        {
            decimal grandTotal = 0;

            foreach (GridViewRow row in CartGridView.Rows)
            {
                //decimal subtotal = Convert.ToDecimal(((DataRowView)row.DataItem)["Subtotal"]);
                //grandTotal += subtotal;
                // Find the Subtotal cell or control
                //string subtotalText = row.Cells[4].Text; // Assuming Subtotal is the 5th column
                //if (decimal.TryParse(subtotalText, out decimal subtotal))
                //{
                //    grandTotal += subtotal;
                //}
                HiddenField hiddenSubtotal = (HiddenField)row.FindControl("HiddenSubtotal");
                if (decimal.TryParse(hiddenSubtotal.Value, out decimal subtotal))
                {
                    grandTotal += subtotal;
                }
            }

            LblGrandTotal.Text = $"Grand Total: RM {grandTotal:0.00}";
        }
        private int GetUserIdByUsername(string username)
        {
            int userId = 0;
            string query = "SELECT UserID FROM Users WHERE Username = @Username";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    userId = Convert.ToInt32(result);
                }
            }

            return userId;
        }

        protected void BtnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout_Payment/checkout.aspx");
        }
    }
}