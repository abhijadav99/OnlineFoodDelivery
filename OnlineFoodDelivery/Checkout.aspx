<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineFoodDelivery.Checkout" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5" style="background-color: var(--muted-bg);">
        <div class="row justify-content-center mb-4">
            <div class="col-md-8 text-center">
                <h2 class="fw-bold text-primary">Complete Your Order</h2>
                <p class="text-muted">We’ll deliver your favorite meals right to your doorstep!</p>
            </div>
        </div>

        <div class="row g-4">
            <!-- Shipping Information Card -->
            <div class="col-md-6">
                <div class="card shadow-lg border-0">
                    <div class="card-header" style="background-color: var(--primary-color); color: var(--secondary-color);">
                        <h5 class="mb-0">Shipping Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Full Name" Required="true" />
                        </div>
                        <div class="mb-3">
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Street Address" Required="true" />
                        </div>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" Required="true" />
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control" placeholder="State" Required="true" />
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" placeholder="Zip Code" Required="true" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Summary Card -->
            <div class="col-md-6">
                <div class="card shadow-lg border-0 h-100">
                    <div class="card-header" style="background-color: var(--primary-color); color: var(--secondary-color);">
                        <h5 class="mb-0">Your Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <asp:Repeater ID="rptOrderSummary" runat="server">
                            <ItemTemplate>
                                <div class="d-flex justify-content-between mb-2">
                                    <span><%# Eval("Name") %> x <%# Eval("Quantity") %></span>
                                    <span class="fw-bold">$<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <hr />
                        <div class="d-flex justify-content-between fs-5 fw-bold">
                            <span>Total:</span>
                            <asp:Literal ID="ltTotal" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Place Order Button -->
        <div class="row mt-4">
            <div class="col-md-12 text-end">
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-lg btn-success px-5" OnClick="btnPlaceOrder_Click" />
            </div>
        </div>
    </div>
</asp:Content>
