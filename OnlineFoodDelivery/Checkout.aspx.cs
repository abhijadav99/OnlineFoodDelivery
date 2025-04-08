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
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            LoadOrderSummary();
        }

        private void LoadOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            DataTable cartItems = GetCartItems(userId);

            rptOrderSummary.DataSource = cartItems;
            rptOrderSummary.DataBind();

            decimal total = cartItems.AsEnumerable()
                .Sum(item => Convert.ToDecimal(item["Price"]) * Convert.ToInt32(item["Quantity"]));

            ltTotal.Text = total.ToString("C");
        }

        private DataTable GetCartItems(int userId)
        {
            const string query = @"
        SELECT 
            c.ProductID, 
            p.Name, 
            p.Price, 
            c.Quantity 
        FROM Cart c
        INNER JOIN Products p ON c.ProductID = p.ProductID
        WHERE c.UserID = @UserID";

            SqlParameter[] parameters =
            {
        new SqlParameter("@UserID", userId)
    };

            return Database.GetDataParameters(query, parameters);
        }


        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            int orderId = 0;
            bool transactionCompleted = false;

            using (SqlConnection conn = new SqlConnection(Database.connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        int userId = Convert.ToInt32(Session["UserID"]);
                        DataTable cartItems = GetCartItems(userId);

                        decimal total = cartItems.AsEnumerable()
                            .Sum(row => Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]));

                        // Create Order
                        orderId = CreateOrder(transaction, userId, total);

                        // Add Order Details
                        foreach (DataRow item in cartItems.Rows)
                        {
                            CreateOrderDetail(transaction, orderId,
                                Convert.ToInt32(item["ProductID"]),
                                Convert.ToInt32(item["Quantity"]),
                                Convert.ToDecimal(item["Price"]));
                        }

                        // Clear Cart
                        Database.ExecuteQueryTransaction(
                            "DELETE FROM Cart WHERE UserID = @UserID",
                            new SqlParameter[] { new SqlParameter("@UserID", userId) },
                            transaction);

                        transaction.Commit();
                        transactionCompleted = true;
                    }
                    catch (Exception ex)
                    {
                        if (!transactionCompleted)
                        {
                            try { transaction.Rollback(); }
                            catch { /* Optionally log rollback failure */ }
                        }

                        ltTotal.Text = $"<div class='alert alert-danger'>Error: {ex.Message}</div>";
                        return;
                    }
                }
            }

            if (transactionCompleted)
            {
                Response.Redirect(GetRouteUrl("HomeRoute", null));
                Context.ApplicationInstance.CompleteRequest();
            }
        }



        private int CreateOrder(SqlTransaction transaction, int userId, decimal total)
        {
            string query = @"
        INSERT INTO Orders 
            (UserID, TotalAmount, ShippingName, ShippingAddress, 
             ShippingCity, ShippingState, ShippingZip)
        OUTPUT INSERTED.OrderID
        VALUES 
            (@UserID, @Total, @Name, @Address, @City, @State, @Zip)";

            SqlParameter[] parameters = {
        new SqlParameter("@UserID", userId),
        new SqlParameter("@Total", total),
        new SqlParameter("@Name", txtFullName.Text.Trim()),
        new SqlParameter("@Address", txtAddress.Text.Trim()),
        new SqlParameter("@City", txtCity.Text.Trim()),
        new SqlParameter("@State", txtState.Text.Trim()),
        new SqlParameter("@Zip", txtZip.Text.Trim())
    };

            object result = Database.ExecuteScalar(query, parameters, transaction);
            return result != null ? Convert.ToInt32(result) : 0;
        }


        private void CreateOrderDetail(SqlTransaction transaction, int orderId, int productId, int quantity, decimal price)
        {
            string query = @"
        INSERT INTO OrderDetails 
            (OrderID, ProductID, Quantity, UnitPrice)
        VALUES 
            (@OrderID, @ProductID, @Quantity, @Price)";

            SqlParameter[] parameters = {
        new SqlParameter("@OrderID", orderId),
        new SqlParameter("@ProductID", productId),
        new SqlParameter("@Quantity", quantity),
        new SqlParameter("@Price", price)
    };

            Database.ExecuteQueryTransaction(query, parameters, transaction);
        }

    }
}
