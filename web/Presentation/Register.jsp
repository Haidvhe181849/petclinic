<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đăng ký</title>
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
                    max-width: 600px;
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

                .btn-submit {
                    background-color: #ff3d3d;
                    color: white;
                    font-weight: 600;
                    border-radius: 25px;
                }

                .btn-submit:hover {
                    background-color: #e63636;
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
            <div class="card p-4">
                <div class="card-header">Đăng ký tài khoản</div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="register" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" id="username" name="username"
                                    placeholder="Tên đăng nhập" required pattern="^[a-zA-Z0-9]{4,}$"
                                    title="Tên đăng nhập chỉ gồm chữ cái, số, không dấu cách, tối thiểu 4 ký tự">
                            </div>
                            <div class="col-md-6">
                                <label for="name" class="form-label">Họ tên</label>
                                <input type="text" class="form-control" id="name" name="name" placeholder="Họ tên"
                                    required pattern="^[a-zA-ZÀ-ỹ\s]+$"
                                    title="Họ tên chỉ gồm chữ cái và dấu cách">
                            </div>
                            <div class="col-md-6">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" id="password" name="password"
                                    placeholder="Mật khẩu" required pattern=".{6,}"
                                    title="Mật khẩu tối thiểu 6 ký tự">
                            </div>
                            <div class="col-md-6">
                                <label for="confirmPassword" class="form-label">Xác nhận lại mật khẩu</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                    placeholder="Xác nhận lại mật khẩu" required pattern=".{6,}"
                                    title="Mật khẩu tối thiểu 6 ký tự">
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                    required>
                            </div>
                            <div class="col-md-6">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" id="phone" name="phone"
                                    placeholder="Số điện thoại" required pattern="^[0-9]{10,11}$"
                                    title="Số điện thoại chỉ gồm 10-11 chữ số, không chứa dấu cách hoặc chữ">
                            </div>
                            <div class="col-md-12">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" id="address" name="address"
                                    placeholder="Địa chỉ" required>
                            </div>
                        </div>
                        <input type="hidden" name="roleId" value="1" />
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-submit">Đăng ký</button>
                        </div>
                    </form>

                    <div class="text-center mt-4">
                        <p>Đã có tài khoản? <a class="text-link" href="${pageContext.request.contextPath}/login">Đăng
                                nhập</a></p>
                    </div>
                </div>
            </div>

            <script>
                document.querySelector('form').addEventListener('submit', function (e) {
                    var pw = document.querySelector('input[name="password"]').value;
                    var cpw = document.querySelector('input[name="confirmPassword"]').value;
                    if (pw !== cpw) {
                        alert('Mật khẩu xác nhận không khớp!');
                        e.preventDefault();
                    }
                });
            </script>
        </body>

        </html>