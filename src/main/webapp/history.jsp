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

        .page-header {
            background: white;
            padding: 2rem 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            margin-bottom: 3rem;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
        }

        h2.purple-heading { color: var(--primary-purple); font-weight: 800; }
        .history-card { background: white; border: none; border-radius: 25px; box-shadow: var(--soft-shadow); overflow: hidden; }

        .table thead th { background-color: #f3e5f5; color: var(--primary-purple); font-weight: 700; border: none; padding: 1.2rem; }
        .table tbody td { padding: 1.2rem; vertical-align: middle; border-bottom: 1px solid #f0f0f0; }

        /* Status Badges */
        .status-badge { padding: 8px 15px; border-radius: 50px; font-size: 0.85rem; font-weight: 700; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-success { background-color: #d4edda; color: #155724; }
        .status-cancel { background-color: #f8d7da; color: #721c24; }

        /* Review Button */
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

        .btn-outline-purple { color: var(--primary-purple); border: 2px solid var(--primary-purple); border-radius: 50px; padding: 8px 25px; font-weight: 700; text-decoration: none; }
        .btn-outline-purple:hover { background-color: var(--primary-purple); color: white; }
    </style>
</head>
<body>

<div class="page-header text-center">
    <div class="container d-flex justify-content-between align-items-center">
        <h2 class="purple-heading m-0">My Booking History</h2>
        <a href="UserBookingServlet" class="btn-outline-purple">&larr; Back to Services</a>
    </div>
</div>

<div class="container">
    <%
        List<Booking> list = (List<Booking>) request.getAttribute("myBookings");
        if (list != null && !list.isEmpty()) {
    %>
    <div class="card history-card animate__animated animate__fadeInUp">
        <div class="table-responsive">
            <table class="table table-hover">
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
                        <%-- FIX: Check for "Completed" OR "Success" to be safe --%>
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

</body>
</html>