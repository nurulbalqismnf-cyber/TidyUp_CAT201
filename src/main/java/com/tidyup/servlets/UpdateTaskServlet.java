package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateTaskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("bookingId");

        // Mark as Success
        if(id != null) {
            DataStore.getInstance().updateBookingStatus(id, "Success");
        }

        // Redirect back to the same page
        String referer = req.getHeader("Referer");
        if(referer != null) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect("dashboard.jsp"); // Fallback
        }
    }
}