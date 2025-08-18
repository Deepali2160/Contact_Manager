package com.yash.contactmanager.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);  // avoid creating new session
        if (session != null) {
            session.invalidate();  // end session
        }
        response.sendRedirect("login.jsp");  // redirect to login
    }
}