<%@ Page Title="" Language="C#" MasterPageFile="~/Site_Default.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="PeripheralHub.SingUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">


    <!-- Container (TOUR Section) -->
    <div id="SingUp" class="bg-1">
        <div class="container text-center">
            <h3 class="text-center">WELCOME TO Peripheral Hub</h3>
            <p class="text-center">
                Create your own Account.<br>
            </p>
            <asp:Label ID="LblMsg" runat="server" Text=""></asp:Label>
            <br />
            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Username</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtLogin" CssClass="form-control" runat="server" AutoPostBack="True"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtLogin" ErrorMessage="Required Field" ForeColor="Red" Display="Static"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TxtLogin" OnServerValidate="TxtLogin_ServerValidate" ErrorMessage="&nbsp;Username already exists" Display="Dynamic" ForeColor="Red"></asp:CustomValidator><br />
                        <asp:RegularExpressionValidator 
    ID="UsernameValidator" 
    runat="server" 
    ControlToValidate="TxtLogin" 
    ErrorMessage="Username must be 4-20 characters and contain only letters and numbers." 
    ValidationExpression="^[a-zA-Z0-9]{4,20}$" ForeColor="Red"></asp:RegularExpressionValidator>
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtPasswd" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator><br />
                        &nbsp;<asp:RegularExpressionValidator 
    ID="PasswordValidator" 
    runat="server" 
    ControlToValidate="TxtPasswd" 
    ErrorMessage="At least 4 characters, contain uppercase, lowercase, a digit and a special character." 
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&amp;+=!]).{4,}$" ForeColor="Red"></asp:RegularExpressionValidator>
                        
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Retype Password</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtPasswdR" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords are different" ControlToCompare="TxtPasswd" ControlToValidate="TxtPasswdR" ForeColor="Red"></asp:CompareValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">First Name</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtFirstName" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TxtFirstName" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Last Name</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtLastName" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtLastName" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    State
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:DropDownList ID="ddlStates" CssClass="form-control" runat="server" DataSourceID="StatesDataSource" DataTextField="stateName" DataValueField="stateID"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlStates" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:SqlDataSource ID="StatesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [stateID], [stateName] FROM [STATES]"></asp:SqlDataSource>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    City </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server" DataSourceID="CityDataSource" DataTextField="cityName" DataValueField="cityID"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlCity" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:SqlDataSource ID="CityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [cityName], [cityID], [stateID] FROM [CITY]"></asp:SqlDataSource>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Address</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtAddress" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtAddress" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <label class="control-label">Phone Number</label>
                </div>
                <div class="col-md-5">
                    <div class="form-group label-floating">
                        <asp:TextBox ID="TxtTele" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtTele" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>
                        &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtTele" ErrorMessage="Invalid phone number. It must start with '0' and contain 10-11 digits." ForeColor="Red" ValidationExpression="^0\d{9,10}$" CssClass="regexValidator"></asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>

                        <div class="row">
    <div class="col-md-3">
        <label class="control-label">Email</label>
    </div>
    <div class="col-md-5">
        <div class="form-group label-floating">
            <asp:TextBox ID="TxtEmail" CssClass="form-control" TextMode="email" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TxtEmail" ErrorMessage="Required Field" ForeColor="Red"></asp:RequiredFieldValidator>&nbsp;
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtEmail" ErrorMessage="Invalid email format. Please enter a valid email address." ForeColor="Red" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" CssClass="regexValidator"></asp:RegularExpressionValidator>
        </div>
    </div>
</div>

            <br />

            <asp:Button ID="BtnSignUp" runat="server" CssClass="btn" Text="Sign up" OnClick="BtnSignUp_Click" />
        </div>
    </div>


    <asp:SqlDataSource ID="ClientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO Users(FirstName, LastName, Tel, Username, Password, Email) VALUES (@FirstName, @LastName, @Tel, @Username, @Password, @Email);
DECLARE @UserID INT = SCOPE_IDENTITY();

INSERT INTO Address (addressLine, userID, cityID)
VALUES (@AddressLine, @UserID, @CityID);" SelectCommand="SELECT Users.UserID, Users.FirstName, Users.LastName, ADDRESS.addressLine, CITY.cityName, STATES.stateName, Users.Tel, Users.Username, Users.Password, Users.Email FROM Users INNER JOIN ADDRESS ON Users.UserID = ADDRESS.UserID INNER JOIN CITY ON ADDRESS.cityID = CITY.cityID INNER JOIN STATES ON CITY.stateID = STATES.stateID" UpdateCommand="UPDATE Users SET FirstName = @FirstName, LastName = @LastName, ADDRESS.addressLine = @addressLine, STATES.stateName = @stateName, CITY.cityName = @cityName, Tel = @Tel, Username = @Username, Password = @Password, Email = @Email FROM Users INNER JOIN ADDRESS ON Users.UserID = ADDRESS.UserID INNER JOIN CITY ON ADDRESS.cityID = CITY.cityID INNER JOIN STATES ON CITY.stateID = STATES.stateID WHERE (Users.UserID = @UserID)">
     <DeleteParameters>
    <asp:Parameter Name="UserID" />
</DeleteParameters>
<InsertParameters>
    <asp:Parameter Name="FirstName" />
    <asp:Parameter Name="LastName" />
    <asp:Parameter Name="Tel" Type="Int32" />
    <asp:Parameter Name="Username" />
    <asp:Parameter Name="Password" />
    <asp:Parameter Name="Email" />
    <asp:Parameter Name="UserID" />
    <asp:Parameter Name="AddressLine" />
    <asp:Parameter Name="CityID" />
</InsertParameters>
<UpdateParameters>
    <asp:Parameter Name="FirstName" Type="String" />
    <asp:Parameter Name="LastName" Type="String" />
    <asp:Parameter Name="addressLine" />
    <asp:Parameter Name="stateName" />
    <asp:Parameter Name="cityName" />
    <asp:Parameter Name="Tel" Type="Int32" />
    <asp:Parameter Name="Username" Type="String" />
    <asp:Parameter Name="Password" Type="String" />
    <asp:Parameter Name="Email" />
    <asp:Parameter Name="UserID" Type="Int32" />
</UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
