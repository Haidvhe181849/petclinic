<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${mode == 'create' ? 'Đánh giá dịch vụ' : 'Xem đánh giá'}</title>
    
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/Presentation/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/css/style_1.css" rel="stylesheet">
    
    <style>
        .feedback-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        
        .booking-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        
        .booking-info h5 {
            margin-bottom: 15px;
            color: #333;
        }
        
        .booking-detail {
            display: flex;
            margin-bottom: 10px;
        }
        
        .booking-label {
            font-weight: 600;
            width: 140px;
            color: #555;
        }
        
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }
        
        .star-rating input {
            display: none;
        }
        
        .star-rating label {
            cursor: pointer;
            width: 40px;
            height: 40px;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23e3e3e3' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: center;
            background-size: 30px;
            transition: .3s;
        }
        
        .star-rating input:checked ~ label,
        .star-rating input:hover ~ label {
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23ffd700' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
        }
        
        .star-rating-display {
            display: flex;
            margin-top: 10px;
        }
        
        .star-rating-display .star {
            color: #e3e3e3;
            font-size: 24px;
            margin-right: 5px;
        }
        
        .star-rating-display .star.filled {
            color: #ffd700;
        }
        
        .feedback-form textarea {
            resize: none;
            height: 150px;
        }
        
        .btn-submit {
            background-color: #FF3B3B;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background-color: #e02e2e;
            transform: translateY(-2px);
        }
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-back:hover {
            background-color: #5a6268;
        }
        
        .feedback-readonly {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }
    </style>
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <div class="container py-5 mt-5">
        <div class="feedback-container">
            <h2 class="text-center mb-4">${mode == 'create' ? 'Đánh giá dịch vụ' : 'Xem đánh giá của bạn'}</h2>
            
            <!-- Booking Information -->
            <div class="booking-info">
                <h5>Thông tin lịch khám</h5>
                <div class="booking-detail">
                    <div class="booking-label">Mã đặt lịch:</div>
                    <div>${booking.bookingId}</div>
                </div>
                <div class="booking-detail">
                    <div class="booking-label">Dịch vụ:</div>
                    <div>${booking.serviceName}</div>
                </div>
                <div class="booking-detail">
                    <div class="booking-label">Thú cưng:</div>
                    <div>${booking.petName}</div>
                </div>
                <div class="booking-detail">
                    <div class="booking-label">Ngày khám:</div>
                    <div>${fn:substring(booking.bookingTime, 0, 10)}</div>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${mode == 'create'}">
                    <!-- Feedback Form -->
                    <form action="${pageContext.request.contextPath}/FeedbackServlet" method="post" class="feedback-form">
                        <input type="hidden" name="action" value="submit">
                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                        
                        <div class="mb-4">
                            <label class="form-label">Đánh giá của bạn</label>
                            <div class="star-rating mb-3">
                                <input type="radio" id="star5" name="starRating" value="5" required/>
                                <label for="star5" title="5 sao"></label>
                                <input type="radio" id="star4" name="starRating" value="4" />
                                <label for="star4" title="4 sao"></label>
                                <input type="radio" id="star3" name="starRating" value="3" />
                                <label for="star3" title="3 sao"></label>
                                <input type="radio" id="star2" name="starRating" value="2" />
                                <label for="star2" title="2 sao"></label>
                                <input type="radio" id="star1" name="starRating" value="1" />
                                <label for="star1" title="1 sao"></label>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="feedbackText" class="form-label">Nội dung đánh giá</label>
                            <textarea class="form-control" id="feedbackText" name="feedbackText" placeholder="Chia sẻ trải nghiệm của bạn về dịch vụ của chúng tôi..." required></textarea>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/ViewBooking" class="btn-back">Quay lại</a>
                            <button type="submit" class="btn-submit">Gửi đánh giá</button>
                        </div>
                    </form>
                </c:when>
                
                <c:otherwise>
                    <!-- View Feedback -->
                    <div class="mb-4">
                        <label class="form-label">Đánh giá của bạn</label>
                        <div class="star-rating-display">
                            <c:forEach begin="1" end="5" var="i">
                                <span class="star ${i <= feedback.starRating ? 'filled' : ''}">
                                    <i class="fas fa-star"></i>
                                </span>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label">Nội dung đánh giá</label>
                        <div class="feedback-readonly">
                            ${feedback.feedbackText}
                        </div>
                    </div>
                    
                    <c:if test="${not empty feedback.replyText}">
                        <div class="mb-4">
                            <label class="form-label">Phản hồi từ phòng khám</label>
                            <div class="feedback-readonly">
                                ${feedback.replyText}
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/ViewBooking" class="btn-back">Quay lại</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <jsp:include page="Footer.jsp"/>
    
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/owlcarousel/owl.carousel.min.js"></script>
</body>
</html> 