<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Welcome to TidyUp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <style>
        /* Special styles just for the Landing Page */
        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .hero-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 3rem;
            border-radius: 25px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 90%;
            border-top: 5px solid #11998e; /* Teal accent */
        }

        .btn-enter {
            background: linear-gradient(90deg, #11998e 0%, #38ef7d 100%);
            border: none;
            color: white;
            padding: 15px 40px;
            font-size: 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-enter:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(56, 239, 125, 0.4);
            color: white;
        }
    </style>
</head>
<body>

<div class="container hero-section">
    <div class="hero-card">
        <div class="mb-4 text-success">
            <i class="fa-solid fa-broom fa-4x"></i>
        </div>

        <h1 class="fw-bold mb-3 display-5">Welcome to TidyUp</h1>

        <p class="text-muted lead mb-5">
            Professional home cleaning services at your fingertips. <br>
            Manage your services, orders, and customers in one place.
        </p>

        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
            <a href="login.jsp" class="btn btn-enter">
                <i class="fa-solid fa-user-shield me-2"></i> Admin Portal
            </a>

        </div>

        <p class="mt-5 text-muted small">© 2026 TidyUp Services. All rights reserved.</p>
    </div>
</div>

</body>
</html>