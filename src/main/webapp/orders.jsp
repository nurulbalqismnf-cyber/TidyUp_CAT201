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

        function sortBookings() {
            const sortValue = document.getElementById("sortSelect").value;
            const urlParams = new URLSearchParams(window.location.search);
            urlParams.set('sort', sortValue);
            window.location.search = urlParams.toString();
        }
    </script>
</head>
<body>
<nav class="navbar navbar-dark mb-5">
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
        <div class="card-header-custom d-flex justify-content-between align-items-center mb-3">
            <div>
                <h4 class="card-title fw-bold text-dark">
                    <i class="fa-solid fa-list-check text-primary me-2"></i>Incoming Bookings
                </h4>
                <p class="text-secondary small mb-2">Manage all customer requests efficiently.</p>

                <%
                    String filter = request.getParameter("filter");
                    if ("pending".equals(filter)) {
                %>
                <p class="text-danger small mb-0 fw-bold">
                    <i class="fa-solid fa-filter me-1"></i> Showing Pending Jobs Only
                </p>
                <% } %>
            </div>

            <div class="d-flex align-items-center">
                <% if ("pending".equals(filter)) { %>
                <a href="orders.jsp" class="btn btn-sm btn-outline-secondary rounded-pill me-2">Show All</a>
                <% } else { %>
                <span class="badge bg-primary rounded-pill me-3">
                    <%= DataStore.getInstance().getBookings().size() %> Total
                </span>
                <% } %>

                <!-- SORT DROPDOWN -->
                <select id="sortSelect" class="form-select form-select-sm me-2" style="width:auto;"
                        onchange="sortBookings();">
                    <option value="">Sort By</option>
                    <option value="customer" <%= "customer".equals(request.getParameter("sort")) ? "selected" : "" %>>Customer Name</option>
                    <option value="service" <%= "service".equals(request.getParameter("sort")) ? "selected" : "" %>>Service Name</option>
                    <option value="date" <%= "date".equals(request.getParameter("sort")) ? "selected" : "" %>>Date</option>
                    <option value="status" <%= "status".equals(request.getParameter("sort")) ? "selected" : "" %>>Status</option>
                </select>

                <!-- SEARCH FORM -->
                <form method="get" class="d-flex">
                    <input type="hidden" name="filter" value="<%= filter != null ? filter : "" %>">
                    <input type="hidden" name="sort" value="<%= request.getParameter("sort") != null ? request.getParameter("sort") : "" %>">
                    <input type="text" name="search" class="form-control form-control-sm me-2"
                           placeholder="Search Customer or Service"
                           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <button type="submit" class="btn btn-sm btn-primary">Search</button>
                </form>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle" style="cursor:pointer;">
                <thead class="table-light">
                <tr>
                    <th>#ID</th>
                    <th>Customer</th>
                    <th>Service</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Mark Done</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // 1. Copy bookings
                    java.util.List<Booking> bookingList = new java.util.ArrayList<>(DataStore.getInstance().getBookings());

                    // 2. Filter pending if selected
                    if ("pending".equals(filter)) {
                        bookingList.removeIf(b -> !"Pending".equals(b.getStatus()));
                    }

                    // 3. Apply search
                    String search = request.getParameter("search");
                    if (search != null && !search.trim().isEmpty()) {
                        String lowerSearch = search.toLowerCase();
                        bookingList.removeIf(b ->
                                !(b.getCustomerName().toLowerCase().contains(lowerSearch)
                                        || b.getServiceName().toLowerCase().contains(lowerSearch))
                        );
                    }

                    // 4. Apply sort
                    String sort = request.getParameter("sort");
                    if ("customer".equals(sort)) bookingList.sort((a,b) -> a.getCustomerName().compareToIgnoreCase(b.getCustomerName()));
                    else if ("service".equals(sort)) bookingList.sort((a,b) -> a.getServiceName().compareToIgnoreCase(b.getServiceName()));
                    else if ("date".equals(sort)) bookingList.sort((a,b) -> a.getDate().compareToIgnoreCase(b.getDate()));
                    else if ("status".equals(sort)) bookingList.sort((a,b) -> a.getStatus().compareToIgnoreCase(b.getStatus()));

                    boolean foundAny = !bookingList.isEmpty();
                    for (Booking b : bookingList) {
                %>
                <tr class="<%= "Pending".equals(b.getStatus()) ? "table-warning" : "" %>">
                    <td class="text-muted small">#<%= b.getId() %></td>
                    <td class="fw-bold text-dark"><%= b.getCustomerName() %></td>
                    <td><%= b.getServiceName() %></td>
                    <td>RM <%= b.getPrice() %></td>

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

                <% if (!foundAny) { %>
                <tr>
                    <td colspan="6" class="text-center py-5">
                        <div class="text-muted">
                            <% if ("pending".equals(filter)) { %>
                            <div class="mb-3 p-3 bg-light rounded-circle d-inline-block">
                                <i class="fa-solid fa-mug-hot fa-2x text-secondary"></i>
                            </div>
                            <h5 class="fw-bold text-dark">All Caught Up!</h5>
                            <p class="small">No pending work. Time to relax.</p>
                            <% } else { %>
                            <div>No bookings found.</div>
                            <% } %>
                        </div>
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
