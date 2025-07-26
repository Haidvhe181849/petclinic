<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>${accountUser != null ? 'Sửa tài khoản' : 'Tạo tài khoản mới'}</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <style>
                body {
                    background: #f8f9fa;
                }

                .form-container {
                    background: white;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                }

                .form-header {
                    text-align: center;
                    margin-bottom: 30px;
                    color: #ff3d3d;
                    font-weight: 600;
                }

                .btn-action {
                    min-width: 120px;
                }

                .btn-primary.btn-action {
                    background: #ff3d3d;
                    border: none;
                    color: #fff;
                    font-weight: 600;
                    border-radius: 8px;
                    min-width: 120px;
                    box-shadow: none;
                    transition: all 0.3s;
                }

                .btn-primary.btn-action:hover {
                    background: #d32f2f;
                }

                .password-container {
                    position: relative;
                }

                .toggle-password {
                    position: absolute;
                    top: 10px;
                    right: 10px;
                    cursor: pointer;
                }

                .swal2-popup .swal2-title,
                .swal2-popup .swal2-html-container {
                    color: #ff3d3d !important;
                }

                .swal2-icon.swal2-error {
                    border-color: #ff3d3d !important;
                    color: #ff3d3d !important;
                }

                .swal2-styled.swal2-confirm {
                    background-color: #ff3d3d !important;
                }
            </style>
        </head>

        <body>
            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="form-container">
                            <h2 class="form-header">${accountUser != null ? 'Sửa tài khoản' : 'Tạo tài khoản mới'}</h2>

                            <c:if test="${not empty alertMessage}">
                                <script>
                                    Swal.fire({
                                        icon: '${alertType == "success" ? "success" : "error"}',
                                        title: '${alertType == "success" ? "Thành công" : "Lỗi"}',
                                        text: '${alertMessage}'
                                    });
                                </script>
                            </c:if>

                            <form id="accountForm" action="account-management" method="post">
                                <input type="hidden" name="action" value="${accountUser != null ? 'edit' : 'create'}" />
                                <c:if test="${accountUser != null}">
                                    <input type="hidden" name="userId" value="${accountUser.userId}" />
                                </c:if>
                                <div class="mb-3">
                                    <label class="form-label">Tên</label>
                                    <input type="text" class="form-control" name="name"
                                        value="${accountUser != null ? accountUser.name : ''}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email"
                                        value="${accountUser != null ? accountUser.email : ''}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Username</label>
                                    <c:choose>
                                        <c:when test="${accountUser != null}">
                                            <input type="text" class="form-control" name="username"
                                                value="${accountUser.username}" readonly>
                                            <input type="hidden" name="username" value="${accountUser.username}">
                                            <small class="text-muted">Username không thể thay đổi</small>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="form-control" name="username" required>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                              
                                <c:if test="${accountUser == null}">
                                    <div class="mb-3 password-container">
                                        <label class="form-label">Nhập lại mật khẩu</label>
                                        <input type="password" class="form-control" name="confirmPassword"
                                            id="confirmPasswordInput" required autocomplete="new-password">
                                        <i class="fa-solid fa-eye-slash toggle-password" id="toggleConfirmPassword"></i>
                                    </div>
                                </c:if>
                                <div class="mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="text" class="form-control" name="phone"
                                        value="${accountUser != null ? accountUser.phone : ''}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Address</label>
                                    <input type="text" class="form-control" name="address"
                                        value="${accountUser != null ? accountUser.address : ''}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Role</label>
                                    <select class="form-control" name="roleId" required>
                                        <option value="1" ${accountUser !=null && accountUser.roleId==1 ? 'selected'
                                            : '' }>Admin</option>
