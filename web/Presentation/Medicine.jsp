<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="Entity.Medicine"%>
<%@page import="DAO.MedicineDAO"%>
<%
List<Medicine> medicineList = (List<Medicine>) request.getAttribute("medicineList");
if (medicineList == null && request.getParameter("service") == null) {
    MedicineDAO dao = new MedicineDAO();
    try {
        medicineList = dao.getAllMedicines();  
    } catch (Exception e) {
        medicineList = new ArrayList<>();
        e.printStackTrace();
    }
    request.setAttribute("medicineList", medicineList);
}
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <title>Manager Medicine</title>
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
            #popup-message {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #d1e7dd; /* Bootstrap green background */
                color: #0f5132;            /* Bootstrap green text */
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.3);
                font-size: 18px;
                font-weight: 500;
                z-index: 9999;
                animation: fadeIn 0.4s ease;
            }

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
                        <div class="d-flex flex-wrap align-items-center gap-2" style="flex-grow: 1;">

                            <!-- Search -->
                            <form action="${pageContext.request.contextPath}/Medicine" method="post" class="d-flex align-items-center gap-2" style="margin: 0;">
                                <input type="search" name="keyword" class="form-control" placeholder="Search by Name, Supplier"
                                       style="font-size: 14px; height: 40px; min-width: 250px;">
                                <input type="hidden" name="service" value="searchMedicine">
                                <button type="submit" class="btn text-white"
                                        style="background-color: #FF3B3B; height: 40px; font-size: 14px; white-space: nowrap; min-width: 100px;">
                                    <i class="fa fa-search me-1"></i> Search
                                </button>
                            </form>

                            <!-- Filter -->
                            <form action="${pageContext.request.contextPath}/Medicine" method="post" style="margin: 0;">
                                <input type="hidden" name="service" value="filterByType" />
                                <select name="medicineType" class="form-select"
                                        onchange="this.form.submit()"
                                        style="font-size: 14px; height: 40px; min-width: 100px;">
                                    <option value="">All Types</option>
                                    <option value="Topical" ${param.medicineType == 'Topical' ? 'selected' : ''}>Topical</option>
                                    <option value="Spray" ${param.medicineType == 'Spray' ? 'selected' : ''}>Spray</option>
                                    <option value="Oral Drug" ${param.medicineType == 'Oral Drug' ? 'selected' : ''}>Oral Drug</option>
                                    <option value="Vaccine" ${param.medicineType == 'Vaccine' ? 'selected' : ''}>Vaccine</option>
                                </select>
                            </form>

                            <!-- Sort by Name -->
                            <form action="${pageContext.request.contextPath}/Medicine" method="post" style="margin: 0;">
                                <input type="hidden" name="service" value="sortByName" />
                                <button type="submit" class="btn text-white fw-bold shadow-sm d-flex align-items-center justify-content-center"
                                        style="background-color: #FF3B3B; height: 40px; font-size: 14px; white-space: nowrap;">
                                    Sort Medicine
                                </button>
                            </form>

                            <!-- Sort by Supplier -->
                            <form action="${pageContext.request.contextPath}/Medicine" method="post" style="margin: 0;">
                                <input type="hidden" name="service" value="sortBySupplier" />
                                <button type="submit" class="btn text-white fw-bold shadow-sm d-flex align-items-center justify-content-center"
                                        style="background-color: #FF3B3B; height: 40px; font-size: 14px; white-space: nowrap;">
                                    Sort Supplier
                                </button>
                            </form>
                        </div>

                        <!-- Bên phải: Add Medicine -->
                        <a href="#addMedicine"
                           class="btn text-white fw-bold shadow-sm d-flex align-items-center justify-content-center"
                           data-bs-toggle="modal"
                           style="background-color: #FF3B3B; height: 40px; border-radius: 30px; font-size: 14px; padding: 0 20px;">
                            <i class="fa fa-plus me-2"></i> Add Medicine
                        </a>
                    </div>
                </div>
            </div>


            <table class="table table-bordered table-hover align-middle ">
                <thead class="table-primary" style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                    <tr>
                        <th style="width: 50px;">ID</th>
                        <th style="width: 150px;">Image</th>
                        <th style="width: 120px;">Name</th>
                        <th style="width: 80px;">Supplier</th>
                        <th style="width: 50px;">Medicine Type</th>
                        <th style="width: 50px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="medicine" items="${medicineList}">
                        <tr>
                            <td><c:out value="${medicine.medicineId}"/></td>
                            <td>
                                <img src="${pageContext.request.contextPath}/${medicine.image}" alt="Medicine Image" 
                                     style="width: 100px; height: 60px; object-fit: cover; border-radius: 6px;">
                            </td>
                            <td><c:out value="${medicine.medicineName}"/></td>
                            <td><c:out value="${medicine.supplier}"/></td>
                            <td><c:out value="${medicine.type}"/></td>
                           

                            <td class="text-center">
                                <a href="#"
                                   class="btn btn-sm btn-outline-primary me-2 update-btn"
                                   style="background: #fd7e14;"
                                   data-bs-toggle="modal"
                                   data-bs-target="#updateMedicine"
                                   data-medicine-id="${medicine.medicineId}"
                                   data-image="${medicine.image}"
                                   data-name="${medicine.medicineName}"
                                   data-supplier="${medicine.supplier}"
                                   data-type="${medicine.type}"
                                   title="Update Medicine">
                                    <i class="fa fa-edit"></i> 
                                </a>
                                <a href="#"
                                   class="btn btn-sm btn-outline-primary me-2 delete-btn"
                                   style="background: #FF3B3B;"
                                   data-bs-toggle="modal"
                                   data-bs-target="#deleteMedicine"
                                   data-medicine-id="${medicine.medicineId}"
                                   data-name="${medicine.medicineName}"
                                   title="Delete Medicine">
                                    <i class="fa fa-trash"></i> 
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <!-- Medicine Management End -->

    <c:if test="${not empty message}">
        <div id="popup-message">${message}</div>

        <script>
            setTimeout(function () {
                var popup = document.getElementById("popup-message");
                if (popup)
                    popup.style.display = "none";
            }, 3000);
        </script>
    </c:if>



    <!-- Add Medicine Modal -->
    <div id="addMedicine" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/Medicine" method="post" enctype="multipart/form-data">
                    <div class="modal-header">						
                        <h4 class="modal-title">Add Medicine</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal">X</button>
                    </div>
                    <div class="modal-body">	
                        <div class="mb-3">
                            <label>Image</label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                        </div>
                        <div class="mb-3">
                            <label>Medicine Name</label>
                            <input pattern="^(?=.*[A-Za-z])[A-Za-z0-9\s\-]{2,30}$" type="text" name="medicineName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Supplier</label>
                            <input pattern="^(?=.*[A-Za-z])[A-Za-z0-9\s\-]{2,30}$" type="text" name="supplier" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Medicine Type</label>
                            <select name="type" class="form-control" required>
                                <option value="">-- Select Type --</option>
                                <option value="Topical">Topical</option>
                                <option value="Spray">Spray</option>
                                <option value="Oral Drug">Oral Drug</option>
                                <option value="Vaccine">Vaccine</option>
                            </select>
                        </div>
                       
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <input type="submit" name="submit" class="btn btn-success" value="Add">
                        <input type="hidden" name="service" value="addMedicine">
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Update Medicine Modal -->
    <div id="updateMedicine" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/Medicine" method="post" enctype="multipart/form-data">
                    <div class="modal-header">						
                        <h4 class="modal-title">Update Medicine</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">X</button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Old Image URL</label>
                            <input type="text" name="oldImage" readonly class="form-control">
                        </div>
                        <div class="mb-3">
                            <label>Change Image</label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*">
                        </div>
                        <div class="mb-3">
                            <label>Medicine Name</label>
                            <input pattern="^(?![\d\s\W]+$)[A-Za-z0-9\s\-]{2,30}$" type="text" name="medicineName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Supplier</label>
                            <input pattern="^(?![\d\s\W]+$)[A-Za-z0-9\s\-]{2,30}$" type="text" name="supplier" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Medicine Type</label>
                            <select name="type" class="form-control" required>
                                <option value="">-- Select Type --</option>
                                <option value="Topical">Topical</option>
                                <option value="Spray">Spray</option>
                                <option value="Oral Drug">Oral Drug</option>
                                <option value="Vaccine">Vaccine</option>
                            </select>
                        </div>
                        
                    </div>
                    <input type="hidden" name="medicineId">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <input type="submit" name="submit" class="btn btn-info" value="Save">
                        <input type="hidden" name="service" value="updateMedicine">
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Delete-->
    <div id="deleteMedicine" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/Medicine" method="post" enctype="multipart/form-data">
                    <div class="modal-header">						
                        <h4 class="modal-title">Delete Medicine</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">X</button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Medicine Name</label>
                            <input type="text" id="deleteMedicineName" name="medicineName" class="form-control" required>
                        </div>
                    </div>
                    <input type="hidden" id="deleteMedicineId" name="medicineId">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <input type="submit" name="submit" class="btn btn-info" value="Save">
                        <input type="hidden" name="service" value="deleteMedicine">
                    </div>
                </form>
            </div>
        </div>
    </div>





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

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    <script>
            $(document).ready(function () {
                $(".update-btn").click(function () {
                    var medicineId = $(this).data("medicine-id");
                    var imageUrl = $(this).data("image");
                    var medicineName = $(this).data("name");
                    var supplier = $(this).data("supplier");
                    var type = $(this).data("type");
                   

                    $("#updateMedicine input[name='medicineId']").val(medicineId);
                    $("#updateMedicine input[name='oldImage']").val(imageUrl);
                    $("#updateMedicine input[name='medicineName']").val(medicineName);
                    $("#updateMedicine input[name='supplier']").val(supplier);
                    $("#updateMedicine input[name='type']").val(type);
                   
                });
            });
    </script>

    <script>
        $(document).ready(function () {
            $(".delete-btn").click(function () {
                var medicineId = $(this).data("medicine-id");

                var medicineName = $(this).data("name");


                $("#deleteMedicine input[name='medicineId']").val(medicineId);

                $("#deleteMedicine input[name='medicineName']").val(medicineName);

            });
        });
    </script>

</body>
</html>

