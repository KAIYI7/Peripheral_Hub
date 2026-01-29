using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Peripheral_Hub
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32(Request.QueryString["ProductID"]);
            if (!IsPostBack)
            {

                LoadProductDetails(productId);
                LoadProductImages(productId);
                //LoadProductVariants(productId);
            }
            LoadProductVariants(productId);
            if (!IsPostBack)
            {
                if (ThumbnailRepeater.Items.Count > 0)
                {
                    // Get the first item in the Repeater
                    var firstImageItem = ThumbnailRepeater.Items[0];
                    var firstImageControl = (Image)firstImageItem.FindControl("Image1");

                    if (firstImageControl != null)
                    {
                        MainProductImage.ImageUrl = firstImageControl.ImageUrl;
                    }
                }


                string script = @"
                document.addEventListener('DOMContentLoaded', function () {
            var mainImage = document.getElementById('" + MainProductImage.ClientID + @"');
            mainImage.addEventListener('load', function () {
                var magnifierContainer = document.createElement('div');
                magnifierContainer.classList.add('magnifier-container');
                mainImage.parentElement.appendChild(magnifierContainer);

                var magnifierLens = document.createElement('div');
                magnifierLens.classList.add('magnifier-lens');
                magnifierContainer.appendChild(magnifierLens);

                mainImage.addEventListener('mousemove', function (e) {
                    magnifierContainer.style.display = 'block'; // Show the magnifier container
                    magnifierLens.style.display = 'block'; // Show the magnifier lens
                    var rect = mainImage.getBoundingClientRect();
                    var lensWidth = magnifierLens.offsetWidth;
                    var lensHeight = magnifierLens.offsetHeight;

                    var mouseX = e.pageX - rect.left;
                    var mouseY = e.pageY - rect.top;

                    // Ensure the lens doesn't go out of bounds
                    if (mouseX > mainImage.width - lensWidth) {
                        mouseX = mainImage.width - lensWidth;
                    }
                    if (mouseY > mainImage.height - lensHeight) {
                        mouseY = mainImage.height - lensHeight;
                    }

                    magnifierLens.style.left = mouseX - lensWidth / 2 + 'px';
                    magnifierLens.style.top = mouseY - lensHeight / 2 + 'px';

                    // Apply zoom effect by adjusting the background position
                    var zoomRatio = 2; // Adjust zoom level
                    magnifierContainer.style.backgroundImage = 'url(' + mainImage.src + ')';
                    magnifierContainer.style.backgroundSize = (mainImage.width * zoomRatio) + 'px ' + (mainImage.height * zoomRatio) + 'px';
                    magnifierContainer.style.backgroundPosition = '-' + (mouseX * zoomRatio - lensWidth / 2 * zoomRatio) + 'px -' + (mouseY * zoomRatio - lensHeight / 2 * zoomRatio) + 'px';
                });

                mainImage.addEventListener('mouseleave', function () {
                    magnifierContainer.style.display = 'none'; // Hide magnifier container
                    magnifierLens.style.display = 'none'; // Hide magnifier lens
                });
            });
        });
        ";

                Page.ClientScript.RegisterStartupScript(this.GetType(), "ZoomScript", script, true);

            }

        }

        private void LoadProductDetails(int productId)
        {
            // Fetch product details
            string query = "SELECT ProductName, Description, MIN(Price) AS Price FROM Products " +
                           "JOIN PRODUCT_VARIANTS ON Products.ProductID = PRODUCT_VARIANTS.ProductID " +
                           "WHERE Products.ProductID = @ProductID GROUP BY ProductName, Description";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductID", productId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    LblProductName.Text = reader["ProductName"].ToString();
                    LblProductDescription.Text = reader["Description"].ToString();
                    LblProductPrice.Text = "RM " + Convert.ToDecimal(reader["Price"]).ToString("0.00");
                }
            }
        }

        private void LoadProductImages(int productId)
        {
            // Fetch product images
            string query = "SELECT urlImage FROM PRODUCT_IMAGES WHERE ProductID = @ProductID";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductID", productId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ThumbnailRepeater.DataSource = reader;
                ThumbnailRepeater.DataBind();
            }
        }

        private void LoadProductVariants(int productId)
        {
            // Fetch product variants (e.g., colors and storage)
            string query = "SELECT DISTINCT VariantOption FROM PRODUCT_VARIANTS WHERE ProductID = @ProductID";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductID", productId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    //string option = reader["VariantOption"].ToString();
                    //string value = reader["VariantValue"].ToString();

                    //if (option == "Color")
                    //    ddlColors.Items.Add(value);
                    //else if (option == "Storage")
                    //    ddlStorage.Items.Add(value);
                    string variantOption = reader["VariantOption"].ToString();
                    // Dynamically create controls (e.g., dropdown) for each variant option
                    CreateVariantControls(variantOption, productId);
                }
            }
        }

        private void CreateVariantControls(string variantOption, int productId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT VariantValue FROM PRODUCT_VARIANTS WHERE ProductID = @ProductID AND VariantOption = @VariantOption";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                cmd.Parameters.AddWithValue("@VariantOption", variantOption);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                DropDownList ddl = new DropDownList();
                ddl.ID = "ddl" + variantOption.Replace(" ", "");
                ddl.CssClass = "variant-dropdown";
                ddl.AutoPostBack = true;
                ddl.SelectedIndexChanged += Variant_Changed;

                while (reader.Read())
                {
                    ddl.Items.Add(new ListItem(reader["VariantValue"].ToString()));
                }

                VariantContainer.Controls.Add(new Literal { Text = $"<label>{variantOption}: </label>" });
                VariantContainer.Controls.Add(ddl);
                VariantContainer.Controls.Add(new Literal { Text = "<br/>" });
            }
        }

        protected void thumbnailRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Find the Image control
                Image img = (Image)e.Item.FindControl("Image1");
                if (img != null)
                {
                    // Get the ImageUrl from the current data item
                    string imageUrl = DataBinder.Eval(e.Item.DataItem, "urlImage").ToString();

                    // Add the onclick event
                    img.Attributes.Add("onclick", $"updateMainImage('{imageUrl.Replace("'", "\\'")}')");
                }
            }
        }

        protected void Variant_Changed(object sender, EventArgs e)
        {
            UpdatePrice();
        }

        private void UpdatePrice()
        {
            // Collect selected variant values
            var selectedVariants = new List<string>();
            foreach (Control control in VariantContainer.Controls)
            {
                if (control is DropDownList ddl)
                {
                    selectedVariants.Add(ddl.SelectedValue);
                }
            }

            // Fetch price based on selected variants
            decimal price = GetPriceFromDatabase(selectedVariants);

            // Update the price label
            LblProductPrice.Text = $"RM {price:F2}";
        }

        private decimal GetPriceFromDatabase(List<string> selectedVariants)
        {
            decimal price = 0;

            // Prepare the query with parameterized IN clause
            string query = @"
        SELECT Price 
        FROM PRODUCT_VARIANTS 
        WHERE ProductID = @ProductID
        AND VariantValue IN (" + string.Join(",", selectedVariants.Select((v, i) => $"@VariantValue{i}")) + @")
        GROUP BY Price
        ORDER BY Price DESC
        ";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // Add parameters for ProductID and VariantValue
                cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(Request.QueryString["ProductID"]));

                // Dynamically add parameters for the selected variants
                for (int i = 0; i < selectedVariants.Count; i++)
                {
                    cmd.Parameters.AddWithValue($"@VariantValue{i}", selectedVariants[i]);
                }

                // Add parameter for the count of selected variants
                //cmd.Parameters.AddWithValue("@VariantCount", selectedVariants.Count);

                try
                {
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        price = Convert.ToDecimal(result);

                    }
                    else
                    {
                        Console.WriteLine("No result returned from query.");

                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error executing SQL: " + ex.Message);
                }
            }

            return price;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Step 1: Retrieve the username from session
            string username = Session["Username"]?.ToString();
            if (string.IsNullOrEmpty(username))
            {
                Response.Redirect("SignIn.aspx?Error=1"); // Redirect if the user is not logged in
                return;
            }

            // Step 2: Get UserID based on the username
            int userId = GetUserIdByUsername(username);
            if (userId == 0)
            {
                //LblMsg.Text = "User not found. Please log in again.";
                return;
            }

            // Step 3: Retrieve product details
            int productId = Convert.ToInt32(Request.QueryString["ProductID"]);
            int quantity = Convert.ToInt32(DropDownList1.SelectedValue);
            var selectedVariants = new List<string>();

            foreach (Control control in VariantContainer.Controls)
            {
                if (control is DropDownList ddl)
                {
                    selectedVariants.Add(ddl.SelectedValue);
                }
            }

            if (selectedVariants.Count == 0)
            {
                //LblMsg.Text = "Please select product variants before adding to cart.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    con.Open();

                    // Step 4: Insert a new cart if it doesn't exist
                    string insertCartQuery = @"
                IF NOT EXISTS (SELECT 1 FROM CART WHERE UserID = @UserID)
                BEGIN
                    INSERT INTO CART (UserID) VALUES (@UserID)
                END";

                    using (SqlCommand cmdCart = new SqlCommand(insertCartQuery, con))
                    {
                        cmdCart.Parameters.AddWithValue("@UserID", userId);
                        cmdCart.ExecuteNonQuery();
                    }

                    // Step 5: Get the CartID for the user
                    string getCartIdQuery = "SELECT CartID FROM CART WHERE UserID = @UserID";
                    int cartId;
                    using (SqlCommand cmdGetCartId = new SqlCommand(getCartIdQuery, con))
                    {
                        cmdGetCartId.Parameters.AddWithValue("@UserID", userId);
                        cartId = Convert.ToInt32(cmdGetCartId.ExecuteScalar());
                    }

                    // Step 6: Get the VariantID for the selected variants
                    string getVariantIdQuery = @"
                SELECT VariantID 
                FROM PRODUCT_VARIANTS 
                WHERE ProductID = @ProductID 
                  AND VariantValue IN (" + string.Join(",", selectedVariants.Select((v, i) => $"@VariantValue{i}")) + ")";

                    int variantId;
                    using (SqlCommand cmdGetVariantId = new SqlCommand(getVariantIdQuery, con))
                    {
                        cmdGetVariantId.Parameters.AddWithValue("@ProductID", productId);
                        for (int i = 0; i < selectedVariants.Count; i++)
                        {
                            cmdGetVariantId.Parameters.AddWithValue($"@VariantValue{i}", selectedVariants[i]);
                        }

                        variantId = Convert.ToInt32(cmdGetVariantId.ExecuteScalar());
                    }

                    // Step 7: Insert or update the cart item
                    string insertCartItemQuery = @"
                IF EXISTS (
                    SELECT 1 
                    FROM CART_ITEM 
                    WHERE CartID = @CartID AND ProductID = @ProductID AND VariantID = @VariantID
                )
                BEGIN
                    UPDATE CART_ITEM 
                    SET Quantity = Quantity + @Quantity 
                    WHERE CartID = @CartID AND ProductID = @ProductID AND VariantID = @VariantID
                END
                ELSE
                BEGIN
                    INSERT INTO CART_ITEM (CartID, ProductID, VariantID, Quantity)
                    VALUES (@CartID, @ProductID, @VariantID, @Quantity)
                END";

                    using (SqlCommand cmdInsertCartItem = new SqlCommand(insertCartItemQuery, con))
                    {
                        cmdInsertCartItem.Parameters.AddWithValue("@CartID", cartId);
                        cmdInsertCartItem.Parameters.AddWithValue("@ProductID", productId);
                        cmdInsertCartItem.Parameters.AddWithValue("@VariantID", variantId);
                        cmdInsertCartItem.Parameters.AddWithValue("@Quantity", quantity);
                        cmdInsertCartItem.ExecuteNonQuery();
                    }
                }

                // Redirect to the cart page after successful addition
                Response.Redirect("CartPage.aspx");
            }
            catch (Exception ex)
            {
                //LblMsg.Text = "An error occurred: " + ex.Message;
            }
        }

        private int GetUserIdByUsername(string username)
        {
            int userId = 0;
            string query = "SELECT UserID FROM Users WHERE Username = @Username";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    userId = Convert.ToInt32(result);
                }
            }

            return userId;
        }



    }
}