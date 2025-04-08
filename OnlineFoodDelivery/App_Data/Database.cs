using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System;

public static class Database
{
    public static string connectionString =
        System.Web.Configuration.WebConfigurationManager.ConnectionStrings["OnlineFoodDeliveryDB"].ConnectionString;
    public static DataTable GetData(string query)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }
    public static void ExecuteQueryParameters(string query, SqlParameter[] parameters)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
    public static DataTable GetDataParameters(string query, SqlParameter[] parameters)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters);
                conn.Open();
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                return dt;
            }
        }
    }
    public static int ExecuteQuery(string query, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(query, conn);
            if (parameters != null)
            {
                cmd.Parameters.AddRange(parameters);
            }
            return cmd.ExecuteNonQuery();
        }
    }
    public static int ExecuteScalar(string query, SqlParameter[] parameters, SqlTransaction transaction)
    {
        using (SqlCommand cmd = new SqlCommand(query, transaction.Connection, transaction))
        {
            cmd.Parameters.AddRange(parameters);
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }

    public static void ExecuteQueryTransaction(string query, SqlParameter[] parameters, SqlTransaction transaction)
    {
        using (SqlCommand cmd = new SqlCommand(query, transaction.Connection, transaction))
        {
            cmd.Parameters.AddRange(parameters);
            cmd.ExecuteNonQuery();
        }
    }


    // NEW METHOD: Add to cart with parameterized query
    public static int AddToCart(int userId, int productId)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            // Check if item exists
            string checkQuery = @"SELECT Quantity FROM Cart 
                                WHERE UserID = @UserId AND ProductID = @ProductId";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@UserId", userId);
            checkCmd.Parameters.AddWithValue("@ProductId", productId);

            object result = checkCmd.ExecuteScalar();

            if (result != null)
            {
                // Update quantity
                string updateQuery = @"UPDATE Cart SET Quantity = Quantity + 1 
                                    WHERE UserID = @UserId AND ProductID = @ProductId";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@UserId", userId);
                updateCmd.Parameters.AddWithValue("@ProductId", productId);
                return updateCmd.ExecuteNonQuery();
            }
            else
            {
                // Insert new item
                string insertQuery = @"INSERT INTO Cart (UserID, ProductID) 
                                    VALUES (@UserId, @ProductId)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                insertCmd.Parameters.AddWithValue("@UserId", userId);
                insertCmd.Parameters.AddWithValue("@ProductId", productId);
                return insertCmd.ExecuteNonQuery();
            }
        }
    }
}