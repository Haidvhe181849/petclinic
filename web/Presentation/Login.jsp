<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đăng nhập</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
                    max-width: 420px;
                    width: 100%;
                }

                .card-header {
                    background-color: #ff3d3d;
                    color: white;
                    text-align: center;
                    font-size: 1.75rem;
                    font-weight: bold;
                    border-top-left-radius: 20px;
                    border-top-right-radius: 20px;
                }

                .form-control {
                    border-radius: 12px;
                    border: 1px solid #ddd;
                }

                .form-control:focus {
                    border-color: #ff3d3d;
                    box-shadow: 0 0 0 0.15rem rgba(255, 61, 61, 0.25);
                }

                .btn-login {
                    background-color: #ff3d3d;
                    color: white;
                    font-weight: 600;
                    border-radius: 25px;
                }

                .btn-login:hover {
                    background-color: #e63636;
                }

                .btn-back {
                    border: 1px solid #ff3d3d;
                    color: #ff3d3d;
                    font-weight: 500;
                    border-radius: 25px;
                    background-color: transparent;
                }

                .btn-back:hover {
                    background-color: #ff3d3d;
                    color: white;
                }

                .text-link {
                    color: #ff3d3d;
                    text-decoration: none;
                    font-weight: 500;
                }

                .text-link:hover {
                    text-decoration: underline;
                }

                .alert-danger {
                    border-radius: 12px;
                    font-size: 0.95rem;
                }
            </style>
        </head>

        <body>
            <% String registerSuccess=(String) session.getAttribute("registerSuccess"); if (registerSuccess !=null) {
                session.removeAttribute("registerSuccess"); %>
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Đăng ký thành công!',
                        text: '<%= registerSuccess %>',
                        confirmButtonColor: '#ff3d3d',
                        timer: 3000,
                        timerProgressBar: true
                    });
                </script>
                <% } %>
                    <% String resetSuccess=(String) session.getAttribute("resetSuccess"); if (resetSuccess !=null) {
                        session.removeAttribute("resetSuccess"); } %>
                        <c:if test='${not empty resetSuccess}'>
                            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                            <script>
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Thành công!',
                                    text: '<%= resetSuccess %>',
                                    confirmButtonColor: '#ff3d3d'
                                });
                            </script>
                        </c:if>
                        <div class="card p-4">
                            <div class="card-header">Đăng nhập</div>
                            <div class="card-body">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/login" method="post">
                                    <div class="mb-3">
                                        <input type="text" class="form-control" name="username"
                                            placeholder="Tên đăng nhập" required>
                                    </div>
                                    <div class="mb-3">
                                        <input type="password" class="form-control" name="password"
                                            placeholder="Mật khẩu" required>
                                    </div>
                                    <div class="d-grid mb-3">
                                        <button type="submit" class="btn btn-login">Đăng nhập</button>
                                    </div>
                                </form>

                                <a href="${pageContext.request.contextPath}/forgot-password" class="text-link">Quên mật
                                    khẩu?</a>

                                <div class="text-center mt-3">
                                    <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register"
                                            class="text-link">Đăng ký</a></p>
                                </div>
                                <div class="text-center mt-3 p-2">
                                    <a href="${pageContext.request.contextPath}/google-login"
                                        class="btn btn-danger w-100"
                                        style="background: #db4437; border: none; border-radius: 22px; font-weight: 600;">
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png"
                                            style="width:22px; margin-right:8px; vertical-align:middle;"> Đăng nhập với
                                        Google
                                    </a>
                                </div>

                                <!-- Nút quay về trang chủ -->
                                <div class="d-grid">
                                    <a href="${pageContext.request.contextPath}/Home"
                                        class="btn btn-back">← Back to Home</a>
                                </div>

                            </div>
                        </div>
        </body>

        </html>