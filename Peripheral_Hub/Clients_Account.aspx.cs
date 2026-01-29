using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class Clients_Account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("SignIn.aspx?Error=1");
            }
        }

        protected void ClientsDataSource_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            // Ensure the update was successful
            if (e.AffectedRows > 0)
            {
                // Retrieve updated values
                string username = e.Command.Parameters["@Username"].Value.ToString();
                string newPassword = e.Command.Parameters["@Password"].Value.ToString();

                try
                {
                    // Update password in Membership
                    MembershipUser user = Membership.GetUser(username);
                    if (user != null)
                    {
                        string tempPassword = user.ResetPassword();
                        user.ChangePassword(tempPassword, newPassword);
                    }

                    // Hash the password
                    string hashedPassword = HashPassword(newPassword);

                    // Insert hashed password into your own database table
                    string updateUsersQuery = "UPDATE Users SET Password = @HashedPassword WHERE Username = @Username";
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand(updateUsersQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@HashedPassword", hashedPassword);
                            cmd.Parameters.AddWithValue("@Username", username);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle any exceptions
                    lblMessage.Text = $"Error: {ex.Message}";
                }
            }

            //// Extract username and new password from the DetailsView
            //string username = e.OldValues["Username"]?.ToString();
            //string newPassword = e.NewValues["Password"]?.ToString();

            //if (!string.IsNullOrEmpty(username) && !string.IsNullOrEmpty(newPassword))
            //{
            //    try
            //    {
            //        // Get the user from the Membership system
            //        MembershipUser user = Membership.GetUser(username);

            //        if (user != null)
            //        {
            //            // Reset the password (returns a temporary password)
            //            string tempPassword = user.ResetPassword();

            //            // Set the new password
            //            bool isPasswordChanged = user.ChangePassword(tempPassword, newPassword);

            //            if (isPasswordChanged)
            //            {
            //                // Optionally, show a success message
            //                lblMessage.Text = "Password updated successfully!";
            //            }
            //            else
            //            {
            //                lblMessage.Text = "Failed to update password.";
            //            }
            //        }
            //        else
            //        {
            //            lblMessage.Text = "User not found.";
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        lblMessage.Text = $"Error: {ex.Message}";
            //    }
            //}
            //else
            //{
            //    lblMessage.Text = "Username or password is empty.";
            //}

            //// Cancel automatic update since password is updated manually
            //e.Cancel = true;

            // Rebind DetailsView to show the updated data
            //DetailsView1.DataBind();
        }
        protected string MaskPassword(string password)
        {
            if (!string.IsNullOrEmpty(password))
            {
                return new string('*', password.Length); // Replace each character with an asterisk
            }
            return string.Empty; // Handle null or empty passwords
        }

        protected void btnChangePassword_Click(object sender, EventArgs e) {
            // Get the current user
            string username = Session["Username"].ToString();

            // Get the new password and confirm password
            TextBox newPassword = (TextBox)DetailsView1.FindControl("txtPassword");

            // Hash the new password
            string hashedPassword = HashPassword(newPassword.Text);

        // Update the password in the database
        UpdatePassword(username, hashedPassword);

    }

        protected void btnForgotPassword_Click(object sender, EventArgs e) {
            string tempPassword = "**********"; // This should ideally be randomized.

            // Set the value in the txtOldPassword textbox
            TextBox txtOldPassword = (TextBox)DetailsView1.FindControl("txtOldPassword");
            txtOldPassword.Text = tempPassword;  
        }
        private string HashPassword(string password)
        {
            // Example hash function (consider using a more secure approach like PBKDF2, bcrypt, etc.)
            using (var sha256 = new SHA256Managed())
            {
                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashBytes);  // Store the hash in your database
            }
        }

        private void UpdatePassword(string username, string newPassword)
        {
            // Update the password in your database (example SQL query)
            string query = "UPDATE Users SET Password = @Password WHERE Username = @Username";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Password", newPassword);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

    }
}