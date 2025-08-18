package com.yash.contactmanager.controller;

import com.yash.contactmanager.service.ContactService;
import com.yash.contactmanager.serviceimpl.ContactServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/deleteMultipleContacts")
public class DeleteMultipleContactsServlet extends HttpServlet {
    private final ContactService contactService = new ContactServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String[] contactIds = request.getParameterValues("contactIds");

        if (contactIds == null || contactIds.length == 0) {
            session.setAttribute("errorMsg", "No contacts selected for deletion");
            response.sendRedirect("contacts.jsp");
            return;
        }

        try {
            List<Integer> ids = new ArrayList<>();
            for (String id : contactIds) {
                ids.add(Integer.parseInt(id));
            }


            boolean success = contactService.deleteMultipleContacts(ids);

            if (success) {
                session.setAttribute("successMsg", ids.size() + " contact(s) deleted successfully");
            } else {
                session.setAttribute("errorMsg", "Failed to delete selected contacts");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid contact ID format");
        }

        response.sendRedirect("contacts.jsp");
    }
}