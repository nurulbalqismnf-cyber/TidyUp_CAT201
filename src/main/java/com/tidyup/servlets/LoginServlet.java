package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Capture the form data
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 2. Ask DataStore to check if this user exists (Admin OR Customer)
        // This uses the unified checkLogin method we created in DataStore
        String role = DataStore.getInstance().checkLogin(username, password);

        if (role != null) {
            // --- LOGIN SUCCESS ---

            // Create a Session (This is better than Cookies for security)
            HttpSession session = req.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", role);

            // 3. Redirect based on Role
            if ("admin".equals(role)) {
                // Admin goes to the Dashboard
                System.out.println("Login: Admin detected. Redirecting to dashboard.");
                resp.sendRedirect("dashboard.jsp");
            } else {
                // Customers go to the Booking Page (Member 2's feature)
                System.out.println("Login: Customer detected. Redirecting to Booking Service.");
                resp.sendRedirect("UserBookingServlet");
            }
        } else {
            // --- LOGIN FAILED ---
            System.out.println("Login Failed for user: " + username);
            resp.sendRedirect("login.jsp?error=invalid");
        }
    }
}