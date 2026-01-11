<%@ page import="java.util.List" %>
<%@ page import="com.tidyup.models.Booking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #9b59b6;
            --purple-hover: #8e44ad;
            --light-purple-bg: #f8f0fc;
            --dark-text: #5b3256;
            --soft-shadow: 0 10px 30px rgba(155, 89, 182, 0.1);
        }

        body {
            background-color: var(--light-purple-bg);
            font-family: 'Segoe UI', Roboto, sans-serif;
            color: var(--dark-text);
        }

        .main-content {
            margin-left: 0; /* Default Closed */
            padding: 2rem;
            width: 100%;
            transition: margin-left 0.3s ease;
        }

        body.sidebar-open .main-content {
            margin-left: 260px;
        }

        .history-card { background: white; border: none; border-radius: 25px; box-shadow: var(--soft-shadow); overflow: hidden; }

        .table thead th { background-color: #f3e5f5; color: var(--primary-purple); font-weight: 700; border: none; padding: 1.2rem; }
        .table tbody td { padding: 1.2rem; vertical-align: middle; border-bottom: 1px solid #f0f0f0; }

        .status-badge { padding: 8px 15px; border-radius: 50px; font-size: 0.85rem; font-weight: 700; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-success { background-color: #d4edda; color: #155724; }
        .status-cancel { background-color: #f8d7da; color: #721c24; }

        .btn-rate {
            border: 1px solid var(--primary-purple);
            color: var(--primary-purple);
            border-radius: 20px;
            font-size: 0.8rem;
            padding: 5px 15px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            margin-top: 5px;
            transition: 0.2s;
        }
        .btn-rate:hover { background-color: var(--primary-purple); color: white; }
    </style>
</head>
<body>

<jsp:include page="customer_sidebar.jsp" />

<div class="main-content">

    <div class="mb-4 bg-white p-4 rounded-4 shadow-sm border-0 ps-5">
        <h2 class="fw-bold m-0 ps-4" style="color: #9b59b6;">My Booking History</h2>
    </div>

    <div class="container-fluid p-0">
        <%
            List<Booking> list = (List<Booking>) request.getAttribute("myBookings");
            if (list != null && !list.isEmpty()) {
        %>
        <div class="card history-card animate__animated animate__fadeInUp">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>Service Name</th>
                        <th>Date Scheduled</th>
                        <th>Time</th>
                        <th>Location</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Booking b : list) { %>
                    <tr>
                        <td class="fw-bold text-dark"><%= b.getServiceName() %></td>
                        <td><%= b.getDate() %></td>
                        <td><%= b.getTime() %></td>
                        <td><%= b.getAddress() %></td>

                        <td>
                            <% if ("Completed".equalsIgnoreCase(b.getStatus()) || "Success".equalsIgnoreCase(b.getStatus())) { %>

                            <span class="status-badge status-success">Completed</span>
                            <br>

                            <% if (b.isReviewed()) { %>
                            <div style="margin-top: 8px; color: #155724; font-weight: bold; font-size: 0.85rem; opacity: 0.8;">
                                <i class="fa-solid fa-circle-check"></i> Rated
                            </div>
                            <% } else { %>
                            <a href="review_form.jsp?bookingId=<%= b.getId() %>" class="btn-rate">
                                <i class="fa-solid fa-star"></i> Rate Us
                            </a>
                            <% } %>

                            <% } else if ("Cancelled".equalsIgnoreCase(b.getStatus())) { %>
                            <span class="status-badge status-cancel">Cancelled</span>
                            <% } else { %>
                            <span class="status-badge status-pending"><%= b.getStatus() %></span>
                            <% } %>
                        </td>

                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } else { %>
        <div class="text-center mt-5">
            <h4 class="text-muted">No bookings found yet.</h4>
            <a href="UserBookingServlet" class="btn btn-outline-purple mt-3">Book your first service</a>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>