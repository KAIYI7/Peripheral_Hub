<%@ Page Title="Account" Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="Clients_Account.aspx.cs" Inherits="PeripheralHub.Clients_Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Account</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">

    <style>
        body {
            background-color: #2d2d30;
        }

        tr:nth-last-child(1) a {
            padding: 8px 30px;
            background-color: #333;
            color: #f1f1f1;
            border-radius: 0;
            transition: .2s;
            width: 200px;
            min-width: 100px;
        }

        .jumbotron {
            margin-top: 8% !important;
        }

        footer {
            background-color: #f0f0f0 !important;
            border-top: 1px solid #ccc !important;
            padding: 20px 10px !important;
            width: 100% !important;
        }

        .footer-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 30px 0 !important;
            text-align: left;
            margin-bottom: 20px;
        }

        .footer-column {
            vertical-align: top;
            padding: 10px 15px !important;
            width: 25% !important; /* Each column takes equal width */
        }

        footer h5 {
            font-size: 16px;
            margin-bottom: 10px;
        }

        footer p,
        footer a {
            font-size: 14px;
            color: #333;
            text-decoration: none;
            background-color: none;
        }

        footer a {
            all: unset;
            background-color: #f0f0f0 !important;
            font-size: 14px !important;
            color: #333 !important;
            text-decoration: none !important;
            margin: 0 !important;
            padding: 0 !important;
        }

            footer a:hover {
                color: darkgray;
            }

        footer img {
            width: 50px;
            height: auto;
            margin-right: 10px;
        }

        .copyright {
            text-align: center;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>

    <div class="jumbotron container">
        <asp:DetailsView ID="DetailsView1" GridLines="None" CssClass="table table-hover" runat="server" Width="100%" AutoGenerateRows="False" DataSourceID="ClientsDataSource" AutoGenerateEditButton="True">
            <Fields>
                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="addressLine" HeaderText="addressLine" SortExpression="addressLine" />
                <asp:BoundField DataField="cityName" HeaderText="cityName" SortExpression="cityName" />
                
                <asp:BoundField DataField="stateName" HeaderText="stateName" SortExpression="stateName" />
                <asp:BoundField DataField="Tel" HeaderText="Tel" SortExpression="Tel" />
                <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />

                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            </Fields>
        </asp:DetailsView>
        <!--<asp:Button ID="btnEdit" runat="server" Text="Edit" BackColor="#666699" ForeColor="White" Width="63px" />-->
    </div>



    <asp:SqlDataSource ID="ClientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Users.Username, Users.FirstName, Users.LastName, 
ADDRESS.addressLine, 
CITY.cityName, STATES.stateName, Users.Tel, Users.Password, Users.Email FROM Users INNER JOIN ADDRESS ON Users.UserID = ADDRESS.UserID INNER JOIN CITY ON ADDRESS.cityID = CITY.cityID INNER JOIN STATES ON CITY.stateID = STATES.stateID WHERE (Users.Username = @Username)"
        DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID" FilterExpression="Username = '{0}'" InsertCommand="INSERT INTO Users(FirstName, LastName, Address, States, Tel, Username, Password, Email) VALUES (@FirstName, @LastName, @Address, @States, @Tel, @Username, @Password, @Email)" UpdateCommand="UPDATE Users 

SET 
    Users.FirstName = @FirstName,
    Users.LastName = @LastName,
    Users.Tel = @Tel,
    Users.Password = @Password,
    Users.Email = @Email

WHERE Users.Username = @Username;

Update ADDRESS
SET ADDRESS.addressLine = @addressLine
WHERE ADDRESS.UserID = (SELECT UserID FROM Users WHERE Username = @Username);
" 
        OnUpdated="ClientsDataSource_Updated">
        <DeleteParameters>
            <asp:Parameter Name="UserID" />
        </DeleteParameters>
        <FilterParameters>
            <asp:SessionParameter Name="Pseudo" SessionField="Pseudo" />
        </FilterParameters>
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
        <SelectParameters>
            <asp:SessionParameter Name="Username" SessionField="Username" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="Tel" Type="Int32" />
            <asp:Parameter Name="Password" />
            <asp:Parameter Name="Email" />
            <asp:Parameter Name="Username" />
            <asp:Parameter Name="addressLine" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="CityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [cityID], [cityName] FROM [CITY]"></asp:SqlDataSource>
    <asp:Label ID="lblMessage" runat="server" ></asp:Label>

</asp:Content>
