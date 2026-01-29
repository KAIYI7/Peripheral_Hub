<%@ Page Title="Products" Language="C#" ValidateRequest="false" EnableEventValidation="false" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="Clients_Products.aspx.cs" Inherits="PeripheralHub.Clients_Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Products</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">

    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="Images/Iphone16ProMaxAds.jpg" alt="Iphone" width="1200" height="700">
                <div class="carousel-caption">
                    <h1>IPHONE 16 Pro Max</h1>
                    <p>Purchase at Peripheral Hub today.</p>
                </div>
            </div>

            <div class="item">
                <img src="Images/razerMouseAds.png" alt="Razer" width="1200" height="700">
                <div class="carousel-caption">
                    <h1>Razer Mice</h1>
                    <p>For Gamers. By Gamers</p>
                </div>
            </div>

            <div class="item">
                <img src="Images/BeatsHeadphoneAds.jpg" alt="Beats" width="1200" height="700">
                <div class="carousel-caption">
                    <h1>Beats Headphone</h1>
                    <p>The Game Starts Here.</p>
                </div>
            </div>
        </div>

        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <%--<asp:PostBackTrigger ControlID="BtnPay" />--%>
            <%--            <asp:AsyncPostBackTrigger ControlID="BtnBuy" EventName="Click" />--%>
        </Triggers>
        <ContentTemplate>
    <%--<label for="ProductSearch">Search by Product Name:</label>
    <asp:TextBox ID="ProductSearch" runat="server"/>
    <asp:Button ID="BtnSearch" runat="server" Text="Search" OnClick="BtnSearch_Click" />--%>
</div>
            <div id="band" class="container">
                <h2 class="text-center">Buy Your Product Now.</h2>
                <br />
                <asp:Label ID="LblMsg" runat="server" Text=""></asp:Label>
                <br />

<%--                <asp:ListView ID="ListView1" runat="server" GroupItemCount="3" GroupPlaceholderID="groupPlaceHolder1"
                    ItemPlaceholderID="itemPlaceHolder1">
                    <LayoutTemplate>
                        <div class="row text-center">
                            <table>
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                            </table>
                        </div>
                    </LayoutTemplate>
                    <GroupTemplate>
                        <tr>
                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                        </tr>
                    </GroupTemplate>
                    <ItemTemplate>
                        <div class="col-sm-4">
                            <div class="thumbnail">
                                <a href='<%# "ProductDetail" + Eval("ProductID") + ".aspx" %>'>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("URLImage") %>' alt="Product Image" Height="200" />
                                </a>
                                <asp:Label ID="LblDesignation" runat="server" Text='<%#Eval("ProductName")%>' Font-Bold="true" />
                                <br />
                                <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ProductID") %>' runat="server" />
                                <asp:Label ID="LblPu" runat="server" Text='<%# "RM " + String.Format("{0:0.00}", Eval("Price"))%>' Font-Bold="true" />
                                <br />
                                <!-- View Details Button -->
                                <asp:Button ID="BtnDetails" runat="server" CssClass="btn btn-sm" Text="View Details" 
                                PostBackUrl='<%# "ProductDetail" + Eval("ProductID") + ".aspx" %>' Width="60%" style="background-color:lightgray;"/>
                                <br /><br />
                                Quantity
                                <asp:DropDownList ID="TxtQte" runat="server">
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                                    <asp:ListItem Value="7">7</asp:ListItem>
                                    <asp:ListItem Value="8">8</asp:ListItem>
                                    <asp:ListItem Value="9">9</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <br />
                                <asp:Button ID="BtnBuy" OnClick="BtnBuy_Click" runat="server" CssClass="btn btn-sm" Text="Buy" Width="60%" OnClientClick="return confirm('Confirm : Add to Cart ?')" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>--%>



                <asp:ListView ID="ListView1" runat="server" GroupItemCount="3" GroupPlaceholderID="groupPlaceHolder1"
    ItemPlaceholderID="itemPlaceHolder1" DataSourceID="ProductsDataSource">
    <LayoutTemplate>
        <div class="row text-center">
            <table>
                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
            </table>
        </div>
    </LayoutTemplate>
    <GroupTemplate>
        <tr>
            <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
        </tr>
    </GroupTemplate>
    <ItemTemplate>
        <div class="col-sm-4">
            <div class="thumbnail">
                <!-- Image and Product Link -->
                <a href='<%# "ProductDetail.aspx?ProductID=" + Eval("ProductID") %>'>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("FirstImage") %>' alt="Product Image" Height="200" />
                </a>
                <!-- Product Name -->
                <asp:Label ID="LblDesignation" runat="server" Text='<%# Eval("ProductName") %>' Font-Bold="true" />
                <br />
                <!-- Hidden Field for ProductID -->
                <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ProductID") %>' runat="server" />
                <!-- Product Price -->
                <asp:Label ID="LblPu" runat="server" Text='<%# "RM " + String.Format("{0:0.00}", Eval("FirstPrice")) %>' Font-Bold="true" />
                <br />
                <!-- View Details Button -->
                <asp:Button ID="BtnDetails" runat="server" CssClass="btn btn-sm" Text="View Details" 
                    PostBackUrl='<%# "ProductDetail.aspx?ProductID=" + Eval("ProductID") %>' Width="60%" style="background-color:lightgray;" />
                <br /><br />
                <!-- Quantity Dropdown -->
                Quantity
                <asp:DropDownList ID="TxtQte" runat="server">
                    <asp:ListItem Value="1">1</asp:ListItem>
                    <asp:ListItem Value="2">2</asp:ListItem>
                    <asp:ListItem Value="3">3</asp:ListItem>
                    <asp:ListItem Value="4">4</asp:ListItem>
                    <asp:ListItem Value="5">5</asp:ListItem>
                    <asp:ListItem Value="6">6</asp:ListItem>
                    <asp:ListItem Value="7">7</asp:ListItem>
                    <asp:ListItem Value="8">8</asp:ListItem>
                    <asp:ListItem Value="9">9</asp:ListItem>
                    <asp:ListItem Value="10">10</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <!-- Buy Button -->
                <asp:Button ID="BtnBuy" OnClick="BtnBuy_Click" runat="server" CssClass="btn btn-sm" Text="Buy" 
                    Width="60%" PostBackUrl='<%# "ProductDetail.aspx?ProductID=" + Eval("ProductID") %>'/>
            </div>
        </div>
    </ItemTemplate>
