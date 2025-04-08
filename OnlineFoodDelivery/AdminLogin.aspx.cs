using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodDelivery
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && Session["UserRole"]?.ToString() == "Admin")
            {
                Response.Redirect(GetRouteUrl("AdminDashboardRoute", null));
            }
        }

        protected void btnAdminLogin(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = "Admin";

            string query = @"SELECT * FROM Users 
                     WHERE Username = @Username AND Password = @Password AND Role = @Role";

            SqlParameter[] parameters = new SqlParameter[]
            {
        new SqlParameter("@Username", username),
        new SqlParameter("@Password", password),
        new SqlParameter("@Role", role)
            };

            DataTable dt = Database.GetDataParameters(query, parameters);

            if (dt.Rows.Count > 0)
            {
                DataRow user = dt.Rows[0];
                Session["UserID"] = user["UserID"];
                Session["Username"] = user["Username"];
                Session["UserRole"] = user["Role"];

                FormsAuthentication.SetAuthCookie(user["Username"].ToString(), false);
                Response.Redirect(GetRouteUrl("AdminDashboardRoute", null));
            }
            else
            {
                ltMessage.Text = "<div class='alert alert-danger mt-3'>Invalid admin credentials</div>";
            }
        }



    }
}