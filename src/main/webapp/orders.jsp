<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* 1. Page Reset */
        body { margin: 0; padding: 0; overflow: hidden; font-family: 'Poppins', sans-serif; }

        /* 2. Content Wrapper (Matches Dashboard) */
        .page-content {
            background: linear-gradient(to bottom, #a0e9ff, #ffffff);
            height: 100vh;
            overflow-y: auto;
            width: 100%;
        }

        /* 3. Card Styling */
        .table-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            background: white;
            padding: 2rem;
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

<div class="d-flex">
    <jsp:include page="sidebar.jsp" />

    <div class="page-content p-4">

        <nav class="d-flex align-items-center mb-4 bg-white p-3 rounded-4 shadow-sm">
            <i class="fa-solid fa-bars me-3 fs-4" onclick="toggleSidebar()" style="cursor: pointer; color: #6a11cb;"></i>
            <h4 class="m-0 fw-bold text-primary">Order Management</h4>
            <a href="dashboard.jsp" class="btn btn-outline-secondary btn-sm ms-auto rounded-pill px-3">
                <i class="fa-solid fa-arrow-left me-2"></i> Dashboard
            </a>
        </nav>

        <div class="container-fluid">
            <div class="table-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold m-0 text-dark">Incoming Bookings</h5>
                    <span class="badge bg-primary rounded-pill px-3 py-2">
                        <%= DataStore.getInstance().getBookings().size() %> Total
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light rounded-3">
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
                                String rowClass = "Pending".equals(b.getStatus()) ? "table-warning" : "";
                        %>
                        <tr class="<%= rowClass %>">
                            <td class="fw-bold"><%= b.getCustomerName() %></td>
                            <td><span class="badge bg-light text-dark border"><%= b.getServiceName() %></span></td>
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
                                            class="btn btn-sm btn-success fw-bold"
                                            onclick="return confirmAction('complete');">
                                        <i class="fa-solid fa-check me-1"></i> Done
                                    </button>

                                    <button type="submit" name="action" value="cancel"
                                            class="btn btn-sm btn-danger px-3"
                                            onclick="return confirmAction('cancel');">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </form>
                                <% } else { %>
                                <span class="text-muted small"><i class="fa-solid fa-lock"></i> Closed</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>