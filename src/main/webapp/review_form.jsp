<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Write a Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* --- FRIENDLY PURPLE THEME --- */
        body { background-color: #f8f0fc; font-family: 'Segoe UI', sans-serif; }

        /* --- CONTENT WRAPPER ANIMATION --- */
        .main-content {
            margin-left: 0; /* Default Closed */
            padding: 2rem;
            width: 100%;
            transition: margin-left 0.3s ease;

            /* Center the form */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Open State */
        body.sidebar-open .main-content {
            margin-left: 260px;
        }

        .review-card { width: 100%; max-width: 500px; border-radius: 30px; border: none; box-shadow: 0 15px 35px rgba(155, 89, 182, 0.15); padding: 2rem; background: white; text-align: center; }
        h3 { color: #9b59b6; font-weight: 800; }
        .btn-purple { background-color: #9b59b6; border: none; border-radius: 50px; padding: 12px; font-weight: 700; width: 100%; color: white; transition: 0.3s; }
        .btn-purple:hover { background-color: #8e44ad; transform: translateY(-3px); }
        .form-control, .form-select { border-radius: 15px; border: 1px solid #e0d0e8; padding: 12px; }
        .form-control:focus { border-color: #9b59b6; box-shadow: 0 0 0 0.2rem rgba(155, 89, 182, 0.2); }
    </style>
</head>
<body>

<jsp:include page="customer_sidebar.jsp" />

<div class="main-content">
    <div class="card review-card">
        <div class="mb-3" style="color: #9b59b6;">
            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-chat-heart-fill" viewBox="0 0 16 16">
                <path d="M8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6-.097 1.016-.417 2.13-.771 2.966-.079.186.074.394.273.362 2.256-.37 3.597-.938 4.18-1.234A9.06 9.06 0 0 0 8 15Zm0-9.007c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z"/>
            </svg>
        </div>
        <h3>Rate Your Experience</h3>
        <p class="text-muted small mb-4">How was the cleaning service?</p>

        <form action="submitReview" method="post">

            <input type="hidden" name="bookingId" value="<%= request.getParameter("bookingId") %>">

            <div class="mb-3 text-start">
                <label class="fw-bold text-muted small ms-2">Rating</label>
                <select name="rating" class="form-select">
                    <option value="5">⭐⭐⭐⭐⭐ (Perfect!)</option>
                    <option value="4">⭐⭐⭐⭐ (Good)</option>
                    <option value="3">⭐⭐⭐ (Okay)</option>
                    <option value="2">⭐⭐ (Not great)</option>
                    <option value="1">⭐ (Bad)</option>
                </select>
            </div>

            <div class="mb-4 text-start">
                <label class="fw-bold text-muted small ms-2">Your Feedback</label>
                <textarea name="message" class="form-control" rows="3" placeholder="Tell us what you liked..." required></textarea>
            </div>

            <button type="submit" class="btn btn-purple">Submit Review</button>
            <a href="UserBookingServlet?action=history" class="btn btn-link text-decoration-none mt-3" style="color: #9b59b6; font-weight: 600;">Cancel</a>
        </form>
    </div>
</div>

</body>
</html>