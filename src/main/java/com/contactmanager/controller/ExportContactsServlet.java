package com.contactmanager.controller;

import com.contactmanager.dao.ContactDao;
import com.contactmanager.model.Contact;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/exportContacts")
public class ExportContactsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] contactIds = request.getParameterValues("contactIds");

        if (contactIds == null || contactIds.length == 0) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "No contacts selected for export");
            response.sendRedirect("contacts.jsp");
            return;
        }

        try {
            List<Integer> ids = new ArrayList<>();
            for (String id : contactIds) {
                ids.add(Integer.parseInt(id));
            }

            ContactDao contactDao = new ContactDao();
            List<Contact> contacts = contactDao.getContactsByIds(ids);

            // Set response headers for CSV download
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"contacts_export.csv\"");

            // Write CSV content
            PrintWriter writer = response.getWriter();
            writer.println("Name,Email,Phone,Address,Category,Notes,Birthday,Anniversary");

            for (Contact contact : contacts) {
                writer.println(String.format("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"",
                        contact.getName(),
                        contact.getEmail(),
                        contact.getPhone(),
                        contact.getAddress(),
                        contact.getCategory(),
                        contact.getNotes() != null ? contact.getNotes().replace("\"", "\"\"") : "",
                        contact.getBirthday(),
                        contact.getAnniversary()
                ));
            }

            writer.flush();
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Invalid contact ID format");
            response.sendRedirect("contacts.jsp");
        }
    }
}