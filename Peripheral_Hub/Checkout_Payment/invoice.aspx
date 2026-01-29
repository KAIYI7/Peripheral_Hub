<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invoice.aspx.cs" Inherits="eCommerce_ASP.Net.Checkout_Payment.invoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Invoice</title>
    <link rel="stylesheet" href="invoice.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .invoice {
            max-width: 800px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .invoice-header div:first-child {
            font-size: 18px;
            color: #333;
        }

        .invoice-header div:last-child {
            text-align: right;
        }

        h2 {
            color: #555;
        }

        .customer-details, .order-details, .payment-details {
            margin-bottom: 20px;
        }

        .customer-details p, .order-details p, .payment-details p {
            margin: 8px 0;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .order-table th, .order-table td {
            text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
        }

        .order-table th {
            background-color: #f9f9f9;
            color: #333;
        }

        .total-row {
            font-weight: bold;
            text-align: right;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container button {
            margin: 0 10px;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-container button:first-child {
            background-color: #28a745;
            color: #fff;
        }

        .button-container button:last-child {
            background-color: #007bff;
            color: #fff;
        }

        @media print {
            .button-container {
                display: none;
            }
        }
    </style>
</head>

<body>
    <form runat="server">
        <div class="invoice">
            <div class="invoice-header">
                <div>
                    <p><strong>PeripheralHub</strong></p>
                    <p>Jalan Genting Kelang,<br />Setapak,<br />53300 Kuala Lumpur.</p>
                </div>
                <div>
                    <h2>Order Invoice</h2>
                </div>
            </div>

            <div class="customer-details">
                <h3>Customer Details</h3>
                <p><strong>Name:</strong> <asp:Label ID="lblCustomerName" runat="server"></asp:Label></p>
                <p><strong>Email:</strong> <asp:Label ID="lblCustomerEmail" runat="server"></asp:Label></p>
                <p><strong>Contact:</strong> <asp:Label ID="lblCustomerPhone" runat="server"></asp:Label></p>
                <p><strong>Address:</strong> <asp:Label ID="lblCustomerAddress" runat="server"></asp:Label></p>
            </div>

            <div class="order-details">
                <h3>Order Details</h3>
                <p><strong>Order Date:</strong> <asp:Label ID="lblOrderDate" runat="server"></asp:Label></p>
                <p><strong>Order Serial Number:</strong> <asp:Label ID="lblOrderSerial" runat="server"></asp:Label></p>
                <p><strong>Order Paid Date:</strong> <asp:Label ID="lblPaidDate" runat="server"></asp:Label></p>
                <p><strong>Tax:</strong> RM <asp:Label ID="lblTax" runat="server"></asp:Label></p>
                <p><strong>Total Paid:</strong> RM <asp:Label ID="lblTotal" runat="server"></asp:Label></p>
            </div>

            <div class="button-container">
                <asp:Button ID="btnHome" runat="server" Text="Back to Home Page" OnClick="btnHome_Click" style="background-color: darkgray;color: white;height:40px;width:200px;" />
                <button type="button" onclick="window.print()">Print Invoice</button>
            </div>
        </div>
    </form>
</body>
</html>