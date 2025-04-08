<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineFoodDelivery.Cart" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5" style="background-color: var(--muted-bg);">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow rounded-4 border-0">
                    <div class="card-body px-4 py-5">
                        <h2 class="text-center mb-4 text-primary">🛒 Shopping Cart</h2>

                        <!-- Cart Table -->
                        <div class="table-responsive">
                            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false"
                                DataKeyNames="ProductID" OnRowCommand="gvCart_RowCommand"
                                CssClass="table align-middle text-center"
                                OnRowDataBound="gvCart_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Product">
                                        <ItemTemplate>
                                            <div class="d-flex align-items-center gap-3">
                                                <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("Name") %>'
                                                    class="rounded shadow-sm" style="width: 80px; height: 80px; object-fit: cover;" />
                                                <strong><%# Eval("Name") %></strong>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />

                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtQuantity" runat="server"
                                                Text='<%# Eval("Quantity") %>' TextMode="Number"
                                                Width="60" CssClass="form-control text-center" AutoPostBack="true"
                                                OnTextChanged="txtQuantity_TextChanged" />
                                            <asp:RangeValidator runat="server" ControlToValidate="txtQuantity"
                                                MinimumValue="1" MaximumValue="99" Type="Integer"
                                                ErrorMessage="1-99 only" Display="Dynamic" CssClass="text-danger small" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Total">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotal" runat="server"
                                                Text='<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("C") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button runat="server" CommandName="Remove" Text="🗑"
                                                CommandArgument='<%# Eval("ProductID") %>'
                                                CssClass="btn btn-outline-danger btn-sm rounded-pill" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- Cart Total + Checkout -->
                        <div class="text-end mt-5">
                            <h4>Total: <asp:Literal ID="ltTotal" runat="server" /></h4>
                            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout"
                                CssClass="btn btn-primary btn-lg mt-3 px-5"
                                OnClick="btnCheckout_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

