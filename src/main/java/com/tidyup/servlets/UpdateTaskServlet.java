package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import com.tidyup.models.Booking;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateTask")
public class UpdateTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Change "id" to "bookingId" to match your JSP form
        String bookingId = req.getParameter("bookingId");

        for (Booking b : DataStore.getInstance().getBookings()) {
            if (String.valueOf(b.getId()).equals(bookingId)) {
                b.setStatus("Completed");
                break;
            }
        }
        resp.sendRedirect("dashboard.jsp");
    }
}