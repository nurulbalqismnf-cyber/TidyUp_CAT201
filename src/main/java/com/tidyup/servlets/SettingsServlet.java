package com.tidyup.servlets;

import com.tidyup.models.DataStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/settings")
public class SettingsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String oldPass = req.getParameter("oldPassword");
        String newPass = req.getParameter("newPassword");

        // 1. Ask DataStore to try and change the password
        boolean isChanged = DataStore.getInstance().changePassword(oldPass, newPass);

        // 2. Redirect based on result
        if (isChanged) {
            // Success: Show green message
            resp.sendRedirect("settings.jsp?msg=success");
        } else {
            // Failed: Show red error (Old password was wrong)
            resp.sendRedirect("settings.jsp?msg=error");
        }
    }
}
