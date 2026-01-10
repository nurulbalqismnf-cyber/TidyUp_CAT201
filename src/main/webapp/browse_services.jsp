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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Browse Services</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-purple: #9b59b6;
            --purple-hover: #8e44ad;
            --light-purple-bg: #f8f0fc;
            --dark-text: #5b3256;
            --soft-shadow: 0 10px 30px rgba(155, 89, 182, 0.1);
        }
        body { background-color: var(--light-purple-bg); font-family: 'Segoe UI', sans-serif; color: var(--dark-text); padding-bottom: 5rem; }
        .page-header { background: white; padding: 2rem 0; box-shadow: 0 4px 15px rgba(0,0,0,0.03); margin-bottom: 3rem; border-bottom-left-radius: 30px; border-bottom-right-radius: 30px; }
        h2.purple-heading { color: var(--primary-purple); font-weight: 800; }
        .service-card { border: none; border-radius: 25px; box-shadow: var(--soft-shadow); transition: all 0.3s ease; background: white; height: 100%; }
        .service-card:hover { transform: translateY(-8px); box-shadow: 0 15px 35px rgba(155, 89, 182, 0.2); }
        .card-body { padding: 2rem; }
        .price-tag { color: var(--primary-purple); font-weight: 800; font-size: 1.2rem; background: #f3e5f5; padding: 5px 15px; border-radius: 20px; display: inline-block; margin-bottom: 1rem; }
        .form-control, .form-select { border-radius: 12px; border: 1px solid #e0d0e8; padding: 10px 15px; margin-bottom: 10px; font-size: 0.9rem; }
        .form-control:focus, .form-select:focus { border-color: var(--primary-purple); box-shadow: 0 0 0 0.2rem rgba(155, 89, 182, 0.15); }
        .btn-purple { background-color: var(--primary-purple); color: white; border: none; border-radius: 50px; padding: 12px; font-weight: 700; width: 100%; transition: all 0.2s; }
        .btn-purple:hover { background-color: var(--purple-hover); transform: scale(1.02); }
        .btn-outline-purple { color: var(--primary-purple); border: 2px solid var(--primary-purple); border-radius: 50px; padding: 8px 20px; font-weight: 700; background: transparent; text-decoration: none; }
        .btn-outline-purple:hover { background-color: var(--primary-purple); color: white; }
    </style>
</head>
<body>

<div class="page-header text-center">
    <div class="container d-flex justify-content-between align-items-center">
        <h2 class="purple-heading m-0">Available Services</h2>
        <div>
            <a href="UserBookingServlet?action=history" class="btn-outline-purple me-2">View My History</a>
            <a href="logout" class="text-danger text-decoration-none fw-bold small">Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="row g-4">
        <%
            List<Service> services = (List<Service>) request.getAttribute("serviceList");
            if (services != null) {
                for (Service s : services) {
        %>
        <div class="col-md-4">
            <div class="card service-card">
                <div class="card-body">
                    <h4 class="fw-bold mb-2" style="color: #4a4a4a;"><%= s.getName() %></h4>
                    <p class="text-muted small mb-3"><%= s.getDescription() %></p>
                    <div class="price-tag">RM <%= s.getPrice() %></div>

                    <form action="UserBookingServlet" method="post" class="mt-3">
                        <input type="hidden" name="serviceName" value="<%= s.getName() %>">

                        <div class="row g-2">
                            <div class="col-12">
                                <label class="small text-muted fw-bold ms-1">Full Name</label>
                                <input type="text" name="userName" class="form-control" placeholder="Your Name" required>
                            </div>
                            <div class="col-12">
                                <label class="small text-muted fw-bold ms-1">Phone Number</label>
                                <input type="tel" name="phone" class="form-control" placeholder="012-3456789" required>
                            </div>
                        </div>

                        <div class="row g-2">
                            <div class="col-6">
                                <label class="small text-muted fw-bold ms-1">Date</label>
                                <input type="date" name="date" class="form-control" required>
                            </div>
                            <div class="col-6">
                                <label class="small text-muted fw-bold ms-1">Time</label>
                                <input type="time" name="time" class="form-control" required>
                            </div>
                        </div>

                        <label class="small text-muted fw-bold ms-1">Address</label>
                        <input type="text" name="address" class="form-control" placeholder="Unit, Street, Area..." required>

                        <label class="small text-muted fw-bold ms-1">Payment Method</label>
                        <select name="payment" class="form-select">
                            <option value="Cash">Cash on Delivery</option>
                            <option value="DuitNow/QR">DuitNow / QR Pay</option>
                            <option value="Credit Card">Credit / Debit Card</option>
                        </select>

                        <button type="submit" class="btn btn-purple mt-3">Book Now</button>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12 text-center text-muted">No services found. (Run via Servlet)</div>
        <% } %>
    </div>
</div>

</body>
</html>