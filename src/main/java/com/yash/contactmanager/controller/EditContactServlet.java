package com.yash.contactmanager.controller;

import com.yash.contactmanager.model.Contact;
import com.yash.contactmanager.serviceimpl.ContactServiceImpl;
import com.yash.contactmanager.service.ContactService;

import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@MultipartConfig
@WebServlet(name = "EditContactServlet", value = "/editContact")
public class EditContactServlet extends HttpServlet {

    private ContactService contactService = new ContactServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int contactId = Integer.parseInt(request.getParameter("id"));
        Contact contact = contactService.getContactById(contactId);

        if (contact != null) {
            request.setAttribute("contact", contact);
            request.getRequestDispatcher("edit_contact.jsp").forward(request, response);
        } else {
            response.sendRedirect("contacts.jsp?error=Contact+not+found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int contactId = Integer.parseInt(request.getParameter("contactId"));
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



        // ✅ Fetch existing contact to get old photo filename
        Contact existingContact = contactService.getContactById(contactId);
        String fileName = existingContact.getPhotoPath();  // Default: old photo remains

        // ✅ Handle uploaded photo
        Part photoPart = request.getPart("photo");
        if (photoPart != null && photoPart.getSize() > 0) {  // If new photo uploaded
            fileName = System.currentTimeMillis() + "_" + photoPart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            photoPart.write(uploadPath + java.io.File.separator + fileName);
        }

        Contact contact = new Contact();
        contact.setId(contactId);
        contact.setName(name);
        contact.setEmail(email);
        contact.setPhone(phone);
        contact.setAddress(address);
        contact.setCategory(category);
        contact.setPhotoPath(fileName);
        contact.setNotes(notes);
        contact.setBirthday(birthday);
        contact.setAnniversary(anniversary);

        boolean updated = contactService.updateContact(contact);

        if (updated) {
            request.getSession().setAttribute("successMsg", "Contact updated successfully");
        } else {
            request.getSession().setAttribute("errorMsg", "Failed to update contact");
        }
        response.sendRedirect("contacts.jsp");

    }
}