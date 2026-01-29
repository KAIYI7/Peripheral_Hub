<%@ Page Title="" Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard_Order.aspx.cs" Inherits="PeripheralHub.Dashboard_Order" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .jumbotron {
            margin-top: 8% !important;
        }
    </style>

    <div class="jumbotron container">
        
        <div class="row text-center">
            <div class="col-md-3">
                Search Option :<asp:DropDownList ID="DropDownList1" AutoPostBack="true" CssClass="form-control" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Selected="True" Value="1">Order ID</asp:ListItem>
                    <asp:ListItem Value="2">Order Date</asp:ListItem>
                    <asp:ListItem Value="3">Between two Order Date</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div id="div1" runat="server" class="col-sm-4">
                Order ID :<asp:TextBox ID="TxtNumCmd" TextMode="Number" CssClass="form-control" Placeholder="'Enter Order ID'" runat="server"></asp:TextBox>
            </div>
            <div id="div2" runat="server" class="col-sm-4" visible="false">
                Order Date :<asp:TextBox ID="TxtDate" CssClass="form-control" Placeholder="'Enter Order Date'" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date" Display="Dynamic" ForeColor="Red" ControlToValidate="TxtDate" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TxtDate" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field"></asp:RequiredFieldValidator>
            </div>
            <div id="div3" runat="server" class="col-sm-4" visible="false">
                Start Date :<asp:TextBox ID="TxtDate1" CssClass="form-control" Placeholder="'Enter Start Date'" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TxtDate1" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="Required Field"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Start Date" Display="Dynamic" ForeColor="Red" ControlToValidate="TxtDate1" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$"></asp:RegularExpressionValidator>
                <br />
                End Date :<asp:TextBox ID="TxtDate2" CssClass="form-control" Placeholder="'Enter End Date'" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="TxtDate2" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="Required Field"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Invalid End Date" Display="Dynamic" ForeColor="Red" ControlToValidate="TxtDate2" ValidationExpression="^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$"></asp:RegularExpressionValidator>
            </div>
            <div id="div4" runat="server" class="col-sm-4" visible="false">
                User ID :<asp:TextBox ID="TxtNumClient" CssClass="form-control" Placeholder="'Enter Username'" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-3 pull-right">
                <br />
                <asp:Button ID="BtnSearch" CssClass="btn" runat="server" Text="Search" OnClick="BtnSearch_Click"  />
            </div>
        </div>
                <br />
                <asp:Label ID="LblMsg" CssClass="text-center center-block" runat="server" Text=""></asp:Label>
<br />
        <%--<asp:GridView ID="GridView1" GridLines="None" CssClass="table table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="OrderListDataSource" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                <asp:BoundField DataField="ProductID" HeaderText="ProductID" SortExpression="ProductID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="VariantOption" HeaderText="VariantOption" SortExpression="VariantOption" />
                <asp:BoundField DataField="VariantValue" HeaderText="VariantValue" SortExpression="VariantValue" />
                <asp:BoundField DataField="quantity" HeaderText="quantity" SortExpression="quantity" />
                <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
                <asp:BoundField DataField="Total Price" HeaderText="Total Price" ReadOnly="True" SortExpression="Total Price" />
            </Columns>
        </asp:GridView>--%>

        <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" DataSourceID="OrdersDataSource"
    OnRowCommand="GridViewOrders_RowCommand" CssClass="table table-bordered" 
    EmptyDataText="No orders found" AllowPaging="True" PageSize="10">
    <Columns>
        <asp:BoundField DataField="OrderID" HeaderText="Order ID" SortExpression="OrderID" />
        <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" SortExpression="TotalPrice" DataFormatString="RM{0:F2}" />
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

        <div style="text-align:center;">
            <h1>Sales Report</h1>
        <asp:Chart ID="SalesChart" runat="server" Width="600px" Height="400px">
            <Series>
                <asp:Series Name="SalesSeries"></asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
            <Legends>
                <asp:Legend Name="Sales"></asp:Legend>
            </Legends>
        </asp:Chart>
            <br /><br />
            <h1>Top 5 Products</h1>
        <asp:Chart ID="TopProductsChart" runat="server" Width="600px" Height="400px">
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
            <Series>
                <asp:Series Name="ProductsSeries" ChartType="Pie"></asp:Series>
            </Series>
            <Legends>
                <asp:Legend Name="Top Products"></asp:Legend>
            </Legends>
        </asp:Chart>
        </div>
        <asp:SqlDataSource ID="OrderListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Orders] WHERE [OrderID] = @OrderID" InsertCommand="INSERT INTO [Orders] ([OrderDate], [UserID], [ProductID], [Quantity]) VALUES (@OrderDate, @UserID, @ProductID, @Quantity)" SelectCommand="SELECT Orders.OrderID, Users.Username, Products.ProductID, Products.ProductName, CONVERT (DATE, Orders.OrderDate) AS OrderDate, PRODUCT_VARIANTS.VariantOption, PRODUCT_VARIANTS.VariantValue, ORDER_DETAILS.quantity, ORDER_DETAILS.price, ORDER_DETAILS.price * ORDER_DETAILS.quantity AS 'Total Price' FROM Orders INNER JOIN Users ON Orders.UserID = Users.UserID INNER JOIN ORDER_DETAILS ON Orders.OrderID = ORDER_DETAILS.orderID INNER JOIN PRODUCT_VARIANTS ON ORDER_DETAILS.VariantID = PRODUCT_VARIANTS.VariantID INNER JOIN Products ON PRODUCT_VARIANTS.ProductID = Products.ProductID" UpdateCommand="UPDATE [Orders] SET [OrderDate] = @OrderDate, [UserID] = @UserID, [ProductID] = @ProductID, [Quantity] = @Quantity WHERE [OrderID] = @OrderID" OnSelected="OrderListDataSource_Selected">
            <DeleteParameters>
                <asp:Parameter Name="OrderID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="OrderDate" Type="DateTime" />
                <asp:Parameter Name="UserID" Type="Int32" />
                <asp:Parameter Name="ProductID" Type="Int32" />
                <asp:Parameter Name="Quantity" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="OrderDate" Type="DateTime" />
                <asp:Parameter Name="UserID" Type="Int32" />
                <asp:Parameter Name="ProductID" Type="Int32" />
                <asp:Parameter Name="Quantity" Type="Int32" />
                <asp:Parameter Name="OrderID" Type="Int32" />
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
                   GROUP BY Orders.OrderID, Users.Username, CONVERT(DATE, Orders.OrderDate)
                   "/>
    </div>
</asp:Content>
