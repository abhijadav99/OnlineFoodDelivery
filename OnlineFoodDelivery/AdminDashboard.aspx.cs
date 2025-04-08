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
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Existing auth check
                if (!IsAdmin())
                {
                    Response.Redirect(GetRouteUrl("AdminLoginRoute", null));
                    return;
                }

                // Initialize hidden field with first tab
                hdnActiveTab.Value = "#products";
                BindData();
            }
            else
            {
                // After postback, preserve the scroll position
                MaintainScrollPositionOnPostBack = true;
            }
        }

        private void BindData()
        {
            BindProducts();
            BindOrders();
            BindUsers();
        }

        private bool IsAdmin() => Session["UserRole"]?.ToString() == "Admin";

        private void BindProducts()
        {
            string query = @"SELECT p.*, c.CategoryName 
                   FROM Products p 
                   INNER JOIN Categories c ON p.CategoryID = c.CategoryID";
            DataTable dt = Database.GetDataParameters(query, new SqlParameter[0]);
            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }

        protected void gvProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            BindProducts();
        }

        protected void gvProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            BindProducts();
        }

        protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int productId = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
                string query = "DELETE FROM Products WHERE ProductID = @ProductID";
                SqlParameter[] parameters = { new SqlParameter("@ProductID", productId) };
                Database.ExecuteQueryParameters(query, parameters);
                BindProducts();
            }
            catch (Exception ex)
            {
                ShowError($"Delete failed: {ex.Message}");
            }
        }

        protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int productId = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvProducts.Rows[e.RowIndex];

                // Get controls
                DropDownList ddlCategories = (DropDownList)row.FindControl("ddlCategories");
                TextBox txtName = (TextBox)row.FindControl("txtName");
                TextBox txtDescription = (TextBox)row.FindControl("txtDescription");
                TextBox txtPrice = (TextBox)row.FindControl("txtPrice");
                TextBox txtImageURL = (TextBox)row.FindControl("txtImageURL");

                string query = @"UPDATE Products SET 
                       Name = @Name,
                       Description = @Description,
                       Price = @Price,
                       CategoryID = @CategoryID,
                       ImageURL = @ImageURL
                       WHERE ProductID = @ProductID";

                SqlParameter[] parameters = {
            new SqlParameter("@Name", txtName.Text),
            new SqlParameter("@Description", txtDescription.Text),
            new SqlParameter("@Price", Convert.ToDecimal(txtPrice.Text)),
            new SqlParameter("@CategoryID", Convert.ToInt32(ddlCategories.SelectedValue)),
            new SqlParameter("@ImageURL", txtImageURL.Text),
            new SqlParameter("@ProductID", productId)
        };

                Database.ExecuteQueryParameters(query, parameters);
                gvProducts.EditIndex = -1;
                BindProducts();
            }
            catch (Exception ex)
            {
                ShowError($"Update failed: {ex.Message}");
            }
        }

        // Update Add Product method
        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            try
            {
                string query = @"INSERT INTO Products 
                       (Name, Description, Price, CategoryID, ImageURL)
                       VALUES (@Name, @Description, @Price, @CategoryID, @ImageURL)";

                SqlParameter[] parameters = {
            new SqlParameter("@Name", txtName.Text.Trim()),
            new SqlParameter("@Description", txtDescription.Text.Trim()),
            new SqlParameter("@Price", Convert.ToDecimal(txtPrice.Text)),
            new SqlParameter("@CategoryID", ddlCategory.SelectedValue),
            new SqlParameter("@ImageURL", txtImageURL.Text.Trim())
        };

                Database.ExecuteQueryParameters(query, parameters);
                ClearProductForm();
                BindProducts();
            }
            catch (Exception ex)
            {
                ShowError($"Add failed: {ex.Message}");
            }
        }

        // Update ClearProductForm method
        private void ClearProductForm()
        {
            txtName.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtImageURL.Text = string.Empty;
            ddlCategory.SelectedIndex = 0;
        }

        private void BindOrders()
        {
            string query = @"SELECT o.*, u.Username 
                          FROM Orders o
                          INNER JOIN Users u ON o.UserID = u.UserID
                          ORDER BY o.OrderDate DESC";

            DataTable dt = Database.GetDataParameters(query, new SqlParameter[0]);
            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }

        protected void gvOrders_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOrders.EditIndex = e.NewEditIndex;
            BindOrders();
        }

        protected void gvOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOrders.EditIndex = -1;
            BindOrders();
        }

        protected void gvOrders_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int orderId = Convert.ToInt32(gvOrders.DataKeys[e.RowIndex].Value);
                DropDownList ddlStatus = (DropDownList)gvOrders.Rows[e.RowIndex].FindControl("ddlStatus");

                string query = "UPDATE Orders SET OrderStatus = @Status WHERE OrderID = @OrderID";
                SqlParameter[] parameters = {
                    new SqlParameter("@Status", ddlStatus.SelectedValue),
                    new SqlParameter("@OrderID", orderId)
                };

                Database.ExecuteQueryParameters(query, parameters);
                gvOrders.EditIndex = -1;
                BindOrders();
            }
            catch (Exception ex)
            {
                ShowError($"Order update failed: {ex.Message}");
            }
        }


        private void ShowError(string message)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert",
                $"alert('{message.Replace("'", @"\'")}');", true);
        }


        private void BindUsers()
        {
            string query = "SELECT UserID, Username, Email, Role FROM Users";
            DataTable dt = Database.GetDataParameters(query, new SqlParameter[0]);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindUsers();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            BindUsers();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvUsers.Rows[e.RowIndex];

                TextBox txtUsername = (TextBox)row.FindControl("txtUsername");
                TextBox txtEmail = (TextBox)row.FindControl("txtEmail");
                DropDownList ddlRoles = (DropDownList)row.FindControl("ddlRoles");

                string query = @"UPDATE Users SET 
                       Username = @Username,
                       Email = @Email,
                       Role = @Role
                       WHERE UserID = @UserID";

                SqlParameter[] parameters = {
            new SqlParameter("@Username", txtUsername.Text),
            new SqlParameter("@Email", txtEmail.Text),
            new SqlParameter("@Role", ddlRoles.SelectedValue),
            new SqlParameter("@UserID", userId)
        };

                Database.ExecuteQueryParameters(query, parameters);
                gvUsers.EditIndex = -1;
                BindUsers();
            }
            catch (Exception ex)
            {
                ShowError($"User update failed: {ex.Message}");
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
                string query = "DELETE FROM Users WHERE UserID = @UserID";
                SqlParameter[] parameters = { new SqlParameter("@UserID", userId) };
                Database.ExecuteQueryParameters(query, parameters);
                BindUsers();
            }
            catch (Exception ex)
            {
                ShowError($"Delete failed: {ex.Message}");
            }
        }
        // Remove the HashPassword method completely

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                string query = @"INSERT INTO Users 
            (Username, Password, Email, Role)
            VALUES (@Username, @Password, @Email, @Role)";

                SqlParameter[] parameters = {
            new SqlParameter("@Username", txtNewUsername.Text.Trim()),
            new SqlParameter("@Password", txtNewPassword.Text), // Store plain text
            new SqlParameter("@Email", txtNewEmail.Text.Trim()),
            new SqlParameter("@Role", ddlNewRole.SelectedValue)
        };

                Database.ExecuteQueryParameters(query, parameters);
                ClearUserForm();
                BindUsers();
            }
            catch (Exception ex)
            {
                ShowError($"Add user failed: {ex.Message}");
            }
        }

        private void ClearUserForm()
        {
            txtNewUsername.Text = string.Empty;
            txtNewEmail.Text = string.Empty;
            txtNewPassword.Text = string.Empty;
            ddlNewRole.SelectedValue = "User"; // Reset to default
        }
    }
}