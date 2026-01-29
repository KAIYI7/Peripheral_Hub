<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="eCommerce_ASP.Net.Checkout_Payment.checkout" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check Out</title>
    <link rel="icon" href="../../images/favicon.ico">
    <link rel="stylesheet" href="checkout.css">
    <script src="https://kit.fontawesome.com/28e3ee16ef.js" crossorigin="anonymous"></script>
    <style type="text/css">
        .regexValidator {
            font-size: 10px;
            margin-top: 0px;
            margin-bottom :0px;
            padding-top: 0px;
            padding-bottom:0px;

        }
    </style>
</head>
<body>
    <header>
        <div id="linesdiv">
            <div class="highlight hrdiv" id="deliverynavdiv">
                <p>DELIVERY</p>
                <hr>
            </div>
            <div class="hrdiv" id="paymentnavdiv">
                <p>PAYMENT</p>
                <hr>
            </div>
        </div>
    </header>

    <form id="form1" runat="server">
        <div id="checkbodycont">
            <!-- Left Section (Form Fields) -->
            <div id="checkoutleftdiv">
                <h3 class="highlight">STANDARD</h3>
                <hr>

                <input type="radio" checked><span> The estimated delivery time will be between 7-10 working days.</span> <span class="delcharge">RM 5.00</span>
                <div id="emergediv"></div>
                <p class="highlight extras" id="addchange">BILLING ADDRESS</p>

                <div id="dummybillnulldiv">
                    <!-- Form Fields (arranged in 2 columns) -->
                    <asp:RadioButton ID="rbSameAddress" runat="server" AutoPostBack="True" OnCheckedChanged="rbSameAddress_CheckedChanged" />Same as Current Account Information
                    <br />
                    <div class="input-row">
                        <div class="input-group">
                            <label for="billEmail">Email*:<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="billEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                            
                            </label><asp:TextBox ID="billEmail" runat="server" CssClass="textbox" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="billEmail" ErrorMessage="Invalid email format. Please enter a valid email address." ForeColor="Red" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" CssClass="regexValidator"></asp:RegularExpressionValidator>
                        </div>
                        <div class="input-group">
                            <label for="billName">
                                Name*:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="billName" CssClass="regexValidator"></asp:RequiredFieldValidator>
                            </label>
                            <asp:TextBox ID="billName" runat="server" CssClass="textbox" />
                        </div>
                    </div>

                    <div class="input-row">
                        <div class="input-group">
                            <label for="billTelephone">
                                Telephone*:<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="billTelephone" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            
                            </label>
                            <asp:TextBox ID="billTelephone" runat="server" CssClass="textbox" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="billTelephone" ErrorMessage="Invalid phone number. It must start with '0' and contain 10-11 digits." ForeColor="Red" ValidationExpression="^0\d{9,10}$" CssClass="regexValidator"></asp:RegularExpressionValidator>
                        </div>
                        <div class="input-group">
                            <label for="billAddress">
                                Address*:<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="billAddress" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </label>
                            <asp:TextBox ID="billAddress" runat="server" CssClass="textbox" />
                        </div>

                    </div>

                    <div class="input-row">
                        <div class="input-group">
                            <label for="billDoor">Floor/door/etc.:</label><asp:TextBox ID="billDoor" runat="server" CssClass="textbox" />
                        </div>
                        <div class="input-group">
                            <label for="billPostcode">
                                Postcode*:<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="billPostcode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </label>
                            <asp:TextBox ID="billPostcode" runat="server" CssClass="textbox" />
                        </div>
                    </div>

                    <div class="input-row">

                        <div class="input-group">
                            <label for="ddlBillState">
                                State*:<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlBillState" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </label>
                            <asp:DropDownList ID="ddlBillState" runat="server" CssClass="dropdown" DataSourceID="StatesDataSource" DataTextField="stateName" DataValueField="stateID">
                                <asp:ListItem Text="-------" Value="State" />
                                <asp:ListItem Text="Perlis" Value="Perlis" />
                                <asp:ListItem Text="Kedah" Value="Kedah" />
                                <asp:ListItem Text="Penang" Value="Penang" />
                                <asp:ListItem Text="Perak" Value="Perak" />
                                <asp:ListItem Text="Selangor" Value="Selangor" />
                                <asp:ListItem Text="Negeri Sembilan" Value="Negeri Sembilan" />
                                <asp:ListItem Text="Malacca" Value="Malacca" />
                                <asp:ListItem Text="Johor" Value="Johor" />
                                <asp:ListItem Text="Pahang" Value="Pahang" />
                                <asp:ListItem Text="Terengganu" Value="Terengganu" />
                                <asp:ListItem Text="Kelantan" Value="Kelantan" />
                                <asp:ListItem Text="Kuala Lumpur" Value="Kuala Lumpur" />
                                <asp:ListItem Text="Putrajaya" Value="Putrajaya" />
                            </asp:DropDownList>
                        </div>
                        <div class="input-group">
                            <label for="billCity">
                                City*:<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="ddlBillCity" ForeColor="Red"></asp:RequiredFieldValidator>
                            </label>
                            <asp:DropDownList ID="ddlBillCity" runat="server" CssClass="dropdown" DataSourceID="CityDataSource" DataTextField="cityName" DataValueField="cityID"></asp:DropDownList>
                        </div>
                    </div>





                    <p class="highlight extras">DELIVERY ADDRESS</p>
                    <asp:RadioButton ID="rbSameBillAddr" runat="server" OnCheckedChanged="rbSameBillAddr_CheckedChanged" AutoPostBack="True" />Same as Billing Address
                    <div id="deliveryAddressDiv" runat="server">
                        <div class="input-row">
                            <div class="input-group">
                                <label for="txtEmail">
                                    Email*:<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="billEmail" ErrorMessage="Invalid email format. Please enter a valid email address." ForeColor="Red" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" CssClass="regexValidator"></asp:RegularExpressionValidator>

                            </div>
                            <div class="input-group">
                                <label for="txtName">
                                    Name*:<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="textbox" />
                            </div>
                        </div>

                        <div class="input-row">

                            <div class="input-group">
                                <label for="txtTelephone">
                                    Telephone*:<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtTelephone" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtTelephone" runat="server" CssClass="textbox" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="billTelephone" ErrorMessage="Invalid phone number. It must start with '0' and contain 10-11 digits." ForeColor="Red" ValidationExpression="^0\d{9,10}$" CssClass="regexValidator"></asp:RegularExpressionValidator>
                            </div>

                            <div class="input-group">
                                <label for="txtAddress">
                                    Address*:<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtAddress" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox" />
                            </div>

                        </div>

                        <div class="input-row">
                            <div class="input-group">
                                <label for="txtDoor">Floor/door/etc.:</label>
                                <asp:TextBox ID="txtDoor" runat="server" CssClass="textbox" />
                            </div>
                            <div class="input-group">
                                <label for="txtPostcode">
                                    Postcode*:<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtPostcode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                                <asp:TextBox ID="txtPostcode" runat="server" CssClass="textbox" />
                            </div>
                        </div>

                        <div class="input-row">

                            <div class="input-group">
                                <label for="ddlDeliveryState">
                                    State*:<asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="ddlDeliveryState" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </label>
                                <asp:DropDownList ID="ddlDeliveryState" runat="server" CssClass="dropdown" DataSourceID="StatesDataSource" DataTextField="stateName" DataValueField="stateID">
                                    <asp:ListItem Text="-------" Value="State" />
                                    <asp:ListItem Text="Perlis" Value="Perlis" />
                                    <asp:ListItem Text="Kedah" Value="Kedah" />
                                    <asp:ListItem Text="Penang" Value="Penang" />
                                    <asp:ListItem Text="Perak" Value="Perak" />
                                    <asp:ListItem Text="Selangor" Value="Selangor" />
                                    <asp:ListItem Text="Negeri Sembilan" Value="Negeri Sembilan" />
                                    <asp:ListItem Text="Malacca" Value="Malacca" />
                                    <asp:ListItem Text="Johor" Value="Johor" />
                                    <asp:ListItem Text="Pahang" Value="Pahang" />
                                    <asp:ListItem Text="Terengganu" Value="Terengganu" />
                                    <asp:ListItem Text="Kelantan" Value="Kelantan" />
                                    <asp:ListItem Text="Kuala Lumpur" Value="Kuala Lumpur" />
                                    <asp:ListItem Text="Putrajaya" Value="Putrajaya" />
                                </asp:DropDownList>
                            </div>
                            <div class="input-group">
                                <label for="ddlDeliveryCity">City*:<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="ddlDeliveryCity"></asp:RequiredFieldValidator></label>

                                <asp:DropDownList ID="ddlDeliveryCity" runat="server" CssClass="dropdown" DataSourceID="CityDataSource" DataTextField="cityName" DataValueField="cityID"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>


            </div>


            <!-- Right Section (Payment Details) -->
            <div id="pricediv">
    <div id="Item">
        <asp:Label ID="LblItemCount" runat="server" Text="0"></asp:Label>&nbsp;<span>ITEM(S)</span>
    </div>
    <hr>
    <div>
        <span>Total price (excluding tax):</span>
        <asp:Label ID="LblGrandTotal" runat="server" CssClass="prices" Text="RM 0.00"></asp:Label>
    </div>
    <div>
        <span>Tax (6%):</span>
        <asp:Label ID="LblTax" runat="server" CssClass="prices" Text="RM 0.00"></asp:Label>
    </div>
    <div>
        <span>Delivery charges:</span>
        <asp:Label ID="LblDeliveryCharges" runat="server" CssClass="prices" Text="RM 5.00"></asp:Label>
    </div>
    <div id="totaldiv">
        <span>TOTAL:</span>
        <asp:Label ID="LblTotal" runat="server" CssClass="prices" Text="RM 0.00"></asp:Label>
    </div>
    <br />
    <asp:Button ID="contBtn" runat="server" Text="CONTINUE" CssClass="contbtn" OnClick="contBtn_Click" />
</div>


        </div>
        <asp:SqlDataSource ID="AddressDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Users.Username, Users.FirstName + ' ' + Users.LastName AS Name, Users.Tel, Users.Email, ADDRESS.addressLine, CITY.cityName, STATES.stateName FROM ADDRESS INNER JOIN Users ON ADDRESS.UserID = Users.UserID INNER JOIN CITY ON ADDRESS.cityID = CITY.cityID INNER JOIN STATES ON CITY.stateID = STATES.stateID
WHERE Users.Username = @Username">
            <SelectParameters>
                <asp:SessionParameter Name="Username" SessionField="Username" />
            </SelectParameters>
        </asp:SqlDataSource>
        <script src="checkout.js"></script>

        <asp:SqlDataSource ID="StatesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [STATES]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="CityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CITY]"></asp:SqlDataSource>

    </form>

</body>
</html>
