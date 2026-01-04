<%@page import="com.tidyup.models.DataStore" %>
<%@page import="com.tidyup.models.Review" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Reviews | TidyUp Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .review-card { border-radius: 15px; transition: 0.3s; border: none; }
        .review-card:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .star-filled { color: #ffc107; }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-dark">All Customer Reviews</h2>
        <a href="dashboard.jsp" class="btn btn-outline-secondary rounded-pill">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>

    <div class="row g-4">
        <%
            for(Review r : DataStore.getInstance().getReviews()) {
        %>
        <div class="col-md-4">
            <div class="card review-card p-4 h-100 shadow-sm">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="fw-bold mb-0 text-primary"><%= r.getCustomerName() %></h6>
                    <span class="badge bg-light text-dark small"><%= r.getDate() %></span>
                </div>
                <div class="mb-3">
                    <% for(int i=1; i<=5; i++) { %>
                    <i class="fa-solid fa-star <%= i <= r.getRating() ? "star-filled" : "text-muted opacity-25" %>"></i>
                    <% } %>
                </div>
                <p class="text-muted italic">"<%= r.getComment() %>"</p>
            </div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
