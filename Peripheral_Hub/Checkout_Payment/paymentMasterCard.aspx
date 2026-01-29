<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="paymentMasterCard.aspx.cs" Inherits="eCommerce_ASP.Net.Checkout_Payment.paymentMasterCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="icon" href="../../images/favicon.ico">
    <link rel="stylesheet" href="checkout.css">
    <link rel="stylesheet" href="payment.css">


    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@100;200;300;400&family=Secular+One&display=swap"
        rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300&family=Raleway:wght@200;300&display=swap"
        rel="stylesheet">

    <script src="https://kit.fontawesome.com/28e3ee16ef.js" crossorigin="anonymous"></script>

    <style type="text/css">
        .auto-style1 {
            border-radius: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            padding: 12px;
        }
    </style>

</head>

<body>
    <form runat="server">
    <header>
        <div id="linesdiv">
            <div class="hrdiv" id ="deliverynavdiv"><p>DELIVERY</p><hr></div>
            <div class="highlight hrdiv" id ="paymentnavdiv"><p>PAYMENT</p><hr></div>
        </div>
    </header>

    <div id="checkbodycont">

    <div id="checkoutleftdiv" style="all: unset; padding: 20px; width: 66%;">
        <div id="payDet">
            <div id="head">PAYMENT DETAILS</div>
            <hr />
            <div id="pMethod">
                <div style="width:80px;">
                    <a href="payment.aspx" id="visa">
                        <img
                            src="../Images/visa_logo.png"
                            alt="payment logo"></a>
                </div>
                <div style="border: 2px solid black; background-color: lightgray; width: 80px;">
                    <a href="paymentMasterCard.aspx" id="master">
                        <img
                            src="../Images/mastercard_logo.jpg"
                            alt="payment logo" /></a>
                </div>
            </div>
            <div class="cardOpt">

                <div class="card-container">

                    <div class="front">
                        <img id="mapI" src="../images/map.png" alt="">
                        <div class="image">
                            <img src="../images/chip.png" alt="">
                            <img src="../images/mastercard_logo.jpg" alt="">
                        </div>
                        <div class="card-number-box">0000&nbsp;0000&nbsp;0000&nbsp;0000</div>
                        <div class="flexbox">
                            <div class="mbox">
                                <span>Card Holder</span>
                                <div class="card-holder-name">Full name</div>
                            </div>
                            <div class="mbox">
                                <span>Expiry</span>
                                <div class="expiration">
                                    <span class="exp-month">MM /</span>
                                    <span class="exp-year">YY</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="back">
                        <img id="mapI" src="../images/map.png" alt="">
                        <div class="stripe"></div>
                        <img id="patt" src="../images/pattern.png" alt="">
                        <div class="mbox">
                            <span>cvv</span>
                            <div class="cvv-box">
                            </div>
                            <div id="backText">
                                This card has been issued by Elon Musk and is licensed for anyone
                            to use
                            anywhere for free.
                                <br>
                                it comes with no warranty. For support issues, please visit
                            www.twitter.com.
                            </div>
                            <img src="../Images/mastercardLogo.png" alt="visaLogo">
                        </div>
                    </div>

                </div>

                <div class="input-row">
                    <div class="input-group">
                        <label for="txtCardName">
                            Name on card*:<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCardName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </label>
                        &nbsp;<asp:TextBox ID="txtCardName" runat="server" CssClass="auto-style1" Width="500px" />
                    </div>
                </div>

                <div class="input-row">
                    <div class="input-group">
                        <label for="txtCardNo">
                            Enter Card Number (16 digits)*:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCardNo" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCardNo" ErrorMessage="Invalid card number" ForeColor="Red" ValidationExpression="^\d{16}$"></asp:RegularExpressionValidator>
                        </label>
                        &nbsp;<asp:TextBox ID="txtCardNo" runat="server" CssClass="auto-style1" Width="500px" MaxLength="16" />
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-group">
                        <label>
                            Expiry Date*:<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlMonth" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlYear" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </label>
                        &nbsp;<asp:DropDownList ID="ddlMonth" runat="server" CssClass="auto-style1" Width="150px">
                            <asp:ListItem Value="">--Month--</asp:ListItem>
                            <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">February</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:DropDownList ID="ddlYear" runat="server" CssClass="auto-style1" Width="150px">
    <asp:ListItem Value="">--Year--</asp:ListItem>
    <asp:ListItem Value="25">2025</asp:ListItem>
    <asp:ListItem Value="26">2026</asp:ListItem>
    <asp:ListItem Value="27">2027</asp:ListItem>
    <asp:ListItem Value="28">2028</asp:ListItem>
    <asp:ListItem Value="29">2029</asp:ListItem>
    <asp:ListItem Value="30">2030</asp:ListItem>
</asp:DropDownList>
                    </div>
                </div>
                <div class="flexbox">

                    <div class="input-row">
                        <div class="input-group">
                            <label for="txtCVV">
                                Security code*:<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCVV" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </label>
                            &nbsp;<asp:TextBox ID="txtCVV" runat="server" CssClass="auto-style1" MaxLength="3" Width="150px"></asp:TextBox>
                        </div>
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

    </form>
</body>

</html>


<script src="payment.js"></script>
