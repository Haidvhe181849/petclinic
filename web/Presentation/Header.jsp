<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

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
                                            <li><a href="#">${sv.serviceName}</a></li>
                                            </c:forEach>
                                    </ul>
                                </li>
                                <li><a
                                        href="${pageContext.request.contextPath}/Presentation/ViewMedicine.jsp">Medicine</a>
                                </li>
                                <li><a href="#">Doctor</a></li>
                                    <c:if test="${sessionScope.user.roleId == 4}">
                                    <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                    </c:if>
                                <li><a
                                        href="${pageContext.request.contextPath}/viewNews?service=listNews">News</a>
                                </li>
                                <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2 || sessionScope.user.roleId == 3}">
                                    <li><a href="#">Managerment</a>
                                        <ul class="submenu">
                                            <li><a href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp">Dashboard</a></li>
                                            <li><a href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">Booking</a></li>
                                            <li><a href="${pageContext.request.contextPath}/Service?service=listService">Service</a></li>
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
                <div class="col-xl-3 col-lg-3 col-md-3 d-flex align-items-center justify-content-end">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="header-user-info">
                                <span>Xin chào, ${sessionScope.user.username}</span>
                                <a href="${pageContext.request.contextPath}/logout"
                                   class="header-btn custom-auth-btn">Đăng xuất</a>
                                <div class="dropdown">
                                    <a href="#"
                                       class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
                                       id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-person-circle" style="font-size: 1rem;"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                        <li><a class="dropdown-item"
                                               href="${pageContext.request.contextPath}/change-password">Đổi
                                                mật khẩu</a></li>
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
                                       id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-person-circle" style="font-size: 2rem;"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ProfileCustomer">Trang cá nhân</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                                        <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
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
<div class="hero-banner" style="
     background-image: url('${pageContext.request.contextPath}/Presentation/img/hero/hero2.png');
     background-size: cover;
     background-position: center;

     ">
</div>