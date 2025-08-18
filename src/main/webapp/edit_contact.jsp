<%@ page import="com.yash.contactmanager.model.User" %>
<%@ page import="com.yash.contactmanager.model.Contact" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Contact</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<%
    // ✅ SESSION VALIDATION
    User loggedInUser = (User) session.getAttribute("currentUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Contact contact = (Contact) request.getAttribute("contact");
    if (contact == null) {
        response.sendRedirect("contacts.jsp");
        return;
    }
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

<!-- ✅ EDIT CONTACT FORM -->
<div class="min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-md">
        <h2 class="text-2xl font-bold text-center mb-6 text-indigo-600">Edit Contact</h2>

        <form action="editContact" method="post" enctype="multipart/form-data">
            <input type="hidden" name="contactId" value="<%= contact.getId() %>">

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Name</label>
                <input type="text" name="name" value="<%= contact.getName() %>" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                <input type="email" name="email" value="<%= contact.getEmail() %>" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Phone</label>
                <input type="text" name="phone" value="<%= contact.getPhone() %>" required
                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>

            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2">Address</label>
                <textarea name="address" rows="3" required
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"><%= contact.getAddress() %></textarea>
            </div>
            <label class="block font-semibold text-gray-700 mb-1">Category</label>
            <select name="category" required
                    class="w-full border px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 mb-4">
                <option value="Family" <%= "Family".equals(contact.getCategory()) ? "selected" : "" %>>Family</option>
                <option value="Friends" <%= "Friends".equals(contact.getCategory()) ? "selected" : "" %>>Friends</option>
                <option value="Work" <%= "Work".equals(contact.getCategory()) ? "selected" : "" %>>Work</option>
                <option value="Other" <%= "Other".equals(contact.getCategory()) ? "selected" : "" %>>Other</option>
            </select>
            <!-- Notes Field -->
            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2">Notes (optional)</label>
                <textarea name="notes" rows="3"
                          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
                          placeholder="Any extra details about this contact..."><%= contact.getNotes() != null ? contact.getNotes() : "" %></textarea>
            </div>

             <!-- ✅ Show existing photo -->
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2">Current Photo</label>
                            <% if (contact.getPhotoPath() != null && !contact.getPhotoPath().isEmpty()) { %>
                                <img src="uploads/<%= contact.getPhotoPath() %>" alt="Photo"
                                     class="h-20 w-20 rounded-full object-cover mb-2">
                            <% } else { %>
                                <p class="text-gray-500 italic">No photo uploaded.</p>
                            <% } %>
                        </div>

                       <!-- ✅ Upload New Photo -->
                        <div class="mb-6">
                            <label class="block text-gray-700 text-sm font-bold mb-2">Change Photo (optional)</label>
                            <input type="file" name="photo"
                                   class="w-full text-sm text-gray-500 border border-gray-300 rounded-md cursor-pointer">
                        </div>
  <label class="font-semibold">Birthday:</label>
  <input type="date" name="birthday"
         value="<%= contact.getBirthday() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(contact.getBirthday()) : "" %>"
         class="w-full border px-3 py-2 rounded mb-4">

  <label class="font-semibold">Anniversary:</label>
  <input type="date" name="anniversary"
         value="<%= contact.getAnniversary() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(contact.getAnniversary()) : "" %>"
         class="w-full border px-3 py-2 rounded mb-4">


            <button type="submit"
                    class="w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700 transition">
                Update Contact
            </button>
        </form>
    </div>
</div>

</body>
</html>