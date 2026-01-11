<%--
  Created by IntelliJ IDEA.
  User: nurulbalqis
  Date: 4/1/2026
  Time: 4:52 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- SIMPLE SESSION CLEAR: Logic to handle logout automatically --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TidyUp Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-purple: #9b59b6;  /* The main soft purple color */
            --purple-hover: #8e44ad;    /* Slightly darker for hover states */
            --light-purple-bg: #f8f0fc; /* Very pale background tint */
            --dark-text: #5b3256;       /* Softer than pure black text */
            --soft-shadow: 0 15px 35px rgba(155, 89, 182, 0.15); /* Purple-tinted shadow */
        }

        body {
            background-color: var(--light-purple-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            border-radius: 30px;
            border: none;
            box-shadow: var(--soft-shadow);
            padding: 2.5rem;
            background: white;
        }

        h3.purple-heading { color: var(--primary-purple); font-weight: 800; font-size: 2rem; }
        p.purple-muted { color: var(--dark-text); opacity: 0.8; font-size: 1.1rem; line-height: 1.5; }
        .purple-icon { color: var(--primary-purple); }

        .btn-purple {
            background-color: var(--primary-purple);
            border: none;
            border-radius: 50px;
            padding: 14px;
            font-weight: 700;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-purple:hover {
            background-color: var(--purple-hover);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(155, 89, 182, 0.3);
        }

        .form-control {
            border-radius: 15px;
            border: 1px solid #e0d0e8;
            padding: 1rem 0.75rem;
        }
        .form-control:focus {
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 0.25rem rgba(155, 89, 182, 0.25);
        }
        .form-floating label { padding-left: 1rem; color: #a0a0a0; }

        .purple-link { color: var(--primary-purple); text-decoration: none; font-weight: 700; transition: color 0.2s; }
        .purple-link:hover { color: var(--purple-hover); text-decoration: underline; }
    </style>
</head>
<body>

<div class="card login-card animate__animated animate__fadeInUp">
    <div class="card-body text-center p-0">
        <div class="mb-3 purple-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-stars" viewBox="0 0 16 16">
                <path d="M7.657 6.247c.11-.33.576-.33.686 0l.645 1.937a2.89 2.89 0 0 0 1.829 1.828l1.936.645c.33.11.33.576 0 .686l-1.937.645a2.89 2.89 0 0 0-1.828 1.829l-.645 1.936a.361.361 0 0 1-.686 0l-.645-1.937a2.89 2.89 0 0 0-1.828-1.828l-1.937-.645a.361.361 0 0 1 0-.686l1.937-.645a2.89 2.89 0 0 0 1.828-1.828l.645-1.937zM3.794 1.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387A1.734 1.734 0 0 0 4.593 5.69l-.387 1.162a.217.217 0 0 1-.412 0L3.407 5.69A1.734 1.734 0 0 0 2.31 4.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387A1.734 1.734 0 0 0 3.407 2.31l.387-1.162zM10.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732L9.1 2.137a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L10.863.1z"/>
            </svg>
        </div>

        <h3 class="mb-2 purple-heading">Welcome to TidyUp!</h3>
        <p class="purple-muted mb-4">
            Perfect for your lazy days.<br>
            <strong>We clean, you chill.</strong> ☕
        </p>

        <% if ("invalid".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger rounded-pill small" role="alert">
            Oops! Unknown username or password.
        </div>
        <% } %>
        <% if ("registered".equals(request.getParameter("msg"))) { %>
        <div class="alert alert-success rounded-pill small" role="alert" style="background-color: #d4edda; color: #155724; border-color: #c3e6cb;">
            Account created! Ready to relax?
        </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingInput" name="username" placeholder="Username" required>
                <label for="floatingInput">Username</label>
            </div>
            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required>
                <label for="floatingPassword">Password</label>
            </div>

            <button type="submit" class="btn btn-primary btn-purple w-100 mb-4">Let's Get Tidy</button>

            <div class="purple-muted small">
                Too lazy to type? <a href="register.jsp" class="purple-link">Join us here</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>