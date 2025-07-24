<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá bác sĩ</title>
    
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/css/style_1.css" rel="stylesheet">
    
    <style>
        .rating-container {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 10px;
            margin: 30px 0;
        }
        
        .rating-container input {
            display: none;
        }
        
        .rating-container label {
            cursor: pointer;
            font-size: 40px;
            color: #ccc;
            transition: color 0.3s;
        }
        
        .rating-container label:hover,
        .rating-container label:hover ~ label,
        .rating-container input:checked ~ label {
            color: #ffcc00;
        }
        
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background-color: #FF3B3B;
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
        }
        
        .booking-info {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .btn-submit {
            background-color: #FF3B3B;
            border: none;
            padding: 10px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background-color: #e62e2e;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 59, 59, 0.3);
        }
        
        .btn-cancel {
            background-color: #6c757d;
            border: none;
            padding: 10px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s;
        }
        
        .btn-cancel:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }
    </style>
</head>
<body>
    <jsp:include page="Header.jsp"></jsp:include>
    
    <div class="container py-5 mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header text-center">
                        <h3 class="mb-0">
                            <c:choose>
                                <c:when test="${isViewOnly}">Đánh giá đã gửi</c:when>
                                <c:otherwise>Đánh giá bác sĩ</c:otherwise>
                            </c:choose>
                        </h3>
                    </div>
                    <div class="card-body p-4">
                        <!-- Booking Information -->
                        <div class="booking-info mb-4">
                            <h5 class="mb-3">Thông tin lịch khám</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Mã lịch khám:</strong> ${booking.bookingId}</p>
                                    <p><strong>Thú cưng:</strong> ${booking.petName}</p>
                                    <p><strong>Dịch vụ:</strong> ${booking.serviceName}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Ngày khám:</strong> ${fn:substring(booking.bookingTime, 0, 10)}</p>
                                    <p><strong>Giờ khám:</strong> ${fn:substring(booking.bookingTime, 11, 16)}</p>
                                    <p><strong>Bác sĩ:</strong> ${booking.employeeName}</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Rating Form -->
                        <c:choose>
                            <c:when test="${isViewOnly}">
                                <!-- View Only Mode - Show existing rating -->
                                <div class="mb-4">
                                    <h5 class="text-center mb-3">Đánh giá của bạn cho bác sĩ ${booking.employeeName}</h5>
                                    <div class="text-center mb-3">
                                        <div class="d-inline-block">
                                            <c:forEach var="i" begin="1" end="5">
                                                <c:choose>
                                                    <c:when test="${i <= existingRating.rating}">
                                                        <span class="fas fa-star" style="color: #ffcc00; font-size: 30px; margin: 0 5px;"></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="fas fa-star" style="color: #ccc; font-size: 30px; margin: 0 5px;"></span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <div class="mt-2">
                                            <strong>${existingRating.rating}/5 sao</strong>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label class="form-label"><strong>Nhận xét của bạn:</strong></label>
                                    <div class="form-control" style="min-height: 120px; background-color: #f8f9fa;">
                                        <c:choose>
                                            <c:when test="${not empty existingRating.comment}">
                                                ${existingRating.comment}
                                            </c:when>
                                            <c:otherwise>
                                                <em style="color: #6c757d;">Không có nhận xét</em>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label class="form-label"><strong>Thời gian đánh giá:</strong></label>
                                    <div class="form-control" style="background-color: #f8f9fa;">
                                        ${fn:substring(existingRating.rateTime, 0, 19)}
                                    </div>
                                </div>
                                
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/ViewBooking" class="btn btn-submit text-white">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Edit Mode - Allow new rating -->
                                <form action="${pageContext.request.contextPath}/RateDoctorServlet" method="post">
                                    <input type="hidden" name="action" value="submit">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                    <input type="hidden" name="employeeId" value="${booking.employeeId}">
                                    
                                    <div class="mb-4">
                                        <h5 class="text-center mb-3">Đánh giá bác sĩ ${booking.employeeName}</h5>
                                        <div class="rating-container">
                                            <input type="radio" id="star5" name="starRating" value="5" required>
                                            <label for="star5" class="fas fa-star"></label>
                                            
                                            <input type="radio" id="star4" name="starRating" value="4">
                                            <label for="star4" class="fas fa-star"></label>
                                            
                                            <input type="radio" id="star3" name="starRating" value="3">
                                            <label for="star3" class="fas fa-star"></label>
                                            
                                            <input type="radio" id="star2" name="starRating" value="2">
                                            <label for="star2" class="fas fa-star"></label>
                                            
                                            <input type="radio" id="star1" name="starRating" value="1">
                                            <label for="star1" class="fas fa-star"></label>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <label for="commentText" class="form-label">Nhận xét của bạn (không bắt buộc)</label>
                                        <textarea class="form-control" id="commentText" name="commentText" rows="5" 
                                                  placeholder="Hãy chia sẻ trải nghiệm của bạn với bác sĩ..."></textarea>
                                    </div>
                                    
                                    <div class="text-center">
                                        <a href="${pageContext.request.contextPath}/ViewBooking" class="btn btn-cancel me-3">
                                            <i class="fas fa-times me-2"></i>Hủy bỏ
                                        </a>
                                        <button type="submit" class="btn btn-submit text-white">
                                            <i class="fas fa-paper-plane me-2"></i>Gửi đánh giá
                                        </button>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="Footer.jsp"></jsp:include>
    
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
</body>
</html> 