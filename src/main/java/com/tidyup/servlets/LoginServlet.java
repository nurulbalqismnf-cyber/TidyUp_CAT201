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
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String remember = req.getParameter("remember"); // Returns "on" if checked, null if not

        // 1. Simple Validation (In real life, check database)
        if ("admin".equals(user) && "admin123".equals(pass)) {

            // --- COOKIE LOGIC (The "Write" Part) ---
            if (remember != null) {
                // Create a cookie named "savedUsername" storing the user's name
                Cookie c = new Cookie("savedUsername", user);

                // Set lifespan (e.g., 24 hours = 60*60*24 seconds)
                c.setMaxAge(60 * 60 * 24);

                // Add cookie to the response (send it to browser)
                resp.addCookie(c);
            } else {
                // If they unchecked it, delete the old cookie (set age to 0)
                Cookie c = new Cookie("savedUsername", "");
                c.setMaxAge(0);
                resp.addCookie(c);
            }

            // Login Success -> Go to Dashboard
            resp.sendRedirect("dashboard.jsp");

        } else {
            // Login Failed -> Go back to Login Page with error
            resp.sendRedirect("login.jsp?error=true");
        }
    }
}