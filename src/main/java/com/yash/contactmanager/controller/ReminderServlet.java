package com.yash.contactmanager.controller;

import com.yash.contactmanager.model.Contact;
import com.yash.contactmanager.model.User;
import com.yash.contactmanager.service.ContactService;
import com.yash.contactmanager.serviceimpl.ContactServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/reminders")
public class ReminderServlet extends HttpServlet {
        private ContactService contactService = new ContactServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("currentUser");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }


        List<Contact> reminders = contactService.getUpcomingReminders(loggedInUser.getId());

        request.setAttribute("reminders", reminders);
        request.getRequestDispatcher("reminders.jsp").forward(request, response);
    }
}

