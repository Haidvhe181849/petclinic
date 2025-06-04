<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Quên mật khẩu</title>
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
                max-width: 420px;
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
                border: 1px solid #ddd;
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
                transition: all 0.3s ease;
            }

            .btn-reset:hover {
                background-color: #e63636;
                transform: translateY(-2px);
            }

            .text-link {
                color: #ff3d3d;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .text-link:hover {
                color: #e63636;
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="card p-4">
            <div class="card-header">Quên mật khẩu</div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="forgotForm">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email"
                            placeholder="Nhập email của bạn" required>
                    </div>
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-reset">Gửi liên kết đặt lại mật khẩu</button>
                    </div>
                </form>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/login" class="text-link">Quay lại đăng nhập</a>
                </div>
            </div>
        </div>

        <% String status=(String) request.getAttribute("mailStatus"); String message=(String)
            request.getAttribute("mailMessage"); if (status !=null) { if (status.equals("success")) { %>
            <script>
                Swal.fire({
                    title: 'Thành công!',
                    text: '${requestScope.mailMessage}',
                    icon: 'success',
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#ff3d3d'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '${pageContext.request.contextPath}/login';
                    }
                });
            </script>
            <% } else if (status.equals("error")) { %>
                <script>
                    Swal.fire({
                        title: 'Lỗi!',
                        text: '${requestScope.mailMessage}',
                        icon: 'error',
                        confirmButtonText: 'OK',
                        confirmButtonColor: '#ff3d3d'
                    });
                </script>
                <% } } %>

                    <script>
                        document.getElementById('forgotForm').addEventListener('submit', function (e) {
                            e.preventDefault();
                            const email = document.getElementById('email').value;

                            if (!email) {
                                Swal.fire({
                                    title: 'Lỗi!',
                                    text: 'Vui lòng nhập email!',
                                    icon: 'error',
                                    confirmButtonText: 'OK',
                                    confirmButtonColor: '#ff3d3d'
                                });
                                return;
                            }

                            if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
                                Swal.fire({
                                    title: 'Lỗi!',
                                    text: 'Email không hợp lệ!',
                                    icon: 'error',
                                    confirmButtonText: 'OK',
                                    confirmButtonColor: '#ff3d3d'
                                });
                                return;
                            }

                            this.submit();
                        });
                    </script>
    </body>

    </html>