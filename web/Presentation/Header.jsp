<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<!-- Style Button -->
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

<!-- Navbar Start -->
<div class="header-area header-transparent">
    <div class="main-header header-sticky">
        <div class="container-fluid">
            <div class="row align-items-center" style="min-height: 80px;">
                <!-- Logo -->
                <div class="col-xl-2 col-lg-2 col-md-2 d-flex align-items-center">
                    <div class="logo">
                        <a href="index.html"><img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" alt=""></a>
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
                                <li><a href="#">Doctor</a></li>
                                <li><a href="${pageContext.request.contextPath}/viewNews?service=listNews">News</a></li>
                                <li><a href="${pageContext.request.contextPath}/Presentation/ViewAboutUs.jsp">About Us</a></li>
                                <li><a href="#">Managerment</a>
                                    <ul class="submenu">
                                        <li><a href="${pageContext.request.contextPath}/ManagerBooking">Booking</a></li>
                                        <li><a href="#">Service</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">Medicine</a></li>
                                        <li><a href="${pageContext.request.contextPath}/News?service=listNews">News</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Presentation/ManageAboutUsAdmin.jsp">About Us</a></li>
                                    </ul>
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
    <!-- Mobile Menu -->
    <div class="col-12">
        <div class="mobile_menu d-block d-lg-none"></div>
    </div>
</div>

<!-- Navbar End -->

<!-- Hero background -->
<div class="hero-banner"
     style="
     background-image: url('${pageContext.request.contextPath}/Presentation/img/hero/hero2.png');
     background-size: cover;
     background-position: center;

     ">
</div>
