<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; overflow: hidden; font-family: 'Poppins', sans-serif; }

        .page-content {
            background: linear-gradient(to bottom, #a0e9ff, #ffffff);
            height: 100vh;
            overflow-y: auto;
            width: 100%;
        }
        .table-card { border-radius: 20px; border: none; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="d-flex">
    <jsp:include page="sidebar.jsp" />

    <div class="page-content p-4">

        <nav class="d-flex align-items-center mb-4 bg-white p-3 rounded-4 shadow-sm">
            <i class="fa-solid fa-bars me-3 fs-4" onclick="toggleSidebar()" style="cursor: pointer; color: #6a11cb;"></i>
            <h4 class="m-0 fw-bold text-primary">Customers</h4>
            <a href="dashboard.jsp" class="btn btn-outline-secondary btn-sm ms-auto rounded-pill px-3">
                <i class="fa-solid fa-arrow-left me-2"></i> Dashboard
            </a>
        </nav>

        <div class="card table-card p-4 bg-white">
            <h5 class="fw-bold mb-4">Unique Customers</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr><th>#</th><th>Customer Name</th><th>Status</th><th>History</th></tr>
                    </thead>
                    <tbody>
                    <%
                        Set<String> uniqueCustomers = new HashSet<>();
                        int count = 1;
                        boolean found = false;
                        for(Booking b : DataStore.getInstance().getBookings()) {
                            if(uniqueCustomers.add(b.getCustomerName())) {
                                found = true;
                    %>
                    <tr>
                        <td class="text-muted"><%= count++ %></td>
                        <td class="fw-bold">
                            <div class="d-flex align-items-center">
                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-3" style="width:35px;height:35px;">
                                    <i class="fa-solid fa-user text-primary"></i>
                                </div>
                                <%= b.getCustomerName() %>
                            </div>
                        </td>
                        <td><span class="badge bg-success-subtle text-success border border-success">Active Member</span></td>
                        <td>
                            <a href="orders.jsp?customer=<%= b.getCustomerName() %>" class="btn btn-sm btn-outline-primary rounded-pill">
                                View Orders
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                        if(!found) {
                    %>
                    <tr><td colspan="4" class="text-center py-4 text-muted">No customers found yet.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>