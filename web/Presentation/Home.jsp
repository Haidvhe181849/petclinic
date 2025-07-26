<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Document : Home Created on : May 25, 2025, 8:09:54 PM Author : LENOVO --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<!doctype html>
<!doctype html>
<html class="no-js" lang="zxx">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Animal | Template </title>
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

    </head>


    <body>
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
        <header>
            <!--? Header Start -->
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
                                                        <li><a href="BookingForm?serviceId=${sv.serviceId}">${sv.serviceName}</a></li>
                                                        </c:forEach>
                                                </ul>
                                            </li>
                                            <li><a
                                                    href="${pageContext.request.contextPath}/Presentation/ViewMedicine.jsp">Medicine</a>
                                            </li>
                                            <c:if test="${sessionScope.user.roleId == 4}">
                                                <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                                </c:if>
                                            <li><a
                                                    href="${pageContext.request.contextPath}/viewNews?service=listNews">News</a>
                                            </li>
                                            <li><a
                                                    href="${pageContext.request.contextPath}/about-us">AboutUs</a>
                                            </li>
                                            <c:if test="${sessionScope.user.roleId == 3}">
                                                <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                                </c:if>
                                                <c:if test="${sessionScope.staff.roleId == 3}">
                                                <li><a href="${pageContext.request.contextPath}/employee-booking">My Schedule</a></li>
                                                </c:if>
                                                <c:if test="${sessionScope.staff.roleId == 3}">
                                                <li><a href="${pageContext.request.contextPath}/doctor-rate-list">My Rate</a></li>
                                                </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- User info -->
                            <div
                                class="col-xl-3 col-lg-3 col-md-3 d-flex align-items-center justify-content-end">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user or not empty sessionScope.staff}">
                                        <div class="header-user-info">
                                            <span>Xin chào, ${sessionScope.user.email}</span>
                                            <div class="dropdown">
                                                <a href="#"
                                                   class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
                                                   id="userDropdown" data-bs-toggle="dropdown"
                                                   aria-expanded="false">
                                                    <img src="${pageContext.request.contextPath}/Presentation/img/images/avata/${user.image}"
                                                         alt="Avatar" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">

                                                </a>
                                                <ul class="dropdown-menu dropdown-menu-end"
                                                    aria-labelledby="userDropdown">
                                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ProfileCustomer">Trang cá nhân</a></li>
                                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                                                    <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>

                                                    <c:if
                                                        test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">
                                                        <li>
                                                            <hr class="dropdown-divider">
                                                        </li>
                                                        <li><a class="dropdown-item"
                                                               href="${pageContext.request.contextPath}/dashboard">Managerment</a></li>

                                                    </c:if>
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
            <!-- Header End -->
        </header>
        <main>
            <!--? Slider Area Start-->
            <div class="slider-area">
                <div class="slider-active dot-style">
                    <!-- Slider Single -->
                    <div class="single-slider d-flex align-items-center slider-height">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-xl-7 col-lg-8 col-md-10 ">
                                    <!-- Video icon -->
                                    <div class="video-icon">
                                        <a class="popup-video btn-icon"
                                           href="https://www.youtube.com/watch?v=up68UAfH0d0"
                                           data-animation="bounceIn" data-delay=".4s">
                                            <i class="fas fa-play"></i>
                                        </a>
                                    </div>
                                    <div class="hero__caption">
                                        <span data-animation="fadeInUp" data-delay=".3s">We help to groom your
                                            pet</span>
                                        <h1 data-animation="fadeInUp" data-delay=".3s">We Care Your Pets.</h1>
                                        <p data-animation="fadeInUp" data-delay=".6s">Consectetur adipiscing
                                            elit,
                                            sed do eiusmod tempor incididunt ut labore et dolore magna sectetur
                                            adipisci.</p>
                                        <a href="#" class="hero-btn" data-animation="fadeInLeft"
                                           data-delay=".3s">Contact Now<i class="ti-arrow-right"></i> </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Slider Single -->
                    <div class="single-slider d-flex align-items-center slider-height">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-xl-7 col-lg-8 col-md-10 ">
                                    <!-- Video icon -->
                                    <div class="video-icon">
                                        <a class="popup-video btn-icon"
                                           href="https://www.youtube.com/watch?v=1aP-TXUpNoU"
                                           data-animation="bounceIn" data-delay=".4s">
                                            <i class="fas fa-play"></i>
                                        </a>
                                    </div>
                                    <div class="hero__caption">
                                        <span data-animation="fadeInUp" data-delay=".3s">We help to groom your
                                            pet</span>
                                        <h1 data-animation="fadeInUp" data-delay=".3s">We Care Your Pets.</h1>
                                        <p data-animation="fadeInUp" data-delay=".6s">Consectetur adipiscing
                                            elit,
                                            sed do eiusmod tempor incididunt ut labore et dolore magna sectetur
                                            adipisci.</p>
                                        <a href="#" class="hero-btn" data-animation="fadeInLeft"
                                           data-delay=".3s">Contact Now<i class="ti-arrow-right"></i> </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- slider Social -->
                <div class="button-text d-none d-md-block">
                    <span>Screll</span>
                </div>
            </div>
            <!-- Slider Area End -->
            <!-- Our Services Start -->
            <div class="our-services section-padding30">
                <div class="container">
                    <div class="row justify-content-sm-center">
                        <div class="col-xl-7 col-lg-8 col-md-10">
                            <div class="section-tittle text-center mb-70">
                                <span>Our Professional Services</span>
                                <h2>Best Pet Care Services</h2>
                            </div>
                        </div>
                    </div>

                    <!-- Scrollable card container -->
                    <div style="overflow-x: auto; white-space: nowrap; padding: 10px 0;">
                        <c:forEach var="s" items="${slist}">
                            <div class="single-services text-center mb-30"
                                 style="display: inline-block; width: 300px; height: 360px; margin-right: 20px; vertical-align: top; border: 1px solid #eee; padding: 16px 16px 10px 16px; border-radius: 15px; background: #FEEEF2; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transition: 0.3s;">

                                <!-- Ảnh dịch vụ: to hơn -->
                                <div class="services-ion mb-2">
                                    <img src="${s.image}" alt="${s.serviceName}"
                                         style="width: 260px; height: 260px; border-radius: 10px; object-fit: cover;" />
                                </div>

                                <!-- Tên dịch vụ -->
                                <h5 style="font-weight: 600; font-size: 17px; margin: 10px 0 5px 0;">
                                    <c:out value="${s.serviceName}" />
                                </h5>

                                <!-- Mô tả: giới hạn 2 dòng -->
                                <p style="font-size: 14px; color: #555; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">
                                    ${s.description}
                                </p>
                            </div>

                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Our Services End -->
            <!--? About Area Start-->
            <div class="about-area fix">
                <!--Right Contents  -->
                <div class="about-img">

                </div>
                <!-- left Contents -->
                <div class="about-details">
                    <div class="right-caption">
                        <!-- Section Tittle -->
                        <div class="section-tittle mb-50">
                            <h2>Chúng tôi cam kết mang đến<br> dịch vụ tốt nhất cho thú cưng của bạn</h2>
                        </div>
                        <div class="about-more">
                            <p class="pera-top">
                                Sức khỏe và hạnh phúc của thú cưng luôn là ưu tiên hàng đầu tại PetCare. 
                                Chúng tôi không chỉ chữa bệnh, mà còn chăm sóc toàn diện về thể chất và tinh thần cho thú cưng của bạn.
                            </p>
                            <p class="mb-65 pera-bottom">
                                ✅ Đội ngũ bác sĩ thú y tận tâm và giàu kinh nghiệm<br>
                                ✅ Trang thiết bị hiện đại, tiệt trùng và an toàn<br>
                                ✅ Tư vấn miễn phí và hỗ trợ chăm sóc sau điều trị<br>
                                ✅ Luôn minh bạch, trách nhiệm và đồng hành cùng khách hàng<br>
                                Chúng tôi tin rằng, thú cưng khỏe mạnh – gia đình hạnh phúc.
                            </p>
                        </div>
                    </div>
                </div>

            </div>
            <!-- About Area End-->
            <!--? Gallery Area Start -->
            <div class="gallery-area section-padding30">
                <div class="container fix">
                    <div class="row justify-content-sm-center">
                        <div class="cl-xl-7 col-lg-8 col-md-10">
                            <!-- Section Tittle -->
                            <div class="section-tittle text-center mb-70">
                                <span>Our Recent Photos</span>
                                <h2>Pets Photo Gallery</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="single-gallery mb-30">
                                <!-- <a href="img/gallery/gallery1.png" class="img-pop-up">View Project</a> -->
                                <div class="gallery-img size-img"
                                     style="background-image: url(${pageContext.request.contextPath}/Presentation/img/gallery/gallery1.png);"></div>
                            </div>
                        </div>
                        <div class="col-lg-8 col-md-6 col-sm-6">
                            <div class="single-gallery mb-30">
                                <div class="gallery-img size-img"
                                     style="background-image: url(${pageContext.request.contextPath}/Presentation/img/gallery/gallery2.png);"></div>
                            </div>
                        </div>
                        <div class="col-lg-8 col-md-6 col-sm-6">
                            <div class="single-gallery mb-30">
                                <div class="gallery-img size-img"
                                     style="background-image: url(${pageContext.request.contextPath}/Presentation/img/gallery/gallery3.png);"></div>
                            </div>
                        </div>
                        <div class="col-lg-4  col-md-6 col-sm-6">
                            <div class="single-gallery mb-30">
                                <div class="gallery-img size-img"
                                     style="background-image: url(${pageContext.request.contextPath}/Presentation/img/gallery/gallery4.png);"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Gallery Area End -->

            <!--? Team Start -->
            <div class="team-area section-padding30">
                <div class="container">
                    <div class="row justify-content-sm-center">
                        <div class="cl-xl-7 col-lg-8 col-md-10">
                            <div class="section-tittle text-center mb-70">
                                <span>Our Professional members</span>
                                <h2>Our Team Members</h2>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <c:forEach var="doc" items="${dlist}">
                            <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12">
                                <div class="single-team mb-30 text-center" style="border: 1px solid #eee; padding: 20px; border-radius: 15px; background-color: #fffafc; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">

                                    <!-- Ảnh bác sĩ -->
                                    <div class="team-img mb-3">
                                        <img src="${doc.image}" alt="${doc.name}" style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover;">
                                    </div>

                                    <!-- Tên bác sĩ -->
                                    <div class="team-caption">
                                        <h4 style="font-weight: 600;">${doc.name}</h4>

                                        <!-- Kinh nghiệm -->
                                        <p style="font-size: 14px; margin-bottom: 15px;">
                                            ${doc.experience}
                                        </p>

                                        <!-- Nút đặt lịch -->
                                        <a href="BookingForm?doctorId=${doc.employeeId}"
                                           style="background-color: #000; color: white; padding: 8px 20px; border-radius: 20px; font-size: 14px; text-decoration: none; display: inline-block;">
                                            Đặt lịch
                                        </a>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Team End -->

            <!--? Blog start -->
            <div class="home_blog-area section-padding30">
                <div class="container">
                    <div class="row justify-content-sm-center">
                        <div class="cl-xl-7 col-lg-8 col-md-10">
                            <!-- Section Tittle -->
                            <div class="section-tittle text-center mb-70">
                                <span>Our recent news</span>
                                <h2>Our Recent Blog</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="r" items="${top3News}">
                            <div class="col-xl-4 col-lg-4 col-md-6 d-flex">
                                <div class="single-blogs mb-30 h-100 d-flex flex-column">
                                    <div class="blog-img">
                                        <img src="${r.imageUrl}" alt="News Image">
                                    </div>
                                    <div class="blogs-cap flex-grow-1 d-flex flex-column">
                                        <div class="date-info">
                                            <span>Pet food</span>
                                            <p><fmt:formatDate value="${r.postTime}" pattern="MMM dd, yyyy"/></p>
                                        </div>
                                        <h4>${r.nameNews}</h4>
                                        <p class="flex-grow-1"
                                           style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;
                                           overflow: hidden; text-overflow: ellipsis; max-height: 4.5em;">
                                            ${r.description}
                                        </p>

                                        <a href="newsdetail?id=${r.newsId}" class="read-more1 mt-auto">Read more</a>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Blog End -->
        </main>
        <footer>
            <!-- Footer Start-->
            <div class="footer-area footer-padding">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-6">
                            <div class="single-footer-caption mb-50">
                                <div class="single-footer-caption mb-30">
                                    <!-- logo -->
                                    <div class="footer-logo mb-25">
                                        <a href="index.html"><img src="img/logo/logo2_footer.png" alt=""></a>
                                    </div>
                                    <div class="footer-tittle">
                                        <div class="footer-pera">
                                            <p>Lorem ipsum dolor sit amet, adipiscing elit, sed do eiusmod
                                                tempor
                                                elit. </p>
                                        </div>
                                    </div>
                                    <!-- social -->
                                    <div class="footer-social">
                                        <a href="https://www.facebook.com/sai4ull"><i
                                                class="fab fa-facebook-square"></i></a>
                                        <a href="#"><i class="fab fa-twitter-square"></i></a>
                                        <a href="#"><i class="fab fa-linkedin"></i></a>
                                        <a href="#"><i class="fab fa-pinterest-square"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-2 col-lg-2 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Company</h4>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/Home">Home</a></li>
                                        <li><a href="about.html">About Us</a></li>
                                        <li><a href="single-blog.html">Services</a></li>
                                        <li><a href="#">Cases</a></li>
                                        <li><a href="contact.html"> Contact Us</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-7">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Services</h4>
                                    <ul>
                                        <li><a href="#">Commercial Cleaning</a></li>
                                        <li><a href="#">Office Cleaning</a></li>
                                        <li><a href="#">Building Cleaning</a></li>
                                        <li><a href="#">Floor Cleaning</a></li>
                                        <li><a href="#">Apartment Cleaning</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-4 col-sm-5">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-tittle">
                                    <h4>Get in Touch</h4>
                                    <ul>
                                        <li><a href="#">152-515-6565</a></li>
                                        <li><a href="#"> Demomail@gmail.com</a></li>
                                        <li><a href="#">New Orleans, USA</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- footer-bottom area -->
            <div class="footer-bottom-area">
                <div class="container">
                    <div class="footer-border">
                        <div class="row d-flex align-items-center">
                            <div class="col-xl-12 ">
                                <div class="footer-copy-right text-center">
                                    <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                        Copyright &copy;
                                        <script>document.write(new Date().getFullYear());</script> All rights
                                        reserved | This template is made with <i class="fa fa-heart"
                                                                                 aria-hidden="true"></i> by <a href="https://colorlib.com"
                                                                                 target="_blank">Colorlib</a>
                                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End-->
        </footer>

        <script>
            $(window).on('load', function () {
                $('#preloader-active').fadeOut('slow');
            });
        </script>

        <!-- Scroll Up -->
        <div id="back-top">
            <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
        </div>

        <!-- JS here -->

        <script src="${pageContext.request.contextPath}/Presentation/js/vendor/modernizr-3.5.0.min.js"></script>
        <!-- Jquery, Popper, Bootstrap -->
        <script src="${pageContext.request.contextPath}/Presentation/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/bootstrap.min.js"></script>
        <!-- Jquery Mobile Menu -->
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.slicknav.min.js"></script>

        <!-- Jquery Slick , Owl-Carousel Plugins -->
        <script src="${pageContext.request.contextPath}/Presentation/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/slick.min.js"></script>
        <!-- One Page, Animated-HeadLin -->
        <script src="${pageContext.request.contextPath}/Presentation/js/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/animated.headline.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.magnific-popup.js"></script>

        <!-- Nice-select, sticky -->
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.nice-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.sticky.js"></script>

        <!-- contact js -->
        <script src="${pageContext.request.contextPath}/Presentation/js/contact.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.form.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/mail-script.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.ajaxchimp.min.js"></script>

        <!-- Jquery Plugins, main Jquery -->
        <script src="${pageContext.request.contextPath}/Presentation/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/main.js"></script>

        <!-- Thêm link Bootstrap JS nếu chưa có -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>

</html>

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

    .blogs-cap p {
        position: relative;
    }

    .blogs-cap p::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 1.5em;
        background: linear-gradient(to bottom, transparent, white);
    }


</style>

<% String changeSuccess=(String) session.getAttribute("changeSuccess"); if (changeSuccess !=null) {
                session.removeAttribute("changeSuccess"); } %>
<c:if test='${not empty changeSuccess}'>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    Swal.fire({
        icon: 'success',
        title: 'Thành công!',
        text: '<%= changeSuccess %>',
        confirmButtonColor: '#ff3d3d'
    });
    </script>
</c:if>