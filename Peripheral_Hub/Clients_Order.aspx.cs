using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class Clients_Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("SignIn.aspx?Error=1");
            }

            DataView dv = (DataView)ClientsDataSource.Select(DataSourceSelectArguments.Empty);
            //string NumClient = null;
            for (int i = 0; i < dv.Table.Rows.Count; i++)
            {
                string Pseudo = dv.Table.Rows[i]["Username"].ToString();
                if (Session["Username"].ToString() == Pseudo)
                {
                    HiddenField1.Value = dv.Table.Rows[i]["UserID"].ToString();
                    break;
                }
            }
        }

        protected void OrderListDataSource_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1) LblMsg.Text = "No Data Found ...";
            else LblMsg.Text = string.Empty;
        }

        protected void HiddenField1_ValueChanged(object sender, EventArgs e)
        {

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