<%-- 
    Document   : BookingSchedule
    Created on : 11 Jun 2025, 22:01:47
    Author     : quang
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
    <head>
        <title>Pet Service Appointment</title>
        <link rel="manifest" href="site.webmanifest">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/slicknav.css">
        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/animate.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/fontawesome-all.min.css">
        <link rel="stylesheet" href="css/themify-icons.css">
        <link rel="stylesheet" href="css/slick.css">
        <link rel="stylesheet" href="css/nice-select.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Presentation/css/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Presentation/css/style_1.css" rel="stylesheet">

        <!-- Custom Styles -->
        <style>
            body {
                font-family: Arial;
                margin: 0;
                padding: 0;
            }

            .booking-background {
                background-image: url('img/hero/h1_hero.png'); /* Replace with your actual background image */
                background-size: cover;
                background-position: center;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 60px 20px;
            }

            .form-container {
                background-color: rgba(255, 255, 255, 0.95);
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 900px;
                z-index: 1;
                position: relative;
                margin-left: -500px;
                margin-top: 50px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"], input[type="email"], input[type="date"], select {
                width: 100%;
                max-width: 400px;
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            .appointment-times button {
                margin: 5px;
                padding: 10px 20px;
            }

            .pet-image {
                margin-top: 15px;
            }

            img#petImage {
                border: 1px solid #ccc;
                border-radius: 6px;
                padding: 5px;
            }

            .form-title {
                text-align: center;
                margin-bottom: 30px;
            }

            .form-columns {
                display: flex;
                flex-wrap: wrap;
                gap: 30px;
            }

            .form-left,
            .form-right {
                flex: 1;
                min-width: 280px;
            }

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



            @media (max-width: 768px) {
                .form-columns {
                    flex-direction: column;
                }


            </style>

            <!-- Script -->
            <script>
                function showPetImage(petId) {
                    const imgSrc = document.getElementById("pet-img-" + petId).value;
                    document.getElementById("petImage").src = imgSrc;
                }

                function showDoctorBooked(doctorId) {
                    let bookedMap = {
                <c:forEach var="entry" items="${doctorSchedules}">
                        "${entry.key}": "${fn:join(entry.value, ', ')}",
                </c:forEach>
                    };
                    document.getElementById("doctorBooked").innerText = bookedMap[doctorId] || "Không có lịch đã đặt";
                }
            </script>
        </head>
        <body>
            <header>
                <!--? Header Start -->
                <div class="header-area header-transparent">
                    <div class="main-header header-sticky">
                        <div class="container-fluid">
                            <div class="row align-items-center" style="min-height: 80px;">
                                <!-- Logo -->
                                <div class="col-xl-2 col-lg-2 col-md-2 d-flex align-items-center">
                                    <div class="logo">
                                        <a href="Home.jsp"><img src="img/logo/logo.png" alt=""></a>
                                    </div>
                                </div>
                                <!-- Menu -->
                                <div class="col-xl-7 col-lg-7 col-md-7">
                                    <div class="main-menu f-right d-none d-lg-block">
                                        <nav>
                                            <ul id="navigation">
                                                <li><a href="${pageContext.request.contextPath}/Presentation/Home.jsp">Home</a></li>
                                                <li><a href="#">Services</a>
                                                    <ul class="submenu">
                                                        <li><a href="#">A</a></li>
                                                        <li><a href="#">B</a></li>
                                                        <li><a href="#">C</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="${pageContext.request.contextPath}/Presentation/ViewMedicine.jsp">Medicine</a></li>
                                                <li><a href="#">Doctor</a></li>
                                                <li><a href="${pageContext.request.contextPath}/Presentation/BookingSchedule.jsp">Booking</a></li>
                                                <li><a href="${pageContext.request.contextPath}/News?service=listNews">News</a></li>
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
                                                               href="${pageContext.request.contextPath}/change-password">Đổi
                                                                mật khẩu</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:when test="${not empty sessionScope.userName}">
                                            <div class="header-user-info">
                                                <span>Hi, ${sessionScope.userName}</span>
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
                    <!-- Mobile Menu -->
                    <div class="col-12">
                        <div class="mobile_menu d-block d-lg-none"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Header End -->
</header>
<div class="booking-background">
    <div class="form-container">
        <h2 class="form-title">Pet Service Appointment</h2>

        <form action="submitBooking" method="post">
            <div class="form-columns">
                <!-- LEFT: Customer + Pet -->
                <div class="form-left">
                    <div class="form-group">
                        <label for="customerName">Customer Name:</label>
                        <input type="text" id="customerName" name="customerName" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number:</label>
                        <input type="text" id="phone" name="phone" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" id="address" name="address">
                    </div>
                    <div class="form-group">
                        <label>Choose Pet:</label>
                        <c:forEach var="pet" items="${pets}">
                            <input type="radio" name="petId" value="${pet.id}" onclick="showPetImage('${pet.id}')"/> ${pet.name}<br>
                            <input type="hidden" id="pet-img-${pet.id}" value="${pet.imageUrl}"/>
                        </c:forEach>
                        <div class="pet-image">
                            <img id="petImage" src="" width="150" height="150" alt="Pet Image"/>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: Doctor + Schedule -->
                <div class="form-right">

                    <div class="form-group">
                        <label>Note</label>
                        <textarea name="description" class="form-control" rows="3" required></textarea>
                    </div>

                    <div class="form-group">
                        <label>Choose Doctor:</label>
                        <input type="radio" name="doctorId" value="" onclick="showDoctorBooked('')"/> No choose<br>
                        <c:forEach var="doctor" items="${doctors}">
                            <input type="radio" name="doctorId" value="${doctor.id}" onclick="showDoctorBooked('${doctor.id}')"/> ${doctor.name}<br>
                        </c:forEach>
                        <div id="doctorBooked" style="margin-top:10px;
                             font-weight: bold;
                             color: blue;"></div>
                    </div>

                    <div class="form-group">
                        <label>Date:</label>
                        <input type="date" name="appointmentDate" required>
                    </div>

                    <div class="form-group">
                        <label>Time:</label><br>
                        <div class="appointment-times">
                            <button type="button" onclick="document.getElementById('timeInput').value = '07:00 AM'">7:00 AM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '08:00 AM'">8:00 AM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '09:00 AM'">9:00 AM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '10:00 AM'">10:00 AM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '11:00 AM'">11:00 AM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '2:00 PM'">2:00 PM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '3:00 PM'">3:00 PM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '4:00 PM'">4:00 PM</button>
                            <button type="button" onclick="document.getElementById('timeInput').value = '5:00 PM'">5:00 PM</button>
                        </div>
                        <input type="hidden" id="timeInput" name="appointmentTime" required>
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="form-group" style="text-align: center;
                 margin-top: 30px;">
                <input type="submit" value="Đặt lịch"
                       style="padding: 10px 30px;
                       background-color: green;
                       color: white;
                       border: none;
                       border-radius: 6px;">
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
<jsp:include page="Footer.jsp"></jsp:include>
</html>
