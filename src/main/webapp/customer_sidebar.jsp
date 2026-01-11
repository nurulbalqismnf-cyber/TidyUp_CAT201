<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* 1. SIDEBAR - CLOSED BY DEFAULT */
    .sidebar {
        height: 100vh;
        width: 260px;
        position: fixed;
        top: 0;
        left: -260px; /* Hidden off-screen */
        background-color: #ffffff;
        padding-top: 2rem;
        box-shadow: 2px 0 15px rgba(0,0,0,0.05);
        z-index: 1000;
        display: flex;
        flex-direction: column;
        transition: left 0.3s ease; /* Smooth slide animation */
    }

    /* 2. OPEN STATE (Triggered by JS) */
    body.sidebar-open .sidebar {
        left: 0; /* Slide in */
    }

    /* 3. FLOATING TOGGLE BUTTON (Hamburger) */
    .btn-toggle-sidebar {
        position: fixed;
        top: 25px;
        left: 25px;
        z-index: 1050; /* Stays above everything */
        width: 45px;
        height: 45px;
        border: none;
        border-radius: 50%;
        background: white;
        color: #9b59b6;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
        cursor: pointer;
        transition: all 0.2s;
    }

    .btn-toggle-sidebar:hover {
        background-color: #9b59b6;
        color: white;
        transform: scale(1.1);
    }

    /* Sidebar Content Styles */
    .sidebar-logo {
        text-align: center;
        color: #9b59b6;
        font-weight: 800;
        font-size: 1.8rem;
        margin-bottom: 3rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .sidebar-menu { list-style: none; padding: 0; margin: 0; flex-grow: 1; }
    .sidebar-menu li { margin-bottom: 0.5rem; }

    .sidebar-link {
        display: flex; align-items: center; padding: 15px 30px;
        color: #5b3256; text-decoration: none; font-weight: 600;
        transition: all 0.3s ease; border-left: 5px solid transparent;
    }
    .sidebar-link i { margin-right: 15px; font-size: 1.2rem; width: 25px; text-align: center; }
    .sidebar-link:hover { background-color: #f8f0fc; color: #9b59b6; border-left: 5px solid #9b59b6; }

    .sidebar-footer { padding: 2rem; border-top: 1px solid #eee; }
    .btn-logout {
        width: 100%; padding: 12px; border-radius: 50px;
        border: 2px solid #9b59b6; color: #9b59b6;
        background: transparent; font-weight: 700; transition: 0.3s;
    }
    .btn-logout:hover { background: #9b59b6; color: white; }
</style>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<button class="btn-toggle-sidebar" onclick="toggleSidebar()">
    <i class="fa-solid fa-bars"></i>
</button>

<div class="sidebar">
    <div class="sidebar-logo">
        <i class="fa-solid fa-broom"></i> TidyUp
    </div>

    <ul class="sidebar-menu">
        <li>
            <a href="UserBookingServlet" class="sidebar-link">
                <i class="fa-solid fa-house"></i> Browse Services
            </a>
        </li>
        <li>
            <a href="UserBookingServlet?action=history" class="sidebar-link">
                <i class="fa-solid fa-clock-rotate-left"></i> My History
            </a>
        </li>
        <li>
            <a href="UserBookingServlet?action=reviews" class="sidebar-link">
                <i class="fa-solid fa-star"></i> My Reviews
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="UserBookingServlet?action=logout" class="btn btn-logout text-center text-decoration-none">
            <i class="fa-solid fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>

<script>
    function toggleSidebar() {
        document.body.classList.toggle('sidebar-open');
    }
</script>