package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    // 1. Handle GET requests (in case someone types /orders directly)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Just show the JSP page
        req.getRequestDispatcher("orders.jsp").forward(req, resp);
    }

    // 2. Handle POST requests (Button clicks)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String action = req.getParameter("action");

        if (id != null && action != null) {
            if ("complete".equals(action)) {
                DataStore.getInstance().updateBookingStatus(id, "Completed");
            }
            else if ("cancel".equals(action)) {
                DataStore.getInstance().updateBookingStatus(id, "Cancelled");
            }
        }

        // 3. SAFELY Redirect back to orders.jsp
        resp.sendRedirect("orders.jsp");
    }
}