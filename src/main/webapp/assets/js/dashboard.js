
        // Theme toggle functionality
        const modeToggle = document.getElementById('themeToggle');
        const modeIcon = modeToggle.querySelector('i');
        const body = document.body;

        // Check for saved theme preference or respect OS preference
        const savedMode = localStorage.getItem('mode');
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

        // Apply theme on page load
        if (savedMode === 'light' || (!savedMode && !prefersDark)) {
            body.classList.add('light-mode');
            modeIcon.classList.remove('fa-moon');
            modeIcon.classList.add('fa-sun');
        } else {
            modeIcon.classList.remove('fa-sun');
            modeIcon.classList.add('fa-moon');
        }

        modeToggle.addEventListener('click', () => {
            body.classList.toggle('light-mode');

            if (body.classList.contains('light-mode')) {
                modeIcon.classList.remove('fa-moon');
                modeIcon.classList.add('fa-sun');
                localStorage.setItem('mode', 'light');
            } else {
                modeIcon.classList.remove('fa-sun');
                modeIcon.classList.add('fa-moon');
                localStorage.setItem('mode', 'dark');
            }

            // Update navbar background after theme change
            updateNavbarBackground();
        });

        // Navbar scroll effect
        const navbar = document.querySelector('.navbar');

        function updateNavbarBackground() {
            if (window.scrollY > 50) {
                navbar.style.background = body.classList.contains('light-mode')
                    ? 'rgba(255, 255, 255, 0.95)'
                    : 'rgba(26, 32, 55, 0.95)';
            } else {
                navbar.style.background = body.classList.contains('light-mode')
                    ? 'rgba(255, 255, 255, 0.9)'
                    : 'rgba(26, 32, 55, 0.85)';
            }
        }

        window.addEventListener('scroll', updateNavbarBackground);

        // Counter animation for stats
        const counters = document.querySelectorAll('.stat-value');
        const speed = 200;

        counters.forEach(counter => {
            const animate = () => {
                const value = +counter.getAttribute('data-target');
                const data = +counter.innerText.replace(/,/g, '');
                const time = value / speed;

                if(data < value) {
                    counter.innerText = Math.ceil(data + time).toLocaleString();
                    setTimeout(animate, 1);
                } else {
                    counter.innerText = value.toLocaleString();
                }
            }

            // Set initial data-target values
            const currentValue = parseInt(counter.textContent);
            counter.setAttribute('data-target', currentValue);
            counter.innerText = '0';
            animate();
        });

        // User dropdown functionality
        const userProfile = document.getElementById('userProfile');
        const userDropdown = document.getElementById('userDropdown');

        userProfile.addEventListener('click', (e) => {
            e.stopPropagation();
            userDropdown.classList.toggle('show');
        });

        // Close dropdown when clicking elsewhere
        document.addEventListener('click', (e) => {
            if (!userProfile.contains(e.target)) {
                userDropdown.classList.remove('show');
            }
        });

        // Logout functionality
        const logoutBtn = document.getElementById('logoutBtn');

        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            // Show confirmation dialog
            if (confirm('Are you sure you want to logout?')) {
                // Here you would typically redirect to logout endpoint
                alert('Logout successful! Redirecting to login page...');
                window.location.href = 'login.jsp';
            }
        });

        // Initialize theme on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set navbar background based on scroll position
            updateNavbarBackground();
        });
