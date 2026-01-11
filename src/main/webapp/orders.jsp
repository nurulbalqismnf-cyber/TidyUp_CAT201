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
        body { margin: 0; padding: 0; overflow: hidden; font-family: 'Poppins', sans-serif; }
        .page-content { background: linear-gradient(to bottom, #a0e9ff, #ffffff); height: 100vh; overflow-y: auto; width: 100%; }
        .table-card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); background: white; padding: 2rem; }

        /* Clickable Name Styling */
        .customer-link { cursor: pointer; color: #333; transition: 0.2s; }
        .customer-link:hover { color: #007bff; }
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
                    <div class="d-flex align-items-center gap-2">
                        <h5 class="fw-bold m-0 text-dark">Bookings List</h5>

                        <%
                            // FILTER LOGIC
                            String filterUser = request.getParameter("customer");
                            if(filterUser != null && !filterUser.isEmpty()) {
                        %>
                        <span class="badge bg-info text-dark">Filter: <%= filterUser %></span>
                        <a href="orders.jsp" class="btn btn-sm btn-secondary rounded-pill ms-2" style="font-size: 0.75rem;">Clear Filter</a>
                        <% } %>
                    </div>

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
                            boolean foundAny = false;
                            for (Booking b : DataStore.getInstance().getBookings()) {
                                // Filter logic
                                if(filterUser != null && !filterUser.isEmpty() && !b.getCustomerName().equals(filterUser)) {
                                    continue;
                                }
                                foundAny = true;
                                String rowClass = "Pending".equals(b.getStatus()) ? "table-warning" : "";
                        %>
                        <tr class="<%= rowClass %>">
                            <td class="fw-bold">
                                <a class="text-decoration-none customer-link" data-bs-toggle="modal" data-bs-target="#orderModal_<%= b.getId() %>">
                                    <%= b.getCustomerName() %> <i class="fa-solid fa-eye small text-primary ms-1 opacity-50"></i>
                                </a>
                            </td>
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
                                    <button type="submit" name="action" value="complete" class="btn btn-sm btn-success fw-bold" onclick="return confirmAction('complete');"><i class="fa-solid fa-check me-1"></i> Done</button>
                                    <button type="submit" name="action" value="cancel" class="btn btn-sm btn-danger px-3" onclick="return confirmAction('cancel');"><i class="fa-solid fa-xmark"></i></button>
                                </form>
                                <% } else { %>
                                <span class="text-muted small"><i class="fa-solid fa-lock"></i> Closed</span>
                                <% } %>
                            </td>
                        </tr>

                        <div class="modal fade" id="orderModal_<%= b.getId() %>" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content border-0 shadow rounded-4">
                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title fw-bold"><i class="fa-solid fa-clipboard-list me-2"></i>Order Details</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-4">

                                        <div class="mb-4">
                                            <h6 class="text-muted text-uppercase small fw-bold mb-3">Customer Information</h6>
                                            <div class="d-flex align-items-center mb-2">
                                                <div class="bg-light rounded-circle p-2 me-3"><i class="fa-solid fa-user text-primary"></i></div>
                                                <div><small class="text-muted d-block">Name</small><strong><%= b.getCustomerName() %></strong></div>
                                            </div>
                                            <div class="d-flex align-items-center mb-2">
                                                <div class="bg-light rounded-circle p-2 me-3"><i class="fa-solid fa-phone text-success"></i></div>
                                                <div><small class="text-muted d-block">Phone Number</small><strong><%= b.getPhoneNumber() %></strong></div>
                                            </div>
                                            <div class="d-flex align-items-start">
                                                <div class="bg-light rounded-circle p-2 me-3"><i class="fa-solid fa-location-dot text-danger"></i></div>
                                                <div><small class="text-muted d-block">Address</small><strong><%= b.getAddress() %></strong></div>
                                            </div>
                                        </div>

                                        <hr class="opacity-25">

                                        <div>
                                            <h6 class="text-muted text-uppercase small fw-bold mb-3">Service Details</h6>
                                            <div class="row g-3">
                                                <div class="col-6">
                                                    <div class="p-2 border rounded bg-light">
                                                        <small class="text-muted d-block">Service Type</small>
                                                        <span class="fw-bold text-dark"><%= b.getServiceName() %></span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="p-2 border rounded bg-light">
                                                        <small class="text-muted d-block">Date</small>
                                                        <span class="fw-bold text-dark"><%= b.getDate() %></span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="p-2 border rounded bg-light">
                                                        <small class="text-muted d-block">Time</small>
                                                        <span class="fw-bold text-dark"><%= b.getTime() %></span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="p-2 border rounded bg-light">
                                                        <small class="text-muted d-block">Price</small>
                                                        <span class="fw-bold text-success">RM <%= String.format("%.2f", b.getPrice()) %></span>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="p-2 border rounded bg-light d-flex align-items-center">
                                                        <i class="fa-solid fa-credit-card text-secondary me-3 fs-5 ps-2"></i>
                                                        <div>
                                                            <small class="text-muted d-block">Payment Method</small>
                                                            <span class="fw-bold text-dark"><%= b.getPaymentMethod() %></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="modal-footer border-0">
                                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>

                        <% if(!foundAny) { %>
                        <tr><td colspan="5" class="text-center py-4 text-muted">No bookings found.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>