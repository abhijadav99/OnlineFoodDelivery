<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="OnlineFoodDelivery.AdminDashboard" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <asp:HiddenField ID="hdnActiveTab" runat="server" Value="#products" />

    <div class="container-fluid">
        <!-- Tabs Navigation -->
        <ul class="nav nav-tabs mb-4" id="adminTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="products-tab" data-toggle="tab" href="#products" role="tab">Products</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="orders-tab" data-toggle="tab" href="#orders" role="tab">Orders</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="users-tab" data-toggle="tab" href="#users" role="tab">Users</a>
            </li>
        </ul>

        <!-- Tab Contents -->
        <div class="tab-content">
            <!-- Products Tab -->
            <div class="tab-pane fade show active" id="products" role="tabpanel">
                <h2 class="mb-4">Product Management</h2>
                
                <asp:GridView ID="gvProducts" runat="server" 
                    OnRowEditing="gvProducts_RowEditing"
                    OnRowUpdating="gvProducts_RowUpdating"
                    OnRowCancelingEdit="gvProducts_RowCancelingEdit" 
                    OnRowDeleting="gvProducts_RowDeleting"
                    AutoGenerateColumns="false"
                    DataKeyNames="ProductID"
                    CssClass="table table-striped">
                       <Columns>
                           <asp:TemplateField>
                           <ItemTemplate>
                               <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm" />
                               <asp:LinkButton runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-sm"
                                   OnClientClick="return confirm('Are you sure?');" />
                           </ItemTemplate>
                           <EditItemTemplate>
                               <asp:LinkButton runat="server" CommandName="Update" Text="Update" 
                                   ValidationGroup="EditProduct" CssClass="btn btn-sm" />
                               <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                                   CausesValidation="false" CssClass="btn btn-sm" />
                           </EditItemTemplate>
                       </asp:TemplateField>
                           <asp:TemplateField HeaderText="Image">
                               <ItemTemplate>
                                   <img src='<%# Eval("ImageURL") %>' alt="Product Image" style="max-width: 100px;"/>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="txtImageURL" runat="server" 
                                       Text='<%# Bind("ImageURL") %>' CssClass="form-control"/>
                               </EditItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Product Name">
                               <ItemTemplate>
                                   <%# Eval("Name") %>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"/>
                               </EditItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Description">
                               <ItemTemplate>
                                   <%# Eval("Description") %>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' 
                                       TextMode="MultiLine" CssClass="form-control"/>
                               </EditItemTemplate>
                           </asp:TemplateField>
                               <asp:TemplateField HeaderText="Price">
                                   <ItemTemplate>
                                       <%# Eval("Price", "{0:C}") %>
                                   </ItemTemplate>
                                   <EditItemTemplate>
                                       <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' 
                                           CssClass="form-control"/>
                                       <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice"
                                           ErrorMessage="Required" ValidationGroup="EditProduct"
                                           CssClass="text-danger" Display="Dynamic"/>
                                       <asp:CompareValidator runat="server" ControlToValidate="txtPrice"
                                           Type="Currency" Operator="DataTypeCheck" ValidationGroup="EditProduct"
                                           ErrorMessage="Invalid" CssClass="text-danger" Display="Dynamic"/>
                                   </EditItemTemplate>
                               </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Category">
                                       <ItemTemplate>
                                           <%# Eval("CategoryName") %>
                                       </ItemTemplate>
                                        <EditItemTemplate>
                                <asp:DropDownList ID="ddlCategories" runat="server"
                                    DataSourceID="SqlDataSource1" DataTextField="CategoryName" 
                                    DataValueField="CategoryID" SelectedValue='<%# Bind("CategoryID") %>'
                                    CssClass="form-select"/>
                            </EditItemTemplate>
                           </asp:TemplateField>
                       </Columns>
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:OnlineFoodDeliveryDB %>"
                    SelectCommand="SELECT * FROM Categories"></asp:SqlDataSource>

                <h3 class="mt-5">Add New Product</h3>
                <div class="row g-3">
                    <div class="col-md-4">
                        <asp:TextBox ID="txtName" runat="server" placeholder="Product Name" CssClass="form-control"/>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="txtPrice" runat="server" placeholder="Price" CssClass="form-control"/>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice"
                            ErrorMessage="Price required" ValidationGroup="AddProduct"
                            CssClass="text-danger" Display="Dynamic"/>
                        <asp:CompareValidator runat="server" ControlToValidate="txtPrice"
                            Type="Currency" Operator="DataTypeCheck" ValidationGroup="AddProduct"
                            ErrorMessage="Invalid price format" CssClass="text-danger" Display="Dynamic"/>
                    </div>
                    <div class="col-md-4">
                        <asp:DropDownList ID="ddlCategory" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="CategoryName" 
                            DataValueField="CategoryID" CssClass="form-select"/>
                    </div>
                    <div class="col-12">
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"
                            placeholder="Description" CssClass="form-control"/>
                    </div>
                    <div class="col-12">
                        <asp:TextBox ID="txtImageURL" runat="server" 
                            placeholder="Image URL" CssClass="form-control"/>
                    </div>
                    <div class="col-md-12">
                        <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" 
                            CssClass="btn btn-primary" ValidationGroup="AddProduct"
                            OnClick="btnAddProduct_Click"/>
                    </div>
                 </div>
            </div>
            <!-- Orders Tab -->
            <div class="tab-pane fade" id="orders" role="tabpanel">
                <h2 class="mb-4">Order Management</h2>
                
                <!-- Order GridView -->
                <asp:GridView ID="gvOrders" runat="server" 
                    AutoGenerateColumns="false"
                    DataKeyNames="OrderID"
                    OnRowEditing="gvOrders_RowEditing"
                    OnRowUpdating="gvOrders_RowUpdating"
                    OnRowCancelingEdit="gvOrders_RowCancelingEdit"
                    CssClass="table table-striped">
                    <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Update" Text="Update" 
                                        ValidationGroup="EditOrder" CssClass="btn btn-sm" />
                                    <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                                        CausesValidation="false" CssClass="btn btn-sm" />
                                </EditItemTemplate>
                        </asp:TemplateField>

                            <asp:BoundField DataField="OrderID" HeaderText="Order ID" ReadOnly="true" />
                            <asp:BoundField DataField="Username" HeaderText="Customer" ReadOnly="true" />
                            <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:d}" ReadOnly="true" />
                            <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:C}" ReadOnly="true" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Eval("OrderStatus") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select"
                                        SelectedValue='<%# Bind("OrderStatus") %>'>
                                        <asp:ListItem>Pending</asp:ListItem>
                                        <asp:ListItem>Shipped</asp:ListItem>
                                        <asp:ListItem>Delivered</asp:ListItem>
                                        <asp:ListItem>Cancelled</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shipping Info">
                                <ItemTemplate>
                                    <div class="small">
                                        <%# Eval("ShippingName") %><br />
                                        <%# Eval("ShippingAddress") %><br />
                                        <%# Eval("ShippingCity") %>, <%# Eval("ShippingState") %> <%# Eval("ShippingZip") %>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                </asp:GridView>
            </div>

            <!-- Users Tab -->
            <div class="tab-pane fade" id="users" role="tabpanel">
                <h2 class="mb-4">User Management</h2>
                   <asp:GridView ID="gvUsers" runat="server"
                    AutoGenerateColumns="false"
                    DataKeyNames="UserID"
                    OnRowEditing="gvUsers_RowEditing"
                    OnRowUpdating="gvUsers_RowUpdating"
                    OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                    OnRowDeleting="gvUsers_RowDeleting"
                    CssClass="table table-striped">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm" />
                                <asp:LinkButton runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-sm"
                                    OnClientClick="return confirm('Are you sure?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton runat="server" CommandName="Update" Text="Update" 
                                    ValidationGroup="EditUser" CssClass="btn btn-sm" />
                                <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" 
                                    CausesValidation="false" CssClass="btn btn-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
    
                        <asp:TemplateField HeaderText="Username">
                            <ItemTemplate><%# Eval("Username") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUsername" runat="server" Text='<%# Bind("Username") %>' 
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
                                    ErrorMessage="Required" ValidationGroup="EditUser"
                                    CssClass="text-danger" Display="Dynamic"/>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' 
                                    CssClass="form-control" TextMode="Email"/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="Required" ValidationGroup="EditUser"
                                    CssClass="text-danger" Display="Dynamic"/>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ErrorMessage="Invalid email" ValidationGroup="EditUser"
                                    CssClass="text-danger" Display="Dynamic"/>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Role">
                            <ItemTemplate><%# Eval("Role") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-select"
                                    SelectedValue='<%# Bind("Role") %>'>
                                    <asp:ListItem>Admin</asp:ListItem>
                                    <asp:ListItem>User</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <h3 class="mt-5">Add New User</h3>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <asp:TextBox ID="txtNewUsername" runat="server" placeholder="Username" 
                                CssClass="form-control"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewUsername"
                                ErrorMessage="Required" ValidationGroup="AddUser"
                                CssClass="text-danger" Display="Dynamic"/>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtNewEmail" runat="server" placeholder="Email" 
                                CssClass="form-control" TextMode="Email"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewEmail"
                                ErrorMessage="Required" ValidationGroup="AddUser"
                                CssClass="text-danger" Display="Dynamic"/>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNewEmail"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ErrorMessage="Invalid email" ValidationGroup="AddUser"
                                CssClass="text-danger" Display="Dynamic"/>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtNewPassword" runat="server" placeholder="Password" 
                                CssClass="form-control" TextMode="Password"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPassword"
                                ErrorMessage="Required" ValidationGroup="AddUser"
                                CssClass="text-danger" Display="Dynamic"/>
                        </div>
                        <!-- Add this new dropdown -->
                        <div class="col-md-4">
                            <asp:DropDownList ID="ddlNewRole" runat="server" CssClass="form-select"
                                ValidationGroup="AddUser">
                                <asp:ListItem Value="User">User</asp:ListItem>
                                <asp:ListItem Value="Admin">Admin</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlNewRole"
                                ErrorMessage="Role required" ValidationGroup="AddUser"
                                CssClass="text-danger" Display="Dynamic"/>
                        </div>
                        <div class="col-md-12">
                            <asp:Button ID="btnAddUser" runat="server" Text="Add User" 
                                CssClass="btn btn-primary" ValidationGroup="AddUser"
                                OnClick="btnAddUser_Click"/>
                        </div>
                    </div>
            </div>
        </div>
</div>
    <!-- Required Scripts -->
     <!-- Add this script after existing scripts -->
    <script type="text/javascript">
        $(function () {
            // Restore active tab from hidden field
            var activeTab = $('#<%= hdnActiveTab.ClientID %>').val();
            if (activeTab) {
                $('#adminTabs a[href="' + activeTab + '"]').tab('show');
            }

            // Update hidden field when tab changes
            $('#adminTabs a').on('shown.bs.tab', function (e) {
                $('#<%= hdnActiveTab.ClientID %>').val($(e.target).attr('href'));
            });
        });
    </script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</asp:Content>