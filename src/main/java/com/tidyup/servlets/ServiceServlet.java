package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import com.tidyup.models.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServiceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            String desc = req.getParameter("desc");
            double price = Double.parseDouble(req.getParameter("price"));
            String id = String.valueOf(System.currentTimeMillis());
            Service newService = new Service(id, name, price, desc);
            DataStore.getInstance().addService(newService);

        } else if ("delete".equals(action)) {
            String id = req.getParameter("id");
            DataStore.getInstance().deleteService(id);

        } else if ("update".equals(action)) {
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            String desc = req.getParameter("desc");
            double price = Double.parseDouble(req.getParameter("price"));

            DataStore.getInstance().updateService(id, name, price, desc);
        }

        resp.sendRedirect("services.jsp");
    }
}
