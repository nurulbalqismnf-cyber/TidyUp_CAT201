<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 1/5/2026
  Time: 11:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join TidyUp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>

        :root {
            --primary-purple: #9b59b6;
            --purple-hover: #8e44ad;
            --light-purple-bg: #f8f0fc;
            --dark-text: #5b3256;
            --soft-shadow: 0 15px 35px rgba(155, 89, 182, 0.15);
        }
        body {
            background-color: var(--light-purple-bg);
            display: flex; align-items: center; justify-content: center;
            min-height: 100vh; font-family: 'Segoe UI', Roboto, sans-serif;
        }
        .login-card {
            width: 100%; max-width: 420px; border-radius: 30px;
            border: none; box-shadow: var(--soft-shadow); padding: 2rem; background: white;
        }
        h3.purple-heading { color: var(--primary-purple); font-weight: 800; }
        p.purple-muted { color: var(--dark-text); opacity: 0.7; }
        .purple-icon { color: var(--primary-purple); }

        .btn-purple {
            background-color: var(--primary-purple); border: none; border-radius: 50px;
            padding: 14px; font-weight: 700; letter-spacing: 0.5px; transition: all 0.3s ease;
        }
        .btn-purple:hover {
            background-color: var(--purple-hover); transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(155, 89, 182, 0.3);
        }
        .form-control { border-radius: 15px; border: 1px solid #e0d0e8; padding: 1rem 0.75rem; }
        .form-control:focus { border-color: var(--primary-purple); box-shadow: 0 0 0 0.25rem rgba(155, 89, 182, 0.25); }
        .form-floating label { padding-left: 1rem; color: #a0a0a0; }
        .purple-link { color: var(--primary-purple); text-decoration: none; font-weight: 700; transition: color 0.2s; }
        .purple-link:hover { color: var(--purple-hover); text-decoration: underline; }
    </style>
</head>
<body>

<div class="card login-card animate__animated animate__fadeInUp">
    <div class="card-body text-center p-0">
        <div class="mb-4 purple-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-person-plus-fill" viewBox="0 0 16 16">
                <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
            </svg>
        </div>

        <h3 class="mb-2 purple-heading">Join TidyUp</h3>
        <p class="purple-muted small mb-5">Create your account in seconds.</p>

        <form action="register" method="post">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="regUser" name="username" placeholder="Choose Username" required>
                <label for="regUser">Choose Username</label>
            </div>
            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="regPass" name="password" placeholder="Choose Password" required>
                <label for="regPass">Choose Password</label>
            </div>

            <button type="submit" class="btn btn-primary btn-purple w-100 mb-4">Create Account</button>

            <div class="purple-muted small">
                Already a member? <a href="login.jsp" class="purple-link">Sign In here</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>