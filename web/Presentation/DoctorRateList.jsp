<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>My Ratings | Doctor Rate Management</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="manifest" href="${pageContext.request.contextPath}/Presentation/site.webmanifest">
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/Presentation/img/favicon.ico">

        <!-- CSS here -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/slicknav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/flaticon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/themify-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/slick.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/nice-select.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        
        <style>
            .rating-table {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            
            .rating-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px;
                text-align: center;
            }
            
            .filter-section {
                background: #f8f9fa;
                padding: 20px;
                border-bottom: 1px solid #dee2e6;
            }
            
            .rating-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: bold;
            }
            
            .rating-5 { background-color: #d1e7dd; color: #0f5132; }
            .rating-4 { background-color: #cff4fc; color: #087990; }
            .rating-3 { background-color: #fff3cd; color: #856404; }
            .rating-2 { background-color: #ffe6cc; color: #664d03; }
            .rating-1 { background-color: #f8d7da; color: #721c24; }
            
            .star-rating {
                color: #ffc107;
                font-size: 14px;
            }
            
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #6c757d;
            }
            
            .empty-state i {
                font-size: 48px;
                margin-bottom: 20px;
                color: #dee2e6;
            }
            
            /* Completely disable header sticky behavior for this page */
            .header-area,
            .header-area.sticky,
            .header-area.sticky-bar {
                position: static !important;
                top: auto !important;
                left: auto !important;
                right: auto !important;
                z-index: auto !important;
                background: transparent !important;
                box-shadow: none !important;
                transform: none !important;
                transition: none !important;
            }
            
            /* Ensure header content is properly displayed */
            .header-area .main-header {
                position: static !important;
                background: transparent !important;
            }
            
            /* Table styling improvements */
            .table td {
                vertical-align: middle;
                padding: 12px 8px;
            }
            
            .table th {
                background-color: #f8f9fa;
                font-weight: 600;
                border-bottom: 2px solid #dee2e6;
                padding: 12px 8px;
            }
            
            .stats-card {
                background: linear-gradient(135deg, #28a745, #20c997);
                color: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            }
        </style>

    </head>

    <body>
        <!-- Check if employee is logged in -->
        <c:if test="${empty sessionScope.employee}">
            <c:redirect url="/Presentation/LoginEmployee.jsp"/>
        </c:if>

        <!-- Preloader Start -->
        <div id="preloader-active">
            <div class="preloader d-flex align-items-center justify-content-center">
                <div class="preloader-inner position-relative">
                    <div class="preloader-circle"></div>
                    <div class="preloader-img pere-text">
                        <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" alt="">
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Header -->
        <jsp:include page="/Presentation/Header.jsp" />

        <main>
            <!-- Breadcrumb Area Start -->
            <div class="slider-area2">
                <div class="slider-height2 d-flex align-items-center">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-12">
                                <div class="hero-cap text-center">
                                    <h2>My Ratings</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb Area End -->

            <!-- Rating Management Section Start -->
            <section class="contact-section" style="padding: 80px 0;">
                <div class="container">
                    <!-- Stats Card -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="stats-card">
                                <div class="row align-items-center">
                                    <div class="col-md-8">
                                        <h4 class="mb-1">Bác sĩ: <strong>${sessionScope.employee.nameEmployee}</strong></h4>
                                        <p class="mb-0">ID: ${sessionScope.employee.employeeId}</p>
                                    </div>
                                    <div class="col-md-4 text-end">
                                        <div class="d-flex flex-column align-items-end">
                                            <h5 class="mb-1">
                                                <i class="fas fa-star me-2"></i>
                                                <fmt:formatNumber value="${averageRating}" maxFractionDigits="1" minFractionDigits="1"/>
                                            </h5>
                                            <small>${totalRatings} đánh giá</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-12">
                            <div class="rating-table">
                                <div class="rating-header">
                                    <h3 class="mb-2">Doctor Rating Management</h3>
                                    <p class="mb-0">Danh sách đánh giá từ khách hàng</p>
                                </div>
                                
                                <!-- Filter Section -->
                                <div class="filter-section">
                                    <form action="${pageContext.request.contextPath}/doctor-rate-list" method="get" class="row g-3">
                                        <div class="col-md-6">
                                            <input type="text" name="keyword" class="form-control" 
                                                   placeholder="Tìm kiếm theo tên khách hàng, nội dung hoặc Booking ID..." value="${param.keyword}">
                                        </div>
                                        <div class="col-md-2">
                                            <select name="order" class="form-select">
                                                <option value="">Sort by time</option>
                                                <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>Newest</option>
                                                <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>Oldest</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <button type="submit" class="btn btn-primary w-100">Filter</button>
                                        </div>
                                        <div class="col-md-2">
                                            <a href="${pageContext.request.contextPath}/doctor-rate-list" class="btn btn-secondary w-100">Reset</a>
                                        </div>
                                    </form>
                                </div>

                                <!-- Table Section -->
                                <div class="table-responsive">
                                    <c:choose>
                                        <c:when test="${not empty rlist}">
                                            <table class="table table-hover mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Rate ID</th>
                                                        <th>Customer</th>
                                                        <th>Rating</th>
                                                        <th>Comment</th>
                                                        <th>Booking ID</th>
                                                        <th>Date</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="r" items="${rlist}">
                                                        <tr>
                                                            <td><strong>${r.rateId}</strong></td>
                                                            <td>
                                                                <div>
                                                                    <strong>${r.userName}</strong><br>
                                                                    <small class="text-muted">${r.userEmail}</small>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <span class="rating-badge rating-${r.rating}">
                                                                        ${r.rating}
                                                                    </span>
                                                                    <div class="star-rating ms-2">
                                                                        <c:forEach var="i" begin="1" end="5">
                                                                            <i class="fa${i <= r.rating ? 's' : 'r'} fa-star"></i>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty r.comment}">
                                                                        <span class="d-inline-block text-truncate" style="max-width: 200px;" title="${r.comment}">
                                                                            ${r.comment}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted fst-italic">Không có nhận xét</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <span class="badge bg-info">${r.bookingId}</span>
                                                            </td>
                                                            <td>
                                                                <fmt:formatDate value="${r.rateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-state">
                                                <i class="fas fa-star"></i>
                                                <h5>Chưa có đánh giá nào</h5>
                                                <p>Hiện tại chưa có khách hàng nào đánh giá bạn.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Rating Management Section End -->
        </main>

        <!-- Footer Start -->
        <jsp:include page="/Presentation/Footer.jsp" />
        <!-- Footer End -->

        <!-- Success/Error Message -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show position-fixed" 
                 style="top: 20px; right: 20px; z-index: 9999;" role="alert">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <script>
                setTimeout(function() {
                    var alert = document.querySelector('.alert');
                    if (alert) {
                        alert.remove();
                    }
                }, 3000);
            </script>
            <c:remove var="message" scope="session"/>
        </c:if>

        <!-- JS here -->
        <script src="${pageContext.request.contextPath}/Presentation/js/vendor/modernizr-3.5.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/slicknav.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/animated-headline.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/magnific-popup.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/gijgo.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/nice-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.sticky.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/main.js"></script>

        <script>
            // Completely disable sticky header for this page
            $(document).ready(function() {
                // Remove all sticky-related classes
                $('.header-area').removeClass('sticky sticky-bar');
                
                // Completely disable scroll events that might add sticky
                $(window).off('scroll');
                $(window).off('scroll.sticky');
                $(window).off('scroll.header');
                
                // Force static positioning
                $('.header-area, .header-area .main-header').css({
                    'position': 'static',
                    'top': 'auto',
                    'left': 'auto',
                    'right': 'auto',
                    'z-index': 'auto',
                    'background': 'transparent',
                    'box-shadow': 'none',
                    'transform': 'none',
                    'transition': 'none'
                });
                
                // Prevent any sticky functionality from being applied
                setInterval(function() {
                    $('.header-area').removeClass('sticky sticky-bar');
                    if ($('.header-area').css('position') === 'fixed') {
                        $('.header-area').css('position', 'static');
                    }
                }, 100);
            });
        </script>
    </body>
</html>
