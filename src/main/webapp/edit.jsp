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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="container mt-5" style="background: #f8f9fa;">

<%
    String id = request.getParameter("id");
    // We need to make sure this method exists in DataStore (See Step 2)
    Service s = DataStore.getInstance().getServiceById(id);

    if (s == null) {
%>
<div class="alert alert-danger shadow-sm">
    Service not found! <a href="services.jsp" class="fw-bold">Go Back</a>
</div>
<%
} else {
%>

<div class="card p-4 mx-auto shadow border-0 rounded-4" style="max-width: 500px;">
    <h3 class="fw-bold text-primary mb-4"><i class="fa-solid fa-pen-to-square"></i> Edit Service</h3>

    <form action="ServiceServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= s.getId() %>">

        <div class="mb-3">
            <label class="fw-bold small text-muted">Service Name</label>
            <input type="text" name="name" class="form-control rounded-3" value="<%= s.getName() %>" required>
        </div>

        <div class="mb-3">
            <label class="fw-bold small text-muted">Price (RM)</label>
            <input type="number" step="0.01" name="price" class="form-control rounded-3" value="<%= s.getPrice() %>" required>
        </div>

        <div class="mb-3">
            <label class="fw-bold small text-muted">Description</label>
            <textarea name="desc" class="form-control rounded-3" rows="3"><%= s.getDescription() %></textarea>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="services.jsp" class="btn btn-secondary rounded-pill px-4">
                Cancel
            </a>
            <button type="submit" class="btn btn-success rounded-pill px-4 fw-bold">
                Save Changes
            </button>
        </div>
    </form>
</div>
<% } %>

</body>
</html>