<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 3/1/2026
  Time: 4:47 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>TidyUp Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-dark mb-5">
    <div class="container">
        <span class="navbar-brand mb-0 h1 fw-bold">
            <i class="fa-solid fa-broom me-2"></i> TidyUp Admin
        </span>

        <a href="dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
            <i class="fa-solid fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>
</nav>

<div class="container pb-5">
    <div class="row g-4">

        <div class="col-md-5">
            <div class="card p-4 h-100">
                <div class="card-header-custom">
                    <h4 class="card-title fw-bold text-dark">
                        <i class="fa-solid fa-plus-circle text-primary me-2"></i>Add Service
                    </h4>
                    <p class="text-muted small mb-0">Create a new cleaning package</p>
                </div>

                <form action="admin" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase text-muted">Service Name</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="fa-solid fa-tag text-muted"></i></span>
                            <input type="text" name="serviceName" class="form-control" placeholder="e.g. Sofa Cleaning" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase text-muted">Price (RM)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="fa-solid fa-money-bill text-muted"></i></span>
                            <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase text-muted">Description</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Describe the service details..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 shadow-sm">
                        Create Service
                    </button>
                </form>
            </div>
        </div>

        <div class="col-md-7">
            <div class="card p-4 h-100">
                <div class="card-header-custom d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="card-title fw-bold text-dark">
                            <i class="fa-solid fa-list-check text-primary me-2"></i>Current Services
                        </h4>
                        <p class="text-muted small mb-0">List of active packages</p>
                    </div>
                    <span class="badge bg-primary rounded-pill">Active</span>
                </div>

                <% if(DataStore.getInstance().getServices().isEmpty()) { %>
                <div class="text-center py-5">
                    <i class="fa-regular fa-folder-open fa-3x text-muted mb-3"></i>
                    <p class="text-muted">No services found. Start adding some!</p>
                </div>
                <% } else { %>
                <div class="list-group bg-transparent">
                    <% for(Service s : DataStore.getInstance().getServices()) { %>
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-1 fw-bold text-dark"><%= s.getName() %></h5>
                            <p class="mb-2 text-muted small"><i class="fa-solid fa-align-left me-1"></i> <%= s.getDescription() %></p>
                            <span class="price-badge">
                                RM <%= s.getPrice() %>
                            </span>
                        </div>

                        <div class="d-flex gap-2">
                            <a href="edit.jsp?id=<%= s.getId() %>" class="btn btn-light text-primary btn-sm border" title="Edit">
                                <i class="fa-solid fa-pen"></i>
                            </a>

                            <form action="admin" method="post" onsubmit="return confirm('Are you sure you want to delete this service?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <button type="submit" class="btn btn-light text-danger btn-sm border" title="Delete">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>