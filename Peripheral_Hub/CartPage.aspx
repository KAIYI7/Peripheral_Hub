<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site_Clients.Master" CodeBehind="CartPage.aspx.cs" Inherits="eCommerce_ASP.Net.CartPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Cart Page</title>
    <style>
        .cart-grid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px; /* Adds spacing between rows */
            margin-top: 20px;
        }

            .cart-grid th {
                background-color: #f8f9fa;
                font-weight: bold;
                text-align: left;
                padding: 10px;
                border: 1px solid #dee2e6;
            }

            .cart-grid td {
                background-color: #ffffff;
                padding: 10px;
                border: 1px solid #dee2e6;
                vertical-align: middle;
            }

            .cart-grid img {
                border: 1px solid #ccc;
                border-radius: 5px;
            }

        .cart-panel {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .cart-header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .checkout-button {
            display: block;
            width: 100%;
            max-width: 200px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-align: center;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 20px auto 0;
        }

            .checkout-button:hover {
                background-color: #0056b3;
            }

        .message-label {
            color: #dc3545;
            font-weight: bold;
        }

        .grand-total-container {
            text-align: right; /* Align to the right */
            margin-top: 20px;
            margin-right: 15px; /* Adjust margin to position correctly */
        }

        .grand-total-label {
            font-size: 20px;
            font-weight: bold;
            color: #e74c3c; /* Red color for emphasis */
            background-color: #f8f9fa; /* Light background for contrast */
            padding: 10px 20px; /* Padding for better visibility */
            border: 2px solid #e74c3c; /* Border to highlight */
            border-radius: 8px; /* Rounded corners */
            display: inline-block; /* Keeps label in place */
            box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.2); /* Subtle shadow for depth */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    <asp:Panel ID="CartPanel" runat="server" CssClass="cart-panel">
        <br />
        <br />
        <br />
        <asp:Label ID="LblHeader" runat="server" Text="My Cart" CssClass="cart-header"></asp:Label>
        <br />
        <br />
        <asp:Label ID="LblMsg" runat="server" CssClass="message-label"></asp:Label>
        <br />

        <asp:GridView ID="CartGridView" runat="server" AutoGenerateColumns="False" CssClass="cart-grid" GridLines="None" OnRowCommand="CartGridView_RowCommand">
            <Columns>

                <asp:TemplateField>
    <ItemTemplate>
        <asp:HiddenField ID="HiddenCartItemID" runat="server" Value='<%# Eval("CartItemID") %>' />
    </ItemTemplate>
</asp:TemplateField>

                <asp:TemplateField HeaderText="Product Image">
                    <ItemTemplate>
                        <asp:Image ID="ProductImage" runat="server" ImageUrl='<%# Eval("ProductImage") %>' Width="100px" Height="100px" />
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:BoundField DataField="ProductName" HeaderText="Product Name" />


                <asp:BoundField DataField="Specifications" HeaderText="Specifications" />


                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="TxtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-textbox" />
                        <asp:Button ID="BtnUpdateQuantity" runat="server" Text="Update" CommandName="UpdateQuantity" CommandArgument='<%# Eval("CartItemID") %>' CssClass="update-button" />
                    </ItemTemplate>
                </asp:TemplateField>

                

                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal (RM)" DataFormatString="{0:0.00}" />

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="BtnRemove" runat="server" Text="Remove" CommandName="RemoveItem" CommandArgument='<%# Eval("CartItemID") %>' CssClass="remove-button" />
                    </ItemTemplate>
                </asp:TemplateField>

                                <asp:TemplateField>
    <ItemTemplate>
        <asp:HiddenField ID="HiddenSubtotal" runat="server" Value='<%# Eval("Subtotal") %>' />
    </ItemTemplate>
</asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="grand-total-container">
            <asp:Label ID="LblGrandTotal" runat="server" CssClass="grand-total-label" Text="Grand Total: RM 0.00"></asp:Label>
        </div>
        <br />
        <asp:Button ID="BtnCheckout" runat="server" Text="Proceed to Checkout" CssClass="checkout-button" OnClick="BtnCheckout_Click" />
    </asp:Panel>
</asp:Content>