<%@ page import="com.yash.contactmanager.model.User" %>
<%@ page import="com.yash.contactmanager.model.Contact" %>
<%@ page import="com.yash.contactmanager.model.Reminder" %>
<%@ page import="com.yash.contactmanager.model.Activity" %>
<%@ page import="com.yash.contactmanager.service.ContactService" %>
<%@ page import="com.yash.contactmanager.service.ReminderService" %>
<%@ page import="com.yash.contactmanager.service.ActivityService" %>
<%@ page import="com.yash.contactmanager.serviceimpl.ContactServiceImpl" %>
<%@ page import="com.yash.contactmanager.serviceimpl.ReminderServiceImpl" %>
<%@ page import="com.yash.contactmanager.serviceimpl.ActivityServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get current user from session
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

        ContactService contactService = new ContactServiceImpl();
        ReminderService reminderService = new ReminderServiceImpl();
        ActivityService activityService = new ActivityServiceImpl();

        // Get stats
        int totalContacts = contactService.getContactCountByUserId(loggedInUser.getId());
        int favoritesCount = contactService.getFavoriteCountByUserId(loggedInUser.getId());
        List<Reminder> upcomingReminders = reminderService.getUpcomingReminders(loggedInUser.getId(), 3);
        int upcomingRemindersCount = upcomingReminders.size();
        List<Activity> recentActivities = activityService.getRecentActivities(loggedInUser.getId(), 5);
        int activityCount = recentActivities.size();

        // Get recent contacts
        List<Contact> recentContacts = contactService.getRecentContacts(loggedInUser.getId(), 5);

        // Date formatters
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("MMM dd, yyyy 'at' h:mm a");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Manager | Enhanced Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <script src="assets/js/dashboard.js" defer></script>

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
            <a href="dashboard.jsp" class="active">Dashboard</a>
            <a href="contacts.jsp">Contacts</a>
            <a href="reminders">Reminders</a>
            <div class="user-profile" id="userProfile">
                <div class="user-avatar"><%= avatarInitial %></div>
                <span class="user-name"><%= loggedInUser.getName() %></span>
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
        <div class="welcome-section">
            <h1 class="welcome-title">Welcome Back, <%= loggedInUser.getName() %>!</h1>
            <p class="user-email">Logged in as <strong><%= loggedInUser.getEmail() %></strong></p>
        </div>

        <!-- Stats Section -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value" id="contactsCount" data-target="<%= totalContacts %>">0</div>
                <div class="stat-label">Total Contacts</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-bell"></i>
                </div>
                <div class="stat-value" id="remindersCount" data-target="<%= upcomingRemindersCount %>">0</div>
                <div class="stat-label">Upcoming Reminders</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-sync"></i>
                </div>
                <div class="stat-value" id="activityCount"data-target="<%= activityCount %>">0</div>
                <div class="stat-label">Recent Activities</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-value" id="favoritesCount"data-target="<%= favoritesCount %>">0</div>
                <div class="stat-label">Favorites</div>
            </div>
        </div>

        <div class="dashboard-content">
            <!-- Recent Contacts Section -->
            <div class="card">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-history"></i> Recent Contacts
                    </h3>
                    <div class="search-bar">
                        <input type="text" placeholder="Search contacts...">
                        <button><i class="fas fa-search"></i></button>
                    </div>
                </div>

                <ul class="recent-contacts">
                 <% if (recentContacts != null && !recentContacts.isEmpty()) { %>
                            <% for (Contact contact : recentContacts) { %>
                   <li class="contact-item">
                       <div class="contact-avatar"><%= contact.getName().charAt(0) %></div>
                       <div class="contact-details">
                           <div class="contact-name"><%= contact.getName() %></div>
                           <div class="contact-email"><%= contact.getEmail() %></div>
                       </div>
                       <div class="contact-date"><%= dateFormat.format(contact.getCreatedAt()) %></div>
                   </li>
                    <% } %>
                            <% } else { %>
                                <li class="contact-item" style="justify-content: center;">
                                    <div>No recent contacts</div>
                                </li>
                            <% } %>

                </ul>

                <div style="text-align: center; margin-top: 20px;">
                    <a href="contacts.jsp" class="view-all-btn">
                        <i class="fas fa-address-book"></i> View All Contacts
                    </a>
                </div>
            </div>

            <!-- Right Column -->
            <div>
                <!-- Reminders Section -->
                <div class="card" style="margin-bottom: 30px;">
                    <h3 class="section-title">
                        <i class="fas fa-bell"></i> Upcoming Reminders
                    </h3>

                    <ul class="reminders-list">
                    <% if (upcomingReminders != null && !upcomingReminders.isEmpty()) { %>
                                <% for (Reminder reminder : upcomingReminders) { %>
                        <li class="reminder-item <%= reminder.getPriority().toLowerCase() %>-priority">
                            <div class="reminder-icon">
                                <i class="<%= getReminderIcon(reminder.getType()) %>"></i>
                            </div>
                            <div class="reminder-details">
                                <div class="reminder-name"><%= reminder.getTitle() %></div>
                                <div class="reminder-date"> <%= dateTimeFormat.format(reminder.getReminderDate()) %></div>
                            </div>
                            <span class="priority-badge"><%= reminder.getPriority() %></span>
                        </li>
                         <% } %>
                                <% } else { %>
                                    <li class="reminder-item">
                                        <div class="reminder-icon">
                                            <i class="fas fa-bell-slash"></i>
                                        </div>
                                        <div class="reminder-details">
                                            <div class="reminder-name">No upcoming reminders</div>
                                        </div>
                                    </li>
                                <% } %>

                    </ul>

                    <a href="reminders" class="view-all-btn">
                        <i class="fas fa-calendar-alt"></i> View All Reminders
                    </a>
                </div>

                <!-- Activity Timeline -->
                <div class="card">
                    <h3 class="section-title">
                        <i class="fas fa-list"></i> Recent Activity
                    </h3>

                    <!-- Fixed activity timeline section -->
                    <ul class="activity-list">
                    <% if (recentActivities != null && !recentActivities.isEmpty()) { %>
                        <% for (Activity activity : recentActivities) { %>
                            <li class="activity-item">
                                <div class="activity-icon">
                                    <i class="<%= getActivityIcon(activity.getActionType()) %>"></i>
                                </div>
                                <div class="activity-content"><%= activity.getDescription() %></div>
                                <div class="activity-time"><%= dateTimeFormat.format(activity.getActivityDate()) %></div>
                            </li>
                        <% } %>
                    <% } else { %>
                        <li class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-info-circle"></i>
                            </div>
                            <div class="activity-content">No recent activity</div>
                        </li>
                    <% } %>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <h3 class="section-title">
                <i class="fas fa-rocket"></i> Quick Actions
            </h3>

            <div class="actions-grid">
                <a href="add_contact.jsp" class="action-card">
                    <div class="action-icon" style="background: linear-gradient(45deg, var(--success), #06d6a0);">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="action-name">Add Contact</div>
                    <div class="action-desc">Create new contact</div>
                </a>

                <a href="import.jsp" class="action-card">
                    <div class="action-icon" style="background: linear-gradient(45deg, var(--primary), var(--secondary));">
                        <i class="fas fa-file-import"></i>
                    </div>
                    <div class="action-name">Import</div>
                    <div class="action-desc">Import contacts</div>
                </a>

                <a href="groups.jsp" class="action-card">
                    <div class="action-icon" style="background: linear-gradient(45deg, #ff9e00, #ff6b00);">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="action-name">Groups</div>
                    <div class="action-desc">Manage contact groups</div>
                </a>

                <a href="settings.jsp" class="action-card">
                    <div class="action-icon" style="background: linear-gradient(45deg, var(--danger), #d90429);">
                        <i class="fas fa-cog"></i>
                    </div>
                    <div class="action-name">Settings</div>
                    <div class="action-desc">Account preferences</div>
                </a>
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
<!-- Add helper methods at the bottom of the JSP -->
<%!
    private String getReminderIcon(String type) {
        if (type == null) return "fas fa-bell";

        switch (type.toLowerCase()) {
            case "birthday": return "fas fa-birthday-cake";
            case "anniversary": return "fas fa-gift";
            case "meeting": return "fas fa-calendar-day";
            case "task": return "fas fa-tasks";
            default: return "fas fa-bell";
        }
    }

    private String getActivityIcon(String actionType) {
        if (actionType == null) return "fas fa-info-circle";

        switch (actionType.toLowerCase()) {
            case "add": return "fas fa-plus";
            case "update": return "fas fa-edit";
            case "delete": return "fas fa-trash";
            case "reminder": return "fas fa-bell";
            case "favorite": return "fas fa-star";
            case "export": return "fas fa-file-export";
            default: return "fas fa-info-circle";
        }
    }
   %>