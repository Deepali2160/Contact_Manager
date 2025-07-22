package com.contactmanager.controller;

import com.contactmanager.dao.UserDao;
import com.contactmanager.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        if (userDao.isEmailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);   // pass plain password
        user.setPhone(phone);
        user.setProfilePic("https://ui-avatars.com/api/?name=" + name.replace(" ", "+") + "&background=random");

        if (userDao.registerUser(user)) {
            response.sendRedirect("login.jsp?success=Registration successful! Please login.");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
