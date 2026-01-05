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

        // 1. Get Form Data
        // Note: We parse the rating as an Integer
        int rating = Integer.parseInt(req.getParameter("rating"));
        String message = req.getParameter("message");

        // 2. Get the current date
        String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

        // 3. Create & Save Review
        // IMPORTANT: Ensure your existing Review.java constructor matches this order!
        // It usually is: (Name, Rating, Message, Date) OR (Name, Rating, Message)

        // TRY THIS FIRST (Most common):
        Review newReview = new Review(user, rating, message, date);

        // IF THAT IS RED, TRY THIS (If your date is auto-generated inside Review.java):
        // Review newReview = new Review(user, rating, message);

        DataStore.getInstance().addReview(newReview);

        // 4. Redirect back to history with a success message
        resp.sendRedirect("UserBookingServlet?action=history&msg=review_success");
    }
}