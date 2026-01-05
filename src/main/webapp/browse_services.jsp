<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 1/5/2026
  Time: 10:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.tidyup.models.Service" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Services</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Available Services</h2>
        <a href="UserBookingServlet?action=history" class="btn btn-outline-primary">View My History</a>
    </div>

    <div class="row">
        <%
            List<Service> services = (List<Service>) request.getAttribute("serviceList");
            if (services != null) {
                for (Service s : services) {
        %>
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title"><%= s.getName() %></h5>
                    <p class="text-muted"><%= s.getDescription() %></p>
                    <h6 class="text-primary fw-bold">Price: RM <%= s.getPrice() %></h6>

                    <form action="UserBookingServlet" method="post" class="mt-3">
                        <input type="hidden" name="serviceName" value="<%= s.getName() %>">
                        <input type="date" name="date" class="form-control mb-2" required>
                        <input type="time" name="time" class="form-control mb-2" required>
                        <input type="text" name="address" class="form-control mb-2" placeholder="Your Address" required>
                        <button type="submit" class="btn btn-success w-100">Book Now</button>
                    </form>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>
</body>
</html>