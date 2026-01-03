package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import com.tidyup.models.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    // 1. doGet handles VIEWING the page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("admin.jsp").forward(req, resp);
    }

    // 2. doPost handles ADDING, DELETING, and UPDATING items
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // --- DELETE LOGIC ---
        if ("delete".equals(action)) {
            String idToDelete = req.getParameter("id");
            DataStore.getInstance().deleteService(idToDelete);
        }

        // --- UPDATE LOGIC ---
        else if ("update".equals(action)) {
            String id = req.getParameter("id");
            String name = req.getParameter("serviceName");
            String priceStr = req.getParameter("price");
            String desc = req.getParameter("description");

            // Parse price safely
            double price = 0.0;
            try {
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                // Ignore error, price stays 0.0
            }

            // Create updated object and save it
            Service updatedService = new Service(id, name, price, desc);
            DataStore.getInstance().updateService(updatedService);
        }

        // --- ADD LOGIC (Default) ---
        else {
            String name = req.getParameter("serviceName");
            String priceStr = req.getParameter("price");
            String desc = req.getParameter("description");

            double price = 0.0;
            try {
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                // Ignore error
            }

            Service newService = new Service(UUID.randomUUID().toString(), name, price, desc);
            DataStore.getInstance().addService(newService);
        }

        // Refresh the page to show changes
        resp.sendRedirect("admin");
    }
}