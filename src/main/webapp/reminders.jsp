<%@ page import="java.util.List" %>
<%@ page import="com.contactmanager.model.Contact" %>
<%@ page import="com.contactmanager.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reminders</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<%
    User loggedInUser = (User) session.getAttribute("currentUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Contact> reminders = (List<Contact>) request.getAttribute("reminders");
%>

<div class="bg-indigo-600 text-white px-4 py-3 flex justify-between items-center shadow-md">
    <div class="text-lg font-semibold">
        Reminders for <%= loggedInUser.getName() %>
    </div>
    <div>
        <a href="contacts.jsp" class="hover:underline font-semibold">Back to Contacts</a>
    </div>
</div>

<div class="max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-lg mt-8">
    <h2 class="text-2xl font-bold text-indigo-700 mb-4">Upcoming Birthdays & Anniversaries (Next 7 Days)</h2>

    <% if (reminders != null && !reminders.isEmpty()) { %>
        <ul class="space-y-4">
            <% for (Contact contact : reminders) { %>
                <li class="border rounded p-4 bg-gray-50 hover:bg-gray-100 transition">
                    <span class="font-semibold text-indigo-600"><%= contact.getName() %></span><br>
                    <% if (contact.getBirthday() != null) { %>
                        🎂 Birthday: <%= new java.text.SimpleDateFormat("dd MMMM").format(contact.getBirthday()) %><br>
                    <% } %>
                    <% if (contact.getAnniversary() != null) { %>
                        💍 Anniversary: <%= new java.text.SimpleDateFormat("dd MMMM").format(contact.getAnniversary()) %><br>
                    <% } %>
                    📧 <%= contact.getEmail() %> | 📞 <%= contact.getPhone() %>
                </li>
            <% } %>
        </ul>
    <% } else { %>
        <p class="text-gray-500">No reminders found for the next 7 days.</p>
    <% } %>
</div>

</body>
</html>
