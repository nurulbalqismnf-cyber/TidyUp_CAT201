<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 3/1/2026
  Time: 10:32 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-dark mb-5">
    <div class="container">
        <span class="navbar-brand fw-bold">
            <i class="fa-solid fa-file-invoice me-2"></i> Order Management
        </span>
        <a href="dashboard.jsp" class="btn btn-outline-light btn-sm">Back to Dashboard</a>
    </div>
</nav>

<div class="container">
    <div class="card p-4">
        <h3 class="mb-4 fw-bold text-dark">Incoming Bookings</h3>

        <% if(DataStore.getInstance().getBookings().isEmpty()) { %>
        <div class="alert alert-warning">No bookings received yet.</div>
        <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>Customer</th>
                    <th>Service Requested</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for(Booking b : DataStore.getInstance().getBookings()) { %>
                <tr>
                    <td class="fw-bold"><%= b.getCustomerName() %></td>
                    <td><%= b.getServiceName() %></td>
                    <td>RM <%= b.getPrice() %></td>
                    <td>
                        <% if("Confirmed".equals(b.getStatus())) { %>
                        <span class="badge bg-success">Confirmed</span>
                        <% } else if("Cancelled".equals(b.getStatus())) { %>
                        <span class="badge bg-danger">Cancelled</span>
                        <% } else { %>
                        <span class="badge bg-warning text-dark">Pending</span>
                        <% } %>
                    </td>
                    <td>
                        <% if("Pending".equals(b.getStatus())) { %>
                        <form action="orders" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= b.getId() %>">
                            <button type="submit" name="action" value="confirm" class="btn btn-sm btn-success">
                                <i class="fa-solid fa-check"></i>
                            </button>
                            <button type="submit" name="action" value="cancel" class="btn btn-sm btn-danger">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </form>
                        <% } else { %>
                        <span class="text-muted small">Completed</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
