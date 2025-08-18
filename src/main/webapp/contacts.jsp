<%@ page import="java.util.List" %>
<%@ page import="com.yash.contactmanager.model.User" %>
<%@ page import="com.yash.contactmanager.model.Contact" %>
<%@ page import="com.yash.contactmanager.service.ContactService" %>
<%@ page import="com.yash.contactmanager.serviceimpl.ContactServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Moved to top: Get current user FIRST
    User loggedInUser = (User) session.getAttribute("currentUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Initialize avatar initial
    String avatarInitial = "?";
    if (loggedInUser.getName() != null && !loggedInUser.getName().isEmpty()) {
        avatarInitial = String.valueOf(loggedInUser.getName().charAt(0)).toUpperCase();
    }
     // Load contacts for the user
        ContactService contactService = new ContactServiceImpl();
        List<Contact> contactList = contactService.getContactsByUserId(loggedInUser.getId());
    %>
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Manager | Contacts</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/contact.css">
    <script src="assets/js/contact.js" defer></script>
</head>
<body>
    <!-- Floating Decorations -->
    <div class="floating-decor">
        <div class="decor"></div>
        <div class="decor-2"></div>
    </div>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="index.jsp" class="logo">Contact Manager</a>
        <div class="nav-links">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="contacts.jsp" class="active">Contacts</a>
            <a href="reminders">Reminders</a>
            <div class="user-profile" id="userProfile">
                <div class="user-avatar"> <%= avatarInitial %></div>
                <span class="user-name"> <%= loggedInUser.getName() %></span>
                <div class="notification-badge">3</div>
                <div class="user-dropdown" id="userDropdown">
                    <a href="#"><i class="fas fa-user-circle"></i> My Profile</a>
                    <a href="#"><i class="fas fa-cog"></i> Account Settings</a>
                    <a href="#"><i class="fas fa-bell"></i> Notifications</a>
                    <div class="divider"></div>
                    <a href="#" class="logout-btn" id="logoutBtn"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
            <button class="theme-toggle" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
        </div>
    </nav>

    <div class="dashboard-container">
        <div class="card">
            <div class="contact-header">
                <div>
                    <h2 class="section-title">
                        <i class="fas fa-address-book"></i> Your Contacts
                    </h2>
                    <div class="user-info">
                        Welcome, <strong><%= loggedInUser.getName() %></strong>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="reminders" class="action-button reminder">
                        <i class="fas fa-bell"></i> Reminders
                    </a>
                    <a href="logout" class="action-button logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

            <!-- Search and Add Contact -->
            <div class="search-add-container">
                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="Search contacts...">
                    <button><i class="fas fa-search"></i></button>
                </div>
                <a href="add_contact.jsp" class="add-contact-btn">
                    <i class="fas fa-user-plus"></i> Add New Contact
                </a>
            </div>

            <!-- Bulk Actions -->
            <div id="bulkActions" class="bulk-actions">
                <span class="bulk-info" id="selectedCount">0 selected</span>
                <button class="bulk-btn delete" id="deleteSelected">
                    <i class="fas fa-trash"></i> Delete Selected
                </button>
                <button class="bulk-btn export" id="exportSelected">
                    <i class="fas fa-file-export"></i> Export Selected
                </button>
                <button class="bulk-btn cancel" id="cancelSelection">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>

            <!-- Toast Messages -->
            <%
                String successMsg = (String) session.getAttribute("successMsg");
                String errorMsg = (String) session.getAttribute("errorMsg");
                session.removeAttribute("successMsg");
                session.removeAttribute("errorMsg");
            %>
            <% if (successMsg != null) { %>
                <div class="toast success">
                    <%= successMsg %>
                </div>
            <% } else if (errorMsg != null) { %>
                <div class="toast error">
                    <%= errorMsg %>
                </div>
            <% } %>

            <!-- Contacts Table -->
            <div class="contacts-container">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 40px;">
                                <input type="checkbox" id="selectAll">
                            </th>
                            <th style="width: 60px;">Photo</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Category</th>
                            <th>Notes</th>
                            <th>Birthday</th>
                            <th>Anniversary</th>
                            <th style="width: 100px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="contactsTableBody">
                        <%

                            if (contactList != null && !contactList.isEmpty()) {
                                for (Contact contact : contactList) {
                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
                        %>
                        <tr>
                            <td><input type="checkbox" class="contact-checkbox" value="<%= contact.getId() %>"></td>
                            <td>
                                <% if (contact.getPhotoPath() != null && !contact.getPhotoPath().isEmpty()) { %>
                                    <img src="uploads/<%= contact.getPhotoPath() %>" alt="Photo" class="contact-avatar">
                                <% } else { %>
                                    <div class="contact-avatar"><%= contact.getName().charAt(0) %></div>
                                <% } %>
                            </td>
                            <td><%= contact.getName() %></td>
                            <td><%= contact.getEmail() %></td>
                            <td><%= contact.getPhone() %></td>
                            <td><%= contact.getAddress() %></td>
                            <td><%= contact.getCategory() %></td>
                            <td><%= contact.getNotes() != null && !contact.getNotes().isEmpty() ? contact.getNotes() : "—" %></td>
                            <td><%= contact.getBirthday() != null ? sdf.format(contact.getBirthday()) : "—" %></td>
                            <td><%= contact.getAnniversary() != null ? sdf.format(contact.getAnniversary()) : "—" %></td>
                            <td>
                                <div class="action-icons">
                                     <a href="editContact?id=<%= contact.getId() %>" class="action-icon edit" data-tooltip="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                   <form action="deleteContact" method="post" onsubmit="return confirm('Are you sure you want to delete this contact?');" class="inline-block">
                                                       <input type="hidden" name="contactId" value="<%= contact.getId() %>">
                                                       <!-- Updated delete button with data-tooltip -->
                                                       <button type="submit" class="action-icon delete" data-tooltip="Delete">
                                                           <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="11" class="no-contacts">
                                No contacts found. Start by adding a new contact.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <button class="pagination-btn" id="prevPage" disabled>
                    <i class="fas fa-chevron-left"></i> Previous
                </button>
                <span class="page-indicator">
                    Page <span id="currentPage">1</span> of <span id="totalPages">1</span>
                </span>
                <button class="pagination-btn" id="nextPage">
                    Next <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>

        <div class="footer">
            <a href="privacypolicy.jsp">Privacy Policy</a>
                                    <a href="termsofservice.jsp">Terms of Service</a>
                                    <a href="contactsupport.jsp">Contact Support</a>
            <p>&copy; 2025 Contact Manager. All rights reserved.</p>
        </div>
    </div>


</body>
</html>
