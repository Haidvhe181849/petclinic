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
                                    <li><a href="${pageContext.request.contextPath}/Home">Home</a>
                                    </li>
                                    <li>
                                        <a href="#">Services</a>
                                        <ul class="submenu">
                                            <c:forEach var="s" items="${slist}">
                                                <li><a href="#">${s.service_name}</a></li>
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
                                    <li><a href="${pageContext.request.contextPath}/Presentation/ViewAboutUs.jsp">About
                                            Us</a></li>
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

        <!-- Header -->
        <!--        <header class="bg-white shadow">
                    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                        <div class="col-xl-2 col-lg-2 col-md-1">
                                    <div class="logo">
                                        <a href="index.html"><img src="img/logo/logo.png" alt=""></a>
                                    </div>
                                </div>
                        <nav class="space-x-4 text-sm font-medium">
                            <a href="index.html" class="hover:text-blue-600">Home</a>
                            <a href="about.html" class="hover:text-blue-600">About</a>
                            <a href="services.html" class="hover:text-blue-600">Services</a>
                            <a href="blog.html" class="text-blue-600">Blog</a>
                            <a href="contact.html" class="hover:text-blue-600">Contact</a>
                        </nav>
                    </div>
                </header>
        
               
                <div class="bg-blue-100 py-12 text-center">
                    <h1 class="text-4xl font-bold text-blue-700">Blog & News</h1>
                    <p class="text-gray-600 mt-2">Keep up with our latest news and updates</p>
                </div>-->






        <!-- Main Content -->
        <main class="container mx-auto px-4 mt-10 grid grid-cols-1 md:grid-cols-3 gap-8 mt-24">

            <!-- Blog List -->
            <div class="md:col-span-2 space-y-8">
                <c:forEach var="n" items="${nlist}">
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <img src="${n.imageUrl}" alt="Blog image" class="w-full h-60 object-cover">
                        <div class="p-6">
                            <a href="news-detail?id=${n.newsId}" class="text-2xl font-semibold text-black-600 hover:underline">${n.nameNews}</a>
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
                                <a href="news-detail?id=${r.newsId}" class="text-sm font-medium text-black-700 hover:underline">${r.nameNews}</a>
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

