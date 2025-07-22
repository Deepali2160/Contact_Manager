<%@ page import="com.contactmanager.dao.ContactDao" %>
<%@ page import="com.contactmanager.dao.ReminderDao" %>
<%@ page import="com.contactmanager.dao.ActivityDao" %>
<%@ page import="com.contactmanager.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.contactmanager.model.User" %>
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
     // Create DAO instances
        ContactDao contactDao = new ContactDao();
        ReminderDao reminderDao = new ReminderDao();
        ActivityDao activityDao = new ActivityDao();

        // Get stats
        int totalContacts = contactDao.getContactCountByUserId(loggedInUser.getId());
        int favoritesCount = contactDao.getFavoriteCountByUserId(loggedInUser.getId());
        List<Reminder> upcomingReminders = reminderDao.getUpcomingReminders(loggedInUser.getId(), 3);
        int upcomingRemindersCount = upcomingReminders.size();
        List<Activity> recentActivities = activityDao.getRecentActivities(loggedInUser.getId(), 5);
        int activityCount = recentActivities.size();

        // Get recent contacts
        List<Contact> recentContacts = contactDao.getRecentContacts(loggedInUser.getId(), 5);

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
            transition: all 0.3s ease;
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

        .welcome-section {
            text-align: center;
            margin-bottom: 60px;
        }

        .welcome-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 3rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ffffff, #e0e0ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -1px;
        }

        body.light-mode .welcome-title {
            background: linear-gradient(45deg, #2d3748, #4a5568);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .user-email {
            font-size: 1.2rem;
            color: #e0e0ff;
            margin-bottom: 2rem;
        }

        body.light-mode .user-email {
            color: #718096;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--feature-bg-dark);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--feature-border-dark);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        body.light-mode .stat-card {
            background: var(--feature-bg-light);
            border: 1px solid var(--feature-border-light);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        body.light-mode .stat-card:hover {
            background: rgba(255, 255, 255, 0.95);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
            margin-bottom: 20px;
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: var(--accent);
        }

        .stat-label {
            font-size: 1rem;
            color: var(--text-secondary-dark);
        }

        body.light-mode .stat-label {
            color: var(--text-secondary-light);
        }

        .dashboard-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 60px;
        }

        @media (max-width: 992px) {
            .dashboard-content {
                grid-template-columns: 1fr;
            }
        }

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

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .search-bar {
            display: flex;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50px;
            padding: 8px 15px;
            width: 250px;
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

        .recent-contacts {
            list-style-type: none;
        }

        .contact-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-radius: 15px;
            margin-bottom: 12px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.05);
        }

        body.light-mode .contact-item {
            border: 1px solid #e2e8f0;
            background: rgba(237, 242, 247, 0.5);
        }

        .contact-item:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        body.light-mode .contact-item:hover {
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
            margin-right: 15px;
        }

        .contact-details {
            flex: 1;
        }

        .contact-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        body.light-mode .contact-name {
            color: #2d3748;
        }

        .contact-email {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.7);
        }

        body.light-mode .contact-email {
            color: #718096;
        }

        .contact-date {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.5);
        }

        body.light-mode .contact-date {
            color: #a0aec0;
        }

        .reminders-list {
            list-style-type: none;
            margin-bottom: 30px;
        }

        .reminder-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-radius: 15px;
            background: rgba(255, 215, 0, 0.1);
            margin-bottom: 15px;
            border: 1px solid rgba(255, 215, 0, 0.2);
            transition: all 0.3s ease;
            position: relative;
        }

        body.light-mode .reminder-item {
            background: rgba(255, 215, 0, 0.08);
            border: 1px solid rgba(255, 215, 0, 0.15);
        }

        .reminder-item.high-priority {
            background: rgba(239, 71, 111, 0.1);
            border-color: rgba(239, 71, 111, 0.2);
        }

        body.light-mode .reminder-item.high-priority {
            background: rgba(239, 71, 111, 0.08);
            border-color: rgba(239, 71, 111, 0.15);
        }

        .reminder-item.medium-priority {
            background: rgba(255, 209, 102, 0.1);
            border-color: rgba(255, 209, 102, 0.2);
        }

        body.light-mode .reminder-item.medium-priority {
            background: rgba(255, 209, 102, 0.08);
            border-color: rgba(255, 209, 102, 0.15);
        }

        .reminder-item:hover {
            transform: translateX(5px);
        }

        .reminder-icon {
            font-size: 1.5rem;
            margin-right: 15px;
            color: var(--warning);
        }

        .reminder-item.high-priority .reminder-icon {
            color: var(--danger);
        }

        .reminder-item.medium-priority .reminder-icon {
            color: #ffb400;
        }

        .reminder-details {
            flex: 1;
        }

        .reminder-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .reminder-item.high-priority .reminder-name {
            color: var(--danger);
        }

        .reminder-item.medium-priority .reminder-name {
            color: #ffb400;
        }

        .reminder-date {
            font-size: 0.9rem;
            color: rgba(255, 215, 0, 0.8);
        }

        body.light-mode .reminder-date {
            color: #d69e2e;
        }

        .reminder-item.high-priority .reminder-date {
            color: rgba(239, 71, 111, 0.8);
        }

        body.light-mode .reminder-item.high-priority .reminder-date {
            color: #e53e3e;
        }

        .reminder-item.medium-priority .reminder-date {
            color: rgba(255, 180, 0, 0.8);
        }

        body.light-mode .reminder-item.medium-priority .reminder-date {
            color: #dd6b20;
        }

        .priority-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 0.8rem;
            padding: 3px 8px;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.8);
        }

        body.light-mode .priority-badge {
            background: rgba(237, 242, 247, 0.8);
            color: #4a5568;
        }

        .activity-list {
            list-style-type: none;
            position: relative;
            padding-left: 30px;
        }

        .activity-list:before {
            content: '';
            position: absolute;
            top: 10px;
            bottom: 10px;
            left: 10px;
            width: 2px;
            background: rgba(255, 255, 255, 0.1);
        }

        body.light-mode .activity-list:before {
            background: rgba(226, 232, 240, 0.8);
        }

        .activity-item {
            position: relative;
            padding: 15px 0 15px 30px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        body.light-mode .activity-item {
            border-bottom: 1px solid rgba(226, 232, 240, 0.8);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-item:before {
            content: '';
            position: absolute;
            top: 20px;
            left: 3px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: var(--primary);
            z-index: 2;
        }

        .activity-icon {
            position: absolute;
            top: 16px;
            left: 0;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: rgba(106, 17, 203, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            color: white;
        }

        .activity-content {
            font-size: 0.95rem;
            margin-bottom: 5px;
        }

        body.light-mode .activity-content {
            color: #2d3748;
        }

        .activity-time {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.6);
        }

        body.light-mode .activity-time {
            color: #a0aec0;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .action-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 20px;
            border-radius: 20px;
            background: rgba(67, 97, 238, 0.1);
            transition: all 0.3s ease;
            text-decoration: none;
            border: 1px solid rgba(67, 97, 238, 0.2);
            min-height: 170px;
        }

        body.light-mode .action-card {
            background: rgba(237, 242, 247, 0.8);
            border: 1px solid #e2e8f0;
        }

        .action-card:hover {
            transform: translateY(-5px);
            background: rgba(67, 97, 238, 0.15);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.2);
        }

        body.light-mode .action-card:hover {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .action-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
        }

        .action-name {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: white;
        }

        body.light-mode .action-name {
            color: #2d3748;
        }

        .action-desc {
            font-size: 0.85rem;
            color: var(--text-secondary-dark);
        }

        body.light-mode .action-desc {
            color: var(--text-secondary-light);
        }

        .view-all-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 25px;
            border-radius: 50px;
            background: linear-gradient(45deg, var(--warning), #ff9e00);
            color: #1e293b;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.3);
        }

        .view-all-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.4);
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

            .welcome-title {
                font-size: 2.2rem;
            }

            .dashboard-container {
                padding-top: 110px;
            }

            .dashboard-content {
                grid-template-columns: 1fr;
            }

            .nav-links {
                gap: 15px;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .search-bar {
                width: 100%;
            }
        }

        /* Notification badge */
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: bold;
        }

        /* Logout button styling */
        .logout-btn {
            color: var(--danger) !important;
            font-weight: 600;
        }

        body.light-mode .logout-btn {
            color: #e53e3e !important;
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
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Contact Support</a>
            <p>&copy; 2025 Contact Manager. All rights reserved.</p>
        </div>
    </div>

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

        // Counter animation for stats
        const counters = document.querySelectorAll('.stat-value');
        const speed = 200;

        counters.forEach(counter => {
            const animate = () => {
                const value = +counter.getAttribute('data-target');
                const data = +counter.innerText.replace(/,/g, '');
                const time = value / speed;

                if(data < value) {
                    counter.innerText = Math.ceil(data + time).toLocaleString();
                    setTimeout(animate, 1);
                } else {
                    counter.innerText = value.toLocaleString();
                }
            }

            // Set initial data-target values
            const currentValue = parseInt(counter.textContent);
            counter.setAttribute('data-target', currentValue);
            counter.innerText = '0';
            animate();
        });

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

        // Initialize theme on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set navbar background based on scroll position
            updateNavbarBackground();
        });
    </script>
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