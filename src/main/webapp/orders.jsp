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

        <!-- HEADER -->
        <div class="card-header-custom d-flex justify-content-between align-items-center mb-3">
            <div>
                <h4 class="card-title fw-bold text-dark">
                    <i class="fa-solid fa-list-check text-primary me-2"></i>Incoming Bookings
                </h4>
                <%
                    String filterParam = request.getParameter("filter");
                    if ("pending".equals(filterParam)) { %>
                <p class="text-danger small mb-0 fw-bold">
                    <i class="fa-solid fa-filter me-1"></i> Showing Pending Jobs Only
                </p>
                <% } else { %>
                <p class="text-muted small mb-0">Manage all customer requests</p>
                <% } %>
            </div>

            <div>
                <% if("pending".equals(filterParam)) { %>
                <a href="orders.jsp" class="btn btn-sm btn-outline-secondary rounded-pill">Show All</a>
                <% } else { %>
                <span class="badge bg-primary rounded-pill">
                        <%= DataStore.getInstance().getBookings().size() %> Total
                    </span>
                <% } %>
            </div>
        </div>

        <!-- SEARCH FORM -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <form class="d-flex" method="get" action="orders.jsp">
                <input type="text" name="search" class="form-control me-2" placeholder="Search by customer or service"
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <% if(filterParam != null) { %>
                <input type="hidden" name="filter" value="<%= filterParam %>">
                <% } %>
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <% if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) { %>
            <a href="orders.jsp<%= filterParam != null ? "?filter=" + filterParam : "" %>" class="btn btn-secondary">
                Clear Search
            </a>
            <% } %>
        </div>

        <!-- TABLE -->
        <div class="table-responsive">
            <table class="table table-hover align-middle" style="cursor: pointer;">
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
                    String search = request.getParameter("search");
                    boolean foundAny = false;
                    for (Booking b : DataStore.getInstance().getBookings()) {

                        // FILTER LOGIC
                        if ("pending".equals(filterParam) && !"Pending".equals(b.getStatus())) continue;

                        // SEARCH LOGIC
                        if (search != null && !search.trim().isEmpty()) {
                            String lowerSearch = search.toLowerCase();
                            if (!b.getCustomerName().toLowerCase().contains(lowerSearch) &&
                                    !b.getServiceName().toLowerCase().contains(lowerSearch)) {
                                continue;
                            }
                        }

                        foundAny = true;
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

                <% if (!foundAny) { %>
                <tr>
                    <td colspan="6" class="text-center py-5">
                        <div class="text-muted">
                            <% if ("pending".equals(filterParam)) { %>
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
