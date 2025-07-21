<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <link rel="stylesheet" href="Presentation/css/bootstrap.min.css">
    <link rel="stylesheet" href="Presentation/css/style.css">
</head>
<body>
    <jsp:include page="Header.jsp"></jsp:include>
    
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="text-center">Kết quả thanh toán</h3>
                    </div>
                    <div class="card-body">
                        <% if (request.getParameter("success") != null && request.getParameter("success").equals("true")) { %>
                            <div class="alert alert-success text-center">
                                <h4><i class="fa fa-check-circle"></i> Thanh toán thành công!</h4>
                                <p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>
                                <p>Mã đặt lịch: <strong>${param.bookingId}</strong></p>
                                <p>Bạn có thể xem chi tiết đặt lịch trong mục "Lịch hẹn của tôi".</p>
                            </div>
                        <% } else { %>
                            <div class="alert alert-danger text-center">
                                <h4><i class="fa fa-times-circle"></i> Thanh toán thất bại!</h4>
                                <p>Đã xảy ra lỗi trong quá trình thanh toán.</p>
                                <p>Lỗi: <strong>${param.error}</strong></p>
                                <p>Vui lòng thử lại hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
                            </div>
                        <% } %>
                        
                        <div class="text-center mt-4">
                            <a href="Home" class="btn btn-primary">Về trang chủ</a>
                            <a href="BookingForm" class="btn btn-outline-primary">Đặt lịch mới</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="Footer.jsp"></jsp:include>
    
    <script src="Presentation/js/jquery-1.12.4.min.js"></script>
    <script src="Presentation/js/bootstrap.min.js"></script>
</body>
</html> 