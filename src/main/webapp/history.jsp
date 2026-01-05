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
<html>
<head>
    <title>My History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
<div class="container">
    <h2 class="mb-4">My Booking History</h2>
    <a href="UserBookingServlet" class="btn btn-secondary mb-3">&larr; Back to Services</a>

    <table class="table table-white shadow-sm">
        <thead class="table-dark">
        <tr>
            <th>Service</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Booking> list = (List<Booking>) request.getAttribute("myBookings");
            if (list != null) {
                for (Booking b : list) {
        %>
        <tr>
            <td><%= b.getServiceName() %></td>
            <td><%= b.getDate() %></td>
            <td><%= b.getTime() %></td>
            <td>
                        <span class="badge bg-<%= "Pending".equals(b.getStatus()) ? "warning" : "success" %>">
                            <%= b.getStatus() %>
                        </span>
            </td>
        </tr>
        <% }} %>
        </tbody>
    </table>
</div>
</body>
</html>