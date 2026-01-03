<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 3/1/2026
  Time: 9:56 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-dark mb-5">
    <div class="container">
        <span class="navbar-brand mb-0 h1 fw-bold">
            <i class="fa-solid fa-user-shield me-2"></i> Admin Portal
        </span>
        <a href="index.jsp" class="btn btn-outline-light btn-sm">Logout</a>
    </div>
</nav>

<div class="container">
    <div class="text-center mb-5">
        <h2 class="fw-bold text-dark">Welcome back, Admin!</h2>
        <p class="text-muted">Select a module to manage</p>
    </div>

    <div class="row g-4 justify-content-center">

        <div class="col-md-4 col-lg-3">
            <a href="admin" class="text-decoration-none">
                <div class="card text-center p-4 h-100 card-hover">
                    <div class="card-body">
                        <div class="icon-box bg-success-subtle text-success mb-3 rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-broom fa-2x"></i>
                        </div>
                        <h5 class="card-title text-dark fw-bold">Services</h5>
                        <p class="card-text text-muted small">Add, edit, or remove cleaning packages.</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4 col-lg-3">
            <a href="orders.jsp" class="text-decoration-none">
                <div class="card text-center p-4 h-100 card-hover">
                    <div class="card-body">
                        <div class="icon-box bg-primary-subtle text-primary mb-3 rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-file-invoice fa-2x"></i>
                        </div>
                        <h5 class="card-title text-dark fw-bold">Orders</h5>
                        <p class="card-text text-muted small">View and manage customer bookings.</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4 col-lg-3">
            <a href="users.jsp" class="text-decoration-none">
                <div class="card text-center p-4 h-100 card-hover">
                    <div class="card-body">
                        <div class="icon-box bg-teal-subtle text-primary mb-3 rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-users fa-2x"></i>
                        </div>
                        <h5 class="card-title text-dark fw-bold">Customers</h5>
                        <p class="card-text text-muted small">View registered user details.</p>
                    </div>
                </div>
            </a>
        </div>

    </div>
</div>

</body>
</html>