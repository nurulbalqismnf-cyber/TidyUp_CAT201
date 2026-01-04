package com.tidyup.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Capture the form data
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Admin verification logic
        if ("admin".equals(username) && "admin123".equals(password)) {
            // Set the Admin Cookie
            Cookie roleCookie = new Cookie("userRole", "admin");
            roleCookie.setMaxAge(60 * 60 * 24);
            roleCookie.setPath("/");
            resp.addCookie(roleCookie);

            // Redirect to your powerful Admin Dashboard
            resp.sendRedirect("dashboard.jsp");
        } else {
            // Send back to login if wrong credentials
            resp.sendRedirect("login.jsp?error=invalid");
        }
    }
} // <--- This final bracket fixes your build error!