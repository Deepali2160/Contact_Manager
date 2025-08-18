<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Manager | Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/register.css">
    <script src="assets/js/register.js" defer></script>
</head>
<body>

<!-- Mode Toggle -->
<div class="mode-toggle-icon" id="modeToggle">
    <i class="fas fa-moon"></i>
    <i class="fas fa-sun"></i>
</div>

<!-- Main Container -->
<div class="container">
    <div class="decor"></div>
    <div class="decor-2"></div>

    <div class="header">
        <div class="logo">
            <i class="fas fa-address-book"></i>
        </div>
        <h1>Contact Manager</h1>
        <p>Create your account to get started</p>
    </div>

    <div class="auth-section">
        <h2>Create Account</h2>

        <!-- Error message -->
        <% String error = request.getParameter("error");
           if (error != null) { %>
            <div class="alert">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="auth-options">
                <input type="text" name="name" placeholder="Full Name" required class="btn input-btn">
                <input type="email" name="email" placeholder="Email Address" required class="btn input-btn">
                <input type="password" id="password" name="password" placeholder="Password" required class="btn input-btn">

                <!-- Password strength indicator -->
                <div class="password-strength">
                    <span>Password strength:</span>
                    <div class="password-strength-meter">
                        <div class="password-strength-fill" id="passwordStrength"></div>
                    </div>
                </div>

                <button type="submit" class="btn register-btn">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </div>
        </form>

        <p class="login-link">
            Already have an account? <a href="login.jsp">Sign in</a>
        </p>
    </div>

    <!-- Footer at the bottom of the container -->
    <div class="footer">
       <a href="privacypolicy.jsp">Privacy Policy</a>
                               <a href="termsofservice.jsp">Terms of Service</a>
                               <a href="contactsupport.jsp">Contact Support</a>
        <p>&copy; 2025 Contact Manager App. All rights reserved.</p>
    </div>
</div>


</body>
</html>