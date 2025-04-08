<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OnlineFoodDelivery._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <div>
            <img src="Images/food-banner.jpg" alt="Delicious Food Banner" class="img-fluid w-100" style="height: 100vh; object-fit: cover;" />
        </div>


    <!-- Popular Categories -->
    <div class="container py-5">
        <h2 class="text-center fw-bold mb-5">Popular Categories</h2>
        <div class="row g-4 text-center">
            <div class="col-md-4">
                <div class="card shadow-sm border-0 h-100">
                    <img src="Images/pizza.jpg" class="card-img-top" alt="Pizza">
                    <div class="card-body">
                        <h5 class="card-title">Pizza</h5>
                        <p class="card-text text-muted">Freshly baked pizzas with cheesy perfection.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm border-0 h-100">
                    <img src="Images/burger.jpg" class="card-img-top" alt="Burger">
                    <div class="card-body">
                        <h5 class="card-title">Burgers</h5>
                        <p class="card-text text-muted">Juicy burgers stacked with flavor.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm border-0 h-100">
                    <img src="Images/dessert.jpg" class="card-img-top" alt="Desserts">
                    <div class="card-body">
                        <h5 class="card-title">Desserts</h5>
                        <p class="card-text text-muted">Satisfy your sweet tooth anytime.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="bg-light py-5">
        <div class="container">
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <img src="Images/icon-fast-delivery.png" alt="Fast Delivery" width="60" class="mb-3" />
                    <h5 class="fw-bold">Fast Delivery</h5>
                    <p class="text-muted">We deliver hot and fresh within 30 minutes!</p>
                </div>
                <div class="col-md-4">
                    <img src="Images/icon-fresh-food.png" alt="Fresh Food" width="60" class="mb-3" />
                    <h5 class="fw-bold">Fresh Ingredients</h5>
                    <p class="text-muted">Prepared with hygiene and premium ingredients.</p>
                </div>
                <div class="col-md-4">
                    <img src="Images/icon-customer-support.png" alt="Support" width="60" class="mb-3" />
                    <h5 class="fw-bold">24/7 Support</h5>
                    <p class="text-muted">Friendly support whenever you need us.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="text-center py-5 mb-4 text-black"  style="background-color: var(--muted-bg);">
        <h2 class="fw-bold">Ready to Eat?</h2>
        <p class="lead">Browse our delicious menu and get it delivered to your door!</p>
        <a href="Products.aspx" class="btn btn-dark btn-lg">Start Ordering</a>
    </div>

</asp:Content>
