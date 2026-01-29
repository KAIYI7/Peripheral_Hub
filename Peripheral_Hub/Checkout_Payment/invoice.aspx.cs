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
    public partial class invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int orderId = Convert.ToInt32(Request.QueryString["orderID"]);
                LoadInvoiceData(orderId);
            }
        }

        private void LoadInvoiceData(int orderId)
        {

            string query = @"
            SELECT 
            o.OrderDate, 
                    o.tax, 
                    p.paymentDate, 
                    p.paymentAmount,
                    u.FirstName + ' ' + u.LastName AS CustomerName, 
                    u.Email, 
                    u.Tel AS Phone,
                    a.addressLine AS Address
                FROM Orders o
                INNER JOIN PAYMENT p ON o.OrderID = p.orderID
                INNER JOIN Users u ON o.UserID = u.UserID
                INNER JOIN ADDRESS a ON u.UserID = a.UserID
                WHERE o.OrderID = @OrderID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {

                        // Populate labels and table
                        while (reader.Read())
                        {
                            // Populate customer details
                            lblCustomerName.Text = reader["CustomerName"].ToString();
                            lblCustomerEmail.Text = reader["Email"].ToString();
                            lblCustomerPhone.Text = reader["Phone"].ToString();
                            lblCustomerAddress.Text = reader["Address"].ToString();

                            // Populate order details
                            lblOrderDate.Text = Convert.ToDateTime(reader["OrderDate"]).ToString("dd/MM/yyyy");
                            lblOrderSerial.Text = orderId.ToString();
                            lblPaidDate.Text = Convert.ToDateTime(reader["paymentDate"]).ToString("dd/MM/yyyy");

                            // Populate tax and total
                            lblTax.Text = Convert.ToDecimal(reader["tax"]).ToString("0.00");
                            lblTotal.Text = Convert.ToDecimal(reader["paymentAmount"]).ToString("0.00");

                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('No invoice data found for this order.');</script>");
                    }
                }
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Clients_Products.aspx");
        }
    }
}