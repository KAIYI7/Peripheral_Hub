<%@ Page Title="Order" Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="Clients_Order.aspx.cs" Inherits="PeripheralHub.Clients_Order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Order</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    
        <style>
            body{
                background-color:#2d2d30;
            }
        .jumbotron{
    margin-top:8% !important;
}
    </style>
    <div class="jumbotron container">
        
        <asp:Label ID="LblMsg" CssClass="text-center center-block" runat="server" Text=""></asp:Label>
    <asp:HiddenField ID="HiddenField1" runat="server" OnValueChanged="HiddenField1_ValueChanged" />

    <%--<asp:GridView ID="GridView1" GridLines="None" CssClass="table table-hover" runat="server" DataSourceID="OrderListDataSource" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
            <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
            <asp:BoundField DataField="ProductID" HeaderText="ProductID" SortExpression="ProductID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
            <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd}"/>
            <asp:BoundField DataField="VariantOption" HeaderText="VariantOption" SortExpression="VariantOption" />
            <asp:BoundField DataField="VariantValue" HeaderText="VariantValue" SortExpression="VariantValue" />
            <asp:BoundField DataField="quantity" HeaderText="quantity" SortExpression="quantity" />
            <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
            <asp:BoundField DataField="Total Price" HeaderText="Total Price" ReadOnly="True" SortExpression="Total Price" />
        </Columns>
        </asp:GridView>--%>

                <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" DataSourceID="OrdersDataSource"
    OnRowCommand="GridViewOrders_RowCommand" CssClass="table table-bordered" 
    EmptyDataText="No orders found" AllowPaging="True" DataKeyNames="OrderID">
    <Columns>
        <asp:BoundField DataField="OrderID" HeaderText="OrderID" SortExpression="OrderID" InsertVisible="False" ReadOnly="True" />
        <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
        <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" ReadOnly="True" />
        <asp:BoundField DataField="TotalPrice" HeaderText="TotalPrice" SortExpression="TotalPrice" ReadOnly="True" />
        <asp:TemplateField HeaderText="Details">
    <ItemTemplate>
        <asp:LinkButton ID="lnkDetails" runat="server" Text="View Details" CommandName="ViewDetails" CommandArgument='<%# Eval("OrderID") %>' />
    </ItemTemplate>
</asp:TemplateField>
    </Columns>
</asp:GridView>

        <asp:GridView ID="GridViewOrderDetails" runat="server" AutoGenerateColumns="False" 
    CssClass="table table-bordered" EmptyDataText="No order details found" DataSourceID="OrderDetailsDataSource">
    <Columns>
        <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
        <asp:BoundField DataField="VariantOption" HeaderText="Variant Option" SortExpression="VariantOption" />
        <asp:BoundField DataField="VariantValue" HeaderText="Variant Value" SortExpression="VariantValue" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="RM{0:F2}" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" SortExpression="TotalPrice" DataFormatString="RM{0:F2}" />
    </Columns>
</asp:GridView>
    </div>
    <asp:SqlDataSource ID="OrderListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Orders] WHERE [OrderID] = @OrderID" InsertCommand="INSERT INTO [Orders] ([OrderDate], [UserID], [ProductID], [Quantity]) VALUES (@OrderDate, @UserID, @ProductID, @Quantity)" SelectCommand="SELECT Users.Username, Orders.OrderID, Products.ProductID, Products.ProductName, CONVERT (DATE, Orders.OrderDate) AS OrderDate, PRODUCT_VARIANTS.VariantOption, PRODUCT_VARIANTS.VariantValue, ORDER_DETAILS.quantity, ORDER_DETAILS.price, ORDER_DETAILS.price * ORDER_DETAILS.quantity AS 'Total Price' FROM Orders INNER JOIN Users ON Orders.UserID = Users.UserID INNER JOIN ORDER_DETAILS ON Orders.OrderID = ORDER_DETAILS.orderID INNER JOIN PRODUCT_VARIANTS ON ORDER_DETAILS.VariantID = PRODUCT_VARIANTS.VariantID INNER JOIN Products ON PRODUCT_VARIANTS.ProductID = Products.ProductID WHERE (Users.Username = @Username)" UpdateCommand="UPDATE [Orders] SET [OrderDate] = @OrderDate, [UserID] = @UserID, [ProductID] = @ProductID, [Quantity] = @Quantity WHERE [OrderID] = @OrderID" OnSelected="OrderListDataSource_Selected">
        <DeleteParameters>
            <asp:Parameter Name="OrderID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OrderDate" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="ProductID" />
            <asp:Parameter Name="Quantity" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="Username" SessionField="Username" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="OrderDate" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="ProductID" />
            <asp:Parameter Name="Quantity" />
            <asp:Parameter Name="OrderID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ClientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO [Users] ([Username]) VALUES (@Username)" SelectCommand="SELECT [UserID], [Username] FROM [Users]" UpdateCommand="UPDATE [Users] SET [Username] = @Username WHERE [UserID] = @UserID">
        <DeleteParameters>
            <asp:Parameter Name="UserID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Username" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Username" />
            <asp:Parameter Name="UserID" />
        </UpdateParameters>
    </asp:SqlDataSource>
            <asp:SqlDataSource ID="OrderDetailsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT Products.ProductID, Products.ProductName, PRODUCT_VARIANTS.VariantOption, PRODUCT_VARIANTS.VariantValue, ORDER_DETAILS.Quantity, ORDER_DETAILS.Price, 
            ORDER_DETAILS.price * ORDER_DETAILS.quantity AS TotalPrice
                   FROM ORDER_DETAILS
                   INNER JOIN PRODUCTS ON ORDER_DETAILS.ProductID = PRODUCTS.ProductID
                   INNER JOIN PRODUCT_VARIANTS ON ORDER_DETAILS.VariantID = PRODUCT_VARIANTS.VariantID
                   WHERE ORDER_DETAILS.OrderID = @OrderID">
    <SelectParameters>
        <asp:Parameter Name="OrderID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

        <asp:SqlDataSource ID="OrdersDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT Orders.OrderID, 
                          Users.Username, 
                          CONVERT(DATE, Orders.OrderDate) AS OrderDate,
                          SUM(ORDER_DETAILS.price * ORDER_DETAILS.quantity) AS 'TotalPrice' 
                   FROM Orders
                   INNER JOIN Users ON Orders.UserID = Users.UserID
                   INNER JOIN ORDER_DETAILS ON Orders.OrderID = ORDER_DETAILS.OrderID
                   INNER JOIN PRODUCT_VARIANTS ON ORDER_DETAILS.VariantID = PRODUCT_VARIANTS.VariantID
                   INNER JOIN Products ON PRODUCT_VARIANTS.ProductID = Products.ProductID
                   WHERE Users.Username = @Username
                   GROUP BY Orders.OrderID, Users.Username, CONVERT(DATE, Orders.OrderDate)
                   ">
            <SelectParameters>
                <asp:SessionParameter Name="Username" SessionField="Username" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>
