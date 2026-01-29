using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PeripheralHub
{
    public partial class Dashboard_Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminSession"] == null)
            {
                Response.Redirect("Admin.aspx?Error=1");
            }

            if (!IsPostBack)
            {
                // Load categories for the footer row
                GridViewRow footerRow = GridView1.FooterRow;
                if (footerRow != null)
                {
                    DropDownList ddlCategory = (DropDownList)footerRow.FindControl("ddlCategory");
                    if (ddlCategory != null)
                    {
                        LoadCategories(ddlCategory);
                    }
                }
            }

        }

        private void LoadCategories(DropDownList ddlCategory)
        {
            string query = "SELECT categoryID, categoryName FROM CATEGORY";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        ddlCategory.DataSource = reader;
                        ddlCategory.DataTextField = "categoryName"; // The name to display in the dropdown
                        ddlCategory.DataValueField = "categoryID";  // The corresponding ID
                        ddlCategory.DataBind();
                    }

                    // Add a default "Select Category" option
                    ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "-1"));
                }
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                // Retrieve product details
                string productName = ((TextBox)GridView1.FooterRow.FindControl("TxtProductName")).Text;
                string description = ((TextBox)GridView1.FooterRow.FindControl("TxtDescription")).Text;
                DropDownList ddlCategory = (DropDownList)GridView1.FooterRow.FindControl("ddlCategory");
                string quantityText = ((TextBox)GridView1.FooterRow.FindControl("TxtQuantity")).Text;

                if (string.IsNullOrEmpty(productName) || string.IsNullOrEmpty(description) || string.IsNullOrEmpty(quantityText) || ddlCategory == null || ddlCategory.SelectedValue == "-1")
                {
                    LblMsg.Text = "Please fill in all required fields and select a valid category.";
                    LblMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                int categoryID = Convert.ToInt32(ddlCategory.SelectedValue);
                float quantity = float.Parse(quantityText);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    conn.Open();

                    // Check if category exists
                    string categoryCheckQuery = "SELECT COUNT(*) FROM CATEGORY WHERE categoryID = @CategoryID";
                    using (SqlCommand categoryCheckCmd = new SqlCommand(categoryCheckQuery, conn))
                    {
                        categoryCheckCmd.Parameters.AddWithValue("@CategoryID", categoryID);
                        int categoryCount = (int)categoryCheckCmd.ExecuteScalar();

                        if (categoryCount == 0)
                        {
                            LblMsg.Text = "The selected category does not exist.";
                            LblMsg.ForeColor = System.Drawing.Color.Red;
                            return;
                        }
                    }
                }

                // Insert the product and get the new ProductID
                int newProductId;
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    conn.Open();

                    // Insert the product
                    string productQuery = @"
                INSERT INTO Products (ProductName, Description, categoryID, quantity) 
                VALUES (@ProductName, @Description, @CategoryID, @Quantity);
                SELECT SCOPE_IDENTITY();";

                    using (SqlCommand cmd = new SqlCommand(productQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductName", productName);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(ddlCategory.SelectedValue));
                        cmd.Parameters.AddWithValue("@Quantity", quantity);

                        newProductId = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    // Insert images
                    for (int i = 1; i <= 4; i++)
                    {
                        FileUpload fileUpload = (FileUpload)GridView1.FooterRow.FindControl($"FileUpload{i}");
                        if (fileUpload.HasFile)
                        {
                            string fileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                            string savePath = Path.Combine(Server.MapPath("Images"), fileName);
                            fileUpload.SaveAs(savePath);

                            string imageQuery = "INSERT INTO PRODUCT_IMAGES (urlImage, ProductID) VALUES (@UrlImage, @ProductID)";
                            using (SqlCommand imgCmd = new SqlCommand(imageQuery, conn))
                            {
                                imgCmd.Parameters.AddWithValue("@UrlImage", $"Images/{fileName}");
                                imgCmd.Parameters.AddWithValue("@ProductID", newProductId);
                                imgCmd.ExecuteNonQuery();
                            }
                        }
                    }

                    // Insert variants
                    string variantOption = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantOption")).Text;
                    string variantValuesText = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantValue")).Text;
                    string variantPricesText = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantPrice")).Text;

                    if (!string.IsNullOrEmpty(variantOption) && !string.IsNullOrEmpty(variantValuesText) && !string.IsNullOrEmpty(variantPricesText))
                    {
                        string[] variantValues = variantValuesText.Split(',');
                        string[] variantPrices = variantPricesText.Split(',');

                        if (variantValues.Length == variantPrices.Length)
                        {
                            for (int i = 0; i < variantValues.Length; i++)
                            {
                                string value = variantValues[i].Trim();
                                decimal price;

                                if (decimal.TryParse(variantPrices[i].Trim(), out price))
                                {
                                    string variantQuery = @"
                INSERT INTO PRODUCT_VARIANTS (ProductID, VariantOption, VariantValue, Price) 
                VALUES (@ProductID, @VariantOption, @VariantValue, @Price)";
                                    using (SqlCommand variantCmd = new SqlCommand(variantQuery, conn))
                                    {
                                        variantCmd.Parameters.AddWithValue("@ProductID", newProductId);
                                        variantCmd.Parameters.AddWithValue("@VariantOption", variantOption);
                                        variantCmd.Parameters.AddWithValue("@VariantValue", value);
                                        variantCmd.Parameters.AddWithValue("@Price", price);

                                        variantCmd.ExecuteNonQuery();
                                    }
                                }
                                else
                                {
                                    // Handle invalid price format
                                    LblMsg.Text = $"Invalid price format for value '{value}'.";
                                    LblMsg.ForeColor = System.Drawing.Color.Red;
                                    return;
                                }
                            }
                        }
                        else
                        {
                            // Handle mismatch in number of values and prices
                            LblMsg.Text = "The number of variant values does not match the number of prices.";
                            LblMsg.ForeColor = System.Drawing.Color.Red;
                            return;
                        }
                    }

                    //// Insert variants
                    //string variantOption = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantOption")).Text;
                    //string variantValue = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantValue")).Text;
                    //string variantPriceText = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantPrice")).Text;

                    //if (!string.IsNullOrEmpty(variantOption) && !string.IsNullOrEmpty(variantValue) && !string.IsNullOrEmpty(variantPriceText))
                    //{
                    //    string[] variantValues = variantValue.Split(','); // Handle multiple values
                    //    decimal price = Convert.ToDecimal(variantPriceText);

                    //    foreach (string value in variantValues)
                    //    {
                    //        string variantQuery = @"
                    //    INSERT INTO PRODUCT_VARIANTS (ProductID, VariantOption, VariantValue, Price) 
                    //    VALUES (@ProductID, @VariantOption, @VariantValue, @Price)";
                    //        using (SqlCommand variantCmd = new SqlCommand(variantQuery, conn))
                    //        {
                    //            variantCmd.Parameters.AddWithValue("@ProductID", newProductId);
                    //            variantCmd.Parameters.AddWithValue("@VariantOption", variantOption);
                    //            variantCmd.Parameters.AddWithValue("@VariantValue", value.Trim());
                    //            variantCmd.Parameters.AddWithValue("@Price", price);

                    //            variantCmd.ExecuteNonQuery();
                    //        }
                    //    }
                    //}
                }
                //string[] variantOptions = { "VariantOption1", "VariantOption2" }; 
                //foreach (string variantOption in variantOptions)
                //{
                //    TextBox variantOptionTextBox = (TextBox)GridView1.FooterRow.FindControl($"Txt{variantOption}");
                //    if (variantOptionTextBox != null && !string.IsNullOrEmpty(variantOptionTextBox.Text))
                //    {
                //        string option = variantOptionTextBox.Text;
                //        TextBox valuesTextBox = (TextBox)GridView1.FooterRow.FindControl($"Txt{variantOption}Values");
                //        TextBox priceTextBox = (TextBox)GridView1.FooterRow.FindControl($"Txt{variantOption}Price");

                //        string[] values = valuesTextBox.Text.Split(',');
                //        decimal price = decimal.Parse(priceTextBox.Text);

                //        foreach (string value in values)
                //        {
                //            string insertVariantQuery = @"
                //        INSERT INTO PRODUCT_VARIANTS (ProductID, VariantOption, VariantValue, Price)
                //        VALUES (@ProductID, @VariantOption, @VariantValue, @Price)";

                //            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                //            {
                //                using (SqlCommand cmd = new SqlCommand(insertVariantQuery, conn))
                //                {
                //                    cmd.Parameters.AddWithValue("@ProductID", productId);
                //                    cmd.Parameters.AddWithValue("@VariantOption", option);
                //                    cmd.Parameters.AddWithValue("@VariantValue", value.Trim());
                //                    cmd.Parameters.AddWithValue("@Price", price);
                //                    conn.Open();
                //                    cmd.ExecuteNonQuery();
                //                }
                //            }
                //        }
                //    }
                //}



                // Refresh GridView
                GridView1.DataBind();
                // Success message
                LblMsg.Text = "Product added successfully.";
                LblMsg.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                LblMsg.Text = $"Error: {ex.Message}";
                LblMsg.ForeColor = System.Drawing.Color.Red;
            }

            //try
            //{
            //    ProductsDataSource.InsertParameters["ProductName"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("TxtProductName")).Text;
            //    ProductsDataSource.InsertParameters["Price"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("TxtPrice")).Text;
            //    FileUpload fileUpload = ((FileUpload)GridView1.FooterRow.FindControl("FileUpload1"));
            //    if (fileUpload.HasFile)
            //    {
            //        string extension = Path.GetExtension(fileUpload.PostedFile.FileName);
            //        string fileName = DateTime.Now.ToString("_MMddyyyy_HHmmss") + extension;

            //        //string fileName = Path.GetFileName(fileUpload.PostedFile.FileName);
            //        fileUpload.SaveAs(Server.MapPath("ImagesData/" + fileName));
            //        ProductsDataSource.InsertParameters["URLImage"].DefaultValue = "ImagesData/" + fileName;
            //        LblMsg.Text = "Success";
            //        LblMsg.ForeColor = System.Drawing.Color.Green;
            //    }
            //    ProductsDataSource.Insert();
            //    GridView1.PageIndex = GridView1.PageCount;
            //}
            //catch (Exception Err)
            //{
            //    LblMsg.Text = Err.Message;
            //    LblMsg.ForeColor = System.Drawing.Color.Red;
            //}

        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            FileUpload FileUpload1 = (FileUpload)GridView1.FooterRow.FindControl("FileUpload1");
            CustomValidator CustomValidator1 = (CustomValidator)GridView1.FooterRow.FindControl("CustomValidator1");
            args.IsValid = false;
            double filesize = FileUpload1.FileContent.Length;
            if (filesize > 1000000)
            {
                CustomValidator1.ErrorMessage = "Invalid File, FileSize Limits Exceeded.";
                return;
            }
            string[] validFileTypes = { "bmp", "gif", "png", "jpg", "jpeg", "icon" };
            string ext = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);

            CustomValidator1.ErrorMessage = "Invalid File, extension not in (" + string.Join(",", validFileTypes) + ")";
            foreach (string fileExt in validFileTypes)
            {
                if (ext == "." + fileExt)
                {
                    args.IsValid = true;
                    break;
                }
            }
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Image img = (Image)GridView1.Rows[e.RowIndex].FindControl("Image1");

            string path = Server.MapPath(img.ImageUrl);
            FileInfo file = new FileInfo(path);
            if (file.Exists)
            {
                file.Delete();
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                FileUpload FileUpload2 = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("FileUpload2");
                if (FileUpload2.HasFile)
                {
                    string extension = Path.GetExtension(FileUpload2.PostedFile.FileName);
                    string fileName = DateTime.Now.ToString("_MMddyyyy_HHmmss") + extension;

                    FileUpload2.SaveAs(MapPath("ImagesData/" + fileName));
                    ProductsDataSource.UpdateParameters["URLImage"].DefaultValue = "ImagesData/" + fileName;
                }
                else
                {
                    Image img = (Image)GridView1.Rows[e.RowIndex].FindControl("Image1");
                    ProductsDataSource.UpdateParameters["URLImage"].DefaultValue = img.ImageUrl.Substring(img.ImageUrl.LastIndexOf(@"/") + 1);
                }
            }
            catch (Exception Err)
            {
                LblMsg.Text = Err.Message;
                LblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void ProductsDataSource_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1) LblMsg.Text = "No Data Found ...";
            else LblMsg.Text = string.Empty;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get the comma-separated image URLs
                string allImages = DataBinder.Eval(e.Row.DataItem, "AllImages").ToString();

                // Split the image URLs into an array
                string[] imageUrls = allImages.Split(',');

                // Find the Repeater control inside the GridView row
                Repeater repeater = (Repeater)e.Row.FindControl("Repeater1");

                // Set the DataSource to the array of image URLs and bind it
                repeater.DataSource = imageUrls;
                repeater.DataBind();
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get the ProductID from the parent row
                int productID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ProductID"));

                // Find the nested GridView (in the ItemTemplate)
                GridView nestedGridView = (GridView)e.Row.FindControl("NestedGridView");

                // Set the DataSource for the nested GridView based on the ProductID
                nestedGridView.DataSource = GetVariantsByProductID(productID);
                nestedGridView.DataBind();
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                DropDownList ddlCategory = (DropDownList)e.Row.FindControl("ddlCategory");
                if (ddlCategory != null)
                {
                    LoadCategories(ddlCategory);
                }
            }

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex >= 0)
            {
                // Get the selected row
                GridViewRow selectedRow = GridView1.SelectedRow;

                // Retrieve the ProductID of the selected row
                int productId = Convert.ToInt32(GridView1.DataKeys[selectedRow.RowIndex].Value);

                // Use this ProductID for further operations
                ViewState["SelectedProductID"] = productId; // Store in ViewState for reuse
            }
            else
            {
                // Handle invalid selection
                LblMsg.Text = "Invalid selection. Please select a valid product.";
                LblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected DataTable GetVariantsByProductID(object productID)
        {
            string query = "SELECT VariantID, VariantOption, VariantValue, Price FROM PRODUCT_VARIANTS WHERE ProductID = @ProductID";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        protected void NestedGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView nestedGridView = (GridView)sender;
            nestedGridView.EditIndex = e.NewEditIndex;

            GridViewRow parentRow = (GridViewRow)nestedGridView.NamingContainer;
            int productID = Convert.ToInt32(GridView1.DataKeys[parentRow.RowIndex].Value);

            nestedGridView.DataSource = GetVariantsByProductID(productID);
            nestedGridView.DataBind();
        }

        protected void NestedGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView nestedGridView = (GridView)sender;
            GridViewRow parentRow = (GridViewRow)nestedGridView.NamingContainer;

            int productID = Convert.ToInt32(GridView1.DataKeys[parentRow.RowIndex].Value);

            nestedGridView.EditIndex = -1;
            nestedGridView.DataSource = GetVariantsByProductID(productID);
            nestedGridView.DataBind();
        }

        protected void NestedGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridView nestedGridView = (GridView)sender;
            GridViewRow parentRow = (GridViewRow)nestedGridView.NamingContainer;

            int productID = Convert.ToInt32(GridView1.DataKeys[parentRow.RowIndex].Value);
            int variantID = Convert.ToInt32(nestedGridView.DataKeys[e.RowIndex].Value);

            TextBox txtOption = (TextBox)nestedGridView.Rows[e.RowIndex].FindControl("txtEditVariantOption");
            TextBox txtValue = (TextBox)nestedGridView.Rows[e.RowIndex].FindControl("txtEditVariantValue");
            TextBox txtPrice = (TextBox)nestedGridView.Rows[e.RowIndex].FindControl("txtEditVariantPrice");

            string query = "UPDATE PRODUCT_VARIANTS SET VariantOption = @Option, VariantValue = @Value, Price = @Price WHERE VariantID = @VariantID";
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Option", txtOption.Text);
                cmd.Parameters.AddWithValue("@Value", txtValue.Text);
                cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
                cmd.Parameters.AddWithValue("@VariantID", variantID);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            nestedGridView.EditIndex = -1;
            nestedGridView.DataSource = GetVariantsByProductID(productID);
            nestedGridView.DataBind();
        }

        protected void BtnAddVariant_Click(object sender, EventArgs e)
        {
            try
            {
                // Ensure a product is selected
                if (ViewState["SelectedProductID"] == null)
                {
                    LblMsg.Text = "Please select a product before adding variants.";
                    LblMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                int productId = Convert.ToInt32(ViewState["SelectedProductID"]);

                // Get the variant details
                string variantOption = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantOption")).Text;
                string variantValues = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantValue")).Text;
                string variantPrices = ((TextBox)GridView1.FooterRow.FindControl("TxtVariantPrice")).Text;

                // Ensure all required fields are filled
                if (string.IsNullOrWhiteSpace(variantOption) || string.IsNullOrWhiteSpace(variantValues) || string.IsNullOrWhiteSpace(variantPrices))
                {
                    LblMsg.Text = "All fields are required for adding variants.";
                    LblMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Split values and prices for multiple entries
                string[] values = variantValues.Split(',');
                string[] prices = variantPrices.Split(',');

                if (values.Length != prices.Length)
                {
                    LblMsg.Text = "The number of variant values and prices must match.";
                    LblMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Insert variants into the database
                string query = "INSERT INTO PRODUCT_VARIANTS (ProductID, VariantOption, VariantValue, Price) VALUES (@ProductID, @VariantOption, @VariantValue, @Price)";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    conn.Open();
                    for (int i = 0; i < values.Length; i++)
                    {
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@ProductID", productId);
                            cmd.Parameters.AddWithValue("@VariantOption", variantOption.Trim());
                            cmd.Parameters.AddWithValue("@VariantValue", values[i].Trim());
                            cmd.Parameters.AddWithValue("@Price", decimal.Parse(prices[i].Trim()));
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                LblMsg.Text = "Variants added successfully!";
                LblMsg.ForeColor = System.Drawing.Color.Green;

                // Clear input fields
                ((TextBox)GridView1.FooterRow.FindControl("TxtVariantOption")).Text = string.Empty;
                ((TextBox)GridView1.FooterRow.FindControl("TxtVariantValue")).Text = string.Empty;
                ((TextBox)GridView1.FooterRow.FindControl("TxtVariantPrice")).Text = string.Empty;

                // Refresh the variant grid
                GridViewRow parentRow = GridView1.SelectedRow;
                GridView nestedGridView = (GridView)parentRow.FindControl("NestedGridView");
                nestedGridView.DataSource = GetVariantsByProductID(productId);
                nestedGridView.DataBind();
            }
            catch (Exception ex)
            {
                LblMsg.Text = "Error adding variants: " + ex.Message;
                LblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        private DataTable GetVariantTableFromGrid(GridView nestedGridView)
        {
            // Create a DataTable to hold the variant data
            DataTable variantTable = new DataTable();

            // Add columns for the variant table
            variantTable.Columns.Add("VariantOption", typeof(string));
            variantTable.Columns.Add("VariantValue", typeof(string));
            variantTable.Columns.Add("Price", typeof(decimal));

            // Loop through the rows of the NestedGridView (variant grid) to extract data
            foreach (GridViewRow row in nestedGridView.Rows)
            {
                // Check if the row is in edit mode
                if (row.RowType == DataControlRowType.DataRow)
                {
                    // Retrieve the variant option, value, and price from the current row
                    string variantOption = ((TextBox)row.FindControl("TxtVariantOption")).Text;
                    string variantValue = ((TextBox)row.FindControl("TxtVariantValue")).Text;
                    decimal variantPrice = decimal.Parse(((TextBox)row.FindControl("TxtVariantPrice")).Text);

                    // Add the data to the DataTable
                    DataRow newRow = variantTable.NewRow();
                    newRow["VariantOption"] = variantOption;
                    newRow["VariantValue"] = variantValue;
                    newRow["Price"] = variantPrice;
                    variantTable.Rows.Add(newRow);
                }
            }

            return variantTable;
        }

    }
}