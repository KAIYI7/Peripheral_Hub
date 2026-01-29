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
    public partial class Dashboard_Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminSession"] == null)
            {
                Response.Redirect("Admin.aspx?Error=1");
            }
            
                BindSalesChart();
                BindTopProductsChart();
                
            

        }

        protected void BtnSearchNum_Click(object sender, EventArgs e)
        {
            //CommandesListeDataSource.FilterExpression = "NumCmd = {0}";
            //CommandesListeDataSource.FilterParameters.Add("NumCmd", TxtSearchNum.Text);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "1")
            {
                div1.Visible = true;
                div2.Visible = false;
                div3.Visible = false;
            }
            switch (DropDownList1.SelectedValue)
            {
                case "1":
                    div1.Visible = true;
                    div2.Visible = false;
                    div3.Visible = false;
                    div4.Visible = false;
                    break;
                case "2":
                    div1.Visible = false;
                    div2.Visible = true;
                    div3.Visible = false;
                    div4.Visible = false;

                    break;
                case "3":
                    div1.Visible = false;
                    div2.Visible = false;
                    div3.Visible = true;
                    div4.Visible = false;

                    break;
                case "4":
                    div1.Visible = false;
                    div2.Visible = false;
                    div3.Visible = false;
                    div4.Visible = true;

                    break;
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            OrdersDataSource.FilterParameters.Clear();
            switch (DropDownList1.SelectedValue)
            {
                case "1":
                    OrdersDataSource.FilterExpression = "OrderID = {0}";
                    OrdersDataSource.FilterParameters.Add("OrderID", TxtNumCmd.Text);
                    // Set the OrderID parameter for the DetailView's SqlDataSource
                    OrderDetailsDataSource.SelectParameters["OrderID"].DefaultValue = "0";
                    // Bind the DetailView to the data
                    GridViewOrderDetails.DataBind();
                    break;
                case "2":
                    OrdersDataSource.FilterExpression = "OrderDate = '{0}'";
                    OrdersDataSource.FilterParameters.Add("OrderDate",Convert.ToDateTime(TxtDate.Text).ToString("yyyy-MM-dd"));
                    // Set the OrderID parameter for the DetailView's SqlDataSource
                    OrderDetailsDataSource.SelectParameters["OrderID"].DefaultValue = "0";
                    // Bind the DetailView to the data
                    GridViewOrderDetails.DataBind();
                    break;
                case "3":
                    OrdersDataSource.FilterExpression = "OrderDate >= '{0}' AND OrderDate <= '{1}'";
                    OrdersDataSource.FilterParameters.Add("OrderDate", Convert.ToDateTime(TxtDate1.Text).ToString("yyyy-MM-dd"));
                    OrdersDataSource.FilterParameters.Add("OrderDate", Convert.ToDateTime(TxtDate2.Text).ToString("yyyy-MM-dd"));
                    // Set the OrderID parameter for the DetailView's SqlDataSource
                    OrderDetailsDataSource.SelectParameters["OrderID"].DefaultValue = "0";
                    // Bind the DetailView to the data
                    GridViewOrderDetails.DataBind();
                    break;
                default:
                    break;

            }
        }


        protected void OrderListDataSource_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1) LblMsg.Text = "No Data Found ...";
            else LblMsg.Text = string.Empty;
        }

        private void BindSalesChart()
        {
            string query = @"
        SELECT CONVERT(DATE, OrderDate) AS OrderDate, SUM(ORDER_DETAILS.price * ORDER_DETAILS.quantity) AS TotalSales
        FROM Orders
        INNER JOIN ORDER_DETAILS ON Orders.OrderID = ORDER_DETAILS.OrderID
        GROUP BY CONVERT(DATE, OrderDate)
        ORDER BY OrderDate";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                SalesChart.Series["SalesSeries"].Points.Clear();
                while (reader.Read())
                {
                    SalesChart.Series["SalesSeries"].Points.AddXY(Convert.ToDateTime(reader["OrderDate"]).ToString("yyyy-MM-dd"), reader["TotalSales"]);
                }
            }
        }

        private void BindTopProductsChart()
        {
            string query = @"
        SELECT TOP 5 Products.ProductName, SUM(ORDER_DETAILS.quantity) AS TotalQuantity
        FROM ORDER_DETAILS
        INNER JOIN PRODUCT_VARIANTS ON ORDER_DETAILS.VariantID = PRODUCT_VARIANTS.VariantID
        INNER JOIN Products ON PRODUCT_VARIANTS.ProductID = Products.ProductID
        GROUP BY Products.ProductName
        ORDER BY TotalQuantity DESC";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                TopProductsChart.Series["ProductsSeries"].Points.Clear();
                while (reader.Read())
                {
                    TopProductsChart.Series["ProductsSeries"].Points.AddXY(reader["ProductName"], reader["TotalQuantity"]);
                }
            }
        }

        protected void GridViewOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                // Get the OrderID from the CommandArgument
                int orderID = Convert.ToInt32(e.CommandArgument);

                // Set the OrderID parameter for the DetailView's SqlDataSource
                OrderDetailsDataSource.SelectParameters["OrderID"].DefaultValue = orderID.ToString();

                // Bind the DetailView to the data
                GridViewOrderDetails.DataBind();
            }
        }
    }
}