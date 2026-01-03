<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 3/1/2026
  Time: 10:24 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>TidyUp - Book a Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-dark mb-5">
    <div class="container">
        <span class="navbar-brand fw-bold"><i class="fa-solid fa-broom me-2"></i> TidyUp Customer</span>
        <a href="index.jsp" class="btn btn-outline-light btn-sm">Exit</a>
    </div>
</nav>

<div class="container">
    <h2 class="text-center fw-bold mb-4">Available Services</h2>

    <div class="row g-4">
        <% for(Service s : DataStore.getInstance().getServices()) { %>
        <div class="col-md-4">
            <div class="card h-100 p-4 card-hover">
                <div class="card-body text-center">
                    <h4 class="fw-bold"><%= s.getName() %></h4>
                    <h2 class="text-success my-3">RM <%= s.getPrice() %></h2>
                    <p class="text-muted"><%= s.getDescription() %></p>

                    <form action="booking" method="post">
                        <input type="hidden" name="serviceName" value="<%= s.getName() %>">
                        <input type="hidden" name="price" value="<%= s.getPrice() %>">

                        <div class="mb-3">
                            <input type="text" name="customerName" class="form-control" placeholder="Your Name" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 rounded-pill">Book Now</button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
