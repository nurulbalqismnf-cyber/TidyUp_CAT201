<%@ page import="java.util.List" %>
<%@ page import="com.tidyup.models.Review" %>
<%@ page import="com.tidyup.models.DataStore" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer Reviews</title> <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-purple: #9b59b6;
            --purple-hover: #8e44ad;
            --light-purple-bg: #f8f0fc;
            --dark-text: #5b3256;
            --soft-shadow: 0 10px 30px rgba(155, 89, 182, 0.1);
        }

        body {
            background-color: var(--light-purple-bg);
            font-family: 'Segoe UI', sans-serif;
            color: var(--dark-text);
        }

        .main-content {
            margin-left: 0;
            padding: 2rem;
            width: 100%;
            transition: margin-left 0.3s ease;
        }
        body.sidebar-open .main-content { margin-left: 260px; }

        .review-card {
            background: white;
            border: none;
            border-radius: 20px;
            box-shadow: var(--soft-shadow);
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .review-card:hover { transform: translateY(-3px); }

        .rating-stars { color: #f1c40f; letter-spacing: 2px; }

        .verified-badge {
            font-size: 0.75rem;
            color: #27ae60;
            background: #eafaf1;
            padding: 2px 8px;
            border-radius: 10px;
            font-weight: 700;
        }
    </style>
</head>
<body>

<jsp:include page="customer_sidebar.jsp" />

<div class="main-content">

    <div class="mb-4 bg-white p-4 rounded-4 shadow-sm border-0 ps-5 d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold m-0 ps-4" style="color: #9b59b6;">Customer Reviews</h2>
            <p class="text-muted small m-0 ps-4">See what people are saying about TidyUp!</p>
        </div>
        <div class="pe-4 text-danger opacity-25">
            <i class="fa-solid fa-heart fa-3x"></i>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <%
                List<Review> reviews = (List<Review>) request.getAttribute("reviewList");
                if(reviews == null) {
                    reviews = DataStore.getInstance().getReviews();
                }

                if (reviews != null && !reviews.isEmpty()) {
                    for (Review r : reviews) {
            %>
            <div class="col-md-6 col-lg-4">
                <div class="card review-card p-4 h-100">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="d-flex align-items-center gap-2">
                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; color: #9b59b6;">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold text-dark m-0"><%= r.getCustomerName() %></h6>
                                <span class="verified-badge"><i class="fa-solid fa-check-circle"></i> Verified</span>
                            </div>
                        </div>
                        <small class="text-muted"><%= r.getDate() %></small>
                    </div>

                    <div class="mb-3 rating-stars">
                        <% for(int i=1; i<=5; i++) { %>
                        <i class="fa-solid fa-star <%= i <= r.getRating() ? "" : "text-muted opacity-25" %>"></i>
                        <% } %>
                    </div>

                    <p class="text-secondary fst-italic mb-0">"<%= r.getMessage() %>"</p>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12 text-center mt-5">
                <div class="text-muted opacity-50 mb-3">
                    <i class="fa-regular fa-face-smile fa-4x"></i>
                </div>
                <h4 class="text-muted">No reviews yet.</h4>
                <p class="small text-muted">Be the first to book and share your experience!</p>
                <a href="UserBookingServlet" class="btn btn-outline-secondary rounded-pill mt-2">Book Now</a>
            </div>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>