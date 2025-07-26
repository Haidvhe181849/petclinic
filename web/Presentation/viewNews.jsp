<%-- 
    Document   : viewNews
    Created on : Jun 1, 2025, 9:58:23 PM
    Author     : LENOVO
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Blog - Animal Clinic</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

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
    </head>
    <!-- Navbar Start -->
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


    <div class="slider-area2 slider-height2 d-flex align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="hero-cap text-center pt-50">
                        <h2>NEWS</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <body class="bg-gray-50 text-gray-800">

        <main class="container mx-auto px-4 mt-10 grid grid-cols-1 md:grid-cols-3 gap-8 mt-24">

            <!-- Blog List -->
            <div class="md:col-span-2 space-y-8">
                <c:forEach var="n" items="${nlist}">
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <img src="${n.imageUrl}" alt="Blog image" class="w-full h-60 object-cover">
                        <div class="p-6">
                            <a href="newsdetail?id=${n.newsId}" class="text-2xl font-semibold text-black-600 hover:underline">${n.nameNews}</a>
                            <p class="text-sm text-gray-500 mt-2"><fmt:formatDate value="${n.postTime}" pattern="dd/MM/yyyy" /></p>
                            <p class="mt-3 text-gray-700 line-clamp-2">${n.description}</p>

                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Sidebar -->
            <aside class="space-y-8">
                <!-- Search -->
                <div class="bg-white shadow p-4 rounded-lg">
                    <form action="viewNews" method="get">
                        <label class="block mb-2 text-sm font-medium">Search</label>
                        <div class="d-flex">
                            <input type="text" name="name" value="<c:out value='${nameNews}'/>"
                                   placeholder="Search News" 
                                   class="flex-grow px-3 py-2 border border-gray-300 rounded-start focus:outline-none" />

                            <button type="submit" name="submit" value="search"
                                    class="px-4 bg-blue-600 text-white rounded-end">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>

                </div>

                <!-- Recent Posts -->
                <div class="bg-white shadow p-4 rounded-lg">
                    <h2 class="text-lg font-semibold border-b pb-2 mb-4">Recent Posts</h2>
                    <c:forEach var="r" items="${top5News}">
                        <div class="flex space-x-4 mb-4">
                            <img src="${r.imageUrl}" alt="Recent" class="w-16 h-16 object-cover rounded-md">
                            <div>
                                <a href="newsdetail?id=${r.newsId}" class="text-sm font-medium text-black-700 hover:underline">${r.nameNews}</a>
                                <p class="text-xs text-gray-500"><fmt:formatDate value="${r.postTime}" pattern="dd/MM/yyyy" /></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </aside>

        </main>

        <!-- Footer -->
        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://cdn.tailwindcss.com?plugins=line-clamp"></script>

    </body>
</html>

