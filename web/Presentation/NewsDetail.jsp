<%-- 
    Document   : NewsDetail
    Created on : Jul 21, 2025, 6:39:32 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Animal | Template </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
            .highlighted {
                background-color: yellow;
                font-weight: bold;
            }


        </style>
    </head>
    <!-- Navbar Start -->
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
                                    <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                        <c:if test="${sessionScope.user.roleId == 3}">
                                        <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                        </c:if>
                                    <li><a
                                            href="${pageContext.request.contextPath}/viewNews?service=listNews">News</a>
                                    </li>
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
                                            <li><a class="dropdown-item"
                                                   href="${pageContext.request.contextPath}/ViewBooking">Xem lịch khám
                                                </a>
                                            </li>
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                                            <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>

                                            <c:if
                                                test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2}">
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item"
                                                       href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp">Managerment</a></li>

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


    <div class="slider-area2 slider-height2 d-flex align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="hero-cap text-center pt-50">
                        <h2>NEWS DETAIL</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <body>

        <!--================Blog Area =================-->
        <section class="blog_area single-post-area section-padding">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 posts-list">
                        <div class="single-post">
                            <div class="blog_details">
                                <h2>${newsDetail.nameNews}</h2>

                                <p style="color: red">
                                    <fmt:formatDate value="${newsDetail.postTime}" pattern="dd/MM/yyyy"/>
                                </p>

                                <div class="feature-img">
                                    <img class="img-fluid" src="${newsDetail.imageUrl}" alt=""> 
                                </div><br>

                                <br><p>${newsDetail.description}</p>
                            </div>
                        </div>
                    </div>


                    <div class="col-lg-4">
                        <div class="blog_right_sidebar">
                            <aside class="single_sidebar_widget popular_post_widget">
                                <h3 class="widget_title">Recent Post</h3>

                                <c:forEach var="n" items="${top5}">
                                    <div class="media post_item">
                                        <img src="${n.imageUrl}" alt="post" style="width: 80px; height: 60px; object-fit: cover;">
                                        <div class="media-body">
                                            <a href="newsdetail?id=${n.newsId}">
                                                <h3>${n.nameNews}</h3>
                                            </a>
                                            <p><fmt:formatDate value="${n.postTime}" pattern="MMM dd, yyyy" /></p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </aside>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ Blog Area end =================-->
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
                                    <a href="index.html"><img src="assets/img/logo/logo2_footer.png" alt=""></a>
                                </div>
                                <div class="footer-tittle">
                                    <div class="footer-pera">
                                        <p>Lorem ipsum dolor sit amet, adipiscing elit, sed do eiusmod tempor elit. </p>
                                    </div>
                                </div>
                                <!-- social -->
                                <div class="footer-social">
                                    <a href="https://www.facebook.com/sai4ull"><i class="fab fa-facebook-square"></i></a>
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
                                    <li><a href="index.html">Home</a></li>
                                    <li><a href="about.html">About Us</a></li>
                                    <li><a href="single-blog.html">Services</a></li>
                                    <li><a href="#">Cases</a></li>
                                    <li><a href="contact.html">  Contact Us</a></li>
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
                                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End-->
    </footer>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

</body>
</html>
