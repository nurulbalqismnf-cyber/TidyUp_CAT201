<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #f8f9fa; overflow-x: hidden; }
        .main-content {
            margin-left: 250px; /* Matches sidebar width */
            padding: 20px;
            transition: margin 0.3s;
            min-height: 100vh;
        }
    </style>
    <script>
        function confirmAction(action) {
            if(action === 'complete') return confirm("Mark this order as COMPLETED?");
            if(action === 'cancel') return confirm("Cancel this order?");
            return true;
        }
    </script>
</head>
<body>

<jsp:include page="sidebar.jsp" />

<div class="main-content">

    <nav class="navbar navbar-light bg-white shadow-sm rounded-4 mb-4 p-3">
        <div class="container-fluid">
            <span class="navbar-brand fw-bold text-primary">
                <i class="fa-solid fa-file-invoice me-2"></i> Order Management
            </span>
            <a href="dashboard.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="fa-solid fa-arrow-left me-2"></i> Dashboard
            </a>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="card p-4 shadow-sm border-0 rounded-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="card-title fw-bold">Incoming Bookings</h4>
                <span class="badge bg-primary rounded-pill">
                    <%= DataStore.getInstance().getBookings().size() %> Total
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Customer</th>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Booking b : DataStore.getInstance().getBookings()) {
                            // Row Color Logic
                            String rowClass = "Pending".equals(b.getStatus()) ? "table-warning" : "";
                    %>
                    <tr class="<%= rowClass %>">
                        <td class="fw-bold"><%= b.getCustomerName() %></td>
                        <td><%= b.getServiceName() %></td>
                        <td><%= b.getDate() %></td>
                        <td>
                            <% if ("Completed".equals(b.getStatus())) { %>
                            <span class="badge bg-success">Completed</span>
                            <% } else if ("Cancelled".equals(b.getStatus())) { %>
                            <span class="badge bg-danger">Cancelled</span>
                            <% } else { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                            <% } %>
                        </td>
                        <td>
                            <% if ("Pending".equals(b.getStatus())) { %>
                            <form action="orders" method="post" class="d-flex gap-2">
                                <input type="hidden" name="id" value="<%= b.getId() %>">

                                <button type="submit" name="action" value="complete"
                                        class="btn btn-sm btn-success"
                                        onclick="return confirmAction('complete');">
                                    <i class="fa-solid fa-check"></i> Done
                                </button>

                                <button type="submit" name="action" value="cancel"
                                        class="btn btn-sm btn-danger"
                                        onclick="return confirmAction('cancel');">
                                    <i class="fa-solid fa-xmark"></i>
                                </button>
                            </form>
                            <% } else { %>
                            <span class="text-muted small">Closed</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div> </body>
</html>