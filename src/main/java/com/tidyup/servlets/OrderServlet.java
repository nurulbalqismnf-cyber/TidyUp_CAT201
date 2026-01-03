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

    // 1. Handle "Confirm" or "Cancel" actions
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String action = req.getParameter("action");

        if ("confirm".equals(action)) {
            DataStore.getInstance().updateBookingStatus(id, "Confirmed");
        } else if ("cancel".equals(action)) {
            DataStore.getInstance().updateBookingStatus(id, "Cancelled");
        }

        // Redirect back to the orders page
        resp.sendRedirect("orders.jsp");
    }
}