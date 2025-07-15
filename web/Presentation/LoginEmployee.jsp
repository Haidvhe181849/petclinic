<%-- 
    Document   : LoginEmployee
    Created on : Jul 14, 2025, 3:37:00 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập Nhân viên</title>
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

            .alert-danger {
                border-radius: 12px;
                font-size: 0.95rem;
            }
        </style>
    </head>
    <body>
        <div class="card p-4">
            <div class="card-header">Đăng nhập Nhân viên</div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login-employee" method="post">
                    <div class="mb-3">
                        <input type="email" class="form-control" name="email"
                               placeholder="Email nhân viên" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="password"
                               placeholder="Mật khẩu" required>
                    </div>
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-login">Đăng nhập</button>
                    </div>
                </form>

                <div class="d-grid">
                    <a href="${pageContext.request.contextPath}/Home"
                       class="btn btn-back">← Quay về trang chủ</a>
                </div>
            </div>
        </div>
    </body>
</html>

