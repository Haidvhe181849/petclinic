<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <title>Manager Product</title>
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
        <jsp:include page="Header.jsp"></jsp:include>
            <!-- Hero Area Start -->
            <div class="slider-area2 slider-height2 d-flex align-items-center">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="hero-cap text-center pt-50">
                                <h2>News</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>






            <!-- News Management Start -->
            <div class="container py-5">
                <h1 class="mb-4">Manage News</h1>
                <div class="row align-items-center mb-4">
                    <!-- Search + All -->
                    <div class="col-md-9">
                        <div class="d-flex align-items-center gap-2" style="height: 56px;">
                            <!-- Search -->
                            <form action="${pageContext.request.contextPath}/News" method="get" class="flex-grow-1">
                                <div class="input-group shadow-sm" style="height: 100%;">
                                    <input type="search" name="name" value="${nameNews}" 
                                       class="form-control border-0 ps-4 rounded-start" 
                                       placeholder="Find Account" style="height: 100%; font-size: 15px;">
                                <input type="hidden" name="service" value="nlist">
                                <button type="submit" name="submit" 
                                        class="btn text-white rounded-end px-4" 
                                        style="background-color: #FF3B3B; height: 100%;">
                                    <i class="fa fa-search me-1"></i> Search
                                </button>
                            </div>
                        </form>

                        <!-- All button -->
                        <a href="News?service=listNews" 
                           class="btn text-white px-4 d-flex align-items-center justify-content-center shadow-sm" 
                           style="background-color: #FF3B3B; height: 100%; border-radius: 25px;">
                            All
                        </a>
                    </div>
                </div>

                <!-- Add button -->
                <div class="col-md-3 mt-2 mt-md-0 text-md-end text-center">
                    <a href="#addEmployeeModal"
                       class="btn text-white fw-bold px-4 shadow-sm d-flex align-items-center justify-content-center w-100"
                       data-bs-toggle="modal"
                       style="background-color: #FF3B3B; height: 56px; border-radius: 30px;">
                        <i class="fa fa-plus me-2"></i> Add News
                    </a>
                </div>
            </div>




            <table class="table table-bordered table-hover align-middle">
                <thead class="table-primary" style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                    <tr>
                        <th style="width: 60px;">ID</th>
                        <th style="width: 120px;">Image</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th style="width: 120px;">Post Time</th>
                        <th style="width: 80px;">Active</th>
                        <th style="width: 140px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="news" items="${nlist}">
                        <tr>
                            <td><c:out value="${news.newsId}"/></td>
                            <td>
                                <img src="<c:out value='${news.imageUrl}'/>" alt="News Image" 
                                     style="width: 100px; height: 60px; object-fit: cover; border-radius: 6px;">
                            </td>
                            <td><c:out value="${news.nameNews}"/></td>
                            <td style="max-width: 350px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                <c:out value="${news.description}"/>
                            </td>
                            <td><c:out value="${news.postTime}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${news.isActive}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Deactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="text-center">
                                <a href="#"
                                   class="btn btn-sm btn-outline-primary me-2 update-btn"
                                   style="background: #fd7e14; te"
                                   data-bs-toggle="modal"
                                   data-bs-target="#editEmployeeModal"
                                   data-id="${news.newsId}"
                                   data-image="${news.imageUrl}"
                                   data-name="${news.nameNews}"
                                   data-date="${fn:escapeXml(news.postTime)}"
                                   data-describe="${fn:escapeXml(news.description)}"
                                   data-active="${news.isActive ? 1 : 0}"
                                   data-oldimage="${news.imageUrl}"
                                   title="Edit News">
                                    <i class="fa fa-edit" ></i> 
                                </a>
                                <a href="News?service=deleteNews&nID=<c:out value='${news.newsId}'/>" 
                                   onclick="return confirm('Are you sure to delete this news?');" 
                                   class="btn btn-sm btn-outline-danger" style="background: #FF3B3B; te" title="Delete News">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty nlist}">
                        <tr>
                            <td colspan="7" class="text-center">No news found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <!-- News Management End -->

        <c:if test="${not empty sessionScope.message}">
            <div id="popup-message">${sessionScope.message}</div>

            <script>
                setTimeout(function () {
                    var popup = document.getElementById("popup-message");
                    if (popup)
                        popup.style.display = "none";
                }, 3000);
            </script>

            <c:remove var="message" scope="session"/>
        </c:if>


        <!-- Add News Modal -->
        <div id="addEmployeeModal" class="modal fade" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/News" method="post" enctype="multipart/form-data">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add News</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">	
                            <div class="mb-3">
                                <label>Image URL</label>
                                <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                            </div>
                            <div class="mb-3">
                                <label>Title</label>
                                <input type="text" name="nameNews" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label>Description</label>
                                <textarea name="description" class="form-control" rows="10" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label>Active</label><br>
                                <input type="radio" name="isActive" value="true" checked/> Active
                                <input type="radio" name="isActive" value="false" /> Deactive
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="submit" name="submit" class="btn btn-success" value="Add">
                            <input type="hidden" name="service" value="addNews">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Update News Modal -->
        <div id="editEmployeeModal" class="modal fade" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/News" method="post" enctype="multipart/form-data">
                        <div class="modal-header">						
                            <h4 class="modal-title">Update News</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label>ID</label>
                                <input name="newsId" type="text" class="form-control" readonly required>
                            </div>
                            <div class="mb-3">
                                <label>Image URL</label>
                                <input type="text" name="oldImage" value="${news.imageUrl}" readonly required>
                            </div>
                            <div class="mb-3">
                                <label>Image URL</label>
                                <input type="file" name="imageFile" class="form-control" accept="image/*">
                            </div>
                            <div class="mb-3">
                                <label>Name</label>
                                <input type="text" name="nameNews" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label>Time</label>
                                <input type="text" name="postTime" class="form-control" readonly>
                            </div>
                            <div class="mb-3">
                                <label>Description</label>
                                <textarea name="description" class="form-control" rows="10" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label>Active</label><br>
                                <input type="radio" name="isActive" value="1"> Active
                                <input type="radio" name="isActive" value="0"> Deactive
                            </div>                          					
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <input type="submit" name="submit" class="btn btn-info" value="Save">
                            <input type="hidden" name="service" value="updateNews">                           
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Fruits Shop End-->

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
                        // Lấy từ data-attributes
                        var newsId = $(this).data("id");
                        var imageUrl = $(this).data("image");
                        var nameNews = $(this).data("name");
                        var postTime = $(this).data("date");
                        var description = $(this).data("describe");
                        var isActive = $(this).data("active");
                        var oldImage = $(this).data("oldimage");

                        // Debug nhanh: kiểm tra console
                        console.log("ID:", newsId,
                                "imageUrl:", imageUrl,
                                "oldImage:", oldImage,
                                "name:", nameNews,
                                "time:", postTime,
                                "desc:", description,
                                "active:", isActive);

                        // Đổ giá trị vào các input trong modal
                        $("#editEmployeeModal input[name='newsId']").val(newsId);
                        $("#editEmployeeModal input[name='postTime']").val(postTime);
                        $("#editEmployeeModal input[name='nameNews']").val(nameNews);
                        $("#editEmployeeModal textarea[name='description']").val(description);
                        $("#editEmployeeModal input[name='oldImage']").val(oldImage);

                        // Set radio Active/Deactive
                        if (isActive == 1 || isActive === "1" || isActive === true) {
                            $("#editEmployeeModal input[name='isActive'][value='1']").prop("checked", true);
                        } else {
                            $("#editEmployeeModal input[name='isActive'][value='0']").prop("checked", true);
                        }
                    });
                });
        </script>

    </body>
</html>

