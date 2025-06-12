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

            /*Thanh dấu trang */
            .modern-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 40px 0;
                flex-wrap: wrap;
                gap: 10px;
            }

            .page-btn {
                width: 42px;
                height: 42px;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                background: #f9d9d6;
                color: #6b4e4e;
                font-weight: 500;
                text-decoration: none;
                border: none;
                box-shadow: 4px 4px 8px rgba(0,0,0,0.05), -4px -4px 8px rgba(255,255,255,0.5);
                transition: all 0.2s ease-in-out;
            }

            .page-btn:hover {
                background: #f7c5c0;
                box-shadow: inset 2px 2px 5px rgba(0,0,0,0.1), inset -2px -2px 5px rgba(255,255,255,0.5);
                color: #5b3a3a;
                font-weight: 600;
            }

            .page-btn.active {
                background: linear-gradient(145deg, #f7bcb6, #f9d9d6);
                color: #fff;
                font-weight: bold;
                box-shadow: inset 2px 2px 6px rgba(0,0,0,0.15), inset -2px -2px 6px rgba(255,255,255,0.3);
                pointer-events: none;
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
                <h1 class="mb-4">Manage Medicine</h1>
                <div class="row align-items-center mb-4">
                    <div class="col-12">
                        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                            <!-- Bên trái: Search, Filter, Sort -->
                            <!-- Left: Form -->
                            <form action="${pageContext.request.contextPath}/Medicine" method="post"
                              class="d-flex align-items-center gap-2 flex-wrap" style="margin: 0;">

                            <input type="hidden" name="service" value="manageQuery" />
                            <input type="hidden" name="page" value="1" />
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
                        <th style="width: 150px;">Image</th>
                        <th style="width: 120px;">Name</th>
                        <th style="width: 80px;">Supplier</th>
                        <th style="width: 50px;">Medicine Type</th>
                        <th style="width: 125px;">Dosage</th>
                        <th style="width: 50px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="medicine" items="${medicineList}">
                        <tr>

                            <td>
                                <img src="${pageContext.request.contextPath}/${medicine.image}" alt="Medicine Image" 
                                     style="width: 100px; height: 60px; object-fit: cover; border-radius: 6px;">
                            </td>
                            <td><c:out value="${medicine.medicineName}"/></td>
                            <td><c:out value="${medicine.supplier}"/></td>
                            <td><c:out value="${medicine.type}"/></td>
                            <td style="max-width: 350px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                <c:out value="${medicine.dosage}"/>
                            </td>

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
                                   data-dosage="${medicine.dosage}"
                                   title="Update Medicine">
                                    <i class="fa fa-edit"></i> 
                                </a>
                                <form method="post" 
                                      action="${pageContext.request.contextPath}/Medicine" 
                                      onsubmit="return confirm('Are you sure to delete this medicine?');"
                                      style="display: inline;">
                                    <input type="hidden" name="service" value="deleteMedicine">
                                    <input type="hidden" name="medicineId" value="${medicine.medicineId}">
                                    <input type="hidden" name="page" value="${currentPage}">
                                    <button type="submit" 
                                            class="btn btn-sm btn-outline-danger" 
                                            style="background: #FF3B3B;" 
                                            title="Delete Medicine">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </form>

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
                        <div class="mb-3">
                            <label>Dosage</label>
                            <input type="text" pattern="^(?=.*[A-Za-z])(?!\s*$).{2,60}$" name="dosage" class="form-control" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <input type="submit" name="submit" class="btn btn-success" value="Add">
                        <input type="hidden" name="service" value="addMedicine">
                        <input type="hidden" name="page" value="${currentPage}">
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

                            <input type="hidden" name="oldImage" readonly class="form-control">
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
                        <div class="mb-3">
                            <label>Dosage</label>
                            <input type="text" pattern="^(?=.*[A-Za-z])(?!\s*$).{2,60}$" name="dosage" class="form-control" rows="3" required>
                        </div>
                    </div>
                    <input type="hidden" name="medicineId">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <input type="submit" name="submit" class="btn btn-info" value="Save">
                        <input type="hidden" name="service" value="updateMedicine">
                        <input type="hidden" name="page" id="update-page" value="${currentPage}">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <c:if test="${totalPages > 1}">
        <div class="modern-pagination">
            <c:if test="${currentPage > 1}">
                <a href="Medicine?service=getAllMedicines&page=${currentPage - 1}" class="page-btn">&laquo;</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="Medicine?service=getAllMedicines&page=${i}"
                   class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="Medicine?service=getAllMedicines&page=${currentPage + 1}" class="page-btn">&raquo;</a>
            </c:if>
        </div>
    </c:if>


    <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="Medicine?service=manageQuery
           &keyword=${searchKeyword}
           &medicineType=${selectedType}
           &sortBy=${selectedSort}
           &page=${i}"
           class="${i == currentPage ? 'active' : ''}">${i}</a>
    </c:forEach>                



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
                    var dosage = $(this).data("dosage");

                    $("#updateMedicine input[name='medicineId']").val(medicineId);
                    $("#updateMedicine input[name='oldImage']").val(imageUrl);
                    $("#updateMedicine input[name='medicineName']").val(medicineName);
                    $("#updateMedicine input[name='supplier']").val(supplier);
                    $("#updateMedicine select[name='type']").val(type);
                    $("#updateMedicine input[name='dosage']").val(dosage);

                    const urlParams = new URLSearchParams(window.location.search);
                    const currentPage = urlParams.get('page') || 1;
                    $("#updateMedicine input[name='page']").val(currentPage);
                });
            });
    </script>

</body>
</html>

