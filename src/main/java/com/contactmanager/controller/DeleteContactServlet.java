package com.contactmanager.controller;

import com.contactmanager.dao.ContactDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteContactServlet", value = "/deleteContact")
public class DeleteContactServlet extends HttpServlet {

    private ContactDao contactDao = new ContactDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contactIdStr = request.getParameter("contactId");

        if (contactIdStr != null) {
            int contactId = Integer.parseInt(contactIdStr);

            boolean deleted = contactDao.deleteContact(contactId);

            if (deleted) {
                response.sendRedirect("contacts.jsp?success=Contact+deleted+successfully");
            } else {
                response.sendRedirect("contacts.jsp?error=Failed+to+delete+contact");
            }
        } else {
            response.sendRedirect("contacts.jsp?error=Invalid+contact+ID");
        }
    }
}
