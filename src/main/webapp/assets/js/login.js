
    // Animation for feature cards on load
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
    });
