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
        function confirmAction(action) {
            if(action === 'complete') {
                return confirm("Are you sure you want to mark this order as COMPLETED?");
            } else if(action === 'cancel') {
                return confirm("Are you sure you want to CANCEL this order?");
            }
            return true;
        }

        function filterPending() {
            window.location.href = "orders.jsp?filter=pending";
        }

        function showAll() {
            window.location.href = "orders.jsp";
        }

        function sortTable() {
            let sortBy = document.getElementById("sortDropdown").value;
            alert("Sort by " + sortBy + " feature not implemented yet.");
        }

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

        <!-- Header and Filters -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h4 class="fw-bold text-dark"><i class="fa-solid fa-list-check text-primary me-2"></i> Incoming Bookings</h4>
                <p class="text-secondary small mb-2">Manage all customer requests efficiently.</p>
                <%
                    String filter = request.getParameter("filter");
                    if("pending".equals(filter)) {
                %>
                <p class="text-danger small mb-0 fw-bold"><i class="fa-solid fa-filter me-1"></i> Showing Pending Jobs Only</p>
                <% } else { %>
                <p class="text-muted small mb-0">All bookings</p>
                <% } %>
            </div>
            <div>
                <% if("pending".equals(filter)) { %>
                <button onclick="showAll()" class="btn btn-sm btn-outline-secondary rounded-pill">Show All</button>
                <% } else { %>
                <span class="badge bg-primary rounded-pill">
                    <%= DataStore.getInstance().getBookings().size() %> Total
                </span>
                <% } %>
            </div>
        </div>

        <!-- Search & Sort -->
        <div class="d-flex justify-content-between mb-3">
            <div class="input-group w-50">
                <input type="text" id="searchInput" class="form-control form-control-sm" placeholder="Search..." onkeyup="searchTable()">
                <button class="btn btn-outline-secondary btn-sm" onclick="searchTable()">Search</button>
            </div>
            <div>
                <select id="sortDropdown" class="form-select form-select-sm" onchange="sortTable()">
                    <option value="">Sort by...</option>
                    <option value="dateAsc">Date ↑</option>
                    <option value="dateDesc">Date ↓</option>
                    <option value="customer">Customer</option>
                    <option value="status">Status</option>
                </select>
            </div>
        </div>

        <!-- Orders Table -->
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
                    java.time.LocalDate today = java.time.LocalDate.now();
                    java.time.LocalDate tomorrow = today.plusDays(1);

                    for(Booking b : DataStore.getInstance().getBookings()) {
                        // Pending filter
                        if("pending".equals(filter) && !"Pending".equals(b.getStatus())) continue;

                        foundAny = true;

                        java.time.LocalDate bookingDate = null;
                        try {
                            bookingDate = java.time.LocalDate.parse(b.getDate());
                        } catch(Exception e) { }

                        String rowClass = "";
                        if("Pending".equals(b.getStatus())) rowClass = "table-warning";
                        else if(bookingDate != null && (bookingDate.equals(today) || bookingDate.equals(tomorrow))) rowClass = "table-info";
                %>
                <tr class="<%= rowClass %>">
                    <td class="text-muted small">#<%= b.getId() %></td>
                    <td class="fw-bold text-dark"><%= b.getCustomerName() %></td>
                    <td><%= b.getServiceName() %></td>
                    <td>RM <%= b.getPrice() %></td>
                    <td><%= b.getDate() %></td>
                    <td><%= b.getTime() %></td>
                    <td>
                        <% if("Completed".equals(b.getStatus())) { %>
                        <span class="badge bg-success-subtle text-success border border-success">Completed</span>
                        <% } else if("Cancelled".equals(b.getStatus())) { %>
                        <span class="badge bg-danger-subtle text-danger border border-danger">Cancelled</span>
                        <% } else { %>
                        <span class="badge bg-warning text-dark border border-warning">Pending</span>
                        <% } %>
                    </td>
                    <td>
                        <% if("Pending".equals(b.getStatus())) { %>
                        <form action="orders" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= b.getId() %>">
                            <button type="submit" name="action" value="complete"
                                    class="btn btn-outline-success btn-sm px-3 shadow-sm"
                                    title="Mark as Done"
                                    onclick="return confirmAction('complete');">
                                <i class="fa-solid fa-square-check fa-lg"></i> Done
                            </button>
                            <button type="submit" name="action" value="cancel"
                                    class="btn btn-light text-danger btn-sm px-2 border ms-1"
                                    title="Cancel Order"
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

                <% if(!foundAny) { %>
                <tr>
                    <td colspan="8" class="text-center py-5">
                        <% if("pending".equals(filter)) { %>
                        <div class="text-muted">
                            <div class="mb-3 p-3 bg-light rounded-circle d-inline-block">
                                <i class="fa-solid fa-mug-hot fa-2x text-secondary"></i>
                            </div>
                            <h5 class="fw-bold text-dark">All Caught Up!</h5>
                            <p class="small">No pending work. Time to relax.</p>
                        </div>
                        <% } else { %>
                        <div class="text-muted">No bookings found.</div>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>
