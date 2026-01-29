<%@ Page Title="" Language="C#" MasterPageFile="~/Site_Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard_Clients.aspx.cs" Inherits="PeripheralHub.Dashboard_Clients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .jumbotron {
            margin-top: 8% !important;
        }
    </style>

    <div class="jumbotron container">

        <asp:TextBox ID="TxtSearch" CssClass="form-control pull-right" Placeholder="'FirstName', 'LastName', 'States', ..." Height="42px" Width="30%" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="LblMsg" CssClass="text-center center-block" runat="server" Text=""></asp:Label>
        <br />
        <asp:GridView ID="GridView1" GridLines="None" CssClass="table table-hover" runat="server" DataSourceID="ClientsDataSource" AutoGenerateColumns="False" DataKeyNames="UserID" AllowPaging="True" AllowSorting="True" ShowFooter="True">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="addressLine" HeaderText="addressLine" SortExpression="addressLine" />
                <asp:BoundField DataField="cityName" HeaderText="cityName" SortExpression="cityName" />
                <asp:BoundField DataField="stateName" HeaderText="stateName" SortExpression="stateName" />
                <asp:BoundField DataField="Tel" HeaderText="Tel" SortExpression="Tel" />
                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="ClientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @original_UserID" InsertCommand="INSERT INTO [Users] ([FirstName], [Lastname], [Address], [States], [Tel], [Username]) VALUES (@FirstName, @LastName, @Address, @States, @Tel, @Username)" SelectCommand="SELECT Users.UserID, Users.FirstName, Users.LastName, ADDRESS.addressLine, CITY.cityName, STATES.stateName, Users.Tel, Users.Username FROM CITY INNER JOIN STATES ON CITY.stateID = STATES.stateID INNER JOIN ADDRESS ON CITY.cityID = ADDRESS.cityID INNER JOIN Users ON ADDRESS.UserID = Users.UserID WHERE (Users.UserID LIKE @SearchValue + '%') OR (Users.FirstName LIKE @SearchValue + '%') OR (Users.LastName LIKE @SearchValue + '%') OR (ADDRESS.addressLine LIKE @SearchValue + '%') OR (STATES.stateName LIKE @SearchValue + '%') OR (CITY.cityName LIKE @SearchValue + '%') OR (Users.Tel LIKE @SearchValue + '%') OR (Users.Username LIKE @SearchValue + '%')"
            UpdateCommand="UPDATE [Users] SET [FirstName] = @FirstName, [Lastname] = @Lastname, [Address] = @Address, [States] = @States, [Tel] = @Tel, [Username] = @Username WHERE [UserID] = @original_UserID" OldValuesParameterFormatString="original_{0}" OnSelected="ClientsDataSource_Selected">
            <DeleteParameters>
                <asp:Parameter Name="original_UserID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FirstName" />
                <asp:Parameter Name="LastName" />
                <asp:Parameter Name="Address" />
                <asp:Parameter Name="States" />
                <asp:Parameter Name="Tel" Type="Int32" />
                <asp:Parameter Name="Username" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TxtSearch" DefaultValue="%" Name="SearchValue" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="FirstName" />
                <asp:Parameter Name="Lastname" />
                <asp:Parameter Name="Address" />
                <asp:Parameter Name="States" />
                <asp:Parameter Name="Tel" Type="Int32" />
                <asp:Parameter Name="Username" />
                <asp:Parameter Name="original_UserID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <%--    <script type="text/javascript">
        function Search_Gridview(strKey, strGV) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(strGV);
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }    
</script>--%>
</asp:Content>

