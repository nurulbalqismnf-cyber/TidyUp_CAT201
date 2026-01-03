<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 3/1/2026
  Time: 9:44 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Service" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<%
    // 1. Get the ID from the URL
    String id = request.getParameter("id");
    // 2. Find the service in our data store
    Service s = DataStore.getInstance().getServiceById(id);

    if (s == null) {
%>
<div class="alert alert-danger">Service not found! <a href="admin">Go Back</a></div>
<%
} else {
%>
<div class="card p-4 mx-auto" style="max-width: 500px;">
    <h3>Edit Service</h3>

    <form action="admin" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= s.getId() %>">

        <div class="mb-3">
            <label>Service Name</label>
            <input type="text" name="serviceName" class="form-control" value="<%= s.getName() %>" required>
        </div>

        <div class="mb-3">
            <label>Price</label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= s.getPrice() %>" required>
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" rows="3"><%= s.getDescription() %></textarea>
        </div>

        <div class="d-flex justify-content-between">
            <a href="admin" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-success">Save Changes</button>
        </div>

        <div class="d-flex justify-content-between">
            <a href="admin" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Cancel
            </a>

            <button type="submit" class="btn btn-success">Save Changes</button>
        </div>
    </form>
</div>
<% } %>

</body>
</html>