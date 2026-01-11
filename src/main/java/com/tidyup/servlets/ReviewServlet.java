package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import com.tidyup.models.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String user = (String) session.getAttribute("user");
        if(user == null) user = "Guest";

        // Get Data
        String bookingId = req.getParameter("bookingId");
        int rating = Integer.parseInt(req.getParameter("rating"));
        String message = req.getParameter("message");
        String date = java.time.LocalDate.now().toString();

        // Save Review
        Review newReview = new Review(user, rating, message, date);
        DataStore.getInstance().addReview(newReview);

        // Mark as 'Reviewed'
        if(bookingId != null && !bookingId.isEmpty()) {
            DataStore.getInstance().markBookingAsReviewed(bookingId);
        }

        // Go back to history
        resp.sendRedirect("UserBookingServlet?action=history");
    }
}