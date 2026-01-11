<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 3/1/2026
  Time: 10:32 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <script>
        function searchTable() {
            let query = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#ordersTable tbody tr");
            rows.forEach(row => {
                row.style.display = Array.from(row.cells)
                    .some(cell => cell.textContent.toLowerCase().includes(query)) ? "" : "none";
            });
        }
    </script>
</head>
<body>

<nav class="navbar navbar-dark mb-4">
    <div class="container">
        <span class="navbar-brand fw-bold">
            <i class="fa-solid fa-file-invoice me-2"></i> Order Management
        </span>
        <a href="dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>
</nav>

<div class="container">
    <div class="card p-4">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h4 class="fw-bold text-dark"><i class="fa-solid fa-list-check text-primary me-2"></i> Incoming Bookings</h4>
                <p class="text-secondary small mb-2">Manage all customer requests efficiently.</p>
            </div>
            <div>
                <span class="badge bg-primary rounded-pill">
                    <%= DataStore.getInstance().getBookings().size() %> Total
                </span>
            </div>
        </div>

        <div class="mb-3">
            <input type="text" id="searchInput" class="form-control form-control-sm w-50" placeholder="Search..." onkeyup="searchTable()">
        </div>

        <div class="table-responsive">
            <table id="ordersTable" class="table table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>#ID</th>
                    <th>Customer</th>
                    <th>Service</th>
                    <th>Price</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Mark Done</th>
                </tr>
                </thead>
                <tbody>
                <%
                    boolean foundAny = false;
                    for(Booking b : DataStore.getInstance().getBookings()) {
                        foundAny = true;
                %>
                <tr>
                    <td class="text-muted small">#<%= b.getId() %></td>
                    <td class="fw-bold text-dark"><%= b.getCustomerName() %></td>
                    <td><%= b.getServiceName() %></td>
                    <td>RM <%= b.getPrice() %></td>
                    <td><%= b.getDate() %></td>
                    <td><%= b.getTime() %></td>
                    <td>
                        <% if("Success".equalsIgnoreCase(b.getStatus())) { %>
                        <span class="badge bg-success-subtle text-success border border-success">Completed</span>
                        <% } else { %>
                        <span class="badge bg-warning text-dark border border-warning">Pending</span>
                        <% } %>
                    </td>
                    <td>
                        <% if(!"Success".equalsIgnoreCase(b.getStatus())) { %>
                        <form action="UpdateTaskServlet" method="post" style="display:inline;">
                            <input type="hidden" name="bookingId" value="<%= b.getId() %>">

                            <button type="submit"
                                    class="btn btn-outline-success btn-sm px-3 shadow-sm"
                                    title="Mark as Done">
                                <i class="fa-solid fa-square-check fa-lg"></i> Done
                            </button>
                        </form>
                        <% } else { %>
                        <span class="text-muted small"><i class="fa-solid fa-lock"></i> Closed</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>

                <% if(!foundAny) { %>
                <tr>
                    <td colspan="8" class="text-center py-5 text-muted">No bookings found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>