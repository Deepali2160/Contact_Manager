<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Manager | Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            /* Light Mode Variables */
            --bg-gradient-light: linear-gradient(135deg, #f0f4ff 0%, #e8e1f7 100%);
            --text-color-light: #333;
            --text-secondary-light: #555;
            --card-bg-light: rgba(255, 255, 255, 0.85);
            --card-border-light: rgba(0, 0, 0, 0.05);
            --feature-bg-light: rgba(255, 255, 255, 0.65);
            --feature-border-light: rgba(0, 0, 0, 0.03);
            --btn-light-bg: rgba(255, 255, 255, 0.95);
            --btn-light-text: #6a11cb;
            --btn-light-border: rgba(106, 17, 203, 0.1);
            --logo-bg-light: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --logo-shadow-light: 0 8px 20px rgba(106, 17, 203, 0.2);
            --feature-icon-light: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --feature-icon-shadow-light: 0 5px 15px rgba(106, 17, 203, 0.15);

            /* Dark Mode Variables */
            --bg-gradient-dark: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --text-color-dark: white;
            --text-secondary-dark: rgba(255, 255, 255, 0.85);
            --card-bg-dark: rgba(255, 255, 255, 0.08);
            --card-border-dark: rgba(255, 255, 255, 0.15);
            --feature-bg-dark: rgba(255, 255, 255, 0.1);
            --feature-border-dark: rgba(255, 255, 255, 0.1);
            --btn-dark-bg: rgba(255, 255, 255, 0.15);
            --btn-dark-text: white;
            --btn-dark-border: rgba(255, 255, 255, 0.3);
            --logo-bg-dark: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --logo-shadow-dark: 0 8px 20px rgba(106, 17, 203, 0.4);
            --feature-icon-dark: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --feature-icon-shadow-dark: 0 5px 15px rgba(106, 17, 203, 0.3);
            --accent-color: #f72585;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: var(--bg-gradient-dark);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            font-family: 'Poppins', sans-serif;
            color: var(--text-color-dark);
            overflow: hidden;
            transition: background 0.5s ease, color 0.5s ease;
        }

        body.light-mode {
            background: var(--bg-gradient-light);
            color: var(--text-color-light);
        }

        .container {
            width: 100%;
            max-width: 500px;
            height: auto;
            min-height: 650px;
            background: var(--card-bg-dark);
            backdrop-filter: blur(12px);
            border-radius: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            border: 1px solid var(--card-border-dark);
            position: relative;
            display: flex;
            flex-direction: column;
            transition: background 0.5s ease, border-color 0.5s ease;
        }

        .light-mode .container {
            background: var(--card-bg-light);
            border-color: var(--card-border-light);
        }

        .decor {
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: linear-gradient(45deg, rgba(118, 75, 162, 0.2), rgba(102, 126, 234, 0.2));
            top: -150px;
            right: -150px;
            z-index: 0;
            transition: background 0.5s ease;
        }

        .light-mode .decor {
            background: linear-gradient(45deg, rgba(118, 75, 162, 0.08), rgba(102, 126, 234, 0.08));
        }

        .decor-2 {
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: linear-gradient(45deg, rgba(255, 255, 255, 0.1), rgba(118, 75, 162, 0.1));
            bottom: -100px;
            left: -100px;
            z-index: 0;
            transition: background 0.5s ease;
        }

        .light-mode .decor-2 {
            background: linear-gradient(45deg, rgba(118, 75, 162, 0.05), rgba(102, 126, 234, 0.05));
        }

        .header {
            padding: 40px 30px 20px;
            text-align: center;
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .logo {
            width: 70px;
            height: 70px;
            background: var(--logo-bg-dark);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            box-shadow: var(--logo-shadow-dark);
            transform: rotate(45deg);
            animation: float 6s ease-in-out infinite;
            transition: background 0.5s ease, box-shadow 0.5s ease;
        }

        .light-mode .logo {
            background: var(--logo-bg-light);
            box-shadow: var(--logo-shadow-light);
        }

        .logo i {
            font-size: 2.5rem;
            color: white;
            transform: rotate(-45deg);
        }

        .header h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 2.2rem;
            margin-bottom: 10px;
            font-weight: 800;
            background: linear-gradient(to right, #ffffff, #e0e0ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -0.5px;
            transition: background 0.5s ease;
        }

        .light-mode .header h1 {
            background: linear-gradient(to right, #333, #555);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header p {
            font-size: 1rem;
            color: var(--text-secondary-dark);
            max-width: 600px;
            margin: 0 auto;
            font-weight: 300;
            line-height: 1.5;
            transition: color 0.5s ease;
        }

        .light-mode .header p {
            color: var(--text-secondary-light);
        }

        .auth-section {
            background: var(--feature-bg-dark);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 30px;
            margin: 0 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            display: flex;
            flex-direction: column;
            justify-content: center;
            border: 1px solid var(--feature-border-dark);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            z-index: 2;
        }

        .light-mode .auth-section {
            background: var(--feature-bg-light);
            border: 1px solid var(--feature-border-light);
        }

        .auth-section:hover {
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }

        .light-mode .auth-section:hover {
            background: rgba(255, 255, 255, 0.8);
        }

        .auth-section h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.8rem;
            margin-bottom: 25px;
            color: var(--accent-color);
            text-align: center;
            position: relative;
            z-index: 2;
            font-weight: 700;
            transition: color 0.5s ease;
        }

        .auth-section h2:after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, #ff9a9e, #fad0c4);
            border-radius: 2px;
        }

        .auth-options {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin: 20px 0;
            position: relative;
            z-index: 2;
        }

        .btn {
            padding: 16px 20px;
            border-radius: 15px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            outline: none;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            z-index: -1;
            transform: translateX(-100%);
            transition: transform 0.4s ease;
        }

        .btn:hover:before {
            transform: translateX(0);
        }

        .register-btn {
           background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            box-shadow: 0 8px 25px rgba(106, 17, 203, 0.4);
        }

        .register-btn:hover {
            background: linear-gradient(to right, #e01e78, #6508a5);
            transform: translateY(-3px);
        }

        .input-btn {
            background: var(--btn-dark-bg);
            color: var(--btn-dark-text);
            border: 2px solid var(--btn-dark-border);
            transition: background 0.5s ease, color 0.5s ease, border-color 0.5s ease;
            text-align: center;
        }

        .light-mode .input-btn {
            background: var(--btn-light-bg);
            color: var(--btn-light-text);
            border: 2px solid var(--btn-light-border);
        }

        .input-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-3px);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .light-mode .input-btn:hover {
            background: rgba(255, 255, 255, 0.9);
            border-color: rgba(106, 17, 203, 0.2);
        }

        .btn i {
            font-size: 1.1rem;
        }

        .footer {
            text-align: center;
            padding: 20px 15px 15px;
            color: var(--text-secondary-dark);
            font-size: 0.8rem;
            border-top: 1px solid var(--feature-border-dark);
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
            margin-top: auto;
            transition: color 0.5s ease, border-color 0.5s ease;
            position: relative;
            z-index: 2;
        }

        .light-mode .footer {
            color: var(--text-secondary-light);
            border-top: 1px solid var(--feature-border-light);
        }

        .footer a {
            color: var(--text-secondary-dark);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .light-mode .footer a {
            color: var(--text-secondary-light);
        }

        .footer a:hover {
            color: var(--text-color-dark);
            text-decoration: underline;
        }

        .light-mode .footer a:hover {
            color: var(--text-color-light);
        }

        @keyframes float {
            0% { transform: rotate(45deg) translateY(0); }
            50% { transform: rotate(45deg) translateY(-10px); }
            100% { transform: rotate(45deg) translateY(0); }
        }

        /* Mode Toggle Icon */
        .mode-toggle-icon {
            position: absolute;
            top: 30px;
            right: 30px;
            width: 42px;
            height: 42px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .light-mode .mode-toggle-icon {
            background: rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.1);
        }

        .mode-toggle-icon:hover {
            transform: scale(1.1) rotate(15deg);
            background: rgba(255, 255, 255, 0.25);
        }

        .light-mode .mode-toggle-icon:hover {
            background: rgba(0, 0, 0, 0.1);
        }

        .mode-toggle-icon i {
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }

        .mode-toggle-icon .fa-moon {
            color: rgba(255, 255, 255, 0.9);
        }

        .mode-toggle-icon .fa-sun {
            color: #ffc107;
            display: none;
        }

        .light-mode .mode-toggle-icon .fa-moon {
            display: none;
        }

        .light-mode .mode-toggle-icon .fa-sun {
            display: block;
        }

        /* Password strength indicator */
        .password-strength {
            margin-top: 0.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .password-strength-meter {
            height: 4px;
            flex-grow: 1;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            overflow: hidden;
        }

        .password-strength-fill {
            height: 100%;
            width: 0%;
            background: #06d6a0;
            transition: width 0.3s ease;
        }

        /* Responsive adjustments */
        @media (max-width: 600px) {
            .container {
                max-width: 95%;
                min-height: 600px;
            }

            .header {
                padding: 30px 20px 15px;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .header p {
                font-size: 0.9rem;
            }

            .auth-section {
                padding: 20px;
                margin: 0 15px;
            }

            .btn {
                padding: 14px 18px;
                font-size: 0.9rem;
            }

            .footer {
                flex-direction: column;
                gap: 8px;
                padding: 15px 10px;
            }

            .mode-toggle-icon {
                top: 20px;
                right: 20px;
                width: 36px;
                height: 36px;
            }
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            text-align: center;
            background: transparent;
            color: var(--text-color-dark);
            font-family: 'Poppins', sans-serif;
        }

        .light-mode input[type="text"],
        .light-mode input[type="email"],
        .light-mode input[type="password"] {
            color: var(--text-color-light);
        }

        input::placeholder {
            color: var(--text-secondary-dark);
        }

        .light-mode input::placeholder {
            color: var(--text-secondary-light);
        }

        .login-link {
            margin-top: 15px;
            text-align: center;
            color: var(--text-secondary-dark);
            font-size: 0.9rem;
        }

        .light-mode .login-link {
            color: var(--text-secondary-light);
        }

        .login-link a {
            color: white;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 12px;
            border-radius: 12px;
            margin-bottom: 20px;
            text-align: center;
            background: rgba(255, 107, 107, 0.15);
            border: 1px solid rgba(255, 107, 107, 0.3);
            color: #ff6b6b;
            font-size: 0.9rem;
        }
        .auth-section h2 {
            color: white !important;
        }

        .light-mode .auth-section h2 {
            color: black !important;
        }

        .auth-section h2::after {
            background: linear-gradient(to right, #ff9a9e, #fad0c4);
        }

        .light-mode .auth-section h2::after {
            background: linear-gradient(to right, #000000, #444444);
        }
        .login-link a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        body.light-mode .login-link a {
            color: black !important;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

    </style>
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
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Contact Support</a>
        <p>&copy; 2025 Contact Manager App. All rights reserved.</p>
    </div>
</div>

<script>
    // Animation for form on load
    document.addEventListener('DOMContentLoaded', function() {
        const authSection = document.querySelector('.auth-section');

        // Animate auth section
        setTimeout(() => {
            authSection.style.opacity = "1";
            authSection.style.transform = "translateY(0)";
        }, 300);

        authSection.style.opacity = "0";
        authSection.style.transform = "translateY(20px)";
        authSection.style.transition = "opacity 0.8s ease, transform 0.8s ease";

        // Button hover effects
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(btn => {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px)';
            });
            btn.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Mode toggle functionality
        const modeToggle = document.getElementById('modeToggle');
        const body = document.body;

        // Check for saved preference
        const savedMode = localStorage.getItem('mode');
        if (savedMode === 'light') {
            body.classList.add('light-mode');
        }

        modeToggle.addEventListener('click', () => {
            body.classList.toggle('light-mode');

            // Save preference
            if (body.classList.contains('light-mode')) {
                localStorage.setItem('mode', 'light');
            } else {
                localStorage.setItem('mode', 'dark');
            }

            // Add animation effect
            modeToggle.style.transform = 'scale(1.2)';
            setTimeout(() => {
                modeToggle.style.transform = '';
            }, 300);
        });

        // Password strength indicator
        const passwordInput = document.getElementById('password');
        const passwordStrength = document.getElementById('passwordStrength');

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            let strength = 0;

            // Length check
            if (password.length > 7) strength += 25;

            // Lowercase check
            if (/[a-z]/.test(password)) strength += 25;

            // Uppercase check
            if (/[A-Z]/.test(password)) strength += 25;

            // Number/special char check
            if (/[0-9!@#$%^&*]/.test(password)) strength += 25;

            // Update visual indicator
            passwordStrength.style.width = strength + '%';

            // Color coding
            if (strength < 50) {
                passwordStrength.style.background = '#ff6b6b';
            } else if (strength < 75) {
                passwordStrength.style.background = '#ffd166';
            } else {
                passwordStrength.style.background = '#06d6a0';
            }
        });
    });
</script>
</body>
</html>