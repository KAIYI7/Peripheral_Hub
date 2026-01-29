<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site_Clients.Master" CodeBehind="ProductDetail1.aspx.cs" Inherits="eCommerce_ASP.Net.ProductDetail1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Product Details</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
        <div class="product-details-container">
            <!-- Product Images Section -->
            <div class="product-images">
                <asp:Image ID="imgProduct" runat="server" CssClass="main-image" />
                <div class="thumbnail-gallery">
                    <!-- Placeholder for additional thumbnails -->
                    <asp:Repeater ID="rptThumbnails" runat="server">
                        <ItemTemplate>
                            <asp:Image ID="imgThumbnail" runat="server" CssClass="thumbnail" ImageUrl='<%# Eval("ThumbnailUrl") %>' />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Product Details Section -->
            <div class="product-details">
                <asp:Label ID="lblProductName" runat="server" CssClass="product-title" Text="Product Name"></asp:Label>
                <asp:Label ID="lblPrice" runat="server" CssClass="product-price" Text="RM 99.99"></asp:Label>

                <!-- Apply Voucher Section -->
                <div class="voucher-section">
                    <label for="txtVoucher">Apply Voucher:</label>
                    <asp:TextBox ID="txtVoucher" runat="server" CssClass="voucher-input" Placeholder="Enter voucher code"></asp:TextBox>
                    <asp:Button ID="btnApplyVoucher" runat="server" CssClass="apply-btn" Text="Apply"/>
                </div>

                <!-- Product Ratings -->
                <div class="ratings">
                    <span class="stars">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star-half-alt"></i>
                        <i class="fa fa-star-o"></i>
                    </span>
                    <asp:Label ID="lblRatingCount" runat="server" CssClass="rating-count" Text="(120 reviews)"></asp:Label>
                </div>

                <!-- Customization Options -->
                <div class="customization-section">
                    <label for="ddlCustomization">Choose Customization:</label>
                    <asp:DropDownList ID="ddlCustomization" runat="server" CssClass="customization-dropdown">
                        <asp:ListItem Text="Red" Value="Red"></asp:ListItem>
                        <asp:ListItem Text="Blue" Value="Blue"></asp:ListItem>
                        <asp:ListItem Text="Size M" Value="SizeM"></asp:ListItem>
                        <asp:ListItem Text="Size L" Value="SizeL"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Add to Cart -->
                <div class="add-to-cart">
                    <asp:Button ID="btnAddToCart" runat="server" CssClass="cart-btn" Text="Add to Cart"/>
                </div>
            </div>
        </div>

</asp:Content>

