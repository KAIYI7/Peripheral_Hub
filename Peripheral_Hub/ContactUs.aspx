<%@ Page Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="eCommerce_ASP.Net.ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Contact Us</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    <div id="contact" class="container">
        <h2 class="text-center">Contact Us</h2>
        <div class="row">
            <div class="col-md-4">
                <p><span class="glyphicon glyphicon-map-marker"></span>Location: <span style="color: rgb(71, 71, 71); font-family: Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">18, Jalan Genting Kelang, Setapak, 53300 Kuala Lumpur</span></p>
                <p><span class="glyphicon glyphicon-phone"></span>Phone: (6)03-41450123</p>
                <p><span class="glyphicon glyphicon-envelope"></span>Email: klax1120@gmail.com</p>
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <input class="form-control" id="name" name="name" placeholder="Name" type="text">
                    </div>
                    <div class="col-sm-6 form-group">
                        <input class="form-control" id="email" name="email" placeholder="Email" type="email">
                    </div>
                </div>
                <textarea class="form-control" id="comments" name="comments" placeholder="Comment" rows="5"></textarea>
                <br>
                <div class="row">
                    <div class="col-md-12 form-group">
                        <button class="btn pull-right">Send</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
