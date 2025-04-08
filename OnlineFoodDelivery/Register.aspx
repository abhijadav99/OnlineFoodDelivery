<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineFoodDelivery.Register" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center align-items-center py-5" style="background-color: var(--muted-bg);">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-lg border-0 rounded-4" style="background-color: var(--card-bg-color);">
                <div class="card-header text-center rounded-top-4" 
                     style="background-color: var(--primary-color); color: var(--secondary-color);">
                    <h4 class="mb-0">📝 Create Account</h4>
                </div>
                <div class="card-body px-4 py-4">
                    <div class="form-group mb-3">
                        <label class="form-label fw-semibold" style="color: var(--card-text-color);">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control rounded-3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Please enter Username" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group mb-3">
                        <label class="form-label fw-semibold" style="color: var(--card-text-color);">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control rounded-3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Please enter Email" CssClass="text-danger small" Display="Dynamic"/>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                            ErrorMessage="Invalid email" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group mb-3">
                        <label class="form-label fw-semibold" style="color: var(--card-text-color);">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control rounded-3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Please enter Password" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group mb-3">
                        <label class="form-label fw-semibold" style="color: var(--card-text-color);">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control rounded-3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Please enter Password" CssClass="text-danger small" Display="Dynamic"/>
                        <asp:CompareValidator runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Passwords don't match" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" 
                        CssClass="btn w-100 mt-3 text-white rounded-3"
                        Style="background-color: var(--accent-color); border: none;"
                        OnClick="btnCreateAccount" />
                    <div class="text-center mt-3">
                        <asp:Literal ID="ltMessage" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


