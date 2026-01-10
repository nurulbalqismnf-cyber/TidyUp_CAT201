package com.tidyup.servlets;

import com.tidyup.models.Booking;
import com.tidyup.models.DataStore;
import com.tidyup.models.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class UserBookingServlet extends HttpServlet {

    // --- doGet: Handles "Viewing" (Service List or History) ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user"); // Gets logged-in username

        // Safety: If not logged in, send them to login page
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("history".equals(action)) {
            // OPTION A: SHOW BOOKING HISTORY
            // Filter the list to show ONLY this user's bookings
            List<Booking> myBookings = DataStore.getInstance().getBookings().stream()
                    .filter(b -> b.getCustomerName() != null && b.getCustomerName().equals(currentUser))
                    .collect(Collectors.toList());

            request.setAttribute("myBookings", myBookings);
            request.getRequestDispatcher("history.jsp").forward(request, response);
        } else {
            // OPTION B: BROWSE SERVICES (Default View)
            List<Service> serviceList = DataStore.getInstance().getServices();
            request.setAttribute("serviceList", serviceList);
            request.getRequestDispatcher("browse_services.jsp").forward(request, response);
        }
    }

    // --- doPost: Handles "Submitting" a New Booking ---
    // --- doPost: Handles "Submitting" a New Booking ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get the current session (Optional, mainly for security check)
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Get ALL parameters from the "browse_services.jsp" form
        // Note: We use the "userName" from the form so the name matches what they typed
        String name = request.getParameter("userName");
        String phone = request.getParameter("phone");       // NEW
        String serviceName = request.getParameter("serviceName");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");   // NEW

        // 3. Create the Booking with the NEW Constructor
        // (Make sure this matches the order in Booking.java!)
        Booking newBooking = new Booking(name, phone, serviceName, date, time, address, payment, "Pending");

        // 4. Save it to DataStore
        DataStore.getInstance().addBooking(newBooking);

        // 5. Redirect user to their history
        response.sendRedirect("UserBookingServlet?action=history");
    }
}