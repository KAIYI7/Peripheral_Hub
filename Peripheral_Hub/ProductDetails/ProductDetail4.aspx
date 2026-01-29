<%@ Page Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="ProductDetail4.aspx.cs" Inherits="eCommerce_ASP.Net.ProductDetails.ProductDetail4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Iphone 16 Pro Max</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            background: #3498db;
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
                <div class="product-image">
                    <img src="../Images/iPhone16ProMax.png" alt="Main Product Image">
                    <div class="product-thumbnails">
                        <img src="../Images/iphone16ProMax1.jpg" alt="Thumbnail 1">
                        <img src="../Images/iphone16ProMax2.jpg" alt="Thumbnail 2">
                        <img src="../Images/iphone16ProMax3.jpg" alt="Thumbnail 3">
                        <img src="../Images/iphone16ProMax4.jpg" alt="Thumbnail 4">
                    </div>
                </div>

                <div class="product-details">
                    <h1>iPhone 16 Pro Max</h1>
                    <p>Colour: Space Black / Silver / Deep Purple<br>
                    Material: Aluminum and Glass<br>
                    Size: Width: 77.6 mm, Length: 160.7 mm, Thickness: 7.8 mm<br>
                    Description: Sleek design with advanced features and exceptional performance</p>
                    <div class="price">RM6000.00</div>

                    <div class="product-colors">
                        <label for="colors">Product Colours:</label>
                        <select id="colors">
                            <option value="yellow">Yellow</option>
                            <option value="white">White</option>
                            <option value="cyan">Cyan</option>
                        </select>
                    </div>

                    <a href="#" class="btn">Add to Cart</a>
                </div>
            </div>
        </div>

</asp:Content>   
