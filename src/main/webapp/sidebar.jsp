<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    /* Sidebar Styles */
    .sidebar {
        width: 250px;
        transition: all 0.3s;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        z-index: 1000;
        background: white;
    }

    /* Collapsed State */
    .sidebar.collapsed {
        margin-left: -250px;
    }

    /* Toggle Button Style */
    #sidebarToggle {
        position: fixed;
        left: 260px; /* Next to sidebar */
        top: 15px;
        z-index: 1001;
        transition: all 0.3s;
    }

    .sidebar.collapsed + .main-content #sidebarToggle {
        left: 15px; /* Move to edge when closed */
    }

    /* Main Content Shift */
    .main-content {
        margin-left: 250px;
        transition: all 0.3s;
        width: calc(100% - 250px);
    }

    .sidebar.collapsed + .main-content {
        margin-left: 0;
        width: 100%;
    }
</style>

<div class="sidebar d-flex flex-column p-3 bg-white shadow-sm" id="sidebar">
    <a href="dashboard.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
        <span class="fs-4 fw-bold" style="color: #6a11cb;">TidyUp Admin</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="dashboard.jsp" class="nav-link link-dark">
                <i class="fa-solid fa-gauge me-2"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="orders.jsp" class="nav-link link-dark">
                <i class="fa-solid fa-list-check me-2"></i> Orders
            </a>
        </li>
        <li>
            <a href="services.jsp" class="nav-link link-dark">
                <i class="fa-solid fa-broom me-2"></i> Services
            </a>
        </li>
        <li>
            <a href="users.jsp" class="nav-link link-dark">
                <i class="fa-solid fa-users me-2"></i> Customers
            </a>
        </li>
        <li>
            <a href="settings.jsp" class="nav-link link-dark">
                <i class="fa-solid fa-gear me-2"></i> Settings
            </a>
        </li>
    </ul>
    <hr>
    <div class="dropdown">
        <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>Admin</strong>
        </a>
        <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
            <li><a class="dropdown-item" href="logout">Sign out</a></li>
        </ul>
    </div>
</div>

<button class="btn btn-primary rounded-circle shadow" id="sidebarToggle" onclick="toggleSidebar()">
    <i class="fa-solid fa-bars"></i>
</button>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const content = document.querySelector('.main-content');
        const toggleBtn = document.getElementById('sidebarToggle');

        sidebar.classList.toggle('collapsed');

        // Adjust main content margin
        if (sidebar.classList.contains('collapsed')) {
            content.style.marginLeft = "0";
            toggleBtn.style.left = "15px";
        } else {
            content.style.marginLeft = "250px";
            toggleBtn.style.left = "260px";
        }
    }
</script>