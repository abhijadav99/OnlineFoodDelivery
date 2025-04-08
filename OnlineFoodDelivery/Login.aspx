<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineFoodDelivery.Login" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center align-items-center py-5" style="background-color: var(--muted-bg);">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-lg border-0 rounded-4" style="background-color: var(--card-bg-color);">
                <div class="card-header text-center rounded-top-4" 
                     style="background-color: var(--primary-color); color: var(--secondary-color);">
                    <h4 class="mb-0">🔐 Secure Login</h4>
                </div>
                <div class="card-body px-4 py-4">
                    <div class="form-group mb-3">
                        <label class="form-label fw-semibold" style="color: var(--card-text-color);">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control rounded-3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
                            ErrorMessage="Please enter the correct User name" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group mb-3">
                        <label class="form-label fw-semibold" style="color: var(--card-text-color);">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control rounded-3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Please Enter correct password" CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" 
                        CssClass="btn w-100 mt-3 text-white rounded-3"
                        Style="background-color: var(--accent-color); border: none;"
                        OnClick="btnLoginUser" />
                    <div class="text-center mt-3">
                        <a href="Register.aspx" style="color: var(--primary-color); text-decoration: underline;">
                            Create new account
                        </a>
                    </div>
                    <div class="text-center mt-2">
                        <asp:Literal ID="ltMessage" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

