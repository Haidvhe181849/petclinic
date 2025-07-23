<%-- 
    Document   : NewsManagerment
    Created on : Jun 11, 2025, 11:19:47 PM
    Author     : LENOVO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/Presentation/img/apple-icon.png" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Presentation/img/favicon.png" />
        <title>News Managerment</title>

        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <script src="${pageContext.request.contextPath}/Presentation/js/argon-dashboard-tailwind.js"></script>


        <!-- Nucleo Icons -->
        <link href="${pageContext.request.contextPath}/Presentation/css/nucleo-icons.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Presentation/css/nucleo-svg.css" rel="stylesheet" />
        <!-- Main Styling -->
        <link href="${pageContext.request.contextPath}/Presentation/css/argon-dashboard-tailwind.css?v=1.0.1" rel="stylesheet" />

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">



        <style>
            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            a {
                text-decoration: none !important;
            }

            a:hover {
                text-decoration: none !important;
            }

            .line-clamp-1 {
                display: -webkit-box;
                -webkit-line-clamp: 1;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: normal;
            }




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

            #sidebar-scroll::-webkit-scrollbar {
                width: 6px;
            }

            #sidebar-scroll::-webkit-scrollbar-track {
                background: transparent;
            }

            #sidebar-scroll::-webkit-scrollbar-thumb {
                background-color: rgba(100, 116, 139, 0.5); /* Slate-500 */
                border-radius: 3px;
            }

            #sidebar-scroll:hover::-webkit-scrollbar-thumb {
                background-color: rgba(100, 116, 139, 0.7);
            }

            #sidebar-scroll::-webkit-scrollbar {
                width: 6px;
            }

            html, body {
                height: 100%;
                overflow: hidden; /* nếu sidebar dùng fixed thì phần content có thể tự cuộn */
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

    <body class="m-0 font-sans text-base antialiased font-normal dark:bg-slate-900 leading-default bg-gray-50 text-slate-500"> 
        <jsp:include page="/Presentation/Sidebar.jsp" />
        <main class="relative overflow-y-auto xl:ml-68 rounded-xl" style="height: calc(100vh - 64px);">

            <!-- Navbar -->
            <nav class="relative flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all ease-in shadow-none duration-250 rounded-2xl lg:flex-nowrap lg:justify-start" navbar-main navbar-scroll="false">
                <div class="flex items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit">
                    <nav>
                        <!-- breadcrumb -->
                        <ol class="flex flex-wrap pt-1 mr-12 bg-transparent rounded-lg sm:mr-16">
                            <li class="text-sm leading-normal">
                                <a class="text-black opacity-50" href="${pageContext.request.contextPath}/homeemployee">Home</a>
                            </li>
                            <!--                            <li class="text-sm pl-2 capitalize leading-normal text-black before:float-left before:pr-2 before:text-white before:content-['/']" aria-current="page">Tables</li>-->
                        </ol>
                    </nav>                    
                </div>
            </nav>

            <!-- Header title on pink background -->
            <div class="w-full bg-pink-100 py-4 flex justify-center items-center">
                <h2 class="text-2xl font-bold text-gray-700">News Management</h2>
            </div> 

            <div class="w-full px-6 py-6 mx-auto">
                <!-- table 1 -->

                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-end">
                                    <div class="flex gap-2 items-center">
                                        <!-- Nút Sort -->
                                        <form action="${pageContext.request.contextPath}/News" method="get" class="flex items-center ml-2">
                                            <input type="hidden" name="service" value="nlist" />

                                            <input type="text" name="name" class="form-control" style="min-width: 180px"
                                                   value="${param.name}" placeholder="News name..."/>

                                            <select name="status" class="form-select form-select-sm w-auto">
                                                <option value="">All</option>
                                                <option value="active" ${status == 'active' ? 'selected' : ''}>Active</option>
                                                <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                            </select>

                                            <label for="fromDate" class="form-label m-0">From</label>
                                            <input type="date" id="fromDate" name="fromDate" class="form-control form-control-sm w-auto" value="${fromDate}"/>

                                            <label for="toDate" class="form-label m-0">To</label>
                                            <input type="date" id="toDate" name="toDate" class="form-control form-control-sm w-auto" value="${toDate}"/>

                                            <select name="order" class="..." onchange="this.form.submit()" type="submit">
                                                <option value="desc" <c:if test="${order eq 'desc'}">selected</c:if>>Newest</option>
                                                <option value="asc" <c:if test="${order eq 'asc'}">selected</c:if>>Oldest</option>
                                                </select>

                                                <button type="submit" class="btn btn-sm btn-outline-secondary">Filter</button>
                                            </form>



                                            <!-- Nút All -->
                                            <form action="${pageContext.request.contextPath}/News" method="get">
                                            <input type="hidden" name="service" value="nlist" />
                                            <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                All
                                            </button>
                                        </form>

                                        <!-- Nút Add News -->
                                        <a href="${pageContext.request.contextPath}/AddNews">
                                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                                Add News
                                            </button>
                                        </a>

                                    </div>
                                </div>



                            </div>
                            <div class="flex-auto px-0 pt-0 pb-2">
                                <div class="p-0 overflow-x-auto">
                                    <table class="items-center w-full mb-0 align-top border-collapse dark:border-white/40 text-slate-500">
                                        <thead class="align-bottom">
                                            <tr>
                                                <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">ID</th>
                                                <th class="px-6 py-3 pl-2 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Image</th>
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Title</th>
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Date</th>
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Description</th>
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Status</th>
                                                <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-collapse border-solid shadow-none dark:border-white/40 dark:text-white tracking-none whitespace-nowrap text-slate-400 opacity-70">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="news" items="${nlist}">
                                                <tr>
                                                    <!-- ID -->
                                                    <td><c:out value="${news.newsId}"/></td>

                                                    <!-- IMAGE -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">
                                                        <img src="${news.imageUrl}" alt="news image" style="width: 100px; height: 60px; object-fit: cover; border-radius: 6px;" />
                                                    </td>

                                                    <!-- TITLE -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">
                                                        <div class="line-clamp-1" title="${news.nameNews}">
                                                            <c:out value="${news.nameNews}" />
                                                        </div>

                                                    </td>

                                                    <!-- DATE -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black whitespace-nowrap">
                                                        <fmt:formatDate value="${news.postTime}" pattern="dd/MM/yyyy"/>
                                                    </td> 

                                                    <!-- DESCRIPTION -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <div class="line-clamp-2">
                                                            ${news.description} />
                                                        </div>
                                                    </td>

                                                    <!-- ACTIVE -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:choose>
                                                            <c:when test="${news.isActive == true}">
                                                                <span class="bg-green-500 text-blue-500 text-xs font-bold px-2 py-1 rounded badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="bg-red-500 text-red-600 text-xs font-bold px-2 py-1 rounded badge bg-secondary">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <td class="text-center">
                                                        <a href="${pageContext.request.contextPath}/UpdateNews?id=${news.newsId}" 
                                                           class="btn btn-sm btn-outline-primary me-2"
                                                           title="Edit News">
                                                            <i class="fas fa-edit"></i>
                                                        </a>


                                                        <a href="News?service=deleteNews&nID=<c:out value='${news.newsId}'/>" 
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tin này không?');" 
                                                           class="btn btn-sm btn-outline-danger" style="background: #0000;" title="Delete News">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Add News Modal -->
            <div id="addNewsModal" class="modal fade" tabindex="-1" aria-hidden="true">
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
                                    <input type="text" name="nameNews" class="form-control" required pattern="^(?!\s*$).{5,100}$"
                                           title="Tiêu đề không được để trống và từ 5 đến 100 ký tự">
                                </div>
                                <div class="mb-3">
                                    <label>Description</label>
                                    <textarea name="description" class="form-control" rows="10"
                                              required minlength="20" maxlength="5000"
                                              title="Mô tả từ 20 đến 5000 ký tự"></textarea>
                                </div>

                                <div class="mb-3">
                                    <label>Active</label><br>
                                    <input type="radio" name="isActive" value="true" checked/> Active
                                    <input type="radio" name="isActive" value="false" /> Inactive
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

            <c:if test="${not empty sessionScope.message}">
                <div id="popup-message" class="alert alert-success position-fixed top-0 end-0 m-4">
                    ${sessionScope.message}
                </div>
                <script>
                    setTimeout(function () {
                        var popup = document.getElementById("popup-message");
                        if (popup)
                            popup.style.display = "none";
                    }, 3000);
                </script>

                <c:remove var="message" scope="session"/>
            </c:if>

        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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


        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const sidebar = document.querySelector("aside");
                const hamburger = document.querySelector("[sidenav-trigger]");
                const closeBtn = document.querySelector("[sidenav-close]");

                if (hamburger) {
                    hamburger.addEventListener("click", function () {
                        const isOpen = sidebar.classList.contains("translate-x-0");
                        sidebar.classList.toggle("-translate-x-full", isOpen);
                        sidebar.classList.toggle("translate-x-0", !isOpen);
                    });
                }

                if (closeBtn) {
                    closeBtn.addEventListener("click", function () {
                        sidebar.classList.add("-translate-x-full");
                        sidebar.classList.remove("translate-x-0");
                    });
                }
            });
        </script>
    </body>


</html>
