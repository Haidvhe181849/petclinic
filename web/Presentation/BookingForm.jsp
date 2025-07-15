<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đặt lịch khám</title>
        <meta charset="UTF-8">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="Presentation/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="Presentation/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="Presentation/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="Presentation/css/style.css" rel="stylesheet">
        <link href="Presentation/css/style_1.css" rel="stylesheet">



        <script>
            function loadAvailableTimes() {
                const doctorId = document.getElementById("doctorId").value;
                const date = document.getElementById("date").value;

                if (!date)
                    return; // Nếu chưa chọn ngày thì không xử lý

                // Xây dựng URL với tham số. Nếu doctorId rỗng thì không truyền tham số đó
                let url = "CheckTime?date=" + date;
                if (doctorId) {
                    url += "&doctorId=" + doctorId;
                }

                fetch(url)
                        .then(res => res.json())
                        .then(times => {
                            const timeSelect = document.getElementById("time");
                            timeSelect.innerHTML = '';
                            if (times.length === 0) {
                                const opt = document.createElement("option");
                                opt.text = "Không còn giờ trống";
                                opt.disabled = true;
                                opt.selected = true;
                                timeSelect.appendChild(opt);
                            } else {
                                times.forEach(t => {
                                    const option = document.createElement("option");
                                    option.value = t;
                                    option.text = t;
                                    timeSelect.appendChild(option);
                                });
                            }
                        });
            }
        </script>
        <style>
            body {
                background-image: url('${pageContext.request.contextPath}/Presentation/img/hero/hero2.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
        </style>

        <style>
            .header-btn.custom-auth-btn {
                font-size: 15px;
                padding: 6px 22px;
                border-radius: 22px;
                background: #ff3d3d;
                color: #fff;
                border: none;
                margin: 0;
                box-shadow: none;
                font-weight: 500;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.2s;
            }

            .header-btn.custom-auth-btn:hover {
                background: #e62e2e;
                color: #fff;
                text-decoration: none;

            }


            .header-user-info {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-left: 20px;
                white-space: nowrap;
            }

            .header-user-info span {
                font-size: 13px;
                color: #000;
                font-weight: 500;
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .header-btn.custom-auth-btn {
                font-size: 12px;
                padding: 4px 12px;
                border-radius: 16px;
                background-color: #ff4d4d;
                color: white;
                border: none;
                font-weight: 500;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .header-btn.custom-auth-btn:hover {
                background-color: #e63e3e;
            }
        </style>
    </head>
    <body>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const today = new Date().toISOString().split("T")[0];
                document.getElementById("date").min = today;
            });
        </script>


        <div class="header-area header-transparent">
            <div class="main-header header-sticky">
                <div class="container-fluid">
                    <div class="row align-items-center" style="min-height: 80px;">
                        <!-- Logo -->
                        <div class="col-xl-2 col-lg-2 col-md-2 d-flex align-items-center">
                            <div class="logo">
                                <a href="${pageContext.request.contextPath}/Home"><img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" alt=""></a>
                            </div>
                        </div>
                        <!-- Menu -->
                        <div class="col-xl-7 col-lg-7 col-md-7">
                            <div class="main-menu f-right d-none d-lg-block">
                                <nav>
                                    <ul id="navigation">
                                        <li><a href="${pageContext.request.contextPath}/Home">Home</a></li>
                                        <li>
                                            <a href="#">Services</a>
                                            <ul class="submenu">
                                                <c:forEach var="sv" items="${slist}">
                                                    <li><a href="#">${sv.serviceName}</a></li>
                                                    </c:forEach>
                                            </ul>
                                        </li>
                                        <li><a
                                                href="${pageContext.request.contextPath}/Presentation/ViewMedicine.jsp">Medicine</a>
                                        </li>
                                        <li><a href="#">Doctor</a></li>
                                            <c:if test="${sessionScope.user.roleId == 3}">
                                            <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                            </c:if>
                                        <li><a
                                                href="${pageContext.request.contextPath}/viewNews?service=listNews">News</a>
                                        </li>
                                        <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2 || sessionScope.user.roleId == 4}">
                                            <li><a href="#">Managerment</a>
                                                <ul class="submenu">
                                                    <li><a href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">Booking</a></li>
                                                    <li><a href="#">Service</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">Medicine</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/News?service=listNews">News</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/Presentation/ManageAboutUsAdmin.jsp">About Us</a></li>
                                                </ul>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <!-- User info -->
                        <div
                            class="col-xl-3 col-lg-3 col-md-3 d-flex align-items-center justify-content-end">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <div class="header-user-info">
                                        <span>Hi, ${sessionScope.user.name}</span>
                                        <a href="${pageContext.request.contextPath}/logout"
                                           class="header-btn custom-auth-btn">Đăng xuất</a>
                                        <div class="dropdown">
                                            <a href="#"
                                               class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
                                               id="userDropdown" data-bs-toggle="dropdown"
                                               aria-expanded="false">
                                                <i class="bi bi-person-circle" style="font-size: 2rem;"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end"
                                                aria-labelledby="userDropdown">
                                                <li><a class="dropdown-item"
                                                       href="${pageContext.request.contextPath}/ViewBooking">Xem lịch khám
                                                    </a></li>
                                                <li><a class="dropdown-item"
                                                       href="${pageContext.request.contextPath}/change-password">Đổi
                                                        mật khẩu</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="header-user-info">
                                        <a href="${pageContext.request.contextPath}/login"
                                           class="header-btn custom-auth-btn">Đăng nhập</a>
                                        <a href="${pageContext.request.contextPath}/register"
                                           class="header-btn custom-auth-btn">Đăng ký</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </div>
            </div>

            <div class="container" style="margin-top: 10px; padding-top: 60px; padding-bottom: 60px; background-color: rgba(255, 255, 255, 0.9);
                 border-radius: 10px;
                 box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);" >
                <h1 class="text-primary mb-4" style="font-size: 2rem;">
                    <i class="fas fa-calendar-check"></i> Đặt lịch khám thú cưng
                </h1>

                <!-- Thông báo -->
                <c:if test="${param.success eq 'true'}">
                    <div class="alert alert-success">✅ Đặt lịch thành công!</div>
                </c:if>
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger">❌ ${param.error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/SubmitBooking" method="post">
                    <!-- Thông tin khách hàng -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label"><i class="fas fa-user"></i> Họ tên</label>
                                    <input type="text" name="customerName" class="form-control" value="${sessionScope.user.name}" readonly>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label"><i class="fas fa-phone-alt"></i> SĐT</label>
                                    <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}" readonly>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label"><i class="fas fa-envelope"></i> Email</label>
                                    <input type="text" name="email" class="form-control" value="${sessionScope.user.email}" readonly>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning">
                                ⚠ Bạn chưa đăng nhập. <a href="Presentation/Login.jsp" class="fw-bold text-decoration-underline">Đăng nhập</a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Pet & Dịch vụ trên cùng 1 hàng -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label"><i class="bi bi-paw"></i> Chọn thú cưng</label>
                            <select name="petId" class="form-select" required>
                                <c:forEach var="pet" items="${pets}">
                                    <option value="${pet.petId}">${pet.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label"><i class="fas fa-stethoscope"></i> Chọn dịch vụ</label>
                            <select name="serviceId" id="service" class="form-select" required>
                                <option value="">-- Vui lòng chọn dịch vụ --</option>
                                <c:forEach var="s" items="${services}">
                                    <option value="${s.serviceId}">${s.serviceName} - ${s.price} VNĐ</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Bác sĩ + Ngày + Giờ -->
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label"><i class="fas fa-user-md"></i> Bác sĩ</label>
                            <select name="doctorId" id="doctorId" class="form-select" onchange="loadAvailableTimes()">
                                <option value="">-- Không chọn bác sĩ --</option>
                                <c:forEach var="doc" items="${doctors}">
                                    <option value="${doc.employeeId}">${doc.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label"><i class="far fa-calendar-alt"></i> Ngày khám</label>
                            <input type="date" name="date" id="date" class="form-control" onchange="loadAvailableTimes()" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label"><i class="far fa-clock"></i> Giờ khám</label>
                            <select name="time" id="time" class="form-select" required>
                                <option selected disabled>-- Chọn giờ --</option>
                                <option>8:00-9:00</option>
                            </select>
                        </div>
                    </div>

                    <!-- Ghi chú -->
                    <div class="mb-4">
                        <label class="form-label"><i class="fas fa-edit"></i> Ghi chú</label>
                        <textarea name="note" class="form-control" rows="3" placeholder="Triệu chứng hoặc yêu cầu thêm..."></textarea>
                    </div>

                    <!-- Nút xác nhận -->
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary btn-lg shadow"
                                style="font-size: 1.25rem; padding: 0.75rem 2rem;">
                            <i class="fas fa-check-circle me-2"></i> Xác nhận đặt lịch
                        </button>
                    </div>
                </form>
            </div>
        </div>


        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   
        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <!-- Bootstrap CSS -->



        <!-- Template Javascript -->
        <script src="js/main.js"></script>

        <script src="https://cdn.tailwindcss.com?plugins=line-clamp"></script>
    </body>
</html>
