<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Document : Home Created on : May 25, 2025, 8:09:54 PM Author : LENOVO --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
        <!-- Preloader Start -->
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
                                                        <li><a href="#">${sv.service_name}</a></li>
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
                                    <c:when test="${not empty sessionScope.userName}">
                                        <div class="header-user-info">
                                            <span>Xin chào, ${sessionScope.userEmail}</span>
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
                        <div class="header-right-btn f-right d-none d-lg-block ml-30">
                            <a href="#" class="header-btn">01654.066.456</a>
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
    <!--? Our Services Start -->
    <div class="our-services section-padding30">
        <div class="container">
            <div class="row justify-content-sm-center">
                <div class="cl-xl-7 col-lg-8 col-md-10">
                    <!-- Section Tittle -->
                    <div class="section-tittle text-center mb-70">
                        <span>Our Professional Services</span>
                        <h2>Best Pet Care Services</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class=" col-lg-4 col-md-6 col-sm-6">
                    <div class="single-services text-center mb-30">
                        <div class="services-ion">
                            <span class="flaticon-animal-kingdom"></span>
                        </div>
                        <div class="services-cap">
                            <h5><a href="#">Pet Boarding</a></h5>
                            <p>consectetur adipiscing elit, serfd dgo eiusmod tempor incididunt ut ore
                                et
                                dolore magna aliqua.</p>
                        </div>
                    </div>
                </div>
                <div class=" col-lg-4 col-md-6 col-sm-6">
                    <div class="single-services text-center mb-30">
                        <div class="services-ion">
                            <span class="flaticon-animals"></span>
                        </div>
                        <div class="services-cap">
                            <h5><a href="#">Pet Treatment</a></h5>
                            <p>consectetur adipiscing elit, serfd dgo eiusmod tempor incididunt ut ore
                                et
                                dolore magna aliqua.</p>
                        </div>
                    </div>
                </div>
                <div class=" col-lg-4 col-md-6 col-sm-6">
                    <div class="single-services text-center mb-30">
                        <div class="services-ion">
                            <span class="flaticon-animals-1"></span>
                        </div>
                        <div class="services-cap">
                            <h5><a href="#">Vaccinations</a></h5>
                            <p>consectetur adipiscing elit, serfd dgo eiusmod tempor incididunt ut ore
                                et
                                dolore magna aliqua.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Our Services End -->
    <!--? About Area Start-->
    <div class="about-area fix">
        <!--Right Contents  -->
        <div class="about-img">
            <div class="info-man text-center">
                <div class="head-cap">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                         width="28px" height="39px">
                    <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                          d="M24.000,19.000 C21.791,19.000 20.000,17.209 20.000,15.000 C20.000,12.790 21.791,11.000 24.000,11.000 C26.209,11.000 28.000,12.790 28.000,15.000 C28.000,17.209 26.209,19.000 24.000,19.000 ZM24.000,8.000 C21.791,8.000 20.000,6.209 20.000,4.000 C20.000,1.790 21.791,-0.001 24.000,-0.001 C26.209,-0.001 28.000,1.790 28.000,4.000 C28.000,6.209 26.209,8.000 24.000,8.000 ZM14.000,38.999 C11.791,38.999 10.000,37.209 10.000,35.000 C10.000,32.791 11.791,31.000 14.000,31.000 C16.209,31.000 18.000,32.791 18.000,35.000 C18.000,37.209 16.209,38.999 14.000,38.999 ZM14.000,29.000 C11.791,29.000 10.000,27.209 10.000,25.000 C10.000,22.791 11.791,21.000 14.000,21.000 C16.209,21.000 18.000,22.791 18.000,25.000 C18.000,27.209 16.209,29.000 14.000,29.000 ZM14.000,19.000 C11.791,19.000 10.000,17.209 10.000,15.000 C10.000,12.790 11.791,11.000 14.000,11.000 C16.209,11.000 18.000,12.790 18.000,15.000 C18.000,17.209 16.209,19.000 14.000,19.000 ZM14.000,8.000 C11.791,8.000 10.000,6.209 10.000,4.000 C10.000,1.790 11.791,-0.001 14.000,-0.001 C16.209,-0.001 18.000,1.790 18.000,4.000 C18.000,6.209 16.209,8.000 14.000,8.000 ZM4.000,29.000 C1.791,29.000 -0.000,27.209 -0.000,25.000 C-0.000,22.791 1.791,21.000 4.000,21.000 C6.209,21.000 8.000,22.791 8.000,25.000 C8.000,27.209 6.209,29.000 4.000,29.000 ZM4.000,19.000 C1.791,19.000 -0.000,17.209 -0.000,15.000 C-0.000,12.790 1.791,11.000 4.000,11.000 C6.209,11.000 8.000,12.790 8.000,15.000 C8.000,17.209 6.209,19.000 4.000,19.000 ZM4.000,8.000 C1.791,8.000 -0.000,6.209 -0.000,4.000 C-0.000,1.790 1.791,-0.001 4.000,-0.001 C6.209,-0.001 8.000,1.790 8.000,4.000 C8.000,6.209 6.209,8.000 4.000,8.000 ZM24.000,21.000 C26.209,21.000 28.000,22.791 28.000,25.000 C28.000,27.209 26.209,29.000 24.000,29.000 C21.791,29.000 20.000,27.209 20.000,25.000 C20.000,22.791 21.791,21.000 24.000,21.000 Z" />
                    </svg>
                    <h3>354</h3>
                </div>
                <p>Success<br>Treatment</p>
            </div>
            <div class="info-man info-man2 text-center">
                <div class="head-cap">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                         width="28px" height="39px">
                    <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                          d="M24.000,19.000 C21.791,19.000 20.000,17.209 20.000,15.000 C20.000,12.790 21.791,11.000 24.000,11.000 C26.209,11.000 28.000,12.790 28.000,15.000 C28.000,17.209 26.209,19.000 24.000,19.000 ZM24.000,8.000 C21.791,8.000 20.000,6.209 20.000,4.000 C20.000,1.790 21.791,-0.001 24.000,-0.001 C26.209,-0.001 28.000,1.790 28.000,4.000 C28.000,6.209 26.209,8.000 24.000,8.000 ZM14.000,38.999 C11.791,38.999 10.000,37.209 10.000,35.000 C10.000,32.791 11.791,31.000 14.000,31.000 C16.209,31.000 18.000,32.791 18.000,35.000 C18.000,37.209 16.209,38.999 14.000,38.999 ZM14.000,29.000 C11.791,29.000 10.000,27.209 10.000,25.000 C10.000,22.791 11.791,21.000 14.000,21.000 C16.209,21.000 18.000,22.791 18.000,25.000 C18.000,27.209 16.209,29.000 14.000,29.000 ZM14.000,19.000 C11.791,19.000 10.000,17.209 10.000,15.000 C10.000,12.790 11.791,11.000 14.000,11.000 C16.209,11.000 18.000,12.790 18.000,15.000 C18.000,17.209 16.209,19.000 14.000,19.000 ZM14.000,8.000 C11.791,8.000 10.000,6.209 10.000,4.000 C10.000,1.790 11.791,-0.001 14.000,-0.001 C16.209,-0.001 18.000,1.790 18.000,4.000 C18.000,6.209 16.209,8.000 14.000,8.000 ZM4.000,29.000 C1.791,29.000 -0.000,27.209 -0.000,25.000 C-0.000,22.791 1.791,21.000 4.000,21.000 C6.209,21.000 8.000,22.791 8.000,25.000 C8.000,27.209 6.209,29.000 4.000,29.000 ZM4.000,19.000 C1.791,19.000 -0.000,17.209 -0.000,15.000 C-0.000,12.790 1.791,11.000 4.000,11.000 C6.209,11.000 8.000,12.790 8.000,15.000 C8.000,17.209 6.209,19.000 4.000,19.000 ZM4.000,8.000 C1.791,8.000 -0.000,6.209 -0.000,4.000 C-0.000,1.790 1.791,-0.001 4.000,-0.001 C6.209,-0.001 8.000,1.790 8.000,4.000 C8.000,6.209 6.209,8.000 4.000,8.000 ZM24.000,21.000 C26.209,21.000 28.000,22.791 28.000,25.000 C28.000,27.209 26.209,29.000 24.000,29.000 C21.791,29.000 20.000,27.209 20.000,25.000 C20.000,22.791 21.791,21.000 24.000,21.000 Z" />
                    </svg>
                    <h3>354</h3>
                </div>
                <p>Success<br>Treatment</p>
            </div>
        </div>
        <!-- left Contents -->
        <div class="about-details">
            <div class="right-caption">
                <!-- Section Tittle -->
                <div class="section-tittle mb-50">
                    <h2>We are commited for<br> better service</h2>
                </div>
                <div class="about-more">
                    <p class="pera-top">Mollit anim laborum duis adseu dolor iuyn voluptcate velit ess
                        <br>cillum dolore egru lofrre dsu.
                    </p>
                    <p class="mb-65 pera-bottom">Mollit anim laborum.Dvcuis aute serunt iruxvfg
                        dhjkolohr
                        indd re voluptate velit esscillumlore eu quife nrulla parihatur. Excghcepteur
                        sfwsignjnt occa cupidatat non aute iruxvfg dhjinulpadeserunt moll.</p>
                    <a href="#" class="btn">Read More</a>
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
    <!--? Contact form Start -->

    <!-- contact left Img-->

    <!-- Contact form End -->
    <!--? Team Start -->
    <div class="team-area section-padding30">
        <div class="container">
            <div class="row justify-content-sm-center">
                <div class="cl-xl-7 col-lg-8 col-md-10">
                    <!-- Section Tittle -->
                    <div class="section-tittle text-center mb-70">
                        <span>Our Professional members </span>
                        <h2>Our Team Mambers</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- single Tem -->
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-">
                    <div class="single-team mb-30">
                        <div class="team-img">
                            <img src="img/gallery/team1.png" alt="">
                        </div>
                        <div class="team-caption">
                            <span>Mike Janathon</span>
                            <h3><a href="#">Doctor</a></h3>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-">
                    <div class="single-team mb-30">
                        <div class="team-img">
                            <img src="img/gallery/team2.png" alt="">
                        </div>
                        <div class="team-caption">
                            <span>Mike J Smith</span>
                            <h3><a href="#">Doctor</a></h3>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-">
                    <div class="single-team mb-30">
                        <div class="team-img">
                            <img src="img/gallery/team3.png" alt="">
                        </div>
                        <div class="team-caption">
                            <span>Pule W Smith</span>
                            <h3><a href="#">Doctor</a></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Team End -->
    <!--? Testimonial Start -->
    <div class="testimonial-area testimonial-padding section-bg"
         data-background="img/gallery/section_bg03.png">
        <div class="container">
            <!-- Testimonial contents -->
            <div class="row d-flex justify-content-center">
                <div class="col-xl-8 col-lg-8 col-md-10">
                    <div class="h1-testimonial-active dot-style">
                        <!-- Single Testimonial -->
                        <div class="single-testimonial text-center">
                            <div class="testimonial-caption ">
                                <!-- founder -->
                                <div class="testimonial-founder">
                                    <div class="founder-img mb-40">
                                        <img src="img/gallery/testi-logo.png" alt="">
                                        <span>Margaret Lawson</span>
                                        <p>Creative Director</p>
                                    </div>
                                </div>
                                <div class="testimonial-top-cap">
                                    <p>"I am at an age where I just want to be fit and healthy our
                                        bodies
                                        are our responsibility! So start caring for your body and it
                                        will
                                        care for you. Eat clean it will care for you and workout hard."
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Testimonial -->
                        <div class="single-testimonial text-center">
                            <div class="testimonial-caption ">
                                <!-- founder -->
                                <div class="testimonial-founder">
                                    <div class="founder-img mb-40">
                                        <img src="img/gallery/testi-logo.png" alt="">
                                        <span>Margaret Lawson</span>
                                        <p>Creative Director</p>
                                    </div>
                                </div>
                                <div class="testimonial-top-cap">
                                    <p>"I am at an age where I just want to be fit and healthy our
                                        bodies
                                        are our responsibility! So start caring for your body and it
                                        will
                                        care for you. Eat clean it will care for you and workout hard."
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!-- Single Testimonial -->
                        <div class="single-testimonial text-center">
                            <div class="testimonial-caption ">
                                <!-- founder -->
                                <div class="testimonial-founder">
                                    <div class="founder-img mb-40">
                                        <img src="img/gallery/testi-logo.png" alt="">
                                        <span>Margaret Lawson</span>
                                        <p>Creative Director</p>
                                    </div>
                                </div>
                                <div class="testimonial-top-cap">
                                    <p>"I am at an age where I just want to be fit and healthy our
                                        bodies
                                        are our responsibility! So start caring for your body and it
                                        will
                                        care for you. Eat clean it will care for you and workout hard."
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Testimonial End -->
    <!--? Blog start -->
    <div class="home_blog-area section-padding30">
        <div class="container">
            <div class="row justify-content-sm-center">
                <div class="cl-xl-7 col-lg-8 col-md-10">
                    <!-- Section Tittle -->
                    <div class="section-tittle text-center mb-70">
                        <span>Oure recent news</span>
                        <h2>Our Recent Blog</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-4 col-lg-4 col-md-6">
                    <div class="single-blogs mb-30">
                        <div class="blog-img">
                            <img src="img/gallery/blog1.png" alt="">
                        </div>
                        <div class="blogs-cap">
                            <div class="date-info">
                                <span>Pet food</span>
                                <p>Nov 30, 2020</p>
                            </div>
                            <h4>Amazing Places To Visit In Summer</h4>
                            <a href="blog_details.html" class="read-more1">Read more</a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6">
                    <div class="single-blogs mb-30">
                        <div class="blog-img">
                            <img src="img/gallery/blog2.png" alt="">
                        </div>
                        <div class="blogs-cap">
                            <div class="date-info">
                                <span>Pet food</span>
                                <p>Nov 30, 2020</p>
                            </div>
                            <h4>Developing Creativithout Losing Visual</h4>
                            <a href="blog_details.html" class="read-more1">Read more</a>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-6">
                    <div class="single-blogs mb-30">
                        <div class="blog-img">
                            <img src="img/gallery/blog3.png" alt="">
                        </div>
                        <div class="blogs-cap">
                            <div class="date-info">
                                <span>Pet food</span>
                                <p>Nov 30, 2020</p>
                            </div>
                            <h4>Winter Photography Tips from Glenn</h4>
                            <a href="blog_details.html" class="read-more1">Read more</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog End -->
    <!--? contact-animal-owner Start -->
    <div class="contact-animal-owner section-bg" data-background="img/gallery/section_bg04.png">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="contact_text text-center">
                        <div class="section_title text-center">
                            <h3>Any time you can call us!</h3>
                            <p>Because we know that even the best technology is only as good as the
                                people
                                behind it. 24/7 tech support.</p>
                        </div>
                        <div class="contact_btn d-flex align-items-center justify-content-center">
                            <a href="contact.html" class="btn white-btn">Contact Us</a>
                            <p>Or<a href="#"> +880 4664 216</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- contact-animal-owner End -->
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