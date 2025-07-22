<%@ page import="com.contactmanager.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Contact</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<%
    User loggedInUser = (User) session.getAttribute("currentUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String errorMsg = request.getParameter("error");
%>
<!-- ✅ HEADER -->
<div class="bg-indigo-600 text-white px-4 py-3 flex justify-between items-center shadow-md">
   <div class="text-lg font-semibold">
       Welcome, <%= loggedInUser.getName() %>
   </div>
   <div>
       <a href="logout" class="hover:underline font-semibold">Logout</a>
   </div>
</div>
<div class="min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-lg">

        <h2 class="text-2xl font-bold text-indigo-600 mb-6">Add New Contact</h2>

        <%-- ✅ Updated: Display error message after failure --%>
        <% if (errorMsg != null) { %>
            <div class="bg-red-100 text-red-700 px-4 py-2 mb-4 rounded">
                <%= errorMsg %>
            </div>
        <% } %>

        <form action="addContact" method="post" enctype="multipart/form-data" class="space-y-4">
            <input type="text" name="name" placeholder="Full Name" required class="w-full border rounded px-3 py-2">
            <input type="email" name="email" placeholder="Email" required class="w-full border rounded px-3 py-2">
            <input type="text" name="phone" placeholder="Phone Number" required class="w-full border rounded px-3 py-2">
            <textarea name="address" placeholder="Address" rows="3" required class="w-full border rounded px-3 py-2"></textarea>

            <label class="block font-semibold text-gray-700 mb-1">Category</label>
            <select name="category" required
                    class="w-full border px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 mb-4">
                <option value="Family">Family</option>
                <option value="Friends">Friends</option>
                <option value="Work">Work</option>
                <option value="Other" selected>Other</option>
            </select>
            <!-- Notes Field -->
            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2">Notes (optional)</label>
                <textarea name="notes" rows="3"
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
                          placeholder="Any extra details about this contact..."></textarea>
            </div>


            <label class="block font-semibold text-gray-700 mb-1">Photo</label>
            <input type="file" name="photo" accept="image/*"
                   class="w-full border px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 mb-4">

            <!-- Birthday Input -->
            <label class="font-semibold">Birthday:</label>
            <input type="date" name="birthday"
                   class="w-full border px-3 py-2 rounded mb-4">

            <!-- Anniversary Input -->
            <label class="font-semibold">Anniversary:</label>
            <input type="date" name="anniversary"
                   class="w-full border px-3 py-2 rounded mb-4">

            <button type="submit"
                    class="w-full bg-indigo-600 text-white py-2 rounded hover:bg-indigo-700">
                Add Contact
            </button>
        </form>


        <p class="mt-4 text-center">
            <a href="contacts.jsp" class="text-indigo-600 hover:underline">View Contacts</a>
        </p>

    </div>
</div>

</body>
</html>
