package com.yash.contactmanager.controller;

import com.yash.contactmanager.model.User;
import com.yash.contactmanager.service.UserService;
import com.yash.contactmanager.serviceimpl.UserServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl(); //creating object of UserServiceImpl

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //fetching details from user
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        System.out.println("Login attempt: email=" + email + ", password=" + password);

        User user = userService.loginUser(email, password);
        System.out.println("Login attempt with email: " + email);
        System.out.println("Returned user: " + user);


        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("dashboard");
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        System.out.println("LoginServlet is running.");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

}