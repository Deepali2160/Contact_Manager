<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Manager | Professional Design</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/index.css">
    <script src="assets/js/index.js" defer></script>
</head>
<body>
<!--switch between dark/light themes, managed by JavaScript-->
    <div class="mode-toggle-icon" id="modeToggle">
        <i class="fas fa-moon"></i>
        <i class="fas fa-sun"></i>
    </div>

    <div class="container">
        <div class="decor"></div>
        <div class="decor-2"></div>

        <div class="header">
            <div class="logo">
                <i class="fas fa-address-book"></i>
            </div>
            <h1>Contact Manager</h1>
            <p>Organize all your contacts in one place</p>
        </div>

        <div class="main-content">
            <div class="features-grid">
                <div class="feature">
                    <div class="feature-header">
                        <div class="feature-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3>Organize Contacts</h3>
                    </div>
                    <p>Categorize contacts into groups and tag them for easy access. Create custom categories and labels.</p>
                </div>

                <div class="feature">
                    <div class="feature-header">
                        <div class="feature-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3>Powerful Search</h3>
                    </div>
                    <p>Find any contact instantly by name, phone, email or tags. Search across all fields simultaneously.</p>
                </div>

                <div class="feature">
                    <div class="feature-header">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Secure Storage</h3>
                    </div>
                    <p>Bank-level encryption keeps your contact data protected. Automatic backups ensure data safety.</p>
                </div>

                <div class="feature">
                    <div class="feature-header">
                        <div class="feature-icon">
                            <i class="fas fa-sync-alt"></i>
                        </div>
                        <h3>Cross-Device Sync</h3>
                    </div>
                    <p>Access contacts from any device with real-time syncing. Changes update instantly everywhere.</p>
                </div>
            </div>

            <div class="auth-section">
                <h2>Get Started</h2>
                <div class="auth-options">
                    <a href="login.jsp" class="btn login-btn">
                        <i class="fas fa-sign-in-alt"></i> Login to Account
                    </a>
                    <a href="register.jsp" class="btn register-btn">
                        <i class="fas fa-user-plus"></i> Create Account
                    </a>
                </div>
            </div>
        </div>

        <div class="footer">
            <a href="privacypolicy.jsp">Privacy Policy</a>
                        <a href="termsofservice.jsp">Terms of Service</a>
                        <a href="contactsupport.jsp">Contact Support</a>
            <p>&copy; 2025 Contact Manager App. All rights reserved.</p>
        </div>
    </div>
</body>
</html>