<!--                                        <option value="2" ${accountUser !=null && accountUser.roleId==2 ? 'selected'
                                            : '' }>Nhân viên</option>
                                        <option value="3" ${accountUser !=null && accountUser.roleId==3 ? 'selected'
                                            : '' }>Bác sĩ</option>-->
                                        <option value="4" ${accountUser !=null && accountUser.roleId==4 ? 'selected'
                                            : '' }>Khách hàng</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Status</label>
                                    <select class="form-control" name="status">
                                        <option value="Active" ${accountUser !=null && accountUser.status eq 'Active'
                                            ? 'selected' : '' }>Active</option>
                                        <option value="Inactive" ${accountUser !=null && accountUser.status
                                            eq 'Inactive' ? 'selected' : '' }>Inactive</option>
                                    </select>
                                </div>
                                <div class="mt-4 d-flex gap-2">
                                    <button type="submit" class="btn btn-primary btn-action">Lưu</button>
                                    <a href="account-management" class="btn btn-secondary btn-action">Hủy</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                // Validate form
                function validateForm(e) {
                    const form = document.getElementById('accountForm');
                    const name = form.elements['name'].value.trim();
                    const usernameInput = form.querySelector('input[name="username"]');
                    const isEdit = usernameInput && usernameInput.hasAttribute('readonly');
                    const username = usernameInput ? usernameInput.value.trim() : '';
                    const email = form.elements['email'].value.trim();
                    const passwordInput = document.getElementById('passwordInput');
                    const password = passwordInput ? passwordInput.value : '';
                    const confirmPasswordInput = document.getElementById('confirmPasswordInput');
                    const confirmPassword = confirmPasswordInput ? confirmPasswordInput.value : '';
                    const phone = form.elements['phone'].value.trim();
                    const address = form.elements['address'].value.trim();

                    // Tên: không null, không số, không ký tự đặc biệt (luôn kiểm tra)
                    if (!name) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Tên không được để trống!' });
                        e.preventDefault(); return false;
                    }
                    if (!/^[\p{L} ]+$/u.test(name)) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Tên chỉ được chứa chữ cái và khoảng trắng!' });
                        e.preventDefault(); return false;
                    }
                    // Email: không null, không chứa ký tự đặc biệt ngoài ., @, _, - và phải đúng định dạng
                    if (!email) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Email không được để trống!' });
                        e.preventDefault(); return false;
                    }
                    // Không cho phép ký tự đặc biệt ngoài a-z, A-Z, 0-9, ., _, -, @
                    if (/[^a-zA-Z0-9._@-]/.test(email)) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Email không được chứa ký tự đặc biệt!' });
                        e.preventDefault(); return false;
                    }
                    // Phải đúng định dạng email chuẩn
                    if (!/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Email không hợp lệ!' });
                        e.preventDefault(); return false;
                    }
                    // Username: chỉ validate khi tạo mới (không readonly)
                    if (!isEdit) {
                        if (!username) {
                            Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Username không được để trống!' });
                            e.preventDefault(); return false;
                        }
                        if (!/^[a-zA-Z0-9]+$/.test(username)) {
                            Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Username chỉ được chứa chữ cái và số, không chứa ký tự đặc biệt!' });
                            e.preventDefault(); return false;
                        }
                    }
                    // Password: nếu có, phải >= 6 ký tự
                    if (passwordInput && passwordInput.hasAttribute('required') && password.length < 6) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Mật khẩu phải có ít nhất 6 ký tự!' });
                        e.preventDefault(); return false;
                    }
                    // Confirm password: nếu có, phải trùng
                    if (confirmPasswordInput && password !== confirmPassword) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Mật khẩu và nhập lại mật khẩu không khớp!' });
                        e.preventDefault(); return false;
                    }
                    // Phone: chỉ số, không null, không ký tự đặc biệt, không chữ (luôn kiểm tra)
                    if (!phone) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Số điện thoại không được để trống!' });
                        e.preventDefault(); return false;
                    }
                    if (!/^\d+$/.test(phone)) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Số điện thoại chỉ được chứa số, không được chứa chữ hoặc ký tự đặc biệt!' });
                        e.preventDefault(); return false;
                    }
                    // Address: không null
                    if (!address) {
                        Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Địa chỉ không được để trống!' });
                        e.preventDefault(); return false;
                    }
                    return true;
                }

                document.getElementById('accountForm').addEventListener('submit', function (e) {
                    validateForm(e);
                });

                // Toggle password visibility
                document.getElementById('togglePassword').addEventListener('click', function () {
                    const pwInput = document.getElementById('passwordInput');
                    const pwIcon = this;
                    if (pwInput.type === 'password') {
                        pwInput.type = 'text';
                        pwIcon.classList.remove('fa-eye-slash');
                        pwIcon.classList.add('fa-eye');
                    } else {
                        pwInput.type = 'password';
                        pwIcon.classList.remove('fa-eye');
                        pwIcon.classList.add('fa-eye-slash');
                    }
                });

                const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
                if (toggleConfirmPassword) {
                    toggleConfirmPassword.addEventListener('click', function () {
                        const cpwInput = document.getElementById('confirmPasswordInput');
                        const cpwIcon = this;
                        if (cpwInput.type === 'password') {
                            cpwInput.type = 'text';
                            cpwIcon.classList.remove('fa-eye-slash');
                            cpwIcon.classList.add('fa-eye');
                        } else {
                            cpwInput.type = 'password';
                            cpwIcon.classList.remove('fa-eye');
                            cpwIcon.classList.add('fa-eye-slash');
                        }
                    });
                }
            </script>
        </body>

        </html>