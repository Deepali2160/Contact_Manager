<%@ page import="java.util.List" %>
<%@ page import="com.contactmanager.dao.ContactDao" %>
<%@ page import="com.contactmanager.model.Contact" %>
<%@ page import="com.contactmanager.model.User" %>
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
        ContactDao contactDao = new ContactDao();
        List<Contact> contactList = contactDao.getContactsByUserId(loggedInUser.getId());
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
    <style>
        :root {
            /* Dark Mode Variables - Updated to match index.jsp */
            --bg-gradient-dark: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --text-color-dark: white;
            --text-secondary-dark: rgba(255, 255, 255, 0.85);
            --card-bg-dark: rgba(255, 255, 255, 0.08);
            --card-border-dark: rgba(255, 255, 255, 0.15);
            --feature-bg-dark: rgba(255, 255, 255, 0.1);
            --feature-border-dark: rgba(255, 255, 255, 0.1);
            --btn-dark-bg: rgba(255, 255, 255, 0.15);
            --btn-dark-text: white;
            --btn-dark-border: rgba(255, 255, 255, 0.3);
            --logo-bg-dark: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --logo-shadow-dark: 0 8px 20px rgba(106, 17, 203, 0.4);
            --feature-icon-dark: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --feature-icon-shadow-dark: 0 5px 15px rgba(106, 17, 203, 0.3);
            --primary: #6a11cb;
            --secondary: #2575fc;
            --accent: #4cc9f0;
            --success: #4ade80;
            --warning: #ffd166;
            --danger: #ef476f;
            --navbar-bg-dark: rgba(26, 32, 55, 0.85);

            /* Light Mode Variables */
            --bg-gradient-light: linear-gradient(135deg, #f5f7fa 0%, #e4e7f4 100%);
            --text-color-light: #2d3748;
            --text-secondary-light: rgba(45, 55, 72, 0.8);
            --card-bg-light: rgba(255, 255, 255, 0.85);
            --card-border-light: rgba(203, 213, 224, 0.5);
            --feature-bg-light: rgba(255, 255, 255, 0.9);
            --feature-border-light: rgba(226, 232, 240, 0.8);
            --btn-light-bg: rgba(237, 242, 247, 0.8);
            --btn-light-text: #2d3748;
            --btn-light-border: rgba(160, 174, 192, 0.3);
            --navbar-bg-light: rgba(255, 255, 255, 0.9);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
        }

        body {
            background: var(--bg-gradient-dark);
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            color: var(--text-color-dark);
            overflow-x: hidden;
        }

        body.light-mode {
            background: var(--bg-gradient-light);
            color: var(--text-color-light);
        }

        /* Floating Decorations */
        .floating-decor {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .decor {
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: linear-gradient(45deg, rgba(118, 75, 162, 0.2), rgba(102, 126, 234, 0.2));
            top: -150px;
            right: -150px;
            z-index: 0;
        }

        .decor-2 {
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: linear-gradient(45deg, rgba(255, 255, 255, 0.1), rgba(118, 75, 162, 0.1));
            bottom: -100px;
            left: -100px;
            z-index: 0;
        }

        /* Navigation */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            transition:  transition: all 0.3s ease, background 0.1s ease;
            background: var(--navbar-bg-dark);
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        body.light-mode .navbar {
            background: var(--navbar-bg-light);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .logo {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(45deg, #6a11cb, #2575fc);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
            position: relative;
        }

        .nav-links a {
            color: #e2e8f0;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
        }

        body.light-mode .nav-links a {
            color: #4a5568;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s ease;
        }

        .nav-links a:hover:after {
            width: 100%;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            position: relative;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .user-name {
            font-size: 1rem;
            font-weight: 500;
        }

        body.light-mode .user-name {
            color: #2d3748;
        }

        /* User dropdown */
        .user-dropdown {
            position: absolute;
            top: 55px;
            right: 0;
            background: var(--card-bg-dark);
            border: 1px solid var(--feature-border-dark);
            border-radius: 12px;
            width: 220px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            z-index: 1001;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
            padding: 10px 0;
            backdrop-filter: blur(10px);
        }

        body.light-mode .user-dropdown {
            background: var(--card-bg-light);
            border: 1px solid var(--feature-border-light);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .user-dropdown.show {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .user-dropdown a {
            display: block;
            padding: 12px 20px;
            color: var(--text-color-dark);
            text-decoration: none;
            transition: background 0.3s ease;
            font-size: 0.95rem;
        }

        body.light-mode .user-dropdown a {
            color: var(--text-color-light);
        }

        .user-dropdown a:hover {
            background: rgba(106, 17, 203, 0.1);
        }

        body.light-mode .user-dropdown a:hover {
            background: rgba(237, 242, 247, 0.8);
        }

        .divider {
            height: 1px;
            background: var(--feature-border-dark);
            margin: 8px 0;
        }

        body.light-mode .divider {
            background: var(--feature-border-light);
        }

        .theme-toggle {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.5rem;
            color: #e2e8f0;
            transition: transform 0.3s ease;
            margin-left: 20px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        body.light-mode .theme-toggle {
            color: #4a5568;
            background: rgba(237, 242, 247, 0.8);
        }

        .theme-toggle:hover {
            transform: rotate(20deg);
            background: rgba(106, 17, 203, 0.1);
        }

        /* Main container */
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 140px 20px 60px;
            position: relative;
            z-index: 2;
        }

        /* Card styling */
        .card {
            background: var(--feature-bg-dark);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--feature-border-dark);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }

        body.light-mode .card {
            background: var(--feature-bg-light);
            border: 1px solid var(--feature-border-light);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        body.light-mode .card:hover {
            background: rgba(255, 255, 255, 0.95);
        }

        .section-title {
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: #e0e0ff;
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
            z-index: 2;
        }

        body.light-mode .section-title {
            color: #4a5568;
        }

        /* Contact header */
        .contact-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .user-info {
            font-size: 1.2rem;
            color: var(--text-secondary-dark);
        }

        body.light-mode .user-info {
            color: var(--text-secondary-light);
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .action-button {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 50px;
            background: linear-gradient(45deg, var(--warning), #ff9e00);
            color: #1e293b;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.3);
            border: none;
            cursor: pointer;
        }

        .action-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.4);
        }

        .action-button.reminder {
            background: linear-gradient(45deg, var(--accent), #06d6a0);
            box-shadow: 0 5px 15px rgba(76, 201, 240, 0.3);
        }

        .action-button.logout {
            background: linear-gradient(45deg, var(--danger), #d90429);
            box-shadow: 0 5px 15px rgba(239, 71, 111, 0.3);
        }

        /* Search and Add Contact */
        .search-add-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            gap: 20px;
        }

        .search-bar {
            display: flex;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50px;
            padding: 8px 15px;
            width: 100%;
            max-width: 400px;
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        body.light-mode .search-bar {
            background: rgba(237, 242, 247, 0.8);
            border: 1px solid #e2e8f0;
        }

        .search-bar input {
            background: transparent;
            border: none;
            color: white;
            padding: 5px 10px;
            width: 100%;
            font-size: 0.95rem;
        }

        body.light-mode .search-bar input {
            color: #2d3748;
        }

        .search-bar input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        body.light-mode .search-bar input::placeholder {
            color: #a0aec0;
        }

        .search-bar input:focus {
            outline: none;
        }

        .search-bar button {
            background: transparent;
            border: none;
            color: #e0e0ff;
            cursor: pointer;
        }

        body.light-mode .search-bar button {
            color: #718096;
        }

        .add-contact-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 25px;
            border-radius: 50px;
            background: linear-gradient(45deg, var(--success), #06d6a0);
            color: #1e293b;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(74, 222, 128, 0.3);
            white-space: nowrap;
        }

        .add-contact-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(74, 222, 128, 0.4);
        }

        /* Bulk Actions */
        .bulk-actions {
            display: none;
            background: rgba(106, 17, 203, 0.15);
            border-radius: 15px;
            padding: 15px;
            margin-bottom: 20px;
            align-items: center;
            gap: 15px;
            border: 1px solid var(--feature-border-dark);
        }

        body.light-mode .bulk-actions {
            background: rgba(237, 242, 247, 0.9);
            border: 1px solid var(--feature-border-light);
        }

        .bulk-actions.visible {
            display: flex;
        }

        .bulk-info {
            font-weight: 600;
            margin-right: 10px;
        }

        .bulk-btn {
            padding: 8px 15px;
            border-radius: 50px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .bulk-btn.delete {
            background: var(--danger);
            color: white;
        }

        .bulk-btn.export {
            background: var(--success);
            color: white;
        }

        .bulk-btn.cancel {
            background: transparent;
            color: var(--text-color-dark);
            border: 1px solid var(--feature-border-dark);
        }

        body.light-mode .bulk-btn.cancel {
            color: var(--text-color-light);
            border: 1px solid var(--feature-border-light);
        }

        /* Toast Messages */
        .toast {
            padding: 12px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            text-align: center;
            opacity: 1;
            transform: translateY(0);
            transition: all 0.5s ease;
        }

        .toast.success {
            background: rgba(74, 222, 128, 0.15);
            color: var(--success);
            border: 1px solid rgba(74, 222, 128, 0.3);
        }

        .toast.error {
            background: rgba(239, 71, 111, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 71, 111, 0.3);
        }

        /* Contacts Table */
        .contacts-container {
            overflow-x: auto;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--feature-border-dark);
        }

        body.light-mode .contacts-container {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid var(--feature-border-light);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--feature-border-dark);
        }
        td:nth-child(9), td:nth-child(10){
               white-space : nowrap;
        }
        body.light-mode th,
        body.light-mode td {
            border-bottom: 1px solid var(--feature-border-light);
        }

        th {
            background: rgba(106, 17, 203, 0.1);
            font-weight: 600;
            color: var(--accent);
        }

        body.light-mode th {
            background: rgba(106, 17, 203, 0.05);
        }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        body.light-mode tbody tr:hover {
            background: rgba(237, 242, 247, 0.8);
        }

        .contact-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
            margin: 0 auto;
        }

        .action-icons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .action-icon {
            color: var(--text-secondary-dark);
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1.2rem;
        }

        .action-icon.edit:hover {
            color: var(--warning);
            transform: scale(1.2);
        }

        .action-icon.delete:hover {
            color: var(--danger);
            transform: scale(1.2);
        }
       .action-icon:hover::after {
                   content: attr(data-tooltip);
                   position: absolute;
                   bottom: -25px;
                   left: 50%;
                   transform: translateX(-50%);
                   background: rgba(0,0,0,0.7);
                   color: white;
                   padding: 4px 8px;
                   border-radius: 4px;
                   font-size: 0.75rem;
                   white-space: nowrap;
                   z-index: 10;
               }
        body.light-mode .action-icon {
            color: var(--text-secondary-light);
        }
        <!-- In the <style> section, add this CSS: -->
        .action-icons form {
            display: inline-block;
        }

        .action-icon.delete {
            font-size: 1.3rem;
            color: #ff6b6b;
        }

            /* Add this to fix the text color inheritance */
            #contactsTableBody td {
                color: inherit;
            }

            /* Explicitly set text colors for both themes */
            body #contactsTableBody td {
                color: var(--text-color-dark);
            }

            body.light-mode #contactsTableBody td {
                color: var(--text-color-light);
            }

            /* Fix the action icons as well */
            .action-icon {
                color: inherit;
            }


        .action-icon.delete:hover {
            color: #ff0000;
            transform: scale(1.3);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 25px;
        }

        .pagination-btn {
            padding: 8px 15px;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-color-dark);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn:hover:not(:disabled) {
            background: rgba(106, 17, 203, 0.2);
            transform: translateY(-3px);
        }

        .pagination-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        body.light-mode .pagination-btn {
            background: rgba(237, 242, 247, 0.8);
            color: var(--text-color-light);
        }

        .page-indicator {
            font-weight: 600;
            color: var(--accent);
            margin: 0 10px;
        }

        /* No contacts message */
        .no-contacts {
            text-align: center;
            padding: 40px;
            color: var(--text-secondary-dark);
        }

        body.light-mode .no-contacts {
            color: var(--text-secondary-light);
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 20px;
            color: var(--text-secondary-dark);
            font-size: 0.9rem;
            border-top: 1px solid var(--feature-border-dark);
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        body.light-mode .footer {
            color: var(--text-secondary-light);
            border-top: 1px solid var(--feature-border-light);
        }

        .footer a {
            color: var(--text-secondary-dark);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        body.light-mode .footer a {
            color: var(--text-secondary-light);
        }

        .footer a:hover {
            color: var(--text-color-dark);
            text-decoration: underline;
        }

        body.light-mode .footer a:hover {
            color: var(--text-color-light);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
            }

            .dashboard-container {
                padding-top: 110px;
            }

            .contact-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header-actions {
                width: 100%;
                justify-content: flex-end;
            }

            .search-add-container {
                flex-direction: column;
            }

            .search-bar {
                max-width: none;
                width: 100%;
            }
        }
    </style>
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
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Contact Support</a>
            <p>&copy; 2025 Contact Manager. All rights reserved.</p>
        </div>
    </div>
        table, th, td {
              color: inherit; /* Ensure text inherits from parent */
          }

          /* Explicitly set text colors for light mode */
          body.light-mode #contactsTableBody td {
              color: var(--text-color-light);
          }

          /* Explicitly set text colors for dark mode */
          body #contactsTableBody td {
              color: var(--text-color-dark);
          }

          /* Update the no-contacts message */
          body.light-mode .no-contacts {
              color: var(--text-secondary-light);
          }
    <script>
        // Theme toggle functionality
        const modeToggle = document.getElementById('themeToggle');
        const modeIcon = modeToggle.querySelector('i');
        const body = document.body;

        // Check for saved theme preference or respect OS preference
        const savedMode = localStorage.getItem('mode');
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

        // Apply theme on page load
        if (savedMode === 'light' || (!savedMode && !prefersDark)) {
            body.classList.add('light-mode');
            modeIcon.classList.remove('fa-moon');
            modeIcon.classList.add('fa-sun');
        } else {
            modeIcon.classList.remove('fa-sun');
            modeIcon.classList.add('fa-moon');
        }

        modeToggle.addEventListener('click', () => {
            body.classList.toggle('light-mode');

            if (body.classList.contains('light-mode')) {
                modeIcon.classList.remove('fa-moon');
                modeIcon.classList.add('fa-sun');
                localStorage.setItem('mode', 'light');
            } else {
                modeIcon.classList.remove('fa-sun');
                modeIcon.classList.add('fa-moon');
                localStorage.setItem('mode', 'dark');
            }
             const table = document.querySelector('.contacts-container');
                table.style.display = 'none';
                table.offsetHeight; // Trigger reflow
                table.style.display = '';
            // Update navbar background after theme change
            updateNavbarBackground();
        });

        // Navbar scroll effect
        const navbar = document.querySelector('.navbar');

        function updateNavbarBackground() {
            if (window.scrollY > 50) {
                navbar.style.background = body.classList.contains('light-mode')
                    ? 'rgba(255, 255, 255, 0.95)'
                    : 'rgba(26, 32, 55, 0.95)';
            } else {
                navbar.style.background = body.classList.contains('light-mode')
                    ? 'rgba(255, 255, 255, 0.9)'
                    : 'rgba(26, 32, 55, 0.85)';
            }
        }

        window.addEventListener('scroll', updateNavbarBackground);

        // User dropdown functionality
        const userProfile = document.getElementById('userProfile');
        const userDropdown = document.getElementById('userDropdown');

        userProfile.addEventListener('click', (e) => {
            e.stopPropagation();
            userDropdown.classList.toggle('show');
        });

        // Close dropdown when clicking elsewhere
        document.addEventListener('click', (e) => {
            if (!userProfile.contains(e.target)) {
                userDropdown.classList.remove('show');
            }
        });

        // Logout functionality
        const logoutBtn = document.getElementById('logoutBtn');

        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            // Show confirmation dialog
            if (confirm('Are you sure you want to logout?')) {
                // Here you would typically redirect to logout endpoint
                alert('Logout successful! Redirecting to login page...');
                window.location.href = 'login.jsp';
            }
        });

        // Bulk actions functionality
        const selectAllCheckbox = document.getElementById('selectAll');
        const contactCheckboxes = document.querySelectorAll('.contact-checkbox');
        const bulkActions = document.getElementById('bulkActions');
        const selectedCount = document.getElementById('selectedCount');
        const deleteSelectedBtn = document.getElementById('deleteSelected');
        const exportSelectedBtn = document.getElementById('exportSelected');
        const cancelSelectionBtn = document.getElementById('cancelSelection');

        // Select/Deselect All
        selectAllCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            contactCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            updateBulkActions();
        });

        // Individual checkbox change
        contactCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateBulkActions);
        });

        // Update bulk actions display
        function updateBulkActions() {
            const selectedCountValue = document.querySelectorAll('.contact-checkbox:checked').length;
            selectedCount.textContent = `${selectedCountValue} selected`;

            if (selectedCountValue > 0) {
                bulkActions.classList.add('visible');
            } else {
                bulkActions.classList.remove('visible');
                selectAllCheckbox.checked = false;
            }
        }

        // Delete selected contacts
        deleteSelectedBtn.addEventListener('click', function() {
            const selectedIds = [];
            document.querySelectorAll('.contact-checkbox:checked').forEach(checkbox => {
                selectedIds.push(checkbox.value);
            });

            if (selectedIds.length === 0) {
                alert('Please select at least one contact to delete');
                return;
            }

            if (confirm(`Are you sure you want to delete ${selectedIds.length} selected contact(s)?`)) {
                // Create a form to submit the selected IDs
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'deleteMultipleContacts';

                selectedIds.forEach(id => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'contactIds';
                    input.value = id;
                    form.appendChild(input);
                });

                document.body.appendChild(form);
                form.submit();
            }
        });

        // Export selected contacts
        exportSelectedBtn.addEventListener('click', function() {
            const selectedIds = [];
            document.querySelectorAll('.contact-checkbox:checked').forEach(checkbox => {
                selectedIds.push(checkbox.value);
            });

            if (selectedIds.length === 0) {
                alert('Please select at least one contact to export');
                return;
            }

            // Create a form to submit the selected IDs
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'exportContacts';

            selectedIds.forEach(id => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'contactIds';
                input.value = id;
                form.appendChild(input);
            });

            document.body.appendChild(form);
            form.submit();
        });

        // Cancel selection
        cancelSelectionBtn.addEventListener('click', function() {
            resetSelection();
        });

        // Reset selection
        function resetSelection() {
            selectAllCheckbox.checked = false;
            contactCheckboxes.forEach(checkbox => {
                checkbox.checked = false;
            });
            bulkActions.classList.remove('visible');
        }

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase();
            const rows = document.querySelectorAll('#contactsTableBody tr');

            rows.forEach(row => {
                if (row.cells.length > 1) {
                    const name = row.cells[2].textContent.toLowerCase();
                    const email = row.cells[3].textContent.toLowerCase();
                    const phone = row.cells[4].textContent.toLowerCase();
                    const category = row.cells[6].textContent.toLowerCase();

                    if (name.includes(query) || email.includes(query) || phone.includes(query) || category.includes(query)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            });
        });

        // Pagination functionality
        const prevPageBtn = document.getElementById('prevPage');
        const nextPageBtn = document.getElementById('nextPage');
        const currentPageElement = document.getElementById('currentPage');
        const totalPagesElement = document.getElementById('totalPages');

        let currentPage = 1;
        const rowsPerPage = 5;
        const rows = Array.from(document.querySelectorAll('#contactsTableBody tr')).filter(row => row.style.display !== 'none');
        const totalPages = Math.ceil(rows.length / rowsPerPage);

        totalPagesElement.textContent = totalPages;

        function updatePagination() {
            // Hide all rows
            rows.forEach(row => row.style.display = 'none');

            // Calculate start and end indices
            const start = (currentPage - 1) * rowsPerPage;
            const end = Math.min(start + rowsPerPage, rows.length);

            // Show rows for current page
            for (let i = start; i < end; i++) {
                rows[i].style.display = '';
            }

            // Update pagination controls
            currentPageElement.textContent = currentPage;
            prevPageBtn.disabled = currentPage === 1;
            nextPageBtn.disabled = currentPage === totalPages;
        }

        prevPageBtn.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                updatePagination();
            }
        });

        nextPageBtn.addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                updatePagination();
            }
        });

        // Initialize pagination
        if (totalPages > 1) {
            updatePagination();
        }

        // Initialize theme on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set navbar background based on scroll position
            updateNavbarBackground();
        });
    </script>
</body>
</html>
