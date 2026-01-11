<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    #sidebar-wrapper {
        min-width: 250px;
        max-width: 250px;
        min-height: 100vh;
        transition: all 0.3s;
        background: white;
        box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        border-right: 1px solid #eee;
    }

    #sidebar-wrapper.collapsed {
        min-width: 0;
        max-width: 0;
    }

    #sidebar-wrapper.collapsed * {
        display: none;
    }

    .nav-link { color: #333; font-weight: 500; padding: 12px 20px; transition: 0.2s; display: flex; align-items: center; }
    .nav-link:hover { background-color: #f0f4f8; color: #6a11cb; text-decoration: none; }
    .nav-link i { width: 30px; font-size: 1.1rem; }
</style>

<div id="sidebar-wrapper" class="collapsed">

    <div class="p-4 mb-2">
        <span class="fs-4 fw-bold" style="color: #6a11cb;">
            <i class="fa-solid fa-broom me-2"></i> TidyUp
        </span>
    </div>

    <ul class="nav nav-pills flex-column mb-auto px-0">
        <li class="nav-item"><a href="dashboard.jsp" class="nav-link"><i class="fa-solid fa-gauge"></i> Dashboard</a></li>
        <li><a href="orders.jsp" class="nav-link"><i class="fa-solid fa-list-check"></i> Orders</a></li>
        <li><a href="services.jsp" class="nav-link"><i class="fa-solid fa-tags"></i> Services</a></li>
        <li><a href="users.jsp" class="nav-link"><i class="fa-solid fa-users"></i> Customers</a></li>
        <li><a href="settings.jsp" class="nav-link"><i class="fa-solid fa-gear"></i> Settings</a></li>
    </ul>

    <div class="p-3 border-top mt-auto">
        <div class="d-flex align-items-center text-decoration-none">

            <div class="d-flex align-items-center justify-content-center bg-secondary text-white rounded-circle me-2" style="width: 32px; height: 32px;">
                <i class="fa-solid fa-user"></i>
            </div>

            <strong class="text-dark">Admin</strong>

        </div>
    </div>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("sidebar-wrapper");
        sidebar.classList.toggle("collapsed");
    }
</script>