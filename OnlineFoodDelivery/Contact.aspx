<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="OnlineFoodDelivery.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Section -->
    <div>
        <img src="Images/contact-hero.jpg" alt="Contact Us Banner" class="img-fluid w-100" style="height: 80vh; object-fit: fill;" />
    </div>

    <!-- Contact Info Section -->
    <div class="container py-5">
        <h2 class="text-center mb-4">Get in Touch</h2>
        <p class="text-center mb-5">We'd love to hear from you! Reach out for orders, feedback, or inquiries.</p>
        <div class="row">
            <div class="col-md-6 mb-4">
                <h5><i class="bi bi-geo-alt-fill me-2"></i>Address</h5>
                <p>Foodies Hub, 123 Taste Street,<br />Gourmet City, FL 54321</p>

                <h5><i class="bi bi-telephone-fill me-2"></i>Phone</h5>
                <p>(123) 456-7890</p>

                <h5><i class="bi bi-envelope-fill me-2"></i>Email</h5>
                <p><a href="mailto:support@onlinefooddelivery.com">support@onlinefooddelivery.com</a></p>

                <h5><i class="bi bi-clock-fill me-2"></i>Working Hours</h5>
                <p>Monday – Sunday: 9:00 AM – 11:00 PM</p>
            </div>

            <!-- Contact Form -->
            <div class="col-md-6">
                <h5>Send us a Message</h5>
                <div class="form-group mb-3">
                    <label>Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group mb-3">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                </div>
                <div class="form-group mb-3">
                    <label>Message</label>
                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                </div>
                <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn btn-primary"/>
                <asp:Literal ID="ltStatus" runat="server" />
            </div>
        </div>
    </div>

    <!-- Embedded Map -->
    <div class="container mb-5">
        <h4 class="text-center mb-3">Find Us Here</h4>
        <div class="ratio ratio-16x9">
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2886.6610541067657!2d-79.38393468450053!3d43.653481579121116!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x882b34d14b46c701%3A0x76ac416b997a6a65!2sToronto%2C%20ON%2C%20Canada!5e0!3m2!1sen!2sus!4v1646411987730!5m2!1sen!2sus" 
                width="100%" 
                height="450" 
                style="border:0;" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade">
            </iframe>

        </div>
    </div>
</asp:Content>

