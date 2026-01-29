using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class Site_Clients : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ActiveUsers.Text = "ONLINE USERS " + Application["ActiveUsers"].ToString();
                UpdateCartCount();
            }
        }
        protected void BtnDeconnection_Click(object sender, EventArgs e)
        {
            //Application.Lock();
            //Application["ActiveUsers"] = (int)Application["ActiveUsers"] - 1;
            //Application.UnLock();

            Session.Clear();
            Response.Redirect("SignIn.aspx?Logout=1");
        }

        private void UpdateCartCount()
        {
            // Replace this with the actual UserID retrieval logic
            string username = Session["Username"]?.ToString();
            if (string.IsNullOrEmpty(username))
            {
                return; // User not logged in
            }

            int userId = GetUserIDFromUsername(username);
            if (userId == 0)
            {
                return; // User not found
            }

            string query = @"
                SELECT COUNT(*) 
                FROM CART_ITEM ci
                INNER JOIN CART c ON ci.CartID = c.CartID
                WHERE c.UserID = @UserID";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    try
                    {
                        con.Open();
                        int itemCount = (int)cmd.ExecuteScalar();

                        // Find the cart count span and update it
                        CartItemCount.InnerHtml = itemCount.ToString();
                    }
                    catch (SqlException ex)
                    {
                        // Log the error (for debugging purposes)
                        Console.WriteLine("SQL Error: " + ex.Message);
                    }
                }
            }
        }

        private int GetUserIDFromUsername(string username)
        {
            string query = "SELECT UserID FROM Users WHERE Username = @Username";
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);

                    try
                    {
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToInt32(result) : 0;
                    }
                    catch (SqlException ex)
                    {
                        // Log the error (for debugging purposes)
                        Console.WriteLine("SQL Error: " + ex.Message);
                        return 0;
                    }
                }
            }
        }
    }
}