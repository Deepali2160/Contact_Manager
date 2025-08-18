<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Manager | Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/login.css">
    <script src="assets/js/login.js" defer></script>
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
        <p>Login to access your contacts securely</p>
    </div>

    <div class="auth-section">
        <h2>Sign In</h2>
        <form action="login" method="post">
            <div class="auth-options">
                <input type="email" name="email" placeholder="Email Address" required class="btn register-btn">
                <input type="password" name="password" placeholder="Password" required class="btn register-btn">
                <button type="submit" class="btn login-btn">
                    <i class="fas fa-sign-in-alt"></i> Sign In
                </button>
            </div>
            <p style="margin-top: 20px; text-align:center; font-size:0.9rem;">
                Don't have an account? <a href="register.jsp" style="color: var(--btn-light-text); text-decoration: underline;">Create Account</a>
            </p>
        </form>
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