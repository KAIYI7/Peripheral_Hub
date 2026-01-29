<%@ Page Title="" Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard_Products.aspx.cs" Inherits="PeripheralHub.Dashboard_Products" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <style>
        .jumbotron {
            margin-top: 8% !important;
        }
        .btn {
    padding: 6px 30px;
    background-color: #333;
    color: #f1f1f1;
    border-radius: 0;
    transition: .2s;
    min-width:100px;
}
        .form-control {
            margin-bottom: 10px;
        }
        .file-upload-container {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .file-upload {
        margin-bottom: 5px;
        width: 150px;
    }

    .custom-gridview .form-control {
        margin-bottom: 10px;
    }
    </style>

    <div class="jumbotron container">

        <asp:Label ID="LblMsg" CssClass="text-center center-block" runat="server" Text=""></asp:Label>

        <%--<asp:GridView ID="GridView1" GridLines="None" CssClass="table table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ProductID" DataSourceID="ProductsDataSource" AllowSorting="True" ShowFooter="True" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:TemplateField HeaderText="ProductID" InsertVisible="False" SortExpression="ProductID">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductID") %>'></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Button ID="BtnAdd" runat="server" CssClass="btn text-center" OnClick="BtnAdd_Click" Text="Add" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("ProductID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ProductName" SortExpression="ProductName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%# Bind("ProductName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="TxtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Image" SortExpression="URLImage">
                    <EditItemTemplate>
                        <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" EnableTheming="True" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" EnableTheming="True" />
                        <asp:CustomValidator ID="CustomValidator1" ControlToValidate="FileUpload1" EnableClientScript="true" runat="server" ErrorMessage="CustomValidator" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="40px" ImageUrl='<%# Eval("URLImage") %>' Width="40px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price (RM)" SortExpression="Price">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%# Bind("Price") %>' TextMode="Number"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="TextBox2" ForeColor="Red" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" runat="server" ErrorMessage="Invalid Price"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="TxtPrice" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="TxtPrice" ForeColor="Red" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" runat="server" ErrorMessage="Invalid Price"></asp:RegularExpressionValidator>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>--%>

        <asp:GridView 
    ID="GridView1" 
    GridLines="None" 
    CssClass="table table-hover" 
    runat="server" 
    AllowPaging="True" 
    AutoGenerateColumns="False" 
    DataKeyNames="ProductID" 
    DataSourceID="ProductsDataSource" 
    AllowSorting="True" 
    ShowFooter="True" 
    OnRowDeleting="GridView1_RowDeleting" 
    OnRowUpdating="GridView1_RowUpdating"
    OnRowDataBound="GridView1_RowDataBound"
    OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
            >
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
        <asp:TemplateField HeaderText="ProductID" InsertVisible="False" SortExpression="ProductID">
    <EditItemTemplate>
        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductID") %>'></asp:Label>
    </EditItemTemplate>
    <FooterTemplate>
        <asp:Button ID="BtnAdd" runat="server" CssClass="btn text-center" OnClick="BtnAdd_Click" Text="Add" />
    </FooterTemplate>
    <ItemTemplate>
        <asp:Label ID="Label3" runat="server" Text='<%# Bind("ProductID") %>'></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
        <asp:TemplateField HeaderText="Product Name">
            <ItemTemplate>
                <asp:Label ID="LblProductName" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="TxtProductName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Description">
            <ItemTemplate>
                <asp:Label ID="LblDescription" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="TxtDescription" runat="server" CssClass="form-control" placeholder="Description"></asp:TextBox>
            </FooterTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Category">
                    <ItemTemplate>
                        <asp:Label ID="LblCategory" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                    </FooterTemplate>
                </asp:TemplateField>    

        <asp:TemplateField HeaderText="Quantity">
            <ItemTemplate>
                <asp:Label ID="LblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="TxtQuantity" runat="server" CssClass="form-control" placeholder="Stock Quantity"></asp:TextBox>
            </FooterTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Images">
            <ItemTemplate>
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Container.DataItem %>' Height="50px" Width="50px" />
                    </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>
            <FooterTemplate>
                <div class="file-upload-container">
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control file-upload" />
                <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control file-upload" />
                <asp:FileUpload ID="FileUpload3" runat="server" CssClass="form-control file-upload" />
                <asp:FileUpload ID="FileUpload4" runat="server" CssClass="form-control file-upload" />
                    </div>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Variants">
            <ItemTemplate>
                <asp:GridView 
                    ID="NestedGridView" 
                    runat="server" 
                    AutoGenerateColumns="False" 
                    CssClass="table table-bordered" 
                    DataKeyNames="VariantID"
                    OnRowEditing="NestedGridView_RowEditing" 
                    OnRowUpdating="NestedGridView_RowUpdating"
                    OnRowCancelingEdit="NestedGridView_RowCancelingEdit"
                    >
                    <Columns>
                        <asp:TemplateField HeaderText="Option">
        <EditItemTemplate>
            <asp:TextBox ID="txtEditVariantOption" runat="server" Text='<%# Bind("VariantOption") %>' CssClass="form-control" />
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblVariantOption" runat="server" Text='<%# Bind("VariantOption") %>' />
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Value">
        <EditItemTemplate>
            <asp:TextBox ID="txtEditVariantValue" runat="server" Text='<%# Bind("VariantValue") %>' CssClass="form-control" />
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblVariantValue" runat="server" Text='<%# Bind("VariantValue") %>' />
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Price">
        <EditItemTemplate>
            <asp:TextBox ID="txtEditVariantPrice" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control" />
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblVariantPrice" runat="server" Text='<%# Bind("Price") %>' />
        </ItemTemplate>
    </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" />
                    </Columns>
                </asp:GridView>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="TxtVariantOption" runat="server" CssClass="form-control" placeholder="Variant Option (e.g.Storage)"></asp:TextBox>
                <asp:TextBox ID="TxtVariantValue" runat="server" CssClass="form-control" placeholder="Variant Value (e.g.256GB,512GB)"></asp:TextBox>
                <asp:TextBox ID="TxtVariantPrice" runat="server" CssClass="form-control" placeholder="Price (RM) (e.g.300.00,350.00)"></asp:TextBox>
                <asp:Button ID="BtnAddVariant" runat="server" CssClass="btn btn-primary" Text="Add Variants" OnClick="BtnAddVariant_Click" />
            </FooterTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
        

        <asp:SqlDataSource ID="ProductsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Productss] WHERE [ProductID] = @ProductID" InsertCommand="INSERT INTO [Productss] ([ProductName], [URLImage], [Price]) VALUES (@ProductName, @URLImage, @Price)" SelectCommand="SELECT 
    P.ProductID,
    P.ProductName,
    P.Description,
    C.categoryName AS Category, 
    P.quantity,
    STRING_AGG(PI.urlImage, ',') AS AllImages
FROM 
    Products P
LEFT JOIN 
        CATEGORY C ON P.categoryID = C.categoryID
LEFT JOIN 
    PRODUCT_IMAGES PI ON P.ProductID = PI.ProductID
GROUP BY 
    P.ProductID, P.ProductName, P.Description, P.quantity, C.categoryName;
" UpdateCommand="UPDATE [Productss] SET [ProductName] = @ProductName, [URLImage] = @URLImage, [Price] = @Price WHERE [ProductID] = @ProductID" OnSelected="ProductsDataSource_Selected">
            <DeleteParameters>
                <asp:Parameter Name="ProductID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProductName" />
                <asp:Parameter Name="URLImage" Type="String" />
                <asp:Parameter Name="Price" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProductName" />
                <asp:Parameter Name="URLImage" Type="String" />
                <asp:Parameter Name="Price" />
                <asp:Parameter Name="ProductID" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>

