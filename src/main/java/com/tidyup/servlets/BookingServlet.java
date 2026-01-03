package com.tidyup.servlets;

import com.tidyup.models.Booking;
import com.tidyup.models.DataStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String customerName = req.getParameter("customerName");
        String serviceName = req.getParameter("serviceName");

        double price = 0.0;
        try {
            price = Double.parseDouble(req.getParameter("price"));
        } catch (NumberFormatException e) {
            price = 0.0;
        }

        Booking newBooking = new Booking(customerName, serviceName, price);
        DataStore.getInstance().addBooking(newBooking);

        // Redirect back to customer page with success message
        resp.sendRedirect("customer.jsp?success=true");
    }
}