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
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && User.Identity.IsAuthenticated)
            {
                LoadCart();
            }
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }
        private void LoadCart()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string query = $@"SELECT c.CartID, c.ProductID, c.Quantity, 
                             p.Name, p.Price, p.ImageURL
                     FROM Cart c
                     INNER JOIN Products p ON c.ProductID = p.ProductID
                     WHERE c.UserID = {userId}";

            DataTable dt = Database.GetData(query);
            gvCart.DataSource = dt;
            gvCart.DataBind();

            UpdateTotal(dt);
        }
        private void UpdateTotal(DataTable dt)
        {
            decimal total = dt.AsEnumerable()
                            .Sum(row => Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]));
            ltTotal.Text = total.ToString("C");
        }
        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            TextBox txtQuantity = (TextBox)sender;
            GridViewRow row = (GridViewRow)txtQuantity.NamingContainer;
            int productId = Convert.ToInt32(gvCart.DataKeys[row.RowIndex].Value);
            int userId = Convert.ToInt32(Session["UserID"]);
            int newQuantity = Convert.ToInt32(txtQuantity.Text);

            // Update database
            string query = @"UPDATE Cart SET Quantity = @Quantity 
                           WHERE UserID = @UserID AND ProductID = @ProductID";
            SqlParameter[] parameters = {
                new SqlParameter("@Quantity", newQuantity),
                new SqlParameter("@UserID", userId),
                new SqlParameter("@ProductID", productId)
            };

            Database.ExecuteQueryParameters(query, parameters);
            LoadCart(); // Refresh data
        }
        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(Session["UserID"]);

                string query = "DELETE FROM Cart WHERE UserID = @UserID AND ProductID = @ProductID";
                SqlParameter[] parameters = {
                    new SqlParameter("@UserID", userId),
                    new SqlParameter("@ProductID", productId)
                };

                Database.ExecuteQueryParameters(query, parameters);
                LoadCart();
            }
        }
        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.DataItem != null)
                {
                    Label lblTotal = (Label)e.Row.FindControl("lblTotal");
                    if (lblTotal != null)
                    {
                        DataRowView rowView = (DataRowView)e.Row.DataItem;
                        if (rowView["Price"] != DBNull.Value && rowView["Quantity"] != DBNull.Value)
                        {
                            decimal price = Convert.ToDecimal(rowView["Price"]);
                            int quantity = Convert.ToInt32(rowView["Quantity"]);
                            lblTotal.Text = (price * quantity).ToString("C");
                        }
                    }
                }
            }
        }
        protected void btnCheckout_Click(object sender, EventArgs e)
        {

            Response.Redirect(GetRouteUrl("CheckoutRoute", null));
        }
    }
}