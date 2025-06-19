<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Quản trị</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/fontawesome-all.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #F6F7F8;
        }

        .dashboard-container {
            padding: 40px 0;
            margin-top: 80px;
        }

        .dashboard-card {
            background: #fff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 100%;
            overflow: hidden;
        }

        .dashboard-card:hover {
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            transform: translateY(-5px);
        }

        .dashboard-icon {
            font-size: 3rem;
            color: #ff2020;
            margin-bottom: 20px;
        }

        .card-title {
            color: #2d2d2d;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .card-text {
            color: #666;
            margin-bottom: 20px;
        }

        .btn {
            background: #f8f9fa;
        }

        .btn-primary {
            background-color: #ff2020;
            border-color: #ff2020;
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #f41717;
            border-color: #f41717;
            transform: translateY(-2px);
        }

        .btn-outline-dark {
            border: 2px solid #2d2d2d;
            color: #2d2d2d;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-dark:hover {
            background-color: #2d2d2d;
            color: #fff;
            transform: translateY(-2px);
        }
    </style>
</head>

<body>
<main>
    <div class="container dashboard-container">

        <!-- Back button -->
        <div class="row mb-4">
            <div class="col-12">
                <a href="${pageContext.request.contextPath}/Presentation/Home.jsp" class="btn btn-outline-dark"
                   style="border-radius: 30px; padding: 12px 25px;">
                    <i class="bi bi-arrow-left me-2"></i>Quay về trang chủ
                </a>
            </div>
        </div>

      
        <div class="row justify-content-center">
            <div class="col-12 text-center mb-5">
                <h2 class="section-title" style="color: #2d2d2d; font-size: 48px; margin-bottom: 30px;">
                    Dashboard Quản trị</h2>
                <div class="section-tittle text-center mb-40" style="width: 50%; margin: 0 auto;">
                    <p style="color: #777;">Quản lý tài khoản và phản hồi của người dùng trong hệ thống PetClinic</p>
                </div>
            </div>
        </div>

       
        <c:choose>

         
            <c:when test="${sessionScope.user.roleId == 1}">
                <div class="row g-4">
                    <div class="col-xl-6 col-lg-6 col-md-6">
                        <a href="../account-management" style="text-decoration:none; color:inherit;">
                            <div class="card dashboard-card p-5 text-center">
                                <div class="dashboard-icon">
                                    <i class="bi bi-people"></i>
                                </div>
                                <h3 class="card-title">Quản lý tài khoản</h3>
                                <p class="card-text">Thêm, sửa, xem, bật/tắt trạng thái tài khoản người dùng trong hệ thống.</p>
                                <div class="mt-auto">
                                    <span class="btn btn-primary">Vào quản lý User</span>
                                </div>
                            </div>
                        </a>
                    </div>

                    <div class="col-xl-6 col-lg-6 col-md-6">
                        <a href="../feedback-management" style="text-decoration:none; color:inherit;">
                            <div class="card dashboard-card p-5 text-center">
                                <div class="dashboard-icon">
                                    <i class="bi bi-chat-dots"></i>
                                </div>
                                <h3 class="card-title">Quản lý Feedback</h3>
                                <p class="card-text">Xem, phản hồi, quản lý đánh giá và góp ý từ khách hàng một cách hiệu quả.</p>
                                <div class="mt-auto">
                                    <span class="btn btn-primary">Vào quản lý Feedback</span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </c:when>

          
            <c:when test="${sessionScope.user.roleId == 2}">
                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-6 col-md-8">
                        <a href="../feedback-management" style="text-decoration:none; color:inherit;">
                            <div class="card dashboard-card p-5 text-center">
                                <div class="dashboard-icon">
                                    <i class="bi bi-chat-dots"></i>
                                </div>
                                <h3 class="card-title">Quản lý Feedback</h3>
                                <p class="card-text">Xem, phản hồi, quản lý đánh giá và góp ý từ khách hàng một cách hiệu quả.</p>
                                <div class="mt-auto">
                                    <span class="btn btn-primary">Vào quản lý Feedback</span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </c:when>

            
            <c:otherwise>
                <div class="text-center">
                    <p class="text-danger">Bạn không có quyền truy cập trang này.</p>
                </div>
            </c:otherwise>

        </c:choose>
    </div>
</main>

<!-- JS -->
<script src="js/vendor/modernizr-3.5.0.min.js"></script>
<script src="js/vendor/jquery-1.12.4.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/jquery.slicknav.min.js"></script>
<script src="js/wow.min.js"></script>
<script src="js/jquery.magnific-popup.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/jquery.counterup.min.js"></script>
<script src="js/waypoints.min.js"></script>
<script src="js/contact.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/mail-script.js"></script>
<script src="js/jquery.ajaxchimp.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>
