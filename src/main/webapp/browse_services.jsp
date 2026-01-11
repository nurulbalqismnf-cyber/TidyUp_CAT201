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

        .main-content {
            margin-left: 0;
            padding: 2rem;
            width: 100%;
            transition: margin-left 0.3s ease;
        }

        body.sidebar-open .main-content {
            margin-left: 260px;
        }

        .service-card { border: none; border-radius: 25px; box-shadow: var(--soft-shadow); transition: all 0.3s ease; background: white; height: 100%; }
        .service-card:hover { transform: translateY(-8px); box-shadow: 0 15px 35px rgba(155, 89, 182, 0.2); }
        .card-body { padding: 2rem; }
        .price-tag { color: var(--primary-purple); font-weight: 800; font-size: 1.2rem; background: #f3e5f5; padding: 5px 15px; border-radius: 20px; display: inline-block; margin-bottom: 1rem; }
        .form-control, .form-select { border-radius: 12px; border: 1px solid #e0d0e8; padding: 10px 15px; margin-bottom: 10px; font-size: 0.9rem; }
        .form-control:focus, .form-select:focus { border-color: var(--primary-purple); box-shadow: 0 0 0 0.2rem rgba(155, 89, 182, 0.15); }
        .btn-purple { background-color: var(--primary-purple); color: white; border: none; border-radius: 50px; padding: 12px; font-weight: 700; width: 100%; transition: all 0.2s; }
        .btn-purple:hover { background-color: var(--purple-hover); transform: scale(1.02); }
    </style>
</head>
<body>

<jsp:include page="customer_sidebar.jsp" />

<div class="main-content">

    <div class="mb-5 bg-white p-4 rounded-4 shadow-sm border-0 ps-5">
        <h2 class="fw-bold m-0 ps-4" style="color: #764ba2;">Available Services</h2>
        <p class="text-muted small m-0 ps-4">Book your next cleaning session</p>
    </div>

    <div class="container-fluid">
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
</div>

</body>
</html>