using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class Admin : System.Web.UI.Page
    {
        public string UserName { get; set; }
        public string Passwd { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            UserName = "admin2";
            Passwd = "admin2";

            LblMsg.ForeColor = System.Drawing.Color.Red;
            if (!IsPostBack)
            {
                if (Request.QueryString["Error"] != null)
                {
                    LblMsg.Text = "You must login to access Peripheral Hub!";
                }
                if (Request.QueryString["Logout"] != null)
                {
                    LblMsg.Text = "You have been successfully logged out";
                    LblMsg.ForeColor = System.Drawing.Color.Green;
                }
                if (Session["AdminSession"] != null)
                {
                    Response.Redirect("Dashboard_Clients.aspx");
                }
            }
        }
        protected void BtnSingIn_Click(object sender, EventArgs e)
        {
            MembershipUser user = Membership.GetUser(TxtLogin.Text);
            if (Membership.ValidateUser(TxtLogin.Text, TxtPasswd.Text) && (UserName ==TxtLogin.Text && Passwd == TxtPasswd.Text))
            {
                    // Create a new session for the administrator user
                    Session["Username"] = TxtLogin.Text;
                    Session["AdminSession"] = "Admin";
                    Response.Redirect("Dashboard_Products.aspx");  // Redirect to the admin dashboard or any admin page
               
            }
            else LblMsg.Text = "Incorrect Username / Password ";
        }
    }
}