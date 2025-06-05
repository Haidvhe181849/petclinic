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
        <jsp:include page="Header.jsp"></jsp:include>
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
                <h1 class="mb-4">All Medicine In Hospital</h1>
                <div class="row align-items-center mb-4">
                    <div class="col-12">
                        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                            <!-- Bên trái: Search, Filter, Sort -->
                            <div class="d-flex flex-wrap align-items-center gap-2" style="flex-grow: 1;">

                                <!-- Search -->
                                <form action="${pageContext.request.contextPath}/ViewMedicine" method="post" class="d-flex align-items-center gap-2" style="margin: 0;">
                                <input type="search" name="keyword" class="form-control" placeholder="Search by Name, Supplier"
                                       style="font-size: 14px; height: 40px; min-width: 250px;">
                                <input type="hidden" name="service" value="searchMedicine">
                                <button type="submit" class="btn text-white"
                                        style="background-color: #FF3B3B; height: 40px; font-size: 14px; white-space: nowrap; min-width: 100px;">
                                    <i class="fa fa-search me-1"></i> Search
                                </button>
                            </form>

                            <!-- Filter -->
                            <form action="${pageContext.request.contextPath}/ViewMedicine" method="post" style="margin: 0;">
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
                            <form action="${pageContext.request.contextPath}/ViewMedicine" method="post" style="margin: 0;">
                                <input type="hidden" name="service" value="sortByName" />
                                <button type="submit" class="btn text-white fw-bold shadow-sm d-flex align-items-center justify-content-center"
                                        style="background-color: #FF3B3B; height: 40px; font-size: 14px; white-space: nowrap;">
                                    Sort Medicine
                                </button>
                            </form>

                            <!-- Sort by Supplier -->
                            <form action="${pageContext.request.contextPath}/ViewMedicine" method="post" style="margin: 0;">
                                <input type="hidden" name="service" value="sortBySupplier" />
                                <button type="submit" class="btn text-white fw-bold shadow-sm d-flex align-items-center justify-content-center"
                                        style="background-color: #FF3B3B; height: 40px; font-size: 14px; white-space: nowrap;">
                                    Sort Supplier
                                </button>
                            </form>
                        </div>


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
                        <th style="width: 125px;">Dosage</th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="medicine" items="${medicineList}">
                        <tr>
                            <td><c:out value="${medicine.medicineId}"/></td>
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
                            <td style="max-width: 350px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                <c:out value="${medicine.dosage}"/>
                            </td>


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

