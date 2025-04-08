using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodDelivery
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCreateAccount(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();

            string checkUserQuery = "SELECT Username FROM Users WHERE Username = @Username";
            SqlParameter[] checkParams = new SqlParameter[]
            {
        new SqlParameter("@Username", username)
            };

            DataTable dt = Database.GetDataParameters(checkUserQuery, checkParams); // Ensure this method supports parameters

            if (dt.Rows.Count == 0)
            {
                string insertQuery = @"INSERT INTO Users (Username, Password, Email, Role)
                               VALUES (@Username, @Password, @Email, 'User')";

                SqlParameter[] insertParams = new SqlParameter[]
                {
            new SqlParameter("@Username", username),
            new SqlParameter("@Password", password),
            new SqlParameter("@Email", email)
                };

                Database.ExecuteQuery(insertQuery, insertParams);
                ltMessage.Text = "<div class='alert alert-success mt-3'>Registration successful! Please login.</div>";
            }
            else
            {
                ltMessage.Text = "<div class='alert alert-danger mt-3'>Username already exists</div>";
            }
        }

    }
}