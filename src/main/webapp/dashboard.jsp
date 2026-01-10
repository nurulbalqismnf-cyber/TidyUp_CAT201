<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Booking" %>
<%@ page import="com.tidyup.models.Service" %>
<%@ page import="com.tidyup.models.Review" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Security and Revenue Logic
    double earnedRevenue = 0.0;
    double pendingRevenue = 0.0;
    int pendingCount = 0;

    // Calculate Revenue
    for(Booking b : DataStore.getInstance().getBookings()) {
        if("Success".equalsIgnoreCase(b.getStatus()) || "Completed".equalsIgnoreCase(b.getStatus())) {
            earnedRevenue += b.getPrice(); // Only count paid/completed jobs
        } else {
            pendingRevenue += b.getPrice();
            pendingCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Portal | TidyUp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background: linear-gradient(to bottom, #a0e9ff, #ffffff); min-height: 100vh; font-family: 'Poppins', sans-serif; }
        .nav-custom { background-color: #00d2ff; padding: 10px 20px; color: white; }
        .revenue-card { border-radius: 25px; color: white; padding: 25px; border: none; }
        .module-card { background: white; border-radius: 20px; border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.05); transition: 0.3s; }
        .module-card:hover { transform: translateY(-5px); }
    </style>
</head>
<body>

<nav class="nav-custom d-flex justify-content-between align-items-center mb-4 shadow-sm">
    <span class="fw-bold"><i class="fa-solid fa-user-shield me-2"></i> Admin Portal</span>
    <a href="login.jsp" class="btn btn-sm btn-outline-light rounded-pill px-3">Logout</a>
</nav>

<%--pannel for servicce, order, customers--%>
<div class="container text-center mb-5">
    <h1 class="fw-bold">Welcome back, Admin!</h1>
    <p class="text-muted">Select a module to manage</p>

    <div class="row g-4 justify-content-center mb-5">
        <div class="col-md-3">
            <a href="services.jsp" class="text-decoration-none text-dark">
                <div class="card module-card p-4 text-center">
                    <i class="fa-solid fa-broom fa-3x text-success mb-3"></i>
                    <h5 class="fw-bold">Services</h5>
                </div>
            </a>
        </div>
        <div class="col-md-3 text-dark">
            <a href="orders.jsp" class="text-decoration-none text-dark">
                <div class="card module-card p-4 text-center">
                    <i class="fa-solid fa-file-invoice fa-3x text-primary mb-3"></i>
                    <h5 class="fw-bold">Orders</h5>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="users.jsp" class="text-decoration-none text-dark">
                <div class="card module-card p-4 text-center">
                    <i class="fa-solid fa-users fa-3x text-info mb-3"></i>
                    <h5 class="fw-bold">Customers</h5>
                </div>
            </a>
        </div>
    </div>

    <%--    earn money--%>
    <div class="row g-4 justify-content-center mb-5">
        <div class="col-md-5">
            <div class="revenue-card shadow" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <p class="small text-uppercase mb-1 fw-bold opacity-75">Total Revenue</p>
                <h2 class="fw-bold">RM <%= String.format("%.2f", earnedRevenue) %></h2>
            </div>
        </div>
        <div class="col-md-5">
            <div class="revenue-card shadow" style="background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%); color: #a30000 !important;">
                <p class="small text-uppercase mb-1 fw-bold opacity-75">Pending Jobs</p>
                <h2 class="fw-bold" id="pendingCountDisplay"><%= pendingCount %></h2>
            </div>
        </div>
    </div>

    <div class="bg-white p-4 rounded-4 shadow-sm border text-start mb-4">
        <h5 class="fw-bold mb-3 text-primary"><i class="fa-solid fa-clock me-2"></i> Pending Tasks</h5>

        <table class="table align-middle" id="pendingTable">
            <thead class="table-light">
            <tr>
                <th style="width: 50px;">Done?</th>
                <th>Customer</th>
                <th>Service</th>
                <th class="text-end">Price</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasPending = false;
                for(Booking b : DataStore.getInstance().getBookings()) {
                    if(!"Success".equals(b.getStatus())) {
                        hasPending = true;
            %>
            <tr id="row_<%= b.getId() %>">
                <td>
                    <input type="checkbox"
                           class="form-check-input"
                           style="width: 22px; height: 22px; cursor: pointer;"
                           onclick="markTaskDone(this, '<%= b.getId() %>')">
                </td>
                <td><span class="fw-bold"><%= b.getCustomerName() %></span></td>
                <td><span class="badge bg-warning text-dark rounded-pill px-3"><%= b.getServiceName() %></span></td>
                <td class="text-end fw-bold">RM <%= String.format("%.2f", b.getPrice()) %></td>
            </tr>
            <% } } %>

            <% if(!hasPending) { %>
            <tr><td colspan="4" class="text-center text-muted py-3">No pending tasks.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <script>
        function markTaskDone(checkbox, bookingId) {
            // STEP 1: Visually hide the row in the table
            var row = document.getElementById('row_' + bookingId);
            if(row) {
                row.style.transition = "all 0.5s";
                row.style.opacity = "0";
                setTimeout(function(){ row.style.display = "none"; }, 500);
            }

            // STEP 2: Update the "Pending Jobs" Counter at the top
            var counter = document.getElementById("pendingCountDisplay");
            if(counter) {
                var currentVal = parseInt(counter.innerText);
                if(currentVal > 0) {
                    counter.innerText = currentVal - 1;
                }
            }

            // STEP 3: Send data to server (AJAX)
            fetch('UpdateTaskServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'bookingId=' + bookingId
            }).then(response => {
                console.log("Server updated successfully");
            }).catch(error => {
                console.error("Error:", error);
            });
        }
    </script>

<%--statistic--%>
<div class="container mb-5">
    <div class="row g-4">
        <div class="col-md-8">
            <div class="p-4 rounded-4 bg-white shadow-sm border h-100">
                <h5 class="fw-bold mb-4"><i class="fa-solid fa-chart-line me-2 text-primary"></i> Revenue Growth</h5>
                <canvas id="revenueChart"></canvas>
            </div>
        </div>

        <div class="col-md-4">
            <div class="p-4 rounded-4 bg-white shadow-sm border h-100">
                <h5 class="fw-bold mb-4"><i class="fa-solid fa-chart-pie me-2 text-info"></i> Service Split</h5>
                <canvas id="servicePieChart"></canvas>
            </div>
        </div>
    </div>
</div>

<%-- DYNAMIC REVIEWS SECTION --%>
<div class="container mb-5">
    <div class="p-4 rounded-4 bg-white shadow-sm border">
        <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-star text-warning me-2"></i> Recent Customer Feedback</h5>

        <div class="row g-3">
            <%
                // 1. Get Real Reviews from DataStore
                List<Review> reviews = DataStore.getInstance().getReviews();

                if (reviews != null && !reviews.isEmpty()) {
                    // 2. Loop through them
                    for (Review r : reviews) {
            %>
            <div class="col-md-6">
                <div class="p-3 rounded-4 border bg-light h-100">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="fw-bold text-primary"><%= r.getCustomerName() %></span>

                        <div class="text-warning small">
                            <%
                                int rating = r.getRating();
                                for(int i=1; i<=5; i++) {
                                    if(i <= rating) {
                            %>
                            <i class="fa-solid fa-star"></i>
                            <%     } else { %>
                            <i class="fa-regular fa-star"></i>
                            <%     }
                            }
                            %>
                        </div>
                    </div>
                    <p class="small text-muted mb-1">"<%= r.getMessage() %>"</p>
                    <small class="text-secondary opacity-75" style="font-size: 0.75rem;">Date: <%= r.getDate() %></small>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12 text-center text-muted py-4">
                No reviews have been submitted yet.
            </div>
            <% } %>
        </div>
    </div>
</div>

<script>
    // 1. Revenue Growth Chart (Line Chart)
    const ctxLine = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctxLine, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Monthly Earnings (RM)',
                data: [1200, 1900, 1500, 2500, 2200, 3000],
                borderColor: '#00d2ff',
                backgroundColor: 'rgba(0, 210, 255, 0.1)',
                fill: true,
                tension: 0.4
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    // 2. Service Popularity Chart (Pie Chart)
    const ctxPie = document.getElementById('servicePieChart').getContext('2d');
    new Chart(ctxPie, {
        type: 'doughnut',
        data: {
            labels: ['Basic', 'Deep Clean', 'Office'],
            datasets: [{
                data: [50, 30, 20],
                backgroundColor: ['#43e97b', '#fa709a', '#667eea']
            }]
        },
        options: { cutout: '70%', plugins: { legend: { position: 'bottom' } } }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>