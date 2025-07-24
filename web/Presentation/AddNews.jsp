<%-- 
    Document   : AddNews
    Created on : Jul 23, 2025, 9:50:33 PM
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
            /* Đặt chiều cao cho khung editor */
            .ck-editor__editable_inline {
                min-height: 1000px; /* hoặc 800px nếu muốn cao hơn */
            }


            /* Đặt chiều cao cho khung editor */
            .ck-editor__editable_inline {
                min-height: 1000px; /* hoặc 800px nếu muốn cao hơn */
            }

            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                line-clamp: 2;
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
                line-clamp: 1;
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

            .schedule-entry {
                display: flex;
                gap: 10px;
                flex-wrap: nowrap;
                align-items: center;
            }
            .schedule-entry > div {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 150px; /* hoặc tùy chỉnh theo thiết kế */
            }

            .schedule-entry > div {
                white-space: nowrap;        /* Không xuống dòng */
                overflow: hidden;           /* Ẩn phần vượt quá */
                text-overflow: ellipsis;    /* Thêm dấu "..." nếu quá dài */
            }

            .schedule-entry {
                display: flex;
                flex-direction: column;  /* Mỗi div là 1 dòng */
                gap: 4px;                /* Khoảng cách giữa các dòng */
            }



            html, body {
                height: 100%;
                overflow: hidden; /* nếu sidebar dùng fixed thì phần content có thể tự cuộn */
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
                <h2 class="text-2xl font-bold text-gray-700">Add News</h2>
            </div> 

            <div class="w-full px-6 py-6 mx-auto">
                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-end">
                                    <div class="flex gap-2 items-center">
                                        <!-- Có thể thêm nút ở đây nếu cần -->
                                    </div>
                                </div>
                            </div>
                            <div class="flex-auto px-0 pt-0 pb-2">
                                <div class="p-0 overflow-x-auto">
                                    <form action="${pageContext.request.contextPath}/AddNews" method="post" enctype="multipart/form-data" class="p-4">

                                        <div class="mb-3">
                                            <label>Image</label>
                                            <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                                        </div>

                                        <div class="mb-3">
                                            <label>Title</label>
                                            <input type="text" name="nameNews" class="form-control" required pattern="^(?!\s*$).{5,100}$"
                                                   title="Tiêu đề không được để trống và từ 5 đến 100 ký tự">
                                        </div>

                                        <div class="mb-3">
                                            <label for="description">Description</label>
                                            <textarea name="description" id="editor" required></textarea>
                                            <small class="text-muted">Bắt buộc nhập nội dung, ít nhất 20 ký tự thực tế.</small>
                                        </div>

                                        <div class="mb-3">
                                            <label>Active</label><br>
                                            <input type="radio" name="isActive" value="1" checked> Active
                                            <input type="radio" name="isActive" value="0"> Inactive
                                        </div>

                                        <button type="submit" class="btn btn-primary">Add News</button>
                                        <a href="${pageContext.request.contextPath}/News?service=listNews" class="btn btn-secondary">Cancel</a>
                                    </form>
                                </div>
                            </div>
                        </div>
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
        <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


        <script>
                    CKEDITOR.replace('editor', {
                        filebrowserUploadUrl: '${pageContext.request.contextPath}/NewsImageUpload',
                        filebrowserUploadMethod: 'form'
                    });
        </script>




    </body>


</html>

