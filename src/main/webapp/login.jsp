<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 4/1/2026
  Time: 4:52 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body style="display: flex; align-items: center; justify-content: center;">

<%
    // --- COOKIE LOGIC (The "Read" Part) ---
    String savedUser = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("savedUsername".equals(c.getName())) {
                savedUser = c.getValue(); // We found the saved name!
            }
        }
    }
%>

<div class="card p-5 shadow-lg" style="max-width: 400px; width: 100%;">
    <div class="text-center mb-4">
        <div class="icon-box bg-blue-subtle text-primary rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
            <i class="fa-solid fa-user-shield fa-3x"></i>
        </div>
        <h3 class="fw-bold mt-3">Admin Login</h3>
        <p class="text-muted small">Please sign in to continue</p>
    </div>

    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label fw-bold small">Username</label>
            <input type="text" name="username" class="form-control" placeholder="Enter username" value="<%= savedUser %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold small">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" name="remember" id="rememberMe">
            <label class="form-check-label small text-muted" for="rememberMe">Remember me</label>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2">Sign In</button>
    </form>

    <%
        String error = request.getParameter("error");
        if (error != null && error.equals("true")) {
    %>
    <div class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
        <i class="fa-solid fa-triangle-exclamation me-2"></i>
        <div class="small">Invalid Username or Password!</div>
    </div>
    <% } %>


    <div class="text-center mt-3">
        <a href="index.jsp" class="text-decoration-none small text-muted">Back to Home</a>
    </div>
</div>

</body>
</html>
