<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 4/1/2026
  Time: 1:05 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-dark mb-5">
    <div class="container">
        <span class="navbar-brand fw-bold">
            <i class="fa-solid fa-users me-2"></i> Customer List
        </span>
        <a href="dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>
</nav>

<div class="container">
    <div class="card p-4">
        <div class="card-header-custom d-flex justify-content-between align-items-center">
            <div>
                <h4 class="card-title fw-bold text-dark">
                    <i class="fa-solid fa-address-book text-primary me-2"></i>My Customers
                </h4>
                <p class="text-muted small mb-0">List of unique customers from bookings</p>
            </div>
            <span class="badge bg-primary rounded-pill">
                <%= DataStore.getInstance().getBookings().size() %> Total Bookings
            </span>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Use a Set to avoid duplicate names
                    Set<String> uniqueNames = new HashSet<>();
                    int count = 1;

                    for(Booking b : DataStore.getInstance().getBookings()) {
                        if(!uniqueNames.contains(b.getCustomerName())) {
                            uniqueNames.add(b.getCustomerName());
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td class="fw-bold">
                        <div class="d-flex align-items-center">
                            <div class="icon-box bg-blue-subtle me-3" style="width:35px; height:35px; margin-bottom:0; font-size:0.8rem;">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <%= b.getCustomerName() %>
                        </div>
                    </td>
                    <td><span class="badge bg-success-subtle text-success border border-success">Active</span></td>
                    <td>
                        <a href="orders.jsp" class="btn btn-sm btn-outline-primary">View Orders</a>
                    </td>
                </tr>
                <%
                        } // End If
                    } // End Loop

                    if (uniqueNames.isEmpty()) {
                %>
                <tr><td colspan="4" class="text-center py-4 text-muted">No customers found yet.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>