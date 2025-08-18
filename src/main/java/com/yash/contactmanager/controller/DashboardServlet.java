package com.yash.contactmanager.controller;

import com.yash.contactmanager.model.User;
import com.yash.contactmanager.service.ContactService;
import com.yash.contactmanager.service.ReminderService;
import com.yash.contactmanager.service.ActivityService;
import com.yash.contactmanager.serviceimpl.ContactServiceImpl;
import com.yash.contactmanager.serviceimpl.ReminderServiceImpl;
import com.yash.contactmanager.serviceimpl.ActivityServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    private ContactService contactService;
    private ReminderService reminderService;
    private ActivityService activityService;
    @Override
    public void init() throws ServletException {
        contactService = new ContactServiceImpl();
        reminderService = new ReminderServiceImpl();
        activityService = new ActivityServiceImpl();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        request.setAttribute("contactCount", contactService.getContactCountByUserId(userId));
        request.setAttribute("favCount", contactService.getFavoriteCountByUserId(userId));
        request.setAttribute("recentContacts", contactService.getRecentContacts(userId, 5));
        request.setAttribute("upcomingReminders", reminderService.getUpcomingReminders(userId, 5));
        request.setAttribute("recentActivities", activityService.getRecentActivities(userId, 5));
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);

    }

}
