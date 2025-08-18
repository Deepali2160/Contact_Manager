
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
             const table = document.querySelector('.contacts-container');
                table.style.display = 'none';
                table.offsetHeight; // Trigger reflow
                table.style.display = '';
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

        // Bulk actions functionality
        const selectAllCheckbox = document.getElementById('selectAll');
        const contactCheckboxes = document.querySelectorAll('.contact-checkbox');
        const bulkActions = document.getElementById('bulkActions');
        const selectedCount = document.getElementById('selectedCount');
        const deleteSelectedBtn = document.getElementById('deleteSelected');
        const exportSelectedBtn = document.getElementById('exportSelected');
        const cancelSelectionBtn = document.getElementById('cancelSelection');

        // Select/Deselect All
        selectAllCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            contactCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            updateBulkActions();
        });

        // Individual checkbox change
        contactCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateBulkActions);
        });

        // Update bulk actions display
        function updateBulkActions() {
            const selectedCountValue = document.querySelectorAll('.contact-checkbox:checked').length;
            selectedCount.textContent = `${selectedCountValue} selected`;

            if (selectedCountValue > 0) {
                bulkActions.classList.add('visible');
            } else {
                bulkActions.classList.remove('visible');
                selectAllCheckbox.checked = false;
            }
        }

        // Delete selected contacts
        deleteSelectedBtn.addEventListener('click', function() {
            const selectedIds = [];
            document.querySelectorAll('.contact-checkbox:checked').forEach(checkbox => {
                selectedIds.push(checkbox.value);
            });

            if (selectedIds.length === 0) {
                alert('Please select at least one contact to delete');
                return;
            }

            if (confirm(`Are you sure you want to delete ${selectedIds.length} selected contact(s)?`)) {
                // Create a form to submit the selected IDs
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'deleteMultipleContacts';

                selectedIds.forEach(id => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'contactIds';
                    input.value = id;
                    form.appendChild(input);
                });

                document.body.appendChild(form);
                form.submit();
            }
        });

        // Export selected contacts
        exportSelectedBtn.addEventListener('click', function() {
            const selectedIds = [];
            document.querySelectorAll('.contact-checkbox:checked').forEach(checkbox => {
                selectedIds.push(checkbox.value);
            });

            if (selectedIds.length === 0) {
                alert('Please select at least one contact to export');
                return;
            }

            // Create a form to submit the selected IDs
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'exportContacts';

            selectedIds.forEach(id => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'contactIds';
                input.value = id;
                form.appendChild(input);
            });

            document.body.appendChild(form);
            form.submit();
        });

        // Cancel selection
        cancelSelectionBtn.addEventListener('click', function() {
            resetSelection();
        });

        // Reset selection
        function resetSelection() {
            selectAllCheckbox.checked = false;
            contactCheckboxes.forEach(checkbox => {
                checkbox.checked = false;
            });
            bulkActions.classList.remove('visible');
        }

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase();
            const rows = document.querySelectorAll('#contactsTableBody tr');

            rows.forEach(row => {
                if (row.cells.length > 1) {
                    const name = row.cells[2].textContent.toLowerCase();
                    const email = row.cells[3].textContent.toLowerCase();
                    const phone = row.cells[4].textContent.toLowerCase();
                    const category = row.cells[6].textContent.toLowerCase();

                    if (name.includes(query) || email.includes(query) || phone.includes(query) || category.includes(query)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            });
        });

        // Pagination functionality
        const prevPageBtn = document.getElementById('prevPage');
        const nextPageBtn = document.getElementById('nextPage');
        const currentPageElement = document.getElementById('currentPage');
        const totalPagesElement = document.getElementById('totalPages');

        let currentPage = 1;
        const rowsPerPage = 5;
        const rows = Array.from(document.querySelectorAll('#contactsTableBody tr')).filter(row => row.style.display !== 'none');
        const totalPages = Math.ceil(rows.length / rowsPerPage);

        totalPagesElement.textContent = totalPages;

        function updatePagination() {
            // Hide all rows
            rows.forEach(row => row.style.display = 'none');

            // Calculate start and end indices
            const start = (currentPage - 1) * rowsPerPage;
            const end = Math.min(start + rowsPerPage, rows.length);

            // Show rows for current page
            for (let i = start; i < end; i++) {
                rows[i].style.display = '';
            }

            // Update pagination controls
            currentPageElement.textContent = currentPage;
            prevPageBtn.disabled = currentPage === 1;
            nextPageBtn.disabled = currentPage === totalPages;
        }

        prevPageBtn.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                updatePagination();
            }
        });

        nextPageBtn.addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                updatePagination();
            }
        });

        // Initialize pagination
        if (totalPages > 1) {
            updatePagination();
        }

        // Initialize theme on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set navbar background based on scroll position
            updateNavbarBackground();
        });
