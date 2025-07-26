<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="Entity.Medicine"%>
<%@page import="DAO.MedicineDAO"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <title>View Medicine</title>
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
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Presentation/css/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Presentation/css/style_1.css" rel="stylesheet">


        <style>
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


        </style>

    </head>

    <body>
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
                            <c:when test="${not empty sessionScope.userName or not empty sessionScope.staff}">
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
<!-- Hero Area Start -->
<div class="slider-area2 slider-height2 d-flex align-items-center">
    <div class="container">
        <div class="row">
            <div class="col-xl-12">
                <div class="hero-cap text-center pt-50">
                    <h2>Medicine</h2>
                </div>
            </div>
        </div>
    </div>
</div>






<div class="container py-5">
    <h1 class="mb-4">Manage Medicine</h1>
    <div class="row align-items-center mb-4">
        <div class="col-12">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <!-- Bên trái: Search, Filter, Sort -->
                <!-- Left: Form -->
                <form action="${pageContext.request.contextPath}/Medicine" method="post"
                      class="d-flex align-items-center gap-2 flex-wrap" style="margin: 0;">

                    <input type="hidden" name="service" value="manageQuery" />

                    <!-- Search input -->
                    <input type="search" name="keyword" value="${searchKeyword}" class="form-control"
                           placeholder="Search by Name, Supplier"
                           style="font-size: 14px; height: 40px; width: 280px;">

                    <!-- Filter -->
                    <select name="medicineType" class="form-select"
                            style="font-size: 14px; height: 40px; width: 130px;">
                        <option value="">All Types</option>
                        <option value="Topical" ${selectedType == 'Topical' ? 'selected' : ''}>Topical</option>
                        <option value="Spray" ${selectedType == 'Spray' ? 'selected' : ''}>Spray</option>
                        <option value="Oral Drug" ${selectedType == 'Oral Drug' ? 'selected' : ''}>Oral Drug</option>
                        <option value="Vaccine" ${selectedType == 'Vaccine' ? 'selected' : ''}>Vaccine</option>
                    </select>

                    <!-- Sort -->
                    <select name="sortBy" class="form-select"
                            style="font-size: 14px; height: 40px; width: 120px;">
                        <option value="">Sort</option>
                        <option value="name" ${selectedSort == 'name' ? 'selected' : ''}>By Name</option>
                        <option value="supplier" ${selectedSort == 'supplier' ? 'selected' : ''}>By Supplier</option>
                    </select>

                    <!-- Submit -->
                    <button type="submit" class="btn text-white"
                            style="background-color: #FF3B3B; height: 40px; font-size: 14px; min-width: 100px;">
                        <i class="fa fa-search me-1"></i> Search
                    </button>
                </form>
            </div>
        </div>
    </div>    



    <table class="table table-bordered table-hover align-middle ">
        <thead class="table-primary" style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
            <tr>
                <th style="width: 150px;">Image</th>
                <th style="width: 120px;">Name</th>
                <th style="width: 80px;">Supplier</th>
                <th style="width: 50px;">Medicine Type</th>
                
            </tr>
        </thead>
        <tbody>
            <c:forEach var="medicine" items="${medicineList}">
                <tr>

                    <td>
                        <img src="${pageContext.request.contextPath}/${medicine.image}" 
                             alt="Medicine Image"
                             class="img-thumbnail"
                             style="width: 100px; height: 60px; object-fit: cover; border-radius: 6px; cursor: pointer;"
                             onclick="showImageModal('${pageContext.request.contextPath}/${medicine.image}')">
                    </td>

                    <td><c:out value="${medicine.medicineName}"/></td>
                    <td><c:out value="${medicine.supplier}"/></td>
                    <td><c:out value="${medicine.type}"/></td>
                    


                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</div>
<!-- Medicine Management End -->

<!-- Image Modal -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="Medicine Image" style="width: 100%; height: auto; border-radius: 8px;">
            </div>
        </div>
    </div>
</div>

<script>
    function showImageModal(imageUrl) {
        const modalImage = document.getElementById("modalImage");
        modalImage.src = imageUrl;
        const imageModal = new bootstrap.Modal(document.getElementById('imageModal'));
        imageModal.show();
    }
</script>


<jsp:include page="Footer.jsp"></jsp:include>
<!-- Back to Top -->
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


</body>
</html>

