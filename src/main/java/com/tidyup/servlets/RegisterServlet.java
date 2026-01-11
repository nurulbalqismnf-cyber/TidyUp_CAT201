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

        // Create new user
        User newUser = new User(u, p, "customer");

        // Save it to DataStore
        DataStore.getInstance().addUser(newUser);

        // go back to login page
        resp.sendRedirect("login.jsp?msg=registered");
    }
}