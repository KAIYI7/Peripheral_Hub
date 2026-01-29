<%@ Page Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="Peripheral_Hub.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Product Details</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script type="text/javascript">
        function updateMainImage(imageUrl) {
            const mainImage = document.getElementById('<%= MainProductImage.ClientID %>');
            if (mainImage) {
                mainImage.setAttribute('src', imageUrl);
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            var mainImage = document.getElementById('<%= MainProductImage.ClientID %>');
            var zoomContainer = document.querySelector('.zoom-container');
            var zoomLens = document.querySelector('.zoom-lens');

            mainImage.addEventListener('mousemove', function (e) {
                var rect = mainImage.getBoundingClientRect();
                var mouseX = e.pageX - rect.left;
                var mouseY = e.pageY - rect.top;

                // Show the zoom area
                zoomContainer.style.display = 'block';
                zoomLens.style.display = 'block';

                // Position the lens based on the mouse position
                var lensWidth = zoomLens.offsetWidth;
                var lensHeight = zoomLens.offsetHeight;

                var lensX = mouseX - lensWidth / 2;
                var lensY = mouseY - lensHeight / 2;

                if (lensX < 0) lensX = 0;
                if (lensY < 0) lensY = 0;
                if (lensX > mainImage.width - lensWidth) lensX = mainImage.width - lensWidth;
                if (lensY > mainImage.height - lensHeight) lensY = mainImage.height - lensHeight;

                zoomLens.style.left = lensX + 'px';
                zoomLens.style.top = lensY + 'px';

                // Zoom in on the image by changing the background
                var zoomRatio = 2; // How much to zoom
                zoomContainer.style.backgroundImage = 'url(' + mainImage.src + ')';
                zoomContainer.style.backgroundSize = (mainImage.width * zoomRatio) + 'px ' + (mainImage.height * zoomRatio) + 'px';
                zoomContainer.style.backgroundPosition = '-' + (lensX * zoomRatio) + 'px -' + (lensY * zoomRatio) + 'px';
            });

            mainImage.addEventListener('mouseleave', function () {
                zoomContainer.style.display = 'none'; // Hide the zoom container
                zoomLens.style.display = 'none'; // Hide the zoom lens
            });
        });

        <%--document.addEventListener('DOMContentLoaded', function () {
            var mainImage = document.getElementById('<%= MainProductImage.ClientID %>');
            // Make sure the main image is fully loaded before doing any operations
            if (mainImage.complete) {
                initializeMagnifier(mainImage);
            } else {
                initializeMagnifier(mainImage);
            }

            function initializeMagnifier (mainImage) {
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
            };
        });--%>


    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: grid;
            grid-template-columns: 1fr;
            padding: 20px;
            padding-top: 100px;
        }

        .content {
            display: flex;
            gap: 20px;
        }

        .product-image {
            position:relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

            .product-image img {
                width: 376px;
                height: 299px;
                border: 1px solid #ddd;
                border-radius: 8px;
                margin-bottom: 10px;
            }
            .main-product-image {
                width: 376px;
                height: 299px;
                border: 1px solid #ddd;
                border-radius: 8px;
                margin-bottom: 10px;
                object-fit: cover;
                transition: transform 0.2s ease;
                cursor: zoom-in;
            }

            .zoom-container {
                position: relative;
                display: none; /* Hidden by default */
                width: 376px; /* Same as the image width */
                height: 299px; /* Same as the image height */
                overflow: hidden;
                border-radius: 8px;
                border: 2px solid #ddd;
                cursor: none;
            }

            .zoom-lens {
                position: absolute;
                width: 100px; /* Size of the lens */
                height: 100px; /* Size of the lens */
                background: rgba(255, 255, 255, 0.4); /* Semi-transparent lens */
                border: 1px solid #000;
                display: none; /* Hidden by default */
                cursor: crosshair;
            }
            .magnifier-container {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
                z-index: 9999;
                display: none; /* Initially hidden */
                border: 2px solid #ddd;
                border-radius: 8px;
            }

            .magnifier-lens {
                position: absolute;
                width: 100px;
                height: 100px;
                border: 1px solid #000;
                background: rgba(255, 255, 255, 0.6);
                cursor: crosshair;
                display: none; /* Initially hidden */
                z-index: 10000;
            }

        .product-thumbnails {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

            .product-thumbnails img {
                width: 88px;
                height: 73px;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                transition: transform 0.3s;
            }

                .product-thumbnails img:hover {
                    transform: scale(1.1);
                }

        .product-details {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

            .product-details h1 {
                font-size: 22px;
                color: #333;
                margin-bottom: 10px;
            }

            .product-details p {
                color: #666;
                line-height: 1.6;
                margin-bottom: 15px;
            }

        .price {
            font-size: 18px;
            color: #e74c3c;
            margin-bottom: 15px;
        }

        .product-colors {
            margin-bottom: 15px;
        }

            .product-colors label {
                font-weight: bold;
            }

            .product-colors select {
                margin-left: 10px;
                padding: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: black;
            color: #fff;
            border-radius: 4px;
            text-decoration: none;
            text-align: center;
            transition: background 0.3s;
            margin-top: 15px;
        }

            .btn:hover {
                background: #2980b9;
            }
    </style>

    <div class="container">
        <div class="content">
            <!-- Product Images Section -->
            <div class="product-image">
                <!-- Main Image -->
                <asp:Image ID="MainProductImage" runat="server" CssClass="main-product-image" />
                <!-- Zoom container that will hold the magnified view -->
                <div class="zoom-container">
                    <div class="zoom-lens"></div> <!-- Lens element that moves with the mouse -->
                </div>
                <!-- Thumbnails -->
                <div class="product-thumbnails">
                    <asp:Repeater ID="ThumbnailRepeater" runat="server" OnItemDataBound="thumbnailRepeater_ItemDataBound">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("urlImage") %>' alt="Thumbnail" CssClass="thumbnail" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Product Details Section -->
            <div class="product-details">
                <asp:Label ID="LblProductName" runat="server" CssClass="product-title" />
                <asp:Label ID="LblProductDescription" runat="server" CssClass="product-description" />
                <div class="price">
                    <asp:Label ID="LblProductPrice" runat="server" />
                </div>

                <!-- Variant Options -->
                <table>
                    <%--<!-- Color Option -->
                    <tr>
                        <td>
                            <label for="colors">Product Colors:</label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlColors" runat="server" />
                        </td>
                    </tr>
                    <!-- Storage Option -->
                    <tr>
                        <td>
                            <label for="storage">Storage Space:</label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStorage" runat="server" />
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="VariantContainer" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                    <!-- Quantity Option -->
                    <tr>
                        <td>
                            <label for="quantity">Quantity:</label>
                            <asp:DropDownList ID="DropDownList1" runat="server">
                                <%-- Quantity Options from 1 to 10 --%>
                                <asp:ListItem Text="1" Value="1" />
                                <asp:ListItem Text="2" Value="2" />
                                <asp:ListItem Text="3" Value="3" />
                                <asp:ListItem Text="4" Value="4" />
                                <asp:ListItem Text="5" Value="5" />
                                <asp:ListItem Text="6" Value="6" />
                                <asp:ListItem Text="7" Value="7" />
                                <asp:ListItem Text="8" Value="8" />
                                <asp:ListItem Text="9" Value="9" />
                                <asp:ListItem Text="10" Value="10" />
                            </asp:DropDownList>
                        </td>

                    </tr>
                </table>

                <!-- Add to Cart Button -->
                <asp:Button ID="btnAddToCart" CssClass="btn" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" />
            </div>
        </div>
    </div>
    
</asp:Content>
