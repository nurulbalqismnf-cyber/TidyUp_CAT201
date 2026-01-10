<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 11/01/2026
  Time: 01:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Services</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(to bottom, #a0e9ff, #ffffff); min-height: 100vh; font-family: sans-serif; }
        .card-custom { border-radius: 20px; border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-dark">Manage Services</h2>
        <a href="dashboard.jsp" class="btn btn-outline-primary rounded-pill px-4">Back to Dashboard</a>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="card card-custom p-4 bg-white">
                <h5 class="fw-bold mb-3 text-primary">Add New Service</h5>
                <form action="ServiceServlet" method="post">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label class="small text-muted fw-bold">Service Name</label>
                        <input type="text" name="name" class="form-control rounded-3" placeholder="e.g. Office Cleaning" required>
                    </div>

                    <div class="mb-3">
                        <label class="small text-muted fw-bold">Price (RM)</label>
                        <input type="number" step="0.01" name="price" class="form-control rounded-3" placeholder="0.00" required>
                    </div>

                    <div class="mb-3">
                        <label class="small text-muted fw-bold">Description</label>
                        <textarea name="desc" class="form-control rounded-3" rows="3" placeholder="Short description..." required></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill fw-bold">Add Service</button>
                </form>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card card-custom p-4 bg-white">
                <h5 class="fw-bold mb-3">Current Services</h5>
                <table class="table align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(Service s : DataStore.getInstance().getServices()) { %>
                    <tr>
                        <td class="fw-bold"><%= s.getName() %></td>
                        <td class="small text-muted"><%= s.getDescription() %></td>
                        <td class="fw-bold text-success">RM <%= s.getPrice() %></td>
                        <td>
                            <div class="d-flex gap-2">
                                <a href="edit.jsp?id=<%= s.getId() %>" class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                    Edit
                                </a>

                                <form action="ServiceServlet" method="post" class="m-0">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= s.getId() %>">
                                    <button class="btn btn-sm btn-outline-danger rounded-pill px-3">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
