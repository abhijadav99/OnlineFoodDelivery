using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodDelivery
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCategoryDropdown();
                BindProductRepeater();
            }
        }

        private void BindCategoryDropdown()
        {
            string categoryQuery = "SELECT CategoryID, CategoryName FROM Categories";
            DataTable categories = Database.GetData(categoryQuery);

            ddlCategories.DataSource = categories;
            ddlCategories.DataTextField = "CategoryName";
            ddlCategories.DataValueField = "CategoryID";
            ddlCategories.DataBind();

            ddlCategories.Items.Insert(0, new ListItem("All Categories", "0"));
        }

        private void BindProductRepeater()
        {
            int selectedCategoryId = int.TryParse(ddlCategories.SelectedValue, out int catId) ? catId : 0;

            string productQuery = @"
        SELECT p.*, c.CategoryName 
        FROM Products p
        INNER JOIN Categories c ON p.CategoryID = c.CategoryID
        WHERE (@CategoryID = 0 OR p.CategoryID = @CategoryID)";

            SqlParameter[] sqlParams = {
        new SqlParameter("@CategoryID", selectedCategoryId)
    };

            DataTable products = Database.GetDataParameters(productQuery, sqlParams);

            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindProductRepeater();
        }


        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            try
            {
                int userId = FetchUserId();
                int productId = Convert.ToInt32(((Button)sender).CommandArgument);

                int rowsAffected = Database.AddToCart(userId, productId);

                if (rowsAffected > 0)
                {
                    ShowMessage("Item added to cart!", "success");
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error: {ex.Message}", "danger");
            }
        }

        private int FetchUserId()
        {
            if (Session["UserID"] == null)
            {
                string username = User.Identity.Name;

                string sql = "SELECT UserID FROM Users WHERE Username = @Username";
                SqlParameter[] parameters = { new SqlParameter("@Username", username) };

                DataTable dt = Database.GetDataParameters(sql, parameters);

                if (dt.Rows.Count > 0)
                {
                    Session["UserID"] = Convert.ToInt32(dt.Rows[0]["UserID"]);
                }
                else
                {
                    throw new Exception("User not found.");
                }
            }

            return Convert.ToInt32(Session["UserID"]);
        }

        private void ShowMessage(string message, string alertType)
        {
            ltMessage.Text = $"<div class='alert alert-{alertType}'>{message}</div>";
        }
    }
}