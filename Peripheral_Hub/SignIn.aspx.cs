using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            LblMsg.ForeColor = System.Drawing.Color.Red;
            if (!IsPostBack)
            {
                if (Request.QueryString["Error"] != null)
                {
                    LblMsg.Text = "You must login to access Peripheral Hub!";
                }
                if (Request.QueryString["Logout"] != null)
                {
                    LblMsg.Text = "You have successfully logged out";
                    LblMsg.ForeColor = System.Drawing.Color.Green;
                }
                if (Session["Username"] != null)
                {
                    Response.Redirect("Clients_Products.aspx");
                }
            }
        }
        protected void BtnSignIn_Click(object sender, EventArgs e)
        {
            //DataView dv = (DataView)ClientsDataSource.Select(DataSourceSelectArguments.Empty);
            //bool IsValid = false;
            //for (int i = 0; i < dv.Table.Rows.Count; i++)
            //{
            //    string Username = dv.Table.Rows[i]["Username"].ToString();
            //    string Passwd = dv.Table.Rows[i]["Password"].ToString();

            //    if (Username == TxtLogin.Text && Passwd == TxtPasswd.Text)
            //    {
            //        IsValid = true;
            //        Session["Username"] = Username;
            //        break;
            //    }
            //}
            //if (IsValid) Response.Redirect("Clients_Products.aspx");
            //Authenticate the user using Membership
            if (Membership.ValidateUser(TxtLogin.Text, TxtPasswd.Text))
            {
                // Create a new session for the logged-in user
                Session["Username"] = TxtLogin.Text;
                Response.Redirect("Clients_Products.aspx");
            }
            else LblMsg.Text = "Incorrect Username / Password";
        }
    }
}