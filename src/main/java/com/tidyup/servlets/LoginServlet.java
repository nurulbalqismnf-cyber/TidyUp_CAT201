package com.tidyup.servlets;

import com.tidyup.models.DataStore; // Import DataStore
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
        String remember = req.getParameter("remember");

        // UPDATED: Now we check the DataStore instead of hardcoded strings!
        if (DataStore.getInstance().validateLogin(user, pass)) {

            // --- COOKIE LOGIC (Same as before) ---
            if (remember != null) {
                Cookie c = new Cookie("savedUsername", user);
                c.setMaxAge(60 * 60 * 24); // 24 hours
                resp.addCookie(c);
            } else {
                Cookie c = new Cookie("savedUsername", "");
                c.setMaxAge(0);
                resp.addCookie(c);
            }

            // Login Success
            resp.sendRedirect("dashboard.jsp");

        } else {
            // Login Failed
            resp.sendRedirect("login.jsp?error=true");
        }
    }
}