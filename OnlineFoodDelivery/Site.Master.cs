using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodDelivery
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Page.User.Identity.IsAuthenticated) // Changed User to Page.User
                {
                    // Check if session has the UserRole
                    if (Session["UserRole"] == null)
                    {
                        // Load the user's role from the database
                        string username = Page.User.Identity.Name; // Changed here as well
                        Session["UserRole"] = CheckIfUserIsAdmin(username) ? "Admin" : "User";
                    }
                    adminLink.Visible = Session["UserRole"].ToString() == "Admin";
                }
            }
        }
        private bool CheckIfUserIsAdmin(string username)
        {
            string query = $@"
                SELECT Role 
                FROM Users 
                WHERE Username = @Username
            ";

            SqlParameter[] parameters = {
                new SqlParameter("@Username", username)
            };

            DataTable dt = Database.GetDataParameters
                (query, parameters);

            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["Role"].ToString()
                    == "Admin";
            }
            return false;
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Response.Redirect(GetRouteUrl("HomeRoute", null));
        }
    }
}