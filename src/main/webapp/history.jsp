<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 1/5/2026
  Time: 10:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.tidyup.models.Booking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        /* Header Area */
        .page-header {
            background: white;
            padding: 2rem 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            margin-bottom: 3rem;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
        }

        h2.purple-heading {
            color: var(--primary-purple);
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        /* The Table Card */
        .history-card {
            background: white;
            border: none;
            border-radius: 25px;
            box-shadow: var(--soft-shadow);
            overflow: hidden; /* Clips the table corners */
            padding: 0;
        }

        /* Custom Table Styling */
        .table {
            margin-bottom: 0; /* Remove bottom space */
        }

        .table thead th {
            background-color: #f3e5f5; /* Very light purple header */
            color: var(--primary-purple);
            font-weight: 700;
            border: none;
            padding: 1.2rem;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }

        .table tbody td {
            padding: 1.2rem;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
            color: #555;
            font-weight: 500;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .table tbody tr:hover {
            background-color: #faf5fc; /* Slight purple tint on hover */
        }

        /* Status Badges */
        .status-badge {
            padding: 8px 15px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: capitalize;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-success, .status-approved {
            background-color: #d4edda;
            color: #155724;
        }

        /* Buttons */
        .btn-outline-purple {
            color: var(--primary-purple);
            border: 2px solid var(--primary-purple);
            border-radius: 50px;
            padding: 8px 25px;
            font-weight: 700;
            background: transparent;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-outline-purple:hover {
            background-color: var(--primary-purple);
            color: white;
        }
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
                        <%
                            String statusClass = "status-pending"; // Default
                            if ("Approved".equalsIgnoreCase(b.getStatus()) || "Success".equalsIgnoreCase(b.getStatus())) {
                                statusClass = "status-success";
                            }
                        %>
                        <span class="status-badge <%= statusClass %>">
                                        <%= b.getStatus() %>
                                    </span>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <%
    } else {
    %>
    <div class="text-center mt-5">
        <div style="font-size: 4rem; color: #e0d0e8; margin-bottom: 1rem;">
            <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-calendar-x" viewBox="0 0 16 16">
                <path d="M6.146 7.146a.5.5 0 0 1 .708 0L8 8.293l1.146-1.147a.5.5 0 1 1 .708.708L8.707 9l1.147 1.146a.5.5 0 0 1-.708.708L8 9.707l-1.146 1.147a.5.5 0 0 1-.708-.708L7.293 9 6.146 7.854a.5.5 0 0 1 0-.708z"/>
                <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
            </svg>
        </div>
        <h4 class="text-muted">No bookings found yet.</h4>
        <a href="UserBookingServlet" class="btn btn-primary mt-3"
           style="background: #9b59b6; border:none; border-radius:50px; padding: 10px 30px;">
            Book your first service
        </a>
    </div>
    <% } %>

</div>

</body>
</html>