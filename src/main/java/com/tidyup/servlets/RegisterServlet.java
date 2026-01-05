package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import com.tidyup.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");

        // 1. Create a new "Customer" user
        User newUser = new User(u, p, "customer");

        // 2. Save it to our shared DataStore
        DataStore.getInstance().addUser(newUser);

        // 3. Redirect to login with a success message
        resp.sendRedirect("login.jsp?msg=registered");
    }
}