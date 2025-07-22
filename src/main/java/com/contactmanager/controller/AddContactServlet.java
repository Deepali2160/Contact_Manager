package com.contactmanager.controller;

import com.contactmanager.dao.ContactDao;
import com.contactmanager.model.Contact;
import com.contactmanager.model.User;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@MultipartConfig   // ✅ To handle file uploads
@WebServlet(name = "AddContactServlet", value = "/addContact")
public class AddContactServlet extends HttpServlet {

    private ContactDao contactDao = new ContactDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String category = request.getParameter("category");
        String notes = request.getParameter("notes");
        String birthdayStr = request.getParameter("birthday");
        String anniversaryStr = request.getParameter("anniversary");

        Date birthday = null;
        Date anniversary = null;

        try {
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                birthday = java.sql.Date.valueOf(birthdayStr);
            }
            if (anniversaryStr != null && !anniversaryStr.isEmpty()) {
                anniversary = java.sql.Date.valueOf(anniversaryStr);
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }


        // ✅ Handle image upload
        Part photoPart = request.getPart("photo");
        String fileName = System.currentTimeMillis() + "_" + photoPart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/") + "uploads";
        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        photoPart.write(uploadPath + java.io.File.separator + fileName);

        // ✅ Set contact data
        Contact contact = new Contact();
        contact.setName(name);
        contact.setEmail(email);
        contact.setPhone(phone);
        contact.setAddress(address);
        contact.setUserId(user.getId());
        contact.setCategory(category);
        contact.setPhotoPath(fileName);   // ✅ Store photo filename
        contact.setNotes(notes);
        contact.setBirthday(birthday);
        contact.setAnniversary(anniversary);


        // ✅ Save to DB
        boolean success = contactDao.addContact(contact);

        if (success) {
            session.setAttribute("successMsg", "Contact added successfully");
        } else {
            session.setAttribute("errorMsg", "Failed to add contact. Please try again.");
        }

        response.sendRedirect("contacts.jsp");
    }
}
