// Inside AdminServlet.java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action"); // Optional if you have multiple forms

    // SIMPLE LOGIN LOGIC (You can upgrade this to DB check later)
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    if ("admin".equals(user) && "admin123".equals(pass)) {
        // Login Success: Create session and go to dashboard
        HttpSession session = request.getSession();
        session.setAttribute("role", "admin");
        response.sendRedirect("adminDashboard.jsp");
    } else {
        // Login Failed: Go back to login
        response.sendRedirect("adminLogin.jsp?error=InvalidCredentials");
    }
}
