<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Lịch hẹn của tôi</title>
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
            .modern-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 40px 0;
                flex-wrap: wrap;
                gap: 10px;
            }

            .page-btn {
                width: 42px;
                height: 42px;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                background: #f9d9d6;
                color: #6b4e4e;
                font-weight: 500;
                text-decoration: none;
                border: none;
                box-shadow: 4px 4px 8px rgba(0,0,0,0.05), -4px -4px 8px rgba(255,255,255,0.5);
                transition: all 0.2s ease-in-out;
            }

            .page-btn:hover {
                background: #f7c5c0;
                box-shadow: inset 2px 2px 5px rgba(0,0,0,0.1), inset -2px -2px 5px rgba(255,255,255,0.5);
                color: #5b3a3a;
                font-weight: 600;
            }

            .page-btn.active {
                background: linear-gradient(145deg, #f7bcb6, #f9d9d6);
                color: #fff;
                font-weight: bold;
                box-shadow: inset 2px 2px 6px rgba(0,0,0,0.15), inset -2px -2px 6px rgba(255,255,255,0.3);
                pointer-events: none;
            }
        </style>

        <style>
            #popup-message {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #d1e7dd; /* Bootstrap green background */
                color: #0f5132;            /* Bootstrap green text */
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.3);
                font-size: 18px;
                font-weight: 500;
                z-index: 9999;
                animation: fadeIn 0.4s ease;
            }

            .search-bar {
                height: 54px;
                border-radius: 30px;
                overflow: hidden;
                box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
            }

            .search-bar .form-control {
                border: none;
                border-radius: 0;
                height: 100%;
                padding: 0 20px;
                font-size: 16px;
            }

            .search-bar .btn {
                border: none;
                background-color: #000;
                color: white;
                padding: 0 20px;
                height: 100%;
                font-size: 18px;
                border-radius: 0;
            }





            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translate(-50%, -60%);
                }
                to {
                    opacity: 1;
                    transform: translate(-50%, -50%);
                }
            }

            /*Thanh dấu trang */
            .modern-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 40px 0;
                flex-wrap: wrap;
                gap: 10px;
            }

            .page-btn {
                width: 42px;
                height: 42px;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                background: #f9d9d6;
                color: #6b4e4e;
                font-weight: 500;
                text-decoration: none;
                border: none;
                box-shadow: 4px 4px 8px rgba(0,0,0,0.05), -4px -4px 8px rgba(255,255,255,0.5);
                transition: all 0.2s ease-in-out;
            }

            .page-btn:hover {
                background: #f7c5c0;
                box-shadow: inset 2px 2px 5px rgba(0,0,0,0.1), inset -2px -2px 5px rgba(255,255,255,0.5);
                color: #5b3a3a;
                font-weight: 600;
            }

            .page-btn.active {
                background: linear-gradient(145deg, #f7bcb6, #f9d9d6);
                color: #fff;
                font-weight: bold;
                box-shadow: inset 2px 2px 6px rgba(0,0,0,0.15), inset -2px -2px 6px rgba(255,255,255,0.3);
                pointer-events: none;
            }
        </style>
    </head>

    <body>
        <jsp:include page="Header.jsp"/>

        <div class="container py-5 mt-5">
            <h1 class="mb-4">Danh sách lịch khám</h1>

            <!-- Form lọc -->
            <form action="ViewBooking" method="get" class="d-flex flex-wrap gap-2 mb-4">
                <input type="text" name="keyword" value="${searchKeyword}" placeholder="Tìm theo tên thú cưng"
                       class="form-control" style="width: 240px;">
                <select name="status" class="form-select" style="width: 160px;">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Pending" ${selectedStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                    <option value="Confirmed" ${selectedStatus == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                    <option value="Complete" ${selectedStatus == 'Complete' ? 'selected' : ''}>Complete</option>
                    <option value="Canceled" ${selectedStatus == 'Canceled' ? 'selected' : ''}>Canceled</option>
                </select>
                <button type="submit" class="btn btn-danger"><i class="fa fa-search"></i> Lọc</button>
            </form>

            <c:if test="${empty bookingList}">
                <div class="alert alert-warning text-center">
                    Không có lịch khám nào.
                </div>
            </c:if>

            <c:if test="${not empty bookingList}">
                <table class="table table-bordered table-hover align-middle">
                    <thead style="background-color: #ffe6e6;">
                        <tr>
                            <th style="width: 150px;">Bác sĩ</th>
                            <th style="width: 100px;">Thú cưng</th>
                            <th style="width: 200px;">Dịch vụ</th>
                            <th style="width: 200px;">Ngày / Giờ</th>
                            <th style="width: 150px;">Ghi chú</th>
                            <th style="width: 120px;">Trạng thái</th>
                            <th style="width: 70px;">Tùy chỉnh</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${bookingList}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty b.employeeName}">
                                            <c:out value="${b.employeeName}" />
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger fst-italic">Chưa phân công</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>


                                <td><c:out value="${b.petName}" /></td>
                                <td>
                                    <strong><c:out value="${b.serviceName}" /></strong><br/>
                                    <span class="text-muted">${b.servicePrice} ₫</span>
                                </td>
                                <td>
                                    Ngày: <strong>${fn:substring(b.bookingTime, 0, 10)}</strong><br/>
                                    Giờ: <strong>${fn:substring(b.bookingTime, 11, 16)}</strong>
                                </td>
                                <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    <c:out value="${b.note}" />
                                </td>
                                <td>
                                    <span class="badge bg-${b.status == 'Confirmed' ? 'success' : b.status == 'Pending' ? 'warning' : 'danger'}">
                                        ${b.status}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="ViewInvoice?bookingId=${b.bookingId}" 
                                       class="btn btn-sm btn-outline-info me-1"
                                       style="padding: 6px 10px; font-size: 12px;"
                                       title="Xem hóa đơn">
                                        <i class="fas fa-file-invoice"></i> Hóa đơn
                                    </a>
                                    <!-- Nút hủy -->
                                    <c:if test="${b.status eq 'Pending'}">
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/ViewBooking"
                                              onsubmit="return confirm('Bạn có chắc muốn hủy lịch khám này?');"
                                              style="display: inline;">
                                            <input type="hidden" name="bookingId" value="${b.bookingId}">
                                            <button type="submit"
                                                    class="btn btn-xs btn-outline-danger"
                                                    style="background: #FF3B3B; padding: 8px 12px; font-size: 12px;"
                                                    title="Hủy lịch">
                                                <i class="fa fa-trash">Hủy Lịch</i>
                                            </button>
                                        </form>
                                    </c:if>

                                    <!-- Nút đánh giá -->
                                    <c:if test="${b.status eq 'Confirmed'}">
                                        <div class="d-flex flex-column gap-2">
                                            <!-- Đánh giá dịch vụ -->
                                            <a href="${pageContext.request.contextPath}/FeedbackServlet?action=create&bookingId=${b.bookingId}"
                                               class="btn btn-xs btn-outline-primary"
                                               style="background: #4B9DF8; padding: 8px 12px; font-size: 12px; color: white;"
                                               title="Đánh giá dịch vụ">
                                                <i class="fa fa-star"></i> Đánh giá dịch vụ
                                            </a>
                                            
                                            <!-- Đánh giá bác sĩ -->
                                            <c:if test="${not empty b.employeeName}">
                                                <a href="${pageContext.request.contextPath}/RateDoctorServlet?action=create&bookingId=${b.bookingId}"
                                                   class="btn btn-xs btn-outline-success"
                                                   style="background: #28a745; padding: 8px 12px; font-size: 12px; color: white;"
                                                   title="Đánh giá bác sĩ">
                                                    <i class="fa fa-user-md"></i> Đánh giá bác sĩ
                                                </a>
                                            </c:if>
                                        </div>
                                    </c:if>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </c:if>


            <!-- Phân trang -->
            <c:if test="${totalPages > 1}">
                <div class="modern-pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="ViewBooking?page=${currentPage - 1}&status=${selectedStatus}&keyword=${searchKeyword}" class="page-btn">&laquo;</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="ViewBooking?page=${i}&status=${selectedStatus}&keyword=${searchKeyword}"
                           class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="ViewBooking?page=${currentPage + 1}&status=${selectedStatus}&keyword=${searchKeyword}" class="page-btn">&raquo;</a>
                    </c:if>
                </div>
            </c:if>
        </div>

        <c:if test="${not empty sessionScope.message}">
            <div id="popup-message">${sessionScope.message}</div>

            <script>
                setTimeout(function () {
                    var popup = document.getElementById("popup-message");
                    if (popup) {
                        popup.style.display = "none";
                    }
                }, 3000);
            </script>

            <!-- Xóa message khỏi session sau khi hiển thị -->
            <c:remove var="message" scope="session" />
        </c:if>

        <jsp:include page="Footer.jsp"/>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>


    </body>
</html>
