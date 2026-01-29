using System;
using System.Collections.Generic;
using System.Data;
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
    public partial class SingUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                //ddlStates.SelectedValue = "";
            }
        }
        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Hash the password before storing
                string hashedPassword = HashPassword(TxtPasswd.Text);

                // Create the user using Membership
                Membership.CreateUser(TxtLogin.Text, TxtPasswd.Text, TxtEmail.Text);

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string sqlQuery = @"
                    INSERT INTO Users (FirstName, LastName, Tel, Username, Password, Email) 
                    VALUES (@FirstName, @LastName, @Tel, @Username, @Password, @Email);

                    DECLARE @UserID INT = SCOPE_IDENTITY();

                    INSERT INTO Address (addressLine, userID, cityID)
                    VALUES (@AddressLine, @UserID, @CityID);
                ";
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand(sqlQuery, conn))
                        {
                            // Add parameters for Users
                            cmd.Parameters.AddWithValue("@FirstName", TxtFirstName.Text);
                            cmd.Parameters.AddWithValue("@LastName", TxtLastName.Text);
                            cmd.Parameters.AddWithValue("@Tel", TxtTele.Text);
                            cmd.Parameters.AddWithValue("@Username", TxtLogin.Text);
                            cmd.Parameters.AddWithValue("@Password", hashedPassword);
                            cmd.Parameters.AddWithValue("@Email", TxtEmail.Text);

                            // Add parameters for Address
                            cmd.Parameters.AddWithValue("@AddressLine", TxtAddress.Text);
                            cmd.Parameters.AddWithValue("@CityID", ddlCity.SelectedValue);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                            LblMsg.Text = "Registration Success";
                            LblMsg.ForeColor = System.Drawing.Color.Green;
                        }
                    }
                }
                catch (Exception Err)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Javascript", string.Format("javascript:alert('{0}');", Err.Message), true);

                }
            }
        }
        protected void TxtLogin_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //DataView dv = (DataView)ClientsDataSource.Select(DataSourceSelectArguments.Empty);
            //args.IsValid = true;
            //for (int i = 0; i < dv.Table.Rows.Count; i++)
            //{
            //    string value = dv.Table.Rows[i][6].ToString();

            //    if (args.Value == value)
            //    {
            //        args.IsValid = false;
            //        break;
            //    }
            //}
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string sqlQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sqlQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", args.Value);

                        conn.Open();
                        int userCount = (int)cmd.ExecuteScalar();

                        args.IsValid = (userCount == 0); // Valid if no matching username exists
                        if (TxtLogin.Text == "admin") {
                            args.IsValid = false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                args.IsValid = false;
                ScriptManager.RegisterStartupScript(this, GetType(), "Javascript", $"alert('Error checking username: {ex.Message}');", true);
            }
        }

        // Hashing function using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                // Convert the password to byte array
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));

                // Convert the byte array to a hex string
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString(); // Return the hashed password
            }
        }
    }
}