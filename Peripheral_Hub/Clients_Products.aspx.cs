using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class Clients_Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                //Response.Redirect("SignIn.aspx?Error=1");
            }

            
        }
        protected void BtnBuy_Click(object sender, EventArgs e)
        {
        }

    }
}