</asp:ListView>
            </div>

            <!-- Modal -->
            <%--    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4><span class="glyphicon glyphicon-lock"></span>Confirm purchase</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="form-group">
                            <label for="usrname"><span class="glyphicon glyphicon-user"></span>Send To</label>
                        </div>
                        <asp:Button ID="BtnPay" OnClick="BtnPay_Click" CssClass="btn btn-block" runat="server" Text="Pay" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-danger btn-default pull-left" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>Cancel
                    </button>
                    <p>Need <a href="#contact" class="close">help?</a></p>
                </div>
            </div>
        </div>
    </div>--%>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="ProductsDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="SELECT p.ProductID, p.ProductName, p.Description, pi.urlImage AS FirstImage, pv.Price AS FirstPrice
                   FROM dbo.Products p
                   LEFT JOIN 
                   (SELECT ProductID, urlImage, ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY imageID) AS RowNum
                    FROM dbo.PRODUCT_IMAGES) pi ON p.ProductID = pi.ProductID AND pi.RowNum = 1
                   LEFT JOIN 
                   (SELECT ProductID, Price, ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY Price) AS RowNum
                    FROM dbo.PRODUCT_VARIANTS) pv ON p.ProductID = pv.ProductID AND pv.RowNum = 1
                    ">
        
</asp:SqlDataSource>
    <%--
    <asp:SqlDataSource ID="ProductListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Productss] WHERE [ProductID] = @ProductID" InsertCommand="INSERT INTO [Productss] ([ProductID], [ProductName], [URLImage], [Price], [DetailsPageLink]) VALUES (@ProductID, @ProductName, @URLImage, @Price, @DetailsPageLink)" SelectCommand="SELECT [ProductID], [ProductName], [URLImage], [Price], DetailsPageLink FROM [Productss]" UpdateCommand="UPDATE [Productss] SET [ProductName] = @ProductName, [URLImage] = @URLImage, [Price] = @Price , [DetailsPageLink] = @[DetailsPageLink] WHERE [ProductID] = @ProductID">
        <DeleteParameters>
            <asp:Parameter Name="ProductID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProductID" />
            <asp:Parameter Name="ProductName" />
            <asp:Parameter Name="URLImage" Type="String" />
            <asp:Parameter Name="Price" />
            <asp:Parameter Name="DetailsPageLink" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ProductName" />
            <asp:Parameter Name="URLImage" Type="String" />
            <asp:Parameter Name="Price" />
            <asp:Parameter />
            <asp:Parameter Name="ProductID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ClientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO Users(FirstName, LastName, Address, States, Tel, Username, Password, Email) VALUES (@FirstName, @LastName, @Address, @States, @Tel, @Username, @Password, @Email)" SelectCommand="SELECT UserID, [FirstName], [LastName], Address, States, Tel, Username, Password, Email FROM Users" UpdateCommand="UPDATE Users SET FirstName = @FirstName, LastName = @LastName, Address = @Address, States = @States, Tel = @Tel, Username = @Username, Password = @Password, Email = @Email WHERE (UserID = @UserID)">
        <DeleteParameters>
            <asp:Parameter Name="UserID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="Address" />
            <asp:Parameter Name="States" />
            <asp:Parameter Name="Tel" Type="Int32" />
            <asp:Parameter Name="Username" />
            <asp:Parameter Name="Password" />
            <asp:Parameter Name="Email" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="Address" />
            <asp:Parameter Name="States" />
            <asp:Parameter Name="Tel" Type="Int32" />
            <asp:Parameter Name="Username" />
            <asp:Parameter Name="Password" />
            <asp:Parameter Name="Email" />
            <asp:Parameter Name="UserID" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="OrdersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Orders] WHERE [OrderID] = @OrderID" InsertCommand="INSERT INTO [Orders] ([OrderDate], [UserID], [ProductID], [Quantity]) VALUES (@OrderDate, @UserID, @ProductID, @Quantity)" SelectCommand="SELECT [OrderID], [OrderDate], [UserID], [ProductID], [Quantity] FROM [Orders]" UpdateCommand="UPDATE [Orders] SET [OrderDate] = @OrderDate, [UserID] = @UserID, [ProductID] = @ProductID, [Quantity] = @Quantity WHERE [OrderID] = @OrderID">
        <DeleteParameters>
            <asp:Parameter Name="OrderID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OrderDate" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="ProductID" />
            <asp:Parameter Name="Quantity" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="OrderDate" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="ProductID" />
            <asp:Parameter Name="Quantity" />
            <asp:Parameter Name="OrderID" />
        </UpdateParameters>
    </asp:SqlDataSource>--%>

</asp:Content>
