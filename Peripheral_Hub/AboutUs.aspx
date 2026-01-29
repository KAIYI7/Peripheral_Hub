<%@ Page Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="eCommerce_ASP.Net.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>About Us</title>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    <div id="about-us" class="container">
        <h2 class="text-center">About Us</h2>
        <p style="text-align:center">
            Welcome to <strong>PeripheralHub</strong>! We are dedicated to providing the best quality peripherals
            for all your technology needs. Our company prides itself on delivering excellent
            service and products to customers around the globe.
        </p>

        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
                <li data-target="#myCarousel" data-slide-to="3"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="Images/factory.jpg" alt="factory" width="1200" height="700">
                    <div class="carousel-caption">
                        <h1>Our Factory</h1>
                        <p>State-of-the-art facilities ensuring the highest quality standards.</p>
                    </div>
                </div>

                <div class="item">
                    <img src="Images/companyBuilding.jpeg" alt="companyBuilding" width="1200" height="700">
                    <div class="carousel-caption">
                        <h1>Our Headquarters</h1>
                        <p>A glimpse of our state-of-the-art company building.</p>
                    </div>
                </div>

                <div class="item">
                    <img src="Images/server.jpg" alt="server" width="1200" height="700">
                    <div class="carousel-caption">
                        <h1>Our Server Facilities</h1>
                        <p>Reliable and secure server solutions for our operations.</p>
                    </div>
                </div>

                <div class="item">
                    <img src="Images/team.jpg" alt="team" width="1200" height="700">
                    <div class="carousel-caption">
                        <h1>Our Team</h1>
                        <p>A team of dedicated professionals driving success.</p>
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
        <!-- Additional Information Section -->
        <section class="company-details mt-4">
            <h2>Company Vision</h2>
            <p>
                At <strong>PeripheralHub</strong>, we envision a future where technology enhances everyday life.
                Our mission is to provide innovative solutions that empower users and foster growth.
           
            </p>
        </section>
        <br />
        <h3 style="text-align: center;">Find Us Here</h3>
        <div id="googleMap" style="width: 600px; height: 450px; margin: auto; border: 1px solid #ccc;">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3983.5378121733747!2d101.72398217473061!3d3.2152551967599208!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc3843bfb6a031%3A0x2dc5e067aae3ab84!2sTunku%20Abdul%20Rahman%20University%20of%20Management%20and%20Technology%20(TAR%20UMT)!5e0!3m2!1sen!2smy!4v1733745324470!5m2!1sen!2smy" style="width: 100%; height: 100%; border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

        </div>



    </div>
</asp:Content>
