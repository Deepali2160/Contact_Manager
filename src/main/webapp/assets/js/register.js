
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
