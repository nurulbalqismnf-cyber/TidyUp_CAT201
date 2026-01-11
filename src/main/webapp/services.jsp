<%@ page import="com.tidyup.models.DataStore" %>
<%@ page import="com.tidyup.models.Service" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Services</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; overflow: hidden; font-family: 'Poppins', sans-serif; }

        /* Consistent Content Wrapper */
        .page-content {
            background: linear-gradient(to bottom, #a0e9ff, #ffffff);
            height: 100vh;
            overflow-y: auto;
            width: 100%;
        }

        .card-custom { border: none; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="d-flex">
    <jsp:include page="sidebar.jsp" />

    <div class="page-content p-4">

        <nav class="d-flex align-items-center mb-4 bg-white p-3 rounded-4 shadow-sm">
            <i class="fa-solid fa-bars me-3 fs-4" onclick="toggleSidebar()" style="cursor: pointer; color: #6a11cb;"></i>
            <h4 class="m-0 fw-bold text-primary">Manage Services</h4>
            <a href="dashboard.jsp" class="btn btn-outline-secondary btn-sm ms-auto rounded-pill px-3">
                <i class="fa-solid fa-arrow-left me-2"></i> Dashboard
            </a>
        </nav>

        <div class="row">
            <div class="col-md-4">
                <div class="card card-custom p-4 bg-white h-100">
                    <h5 class="fw-bold mb-3 text-primary">Add New Service</h5>
                    <form action="ServiceServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="small fw-bold text-muted">Name</label>
                            <input type="text" name="name" class="form-control rounded-3" required>
                        </div>
                        <div class="mb-3">
                            <label class="small fw-bold text-muted">Price (RM)</label>
                            <input type="number" step="0.01" name="price" class="form-control rounded-3" required>
                        </div>
                        <div class="mb-3">
                            <label class="small fw-bold text-muted">Description</label>
                            <textarea name="desc" class="form-control rounded-3" rows="3"></textarea>
                        </div>
                        <button class="btn btn-primary w-100 rounded-pill fw-bold">Add Service</button>
                    </form>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card card-custom p-4 bg-white h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold m-0">Current Services</h5>
                        <span class="badge bg-primary rounded-pill"><%= DataStore.getInstance().getServices().size() %> Active</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead class="table-light rounded-3">
                            <tr><th>Name / Desc</th><th>Price</th><th class="text-end">Action</th></tr>
                            </thead>
                            <tbody>
                            <% for(Service s : DataStore.getInstance().getServices()) { %>
                            <tr>
                                <td>
                                    <strong class="text-dark"><%= s.getName() %></strong><br>
                                    <small class="text-muted"><%= s.getDescription() %></small>
                                </td>
                                <td class="text-success fw-bold">RM <%= s.getPrice() %></td>
                                <td class="text-end">
                                    <a href="edit.jsp?id=<%= s.getId() %>" class="btn btn-sm btn-light text-primary border"><i class="fa-solid fa-pen"></i></a>
                                    <form action="ServiceServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<%= s.getId() %>">
                                        <button class="btn btn-sm btn-light text-danger border"><i class="fa-solid fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>