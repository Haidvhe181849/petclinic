<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>My Schedule | Employee Booking Management</title>
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
            .booking-table {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            
            .booking-header {
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
            
            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: bold;
            }
.status-pending { background-color: #fff3cd; color: #856404; }
            .status-confirmed { background-color: #d1e7dd; color: #0f5132; }
            .status-cancelled { background-color: #f8d7da; color: #721c24; }
            
            .action-btn {
                margin: 2px;
                padding: 8px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;
                font-weight: 500;
                transition: all 0.3s ease;
                text-align: center;
                min-width: 80px;
            }
            
            .btn-view { 
                background: linear-gradient(135deg, #007bff, #0056b3); 
                color: white; 
                border: 1px solid #007bff;
            }
            
            .btn-view:hover {
                background: linear-gradient(135deg, #0056b3, #004085);
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
                color: white;
                text-decoration: none;
            }
            
            .btn-invoice { 
                background: linear-gradient(135deg, #28a745, #1e7e34); 
                color: white; 
                border: 1px solid #28a745;
            }
            
            .btn-invoice:hover {
                background: linear-gradient(135deg, #1e7e34, #155724);
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
                color: white;
                text-decoration: none;
            }
            
            .action-btn i {
                margin-right: 5px;
                font-size: 11px;
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
            
            /* Action column specific styling */
            .table td:last-child {
                white-space: nowrap;
                width: 180px;
            }
            
            .d-flex.gap-1 {
                gap: 5px !important;
                flex-wrap: nowrap;
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
                                    <h2>My Schedule</h2>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb Area End -->

            <!-- Booking Management Section Start -->
            <section class="contact-section" style="padding: 80px 0;">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="booking-table">
                                <div class="booking-header">
                                    <h3 class="mb-2">Employee Booking Management</h3>
                                    <p class="mb-0">Nhân viên: <strong>${sessionScope.employee.nameEmployee}</strong> (${sessionScope.employee.employeeId})</p>
                                </div>
                                
                                <!-- Filter Section -->
                                <div class="filter-section">
<form action="${pageContext.request.contextPath}/employee-booking" method="get" class="row g-3">
                                        <div class="col-md-4">
                                            <input type="text" name="keyword" class="form-control" 
                                                   placeholder="Booking ID hoặc tên bác sĩ..." value="${param.keyword}">
                                        </div>
                                        <div class="col-md-2">
                                            <select name="status" class="form-select">
                                                <option value="">All Status</option>
                                                <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                <option value="Confirmed" ${param.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                                <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                            </select>
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
                                            <a href="${pageContext.request.contextPath}/employee-booking" class="btn btn-secondary w-100">Reset</a>
                                        </div>
                                    </form>
                                </div>

                                <!-- Table Section -->
                                <div class="table-responsive">
                                    <c:choose>
                                        <c:when test="${not empty blist}">
                                            <table class="table table-hover mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Booking ID</th>
                                                        <th>Customer</th>
<th>Pet</th>
                                                        <th>Type</th>
                                                        <th>Service</th>
                                                        <th>Doctor</th>
                                                        <th>Booking Time</th>
                                                        <th>Status</th>
                                                        <th>Accept</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="b" items="${blist}">
                                                        <tr>
                                                            <td><strong>${b.bookingId}</strong></td>
                                                            <td>${b.customerName}</td>
                                                            <td>${b.petName}</td>
                                                            <td>${b.petType}</td>
                                                            <td>${b.serviceName}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty b.employeeName}">
                                                                        ${b.employeeName}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Not selected yet</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <fmt:formatDate value="${b.bookingTime}" pattern="yyyy-MM-dd HH:mm" />
                                                            </td>
                                                            <td>
                                                                <span class="status-badge status-${fn:toLowerCase(b.status)}">
                                                                    ${b.status}
                                                                </span>
                                                            </td>
                                                            <td>
<form action="${pageContext.request.contextPath}/ConfirmBooking" method="post" class="d-inline">
                                                                    <input type="hidden" name="service" value="updateStatus" />
                                                                    <input type="hidden" name="bookingId" value="${b.bookingId}" />
                                                                    
                                                                    <select name="status" class="form-select form-select-sm"
                                                                            onchange="handleStatusChange(this, '${b.bookingId}')"
                                                                            data-current-status="${b.status}">
                                                                        <option value="Pending">Choose Status</option>
                                                                        <c:if test="${b.status eq 'Pending' || b.status eq 'Cancelled_Pending'}">
                                                                            <option value="Confirmed">Confirmed</option>
                                                                            <option value="Cancelled">Cancelled</option>
                                                                        </c:if>
                                                                        <c:if test="${b.status ne 'Pending' && b.status ne 'Cancelled_Pending'}">
                                                                            <option value="${b.status}" selected>${b.status}</option>
                                                                        </c:if>
                                                                    </select>
                                                                    
                                                                    <div id="cancelReasonDiv-${b.bookingId}" style="display:none; margin-top: 5px;">
                                                                        <input type="text" name="cancelReason" placeholder="Enter cancel reason"
                                                                               class="form-control form-control-sm" />
                                                                    </div>
                                                                </form>
                                                            </td>
                                                            <td>
                                                                <div class="d-flex gap-1">
                                                                    <a href="${pageContext.request.contextPath}/employee-booking?action=detail&bookingId=${b.bookingId}"
                                                                       class="action-btn btn-view" title="Xem chi tiết">
<i class="fas fa-eye"></i> Chi tiết
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/ViewInvoice?bookingId=${b.bookingId}"
                                                                       class="action-btn btn-invoice" title="Xem hóa đơn">
                                                                        <i class="fas fa-file-invoice-dollar"></i> Hóa đơn
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-state">
                                                <i class="fas fa-calendar-times"></i>
                                                <h5>Không có lịch hẹn nào</h5>
                                                <p>Hiện tại chưa có lịch hẹn nào được phân công cho bạn.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Booking Management Section End -->

            <!-- Booking Detail Section -->
            <c:if test="${not empty bookingDetail}">
                <section class="contact-section" style="padding: 40px 0 80px 0;">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="card shadow-lg">
                                    <div class="card-header bg-primary text-white">
                                        <h4 class="mb-0">Booking Detail Information</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <strong>Booking ID:</strong> ${bookingDetail.bookingId}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Customer Name:</strong> ${bookingDetail.customerName}
                                            </div>
<div class="col-md-6">
                                                <strong>Phone Number:</strong> ${bookingDetail.customerPhone}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Email:</strong> ${bookingDetail.customerEmail}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Pet Name:</strong> ${bookingDetail.petName}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Breed:</strong> ${bookingDetail.breed}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Pet Type:</strong> ${bookingDetail.petType}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Service:</strong> ${bookingDetail.serviceName}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Doctor:</strong> ${bookingDetail.employeeName}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Booking Time:</strong> 
                                                <fmt:formatDate value="${bookingDetail.bookingTime}" pattern="yyyy-MM-dd HH:mm" />
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Status:</strong> 
                                                <span class="status-badge status-${fn:toLowerCase(bookingDetail.status)}">
                                                    ${bookingDetail.status}
                                                </span>
                                            </div>
                                            <div class="col-12">
                                                <strong>Note:</strong> ${bookingDetail.note}
                                            </div>
                                            <c:if test="${bookingDetail.status eq 'Cancelled'}">
                                                <div class="col-12">
                                                    <div class="alert alert-danger">
                                                        <strong>Cancel Reason:</strong> ${bookingDetail.cancelReason}
                                                    </div>
                                                </div>
</c:if>
                                            <c:if test="${bookingDetail.actualCheckinTime != null}">
                                                <div class="col-12">
                                                    <div class="alert alert-success">
                                                        <strong>Actual Check-in:</strong> 
                                                        <fmt:formatDate value="${bookingDetail.actualCheckinTime}" pattern="yyyy-MM-dd HH:mm" />
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </c:if>
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
            function handleStatusChange(selectElement, bookingId) {
                const selectedValue = selectElement.value;
                const currentStatus = selectElement.dataset.currentStatus;
                const reasonDiv = document.getElementById('cancelReasonDiv-' + bookingId);

                if (selectedValue === 'Cancelled' && currentStatus !== 'Cancelled_Pending') {
                    if (reasonDiv) {
                        reasonDiv.style.display = 'block';
                    }
                } else {
                    if (reasonDiv) {
                        reasonDiv.style.display = 'none';
                    }
                    selectElement.form.submit();
                }
            }

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
