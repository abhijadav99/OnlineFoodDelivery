<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OnlineFoodDelivery.Products" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="bg-light py-4 px-3 rounded shadow-sm mb-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <h2 class="mb-2 fw-bold text-dark">Browse Our Collection</h2>
            <div class="w-100 w-md-25">
                <asp:DropDownList 
                    ID="ddlCategories" 
                    runat="server" 
                    AutoPostBack="True" 
                    OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged"
                    CssClass="form-select shadow-sm">
                </asp:DropDownList>
            </div>
        </div>
    </section>

    <!-- Message -->
    <asp:Literal ID="ltMessage" runat="server" EnableViewState="false" />

    <!-- Products Grid -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="col">
                    <div class="card border-0 h-100 shadow-sm product-card position-relative">
                        <div class="bg-image">
                            <img src='<%# Eval("ImageURL") %>' 
                                 class="card-img-top rounded-top object-fit-cover" 
                                 alt='<%# Eval("Name") %>' 
                                 style="height: 280px; object-fit: cover;" />
                        </div>
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="fw-semibold text-dark mb-1"><%# Eval("Name") %></h5>
                                <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold text-primary">$<%# Eval("Price", "{0:F2}") %></span>
                                <asp:Button runat="server" CommandArgument='<%# Eval("ProductID") %>' 
                                    Text="Add to Cart" CssClass="btn btn-outline-primary btn-sm px-3" 
                                    OnClick="btnAddToCart_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
