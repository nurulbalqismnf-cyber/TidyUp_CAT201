package com.tidyup.servlets;

import com.tidyup.models.Booking;
import com.tidyup.models.DataStore;
import com.tidyup.models.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.tidyup.models.Review;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class UserBookingServlet extends HttpServlet {

    // do get handles viewing (Service List or History)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user");

        if ("logout".equals(action)) {
            if (session != null) session.invalidate();
            response.sendRedirect("login.jsp");
            return;
        }

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("history".equals(action)) {
            // Filter bookings where customerName == currentUser (e.g., "Farah123")
            List<Booking> myBookings = DataStore.getInstance().getBookings().stream()
                    .filter(b -> b.getCustomerName() != null && b.getCustomerName().equals(currentUser))
                    .collect(Collectors.toList());

            request.setAttribute("myBookings", myBookings);
            request.getRequestDispatcher("history.jsp").forward(request, response);
        }
        else if ("reviews".equals(action)) {
            // Get reviews from DataStore
            // (If you have a login system, you would filter this list by the current user)
            List<Review> reviewList = DataStore.getInstance().getReviews();

            // Send list to jsp
            request.setAttribute("reviewList", reviewList);

            // Go to review page
            request.getRequestDispatcher("my_reviews.jsp").forward(request, response);
        }

        else {
            List<Service> serviceList = DataStore.getInstance().getServices();
            request.setAttribute("serviceList", serviceList);
            request.getRequestDispatcher("browse_services.jsp").forward(request, response);
        }
    }

    // doPost handles submitting a New Booking
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user"); // Example: "Farah123"

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String formName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        String serviceName = request.getParameter("serviceName");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");

        Booking newBooking = new Booking(currentUser, phone, serviceName, date, time, address, payment, "Pending");

        DataStore.getInstance().addBooking(newBooking);

        response.sendRedirect("UserBookingServlet?action=history");
    }
}