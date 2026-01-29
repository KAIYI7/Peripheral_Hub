
<%@ Page Title="" Language="C#" MasterPageFile="~/Site_Default.Master" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="PeripheralHub.SignIn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    
    <!-- Container (TOUR Section) -->
    <div id="SingIN" class="bg-1">
        <div class="container text-center">
            <h3 class="text-center">WELCOME TO PERIPHERAL HUB</h3>
            <p class="text-center">Login to your Account.<br>
                Remember to Get Best deals!</p>
            <p class="text-center">Login as  <a href="Admin.aspx"><strong>Admin </strong></a> /  <a href="Clients_Products.aspx">Guest</a></p>
            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Username</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtLogin" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtLogin" ErrorMessage="Required Field" ForeColor="Red" Display="Static"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Password</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtPasswd" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtPasswd" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            

            <asp:Label ID="LblMsg" runat="server" CssClass="control-label" ForeColor="Red"></asp:Label>

            <br />

            <asp:Button ID="BtnSignIn" CssClass="btn" runat="server" Text="Sign in" OnClick="BtnSignIn_Click" />
        </div>
    </div>

    
    <asp:SqlDataSource ID="ClientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Users.UserID, Users.FirstName, Users.LastName, Users.Tel, Users.Username, Users.Password, Users.Email, ADDRESS.addressLine, CITY.cityName, STATES.stateName FROM Users INNER JOIN ADDRESS ON Users.UserID = ADDRESS.UserID INNER JOIN CITY ON ADDRESS.cityID = CITY.cityID INNER JOIN STATES ON CITY.stateID = STATES.stateID">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT * FROM [table1]"></asp:SqlDataSource>
</asp:Content>
