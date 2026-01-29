<%@ Page Language="C#" MasterPageFile="~/Site_Clients.Master" AutoEventWireup="true" CodeBehind="Clients_Main.aspx.cs" Inherits="Peripheral_Hub.Clients_Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Main Page - Peripheral Hub</title>
    <!-- Add Bootstrap for styling and carousel functionality -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="Content/Styles.css" rel="stylesheet" />
    <style>
    #bootstrap-scope body {
        font-family: "Arial", sans-serif;
        font-size: 18px; /* Default font size for all text */
        line-height: 1.6; /* Increase line height for readability */
    }
    
    #bootstrap-scope h1 {
        font-size: 3.5rem; /* Large size for main headers */
        font-weight: bold;
        color: #1d3557; /* Deep blue for an elegant look */
        text-align: center;
        margin-bottom: 20px;
    }
    
    #bootstrap-scope h2.featured-title {
        font-size: 3rem; /* Prominent size for section titles */
        font-weight: bold;
        color: #457b9d; /* Slightly lighter blue for variety */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Subtle shadow effect */
        text-align: center;
    }
    
    #bootstrap-scope .card-title {
        font-size: 1.75rem; /* Larger size for product titles */
        font-weight: bold;
        color: #2a9d8f; /* Distinct green for a fresh look */
        margin-bottom: 10px;
    }
    
    #bootstrap-scope .card-text {
        font-size: 1.25rem; /* Increase body text size */
        color: #495057; /* Neutral gray for better readability */
        margin-bottom: 20px;
    }
    
    #bootstrap-scope a.btn-primary {
        font-size: 1.25rem; /* Make button text larger */
        font-weight: bold;
        padding: 12px 24px; /* Larger padding for a bold button look */
        color: #fff; /* White text for contrast */
        background-color: #e63946; /* Bright red for call-to-action */
        border: none;
        border-radius: 8px; /* Rounded corners for modern design */
        transition: background-color 0.3s, transform 0.2s; /* Smooth hover effect */
    }
    
    #bootstrap-scope a.btn-primary:hover {
        background-color: #d62828; /* Darker red on hover */
        transform: scale(1.05); /* Slight enlargement on hover */
    }

        #bootstrap-scope .carousel-item img {
            width: 1920px; /* Set the image width */
            height: 550px; /* Set the image height */
            object-fit: cover; /* Ensures the image scales correctly without distortion */
        }
     #bootstrap-scope .carousel-caption h5 {
        font-size: 2rem; /* Larger text in carousel captions */
        font-weight: bold;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* Stronger shadow for readability */
        color: #f1faee; /* Soft white for high contrast */
    }
    .navbar {
    font-family: Montserrat, sans-serif;
    margin-bottom: 0;
    background-color: #2d2d30;
    border: 0;
    font-size: 11px !important;
    letter-spacing: 4px;
    opacity: 0.9;
}

    .navbar li a, .navbar .navbar-brand {
        color: #d5d5d5 !important;
    }

.navbar-nav li a:hover {
    color: #fff !important;
}

.navbar-nav li.active a {
    color: #fff !important;
    background-color: red !important;
}

.navbar-default .navbar-toggle {
    border-color: transparent;
}

.open .dropdown-toggle {
    color: #fff;
    background-color: #555 !important;
}
.nav-tabs li a {
    color: #777;
}
    
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GlobalContent" runat="server">
    <div id="bootstrap-scope">
    <div class="container mt-5">
        <h1 class="text-center mb-4">Welcome to Our Peripheral Hub</h1>
        <!-- Bootstrap Carousel -->
        <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3800">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <a href="Clients_Products.aspx">
                        <img src="Gif/products.gif" class="d-block w-100" alt="Products">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Explore Our Products</h5>
                        </div>
                    </a>
                </div>
                <div class="carousel-item">
                    <a href="ContactUs.aspx">
                        <img src="Gif/contact_us.gif" class="d-block w-100" alt="Contact Us">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Get in Touch with Us</h5>
                        </div>
                    </a>
                </div>
                <div class="carousel-item">
                    <a href="AboutUs.aspx">
                        <img src="Gif/about_us.gif" class="d-block w-100" alt="About Us">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Learn More About Us</h5>
                        </div>
                    </a>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- Featured Products Section -->
        <section class="mt-5">
            <h2 class="text-center mb-4">Featured Products</h2>
            <div class="row">
                <!-- Product Slot 1 -->
                <div class="col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="Gif/op12.gif" class="card-img-top" alt="Featured Product 1">
                        <div class="card-body">
                            <h5 class="card-title">One Plus 12</h5>
                            <p class="card-text">The OnePlus 12 is a flagship smartphone featuring a sleek design, a high-resolution AMOLED display, and cutting-edge Snapdragon processor. It offers a triple-camera setup for professional-quality photos, 5G connectivity, and a long-lasting battery with super-fast charging. Ideal for tech enthusiasts seeking performance and style.</p>
                            <asp:Button ID="Button1" CssClass="btn btn-primary" Style="font-size: 1.25rem; /* Make button text larger */
font-weight: bold;
padding: 12px 24px; /* Larger padding for a bold button look */
color: #fff; /* White text for contrast */
background-color: #e63946; /* Bright red for call-to-action */
border: none;
border-radius: 8px; /* Rounded corners for modern design */
transition: background-color 0.3s, transform 0.2s;" runat="server" Text="View Product" OnClick="Button1_Click" />
                        </div>
                    </div>
                </div>
                <!-- Product Slot 2 -->
                <div class="col-md-6 mb-4">
                    <div class="card h-100">
                        <img src="Gif/asx14.gif" class="card-img-top" alt="Featured Product 2">
                        <div class="card-body">
                            <h5 class="card-title">Acer Swift X 14</h5>
                            <p class="card-text">The Acer Swift X 14 is a powerful and lightweight laptop designed for creators and professionals. It boasts a 14-inch high-resolution display, dedicated NVIDIA graphics, and the latest Intel processor. With a long battery life and premium build, it's perfect for multitasking, editing, and on-the-go productivity.</p>
                            <asp:Button ID="Button2" CssClass="btn btn-primary" Style="font-size: 1.25rem; /* Make button text larger */
font-weight: bold;
padding: 12px 24px; /* Larger padding for a bold button look */
color: #fff; /* White text for contrast */
background-color: #e63946; /* Bright red for call-to-action */
border: none;
border-radius: 8px; /* Rounded corners for modern design */
transition: background-color 0.3s, transform 0.2s;" runat="server" Text="View Product" OnClick="Button2_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
        </div>
</asp:Content>
