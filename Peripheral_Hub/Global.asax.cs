using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace PeripheralHub
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //Application["ActiveUsers"] = 0;
            //MembershipUserCollection msterUsers = Membership.FindUsersByName("Administrator");
            //if (msterUsers.Count == 0)
            //{
            //    MembershipCreateStatus status;
            //    MembershipUser newuser = Membership.CreateUser("admin", "admin", "admin@gmail.com",
            //   "none", "none", true, out status);
            //    string[] roles = Roles.GetAllRoles();
            //    if (roles.Length == 0)
            //    {
            //        Roles.CreateRole("administrator");
            //    }
            //    string[] users = Roles.GetUsersInRole("administrator");
            //    if (users.Where(x => x == "admin").FirstOrDefault() == null)
            //    {
            //        Roles.AddUserToRole("admin", "administrator");
            //    }
            //}
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            //Application.Lock();
            //Application["ActiveUsers"] = (int)Application["ActiveUsers"] + 1;
            //Application.UnLock();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            //Application.Lock();
            //Application["ActiveUsers"] = (int)Application["ActiveUsers"] - 1;
            //Application.UnLock();
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}