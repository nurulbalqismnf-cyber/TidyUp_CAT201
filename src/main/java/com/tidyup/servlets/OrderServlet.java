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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Get the Order ID and the Action (Complete or Cancel)
        String id = req.getParameter("id");
        String action = req.getParameter("action");

        // 2. Process the Action
        if ("complete".equals(action)) {
            // Change status to Completed
            DataStore.getInstance().updateBookingStatus(id, "Completed");
            // If you implemented the file saving from the previous step, uncomment this:
            // DataStore.getInstance().saveCredentials();
        }
        else if ("cancel".equals(action)) {
            DataStore.getInstance().updateBookingStatus(id, "Cancelled");
        }

        // 3. Reload the page you came from
        String referer = req.getHeader("Referer");
        if (referer != null) {
            resp.sendRedirect(referer);
        } else {
            // Fallback if referer is missing
            resp.sendRedirect("orders.jsp");
        }
    }
}