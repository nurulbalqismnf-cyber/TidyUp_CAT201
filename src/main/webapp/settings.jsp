<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 4/1/2026
  Time: 5:14 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-dark mb-5">
    <div class="container">
        <span class="navbar-brand fw-bold">
            <i class="fa-solid fa-gear me-2"></i> Settings
        </span>

        <a href="dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>
</nav>

<div class="container">
    <div class="card p-4 mx-auto" style="max-width: 500px;">
        <h4 class="mb-4 fw-bold text-dark">Change Password</h4>

        <% String msg = request.getParameter("msg");
            if("success".equals(msg)) { %>
        <div class="alert alert-success">Password updated successfully!</div>
        <% } else if("error".equals(msg)) { %>
        <div class="alert alert-danger">Old password is incorrect.</div>
        <% } %>

        <form action="settings" method="post">
            <div class="mb-3">
                <label class="form-label text-muted small fw-bold">Current Password</label>
                <input type="password" name="oldPassword" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small fw-bold">New Password</label>
                <input type="password" name="newPassword" class="form-control" required>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary w-50 shadow-sm">
                    Update Password
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
