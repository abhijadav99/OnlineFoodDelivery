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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect(GetRouteUrl("HomeRoute", null));
            }
        }
        protected void btnLoginUser(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string query = "SELECT * FROM Users WHERE Username = @Username AND Password = @Password";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", password)
            };

            DataTable dt = Database.GetDataParameters(query, parameters);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                // Session assignments
                Session["UserID"] = Convert.ToInt32(row["UserID"]);
                Session["Username"] = row["Username"].ToString();
                Session["UserRole"] = row["Role"].ToString();

                // Auth cookie
                FormsAuthentication.SetAuthCookie(row["Username"].ToString(), false);

                // Route-based redirect
                string role = row["Role"].ToString();
                string redirectUrl = role == "Admin"
                    ? GetRouteUrl("AdminDashboardRoute", null)
                    : GetRouteUrl("HomeRoute", null);

                Response.Redirect(redirectUrl);
            }
            else
            {
                ltMessage.Text = "<div class='alert alert-danger mt-3'>Invalid credentials</div>";
            }
        }

        //protected void btnLogin_Click(object sender, EventArgs e)
        //{
        //    if (Page.IsValid)
        //    {
        //        string query = $@"SELECT * FROM Users 
        //                WHERE Username='{txtUsername.Text.Trim()}' 
        //                AND Password='{txtPassword.Text.Trim()}'";

        //        DataTable dt = Database.GetData(query);

        //        if (dt.Rows.Count > 0)
        //        {
        //            DataRow row = dt.Rows[0];
        //            // Set session variables
        //            Session["UserID"] = Convert.ToInt32(row["UserID"]);
        //            Session["Username"] = row["Username"].ToString();
        //            Session["UserRole"] = row["Role"].ToString();

        //            // Set authentication cookie
        //            FormsAuthentication.SetAuthCookie(row["Username"].ToString(), false);

        //            // Redirect based on role
        //            if (row["Role"].ToString() == "Admin")
        //                Response.Redirect(GetRouteUrl("AdminDashboardRoute", null));
        //            else
        //                Response.Redirect(GetRouteUrl("HomeRoute", null));
        //        }
        //        else
        //        {
        //            ltMessage.Text = "<div class='alert alert-danger mt-3'>Invalid credentials</div>";
        //        }
        //    }
        //}
    }
}