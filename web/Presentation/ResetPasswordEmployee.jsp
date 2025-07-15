<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đổi mật khẩu nhân viên</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background: linear-gradient(to right, #f8f9fa, #ffe5e5);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .card {
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 450px;
                width: 100%;
            }
            .card-header {
                background-color: #ff3d3d;
                color: white;
                text-align: center;
                font-size: 1.5rem;
                font-weight: bold;
                border-top-left-radius: 20px;
                border-top-right-radius: 20px;
                padding: 1rem;
            }
            .form-control {
                border-radius: 12px;
                padding: 0.75rem 1rem;
            }
            .form-control:focus {
                border-color: #ff3d3d;
                box-shadow: 0 0 0 0.15rem rgba(255, 61, 61, 0.25);
            }
            .btn-reset {
                background-color: #ff3d3d;
                color: white;
                font-weight: 600;
                border-radius: 25px;
                padding: 0.75rem 2rem;
                border: none;
                width: 100%;
            }
            .btn-reset:hover {
                background-color: #e63636;
            }
            .text-link {
                color: #ff3d3d;
                text-decoration: none;
            }
            .text-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="card p-4">
            <div class="card-header">Đổi mật khẩu</div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/change-password-employee" method="post" id="changePasswordForm">
                    <div class="mb-3">
                        <label for="oldPassword" class="form-label">Mật khẩu cũ</label>
                        <input type="password" class="form-control" name="oldPassword" id="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                        <input type="password" class="form-control" name="newPassword" id="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required>
                    </div>
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-reset">Đổi mật khẩu</button>
                    </div>
                </form>
                <div class="text-center mt-2">
                    <a href="${pageContext.request.contextPath}/ProfileStaff" class="text-link">Quay lại trang hồ sơ</a>
                </div>
            </div>
        </div>

        <%
            String status = (String) request.getAttribute("changeStatus");
            String message = (String) request.getAttribute("changeMessage");
            if (status != null) {
        %>
        <script>
            Swal.fire({
                icon: '<%= status.equals("success") ? "success" : "error" %>',
                title: '<%= status.equals("success") ? "Thành công!" : "Lỗi!" %>',
                text: '<%= message %>',
                showConfirmButton: true,
                confirmButtonColor: '#ff3d3d'
            });
        </script>
        <% } %>

        <script>
            document.getElementById("changePasswordForm").addEventListener("submit", function (e) {
                const oldPass = document.getElementById("oldPassword").value.trim();
                const newPass = document.getElementById("newPassword").value.trim();
                const confirmPass = document.getElementById("confirmPassword").value.trim();

                if (!oldPass || !newPass || !confirmPass) {
                    e.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Vui lòng nhập đầy đủ tất cả các trường!',
                        confirmButtonColor: '#ff3d3d'
                    });
                    return;
                }

                if (newPass.length < 6) {
                    e.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Mật khẩu mới phải có ít nhất 6 ký tự!',
                        confirmButtonColor: '#ff3d3d'
                    });
                    return;
                }

                if (newPass !== confirmPass) {
                    e.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi!',
                        text: 'Mật khẩu xác nhận không khớp!',
                        confirmButtonColor: '#ff3d3d'
                    });
                }
            });
        </script>
    </body>
</html>
