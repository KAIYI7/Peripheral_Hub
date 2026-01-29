using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Peripheral_Hub
{
    public partial class Clients_Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductDetail.aspx?ProductID=6");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductDetail.aspx?ProductID=1");
        }
    }
}