package com.contactmanager.controller;

import com.contactmanager.dao.ContactDao;
import com.contactmanager.model.Contact;
import com.contactmanager.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/reminders")
public class ReminderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("currentUser");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ContactDao contactDao = new ContactDao();
        List<Contact> reminders = contactDao.getUpcomingReminders(loggedInUser.getId());

        request.setAttribute("reminders", reminders);
        request.getRequestDispatcher("reminders.jsp").forward(request, response);
    }
}

