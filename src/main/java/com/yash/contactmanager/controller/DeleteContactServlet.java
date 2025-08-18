package com.yash.contactmanager.controller;

import com.yash.contactmanager.dao.ContactDao;
import com.yash.contactmanager.service.ContactService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import com.yash.contactmanager.serviceimpl.ContactServiceImpl;

@WebServlet(name = "DeleteContactServlet", value = "/deleteContact")
public class DeleteContactServlet extends HttpServlet {

    private ContactService contactService = new ContactServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contactIdStr = request.getParameter("contactId");

        if (contactIdStr != null) {
            int contactId = Integer.parseInt(contactIdStr);

            boolean deleted = contactService.deleteContact(contactId);

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
