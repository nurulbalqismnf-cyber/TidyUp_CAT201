<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page import="com.tidyup.models.Review" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Security and Revenue Logic
    double earnedRevenue = 0.0;
    double pendingRevenue = 0.0;
    int pendingCount = 0;

    for(Booking b : DataStore.getInstance().getBookings()) {
        if("Success".equalsIgnoreCase(b.getStatus()) || "Completed".equalsIgnoreCase(b.getStatus())) {
            earnedRevenue += b.getPrice();
        } else {
            pendingRevenue += b.getPrice();
            pendingCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Portal | TidyUp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* 1. Reset Body to allow Side-by-Side layout */
        body { margin: 0; padding: 0; overflow: hidden; font-family: 'Poppins', sans-serif; }

        /* 2. Move Gradient to the Content Area */
        .dashboard-content {
            background: linear-gradient(to bottom, #a0e9ff, #ffffff);
            height: 100vh;
            overflow-y: auto; /* Allow scrolling */
            width: 100%;
        }

        .nav-custom { background-color: #00d2ff; padding: 10px 20px; color: white; }
        .revenue-card { border-radius: 25px; color: white; padding: 25px; border: none; }
        .module-card { background: white; border-radius: 20px; border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.05); transition: 0.3s; }
        .module-card:hover { transform: translateY(-5px); }
    </style>
</head>
<body>

<div class="d-flex">

    <jsp:include page="sidebar.jsp" />

    <div class="dashboard-content">

        <nav class="nav-custom d-flex justify-content-between align-items-center mb-4 shadow-sm">
            <div class="d-flex align-items-center">
                <i class="fa-solid fa-bars me-3" onclick="toggleSidebar()" style="cursor: pointer; font-size: 1.5rem;"></i>
                <span class="fw-bold"><i class="fa-solid fa-user-shield me-2"></i> Admin Portal</span>
            </div>
            <a href="logout" class="btn btn-sm btn-outline-light rounded-pill px-3">Logout</a>
        </nav>

        <div class="container text-center mb-5">
            <h1 class="fw-bold">Welcome back, Admin!</h1>
            <p class="text-muted">Select a module to manage</p>

            <div class="row g-4 justify-content-center mb-5">
                <div class="col-md-3">
                    <a href="services.jsp" class="text-decoration-none text-dark">
                        <div class="card module-card p-4 text-center">
                            <i class="fa-solid fa-broom fa-3x text-success mb-3"></i>
                            <h5 class="fw-bold">Services</h5>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 text-dark">
                    <a href="orders.jsp" class="text-decoration-none text-dark">
                        <div class="card module-card p-4 text-center">
                            <i class="fa-solid fa-file-invoice fa-3x text-primary mb-3"></i>
                            <h5 class="fw-bold">Orders</h5>
                        </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="users.jsp" class="text-decoration-none text-dark">
                        <div class="card module-card p-4 text-center">
                            <i class="fa-solid fa-users fa-3x text-info mb-3"></i>
                            <h5 class="fw-bold">Customers</h5>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row g-4 justify-content-center mb-5">
                <div class="col-md-5">
                    <div class="revenue-card shadow" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <p class="small text-uppercase mb-1 fw-bold opacity-75">Total Revenue</p>
                        <h2 class="fw-bold">RM <%= String.format("%.2f", earnedRevenue) %></h2>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="revenue-card shadow" style="background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%); color: #a30000 !important;">
                        <p class="small text-uppercase mb-1 fw-bold opacity-75">Pending Jobs</p>
                        <h2 class="fw-bold" id="pendingCountDisplay"><%= pendingCount %></h2>
                    </div>
                </div>
            </div>

            <div class="bg-white p-4 rounded-4 shadow-sm border text-start mb-4">
                <h5 class="fw-bold mb-3 text-primary"><i class="fa-solid fa-clock me-2"></i> Pending Tasks</h5>
                <table class="table align-middle">
                    <thead class="table-light"><tr><th style="width: 50px;">Done?</th><th>Customer</th><th>Service</th><th class="text-end">Price</th></tr></thead>
                    <tbody>
                    <%
                        boolean hasPending = false;
                        for(Booking b : DataStore.getInstance().getBookings()) {
                            if("Pending".equals(b.getStatus())) {
                                hasPending = true;
                    %>
                    <tr id="row_<%= b.getId() %>">
                        <td>
                            <form action="orders" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%= b.getId() %>">
                                <button type="submit" name="action" value="complete" class="btn btn-sm btn-outline-success border-0"><i class="fa-regular fa-square-check fa-xl"></i></button>
                            </form>
                        </td>
                        <td><span class="fw-bold"><%= b.getCustomerName() %></span></td>
                        <td><span class="badge bg-warning text-dark rounded-pill px-3"><%= b.getServiceName() %></span></td>
                        <td class="text-end fw-bold">RM <%= String.format("%.2f", b.getPrice()) %></td>
                    </tr>
                    <% } } if(!hasPending) { %> <tr><td colspan="4" class="text-center text-muted">No pending tasks.</td></tr> <% } %>
                    </tbody>
                </table>
            </div>

        </div> </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>