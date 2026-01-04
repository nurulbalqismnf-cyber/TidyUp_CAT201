<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page import="com.tidyup.models.Service" %>
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
<body style="background-color: #f5f7fa;">

<nav class="navbar navbar-dark mb-4">
    <div class="container">
        <span class="navbar-brand mb-0 h1 fw-bold">
            <i class="fa-solid fa-user-shield me-2"></i> Admin Portal
        </span>

        <div class="d-flex gap-2">
            <a href="settings.jsp" class="btn btn-light btn-sm rounded-pill px-3 text-primary fw-bold">
                <i class="fa-solid fa-gear me-1"></i> Settings
            </a>
            <a href="index.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container mb-5">
    <div class="p-4 rounded-4 bg-white shadow-sm border">

        <div class="mb-4">
            <h3 class="fw-bold text-dark">Daily Overview</h3>
            <p class="text-muted mb-0">Here is what is happening today.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <a href="orders.jsp" class="text-decoration-none">
                    <div class="card border-0 text-white card-hover" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 15px;">
                        <div class="card-body p-4 d-flex justify-content-between align-items-center">
                            <div>
                                <p class="mb-1 opacity-75 small text-uppercase fw-bold">Total Revenue</p>
                                <%
                                    double totalRevenue = 0.0;
                                    int pendingCount = 0;
                                    for(Booking b : DataStore.getInstance().getBookings()) {
                                        for(Service s : DataStore.getInstance().getServices()) {
                                            if(s.getName().equals(b.getServiceName())) {
                                                totalRevenue += s.getPrice();
                                            }
                                        }
                                        if("Pending".equals(b.getStatus())) pendingCount++;
                                    }
                                %>
                                <h2 class="fw-bold mb-0">RM <%= String.format("%.2f", totalRevenue) %></h2>
                            </div>
                            <div class="icon-box bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                <i class="fa-solid fa-wallet fa-xl"></i>
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="orders.jsp?filter=pending" class="text-decoration-none">
                    <div class="card border-0 text-white card-hover" style="background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%); color: #a30000 !important; border-radius: 15px;">
                        <div class="card-body p-4 d-flex justify-content-between align-items-center">
                            <div>
                                <p class="mb-1 opacity-75 small text-uppercase fw-bold">Pending Jobs</p>
                                <h2 class="fw-bold mb-0"><%= pendingCount %></h2>
                            </div>
                            <div class="icon-box bg-white bg-opacity-50 rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                <i class="fa-solid fa-clock fa-xl"></i>
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <div class="card border-0 text-white" style="background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%); color: #005c4b !important; border-radius: 15px;">
                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-1 opacity-75 small text-uppercase fw-bold">Active Services</p>
                            <h2 class="fw-bold mb-0"><%= DataStore.getInstance().getServices().size() %></h2>
                        </div>
                        <div class="icon-box bg-white bg-opacity-50 rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-broom fa-xl"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container pb-5">
    <div class="p-4">

        <div class="mb-4">
            <h4 class="fw-bold text-dark"><i class="fa-solid fa-layer-group me-2 text-primary"></i>Management Modules</h4>
            <p class="text-muted small">Select a module to manage your business.</p>
        </div>

        <div class="row g-4 justify-content-center">
            <div class="col-md-4 col-lg-3">
                <a href="admin" class="text-decoration-none">
                    <div class="card text-center p-4 h-100 card-hover border-0 shadow-sm">
                        <div class="card-body">
                            <div class="icon-box bg-blue-subtle text-primary mb-3 rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                                <i class="fa-solid fa-broom fa-2x"></i>
                            </div>
                            <h5 class="card-title text-dark fw-bold">Services</h5>
                            <p class="card-text text-muted small">Manage cleaning packages.</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4 col-lg-3">
                <a href="orders.jsp" class="text-decoration-none">
                    <div class="card text-center p-4 h-100 card-hover border-0 shadow-sm">
                        <div class="card-body">
                            <div class="icon-box bg-primary-subtle text-primary mb-3 rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                                <i class="fa-solid fa-file-invoice fa-2x"></i>
                            </div>
                            <h5 class="card-title text-dark fw-bold">Orders</h5>
                            <p class="card-text text-muted small">Manage bookings.</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4 col-lg-3">
                <a href="users.jsp" class="text-decoration-none">
                    <div class="card text-center p-4 h-100 card-hover border-0 shadow-sm">
                        <div class="card-body">
                            <div class="icon-box bg-teal-subtle text-primary mb-3 rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                                <i class="fa-solid fa-users fa-2x"></i>
                            </div>
                            <h5 class="card-title text-dark fw-bold">Customers</h5>
                            <p class="card-text text-muted small">View user details.</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>