package com.tidyup.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin-dashboard")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- AUTO-CALCULATE LOGIC ---
        // In a real app, you would get these numbers from a Database
        double totalRevenue = 12450.00;
        int reviewCount = 4;
        double avgRating = 4.9;

        // Sending the data to the HTML page
        request.setAttribute("revenue", totalRevenue);
        request.setAttribute("reviews", reviewCount);
        request.setAttribute("rating", avgRating);

        // Forward to your aesthetic HTML file
        request.getRequestDispatcher("/admin/dashboard.html").forward(request, response);
    }
}
