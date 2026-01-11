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
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <script>
        function confirmAction(action) {
            if(action === 'complete') return confirm("Mark this order as COMPLETED?");
            if(action === 'cancel') return confirm("Cancel this order?");
            return true;
        }

        function searchTable() {
            const query = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("#ordersTable tbody tr");
            rows.forEach(row => {
                const text = Array.from(row.cells).map(c => c.textContent.toLowerCase()).join(" ");
                row.style.display = text.includes(query) ? "" : "none";
            });
        }

        function sortTable() {
            const table = document.getElementById("ordersTable");
            const tbody = table.tBodies[0];
            const sortBy = document.getElementById("sortDropdown").value;
            const rows = Array.from(tbody.rows);

            rows.sort((a, b) => {
                let valA, valB;
                switch(sortBy) {
                    case "dateAsc":
                    case "dateDesc":
                        valA = new Date(a.cells[4].textContent);
                        valB = new Date(b.cells[4].textContent);
                        return sortBy === "dateAsc" ? valA - valB : valB - valA;
                    case "customer":
                        valA = a.cells[1].textContent.toLowerCase();
                        valB = b.cells[1].textContent.toLowerCase();
                        return valA.localeCompare(valB);
                    case "status":
                        valA = a.cells[5].textContent.toLowerCase();
                        valB = b.cells[5].textContent.toLowerCase();
                        return valA.localeCompare(valB);
                    case "price":
                        valA = parseFloat(a.cells[3].textContent.replace("RM","").trim());
                        valB = parseFloat(b.cells[3].textContent.replace("RM","").trim());
                        return valA - valB;
                    default: return 0;
                }
            });

            rows.forEach(r => tbody.appendChild(r));
        }

        let pendingOnly = false;
        function filterPending() {
            pendingOnly = true;
            const rows = document.querySelectorAll("#ordersTable tbody tr");
            rows.forEach(r => r.style.display = r.querySelector("td:nth-child(6)").textContent.includes("Pending") ? "" : "none");
        }
        function clearFilter() {
            pendingOnly = false;
            searchTable();
        }
    </script>
</head>
<body>
<jsp:include page="sidebar.jsp" />
<nav class="navbar navbar-dark mb-4">
    <div class="main-content">
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

    <div class="d-flex justify-content-between mb-3">
        <div>
            <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search bookings..."
                   class="form-control form-control-sm" style="width: 250px;">
        </div>
        <div class="d-flex gap-2">
            <select id="sortDropdown" class="form-select form-select-sm" onchange="sortTable()">
                <option value="">Sort by</option>
                <option value="dateAsc">Date ↑</option>
                <option value="dateDesc">Date ↓</option>
                <option value="customer">Customer</option>
                <option value="status">Status</option>
                <option value="price">Price</option>
            </select>

            <button class="btn btn-sm btn-outline-primary" onclick="filterPending()">Pending Only</button>
            <button class="btn btn-sm btn-outline-secondary" onclick="clearFilter()">Show All</button>
        </div>
    </div>

    <div class="card p-4">
        <div class="card-header-custom d-flex justify-content-between align-items-center mb-3">
            <div>
                <h4 class="card-title fw-bold text-dark">
                    <i class="fa-solid fa-list-check text-primary me-2"></i> Incoming Bookings
                </h4>
                <p class="text-muted small mb-0">Manage all customer requests</p>
            </div>
            <span class="badge bg-primary rounded-pill">
                <%= DataStore.getInstance().getBookings().size() %> Total
            </span>
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
                    for (Booking b : DataStore.getInstance().getBookings()) {
                        foundAny = true;

                        java.time.LocalDate bookingDate = java.time.LocalDate.parse(b.getDate());
                        java.time.LocalDate today = java.time.LocalDate.now();
                        java.time.LocalDate tomorrow = today.plusDays(1);

                        String rowClass = "";
                        if ("Pending".equals(b.getStatus())) rowClass = "table-warning";
                        else if (bookingDate.equals(today) || bookingDate.equals(tomorrow)) rowClass = "table-info";
                %>
                <tr class="<%= rowClass %>">
                    <td class="text-muted small">#<%= b.getId() %></td>
                    <td class="fw-bold text-dark"><%= b.getCustomerName() %></td>
                    <td><%= b.getServiceName() %></td>
                    <td>RM <%= b.getPrice() %></td>
                    <td><%= b.getDate() %></td>
                    <td><%= b.getTime() %></td>
                    <td>
                        <% if ("Completed".equals(b.getStatus())) { %>
                        <span class="badge bg-success-subtle text-success border border-success">Completed</span>
                        <% } else if ("Cancelled".equals(b.getStatus())) { %>
                        <span class="badge bg-danger-subtle text-danger border border-danger">Cancelled</span>
                        <% } else { %>
                        <span class="badge bg-warning text-dark border border-warning">Pending</span>
                        <% } %>
                    </td>
                    <td>
                        <% if ("Pending".equals(b.getStatus())) { %>
                        <form action="orders" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= b.getId() %>">
                            <button type="submit" name="action" value="complete"
                                    class="btn btn-outline-success btn-sm px-3 shadow-sm"
                                    onclick="return confirmAction('complete');">
                                <i class="fa-solid fa-square-check fa-lg"></i> Done
                            </button>

                            <button type="submit" name="action" value="cancel"
                                    class="btn btn-light text-danger btn-sm px-2 border ms-1"
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
                        <div class="text-muted">No bookings found.</div>
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
