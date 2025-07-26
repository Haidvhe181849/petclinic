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
        <title>Feedback Management</title>

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

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

            #popup-message {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #d1e7dd;
                color: #0f5132;
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
                background-color: rgba(100, 116, 139, 0.5);
                border-radius: 3px;
            }

            #sidebar-scroll:hover::-webkit-scrollbar-thumb {
                background-color: rgba(100, 116, 139, 0.7);
            }

            html, body {
                height: 100%;
                overflow-x: hidden;
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

            .star-rating .fa-star {
                margin-right: 2px;
                color: #ffd600 !important;
            }

            .star-rating .fa-regular {
                color: #bdbdbd !important;
            }

            .customer-name {
                font-weight: 600;
                color: #ff3d3d;
            }

            .customer-email {
                font-size: 12px;
                color: #6c757d;
            }

            .preview-text {
                max-width: 350px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                color: #222;
            }

            .reply-preview {
                font-size: 13px;
                color: #ff3d3d;
                font-style: italic;
                margin-top: 4px;
                display: block;
            }

            /* Mobile responsive styles */
            @media (max-width: 1279px) {
                #sidebar {
                    display: none;
                }

                .main-content {
                    margin-left: 0 !important;
                }
            }

            @media (min-width: 1280px) {
                #sidebar {
                    display: flex !important;
                    position: relative;
                }

                .main-content {
                    margin-left: 0;
                }
            }

            /* Overlay for mobile */
            .sidebar-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 30;
                display: none;
            }

            .sidebar-overlay.show {
                display: block;
            }
        </style>

    </head>

    <body class="m-0 font-sans text-base antialiased font-normal dark:bg-slate-900 leading-default bg-gray-50 text-slate-500">
        <div class="flex">
            <!-- Sidebar -->
            <aside id="sidebar" class="w-64 h-screen bg-white dark:bg-slate-850 shadow-xl rounded-2xl flex flex-col"
                   aria-expanded="false">
                <div class="h-19">
                    <a class="block px-8 py-6 m-0 text-sm whitespace-nowrap dark:text-white text-slate-700" href="${pageContext.request.contextPath}/Home" >
                        <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" class="inline h-full max-w-full transition-all duration-200 dark:hidden ease-nav-brand max-h-8" alt="main_logo" />
                        <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" class="hidden h-full max-w-full transition-all duration-200 dark:inline ease-nav-brand max-h-8" alt="main_logo" />
                    </a>
                </div>

                <hr class="h-px mt-0 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent dark:bg-gradient-to-r dark:from-transparent dark:via-white dark:to-transparent" />
                <div id="sidebar-scroll" class="flex flex-col overflow-y-auto px-2"
                     style="height: calc(100vh - 5rem);">

                    <ul class="flex flex-col pl-0 mb-0">
                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${dashboardActive}" 
                               href="${pageContext.request.contextPath}/dashboard">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="text-blue-500 ni ni-tv-2"></i>
                                </div>
                                <span class="ml-1">Dashboard</span>
                            </a>
                        </li>

                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${accountActive}" 
                               href="${pageContext.request.contextPath}/account-management">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="text-red-600 ni ni-circle-08"></i>
                                </div>
                                <span class="ml-1">Account Managerment</span>
                            </a>
                        </li>   

                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${employeeActive}" 
                               href="${pageContext.request.contextPath}/Employee?service=listEmployee">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="text-red-600 ni ni-single-02"></i>
                                </div>
                                <span class="ml-1">Employee Managerment</span>
                            </a>
                        </li>
                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/News?service=listNews">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="relative top-0 text-sm leading-normal text-orange-500 ni ni-bullet-list-67"></i>
                                </div>
                                <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">News Management</span>
                            </a>
                        </li>

                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Service?service=listService">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center fill-current stroke-0 text-center xl:p-2.5">
                                    <i class="relative top-0 text-sm leading-normal text-emerald-500 ni ni-delivery-fast"></i>
                                </div>
                                <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Service Management</span>
                            </a>
                        </li>

                        <li class="mt-0.5 w-full">
                            <a href="javascript:void(0);" onclick="toggleDropdown('animalDropdown')" 
                               class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center justify-between whitespace-nowrap px-4 transition-colors ${animalActive}">
                                <div class="flex items-center">
                                    <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                        <i class="text-red-600 ni ni-world-2"></i>
                                    </div>
                                    <span class="ml-1">Quản lý Animal</span>
                                </div>
                                <i class="fas fa-chevron-down text-xs"></i>
                            </a>

                            <!-- dropdown items -->
                            <ul id="animalDropdown" class="hidden ml-12 mt-1">
                                <li class="mb-1">
                                    <a href="${pageContext.request.contextPath}/Animal?service=listType"
                                       class="block px-2 py-1 text-sm rounded hover:bg-gray-100 dark:hover:bg-slate-700 ${animalTypeActive}">
                                        Animal Type
                                    </a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/Breed?service=listBreed"
                                       class="block px-2 py-1 text-sm rounded hover:bg-gray-100 dark:hover:bg-slate-700 ${breedActive}">
                                        Breed
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-caps-small"></i>
                                </div>
                                <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Medicine Management</span>
                            </a>
                        </li>
                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${feedbackActive}" 
                               href="${pageContext.request.contextPath}/feedback-management">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="text-red-600 ni ni-chat-round"></i>
                                </div>
                                <span class="ml-1">Feedback Managerment</span>
                            </a>
                        </li>
                        <!--                <li class="mt-0.5 w-full">
                                                <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/account-management">
                                                    <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                                        <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-circle-08"></i>
                                                    </div>
                                                    <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Account Management</span>
                                                </a>
                                            </li>-->

                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-calendar-grid-58"></i>
                                </div>
                                <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Booking Management</span>
                            </a>
                        </li>
                        <li class="mt-0.5 w-full">
                            <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${timeActive}" 
                               href="${pageContext.request.contextPath}/ClinicWorking">
                                <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                    <i class="text-red-600 ni ni-chat-round"></i>
                                </div>
                                <span class="ml-1">Working Time</span>
                            </a>
                        </li>

                    </ul>
                </div>           
            </aside>

            <!-- Content Wrapper -->
            <main class="flex-1 min-h-screen p-6 main-content">
                <!-- Navbar -->
                <nav class="relative flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all ease-in shadow-none duration-250 rounded-2xl lg:flex-nowrap lg:justify-start"
                     navbar-main navbar-scroll="false">
                    <div class="flex items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit">
                        <nav>
                            <h6 class="mb-0 font-bold text-slate-700 dark:text-white">Feedback Management</h6>
                        </nav>

                        <div class="flex items-center mt-2 grow sm:mt-0 sm:mr-6 md:mr-0 lg:flex lg:basis-auto">
                            <ul class="flex flex-row justify-end pl-0 mb-0 list-none md-max:w-full">
                                <!-- Mobile menu removed for laptop-only design -->
                            </ul>
                        </div>
                    </div>
                </nav>

                <!-- Content -->
                <div class="w-full mx-auto">
                    <!-- Search and Actions -->
                    <div class="flex flex-wrap -mx-3">
                        <div class="flex-none w-full max-w-full px-3">
                            <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                                <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                    <div class="flex flex-wrap items-center mb-4">
                                        <div class="flex-grow">
                                            <h6 class="mb-2 text-slate-700 dark:text-white">Quản lý Feedback</h6>
                                            <p class="mb-0 text-sm leading-normal text-slate-400">Danh sách và quản lý feedback từ khách hàng</p>
                                        </div>
                                    </div>

                                    <!-- Alert Messages -->
                                    <c:if test="${not empty sessionScope.alertMessage}">
                                        <div class="p-3 mb-4 text-sm rounded-lg ${sessionScope.alertType == 'success' ? 'text-green-700 bg-green-100' : 'text-red-700 bg-red-100'}">
                                            <div id="popup-message">${sessionScope.alertMessage}</div>
                                            <script>
                                                setTimeout(function () {
                                                    var popup = document.getElementById("popup-message");
                                                    if (popup)
                                                        popup.style.display = "none";
                                                }, 3000);
                                            </script>
                                            <c:remove var="alertMessage" scope="session"/>
                                            <c:remove var="alertType" scope="session"/>
                                        </div>
                                    </c:if>

                                    <!-- Search Form -->
                                    <div class="flex flex-wrap items-center mb-4 gap-4">
                                        <form action="${pageContext.request.contextPath}/feedback-management" method="get" class="flex-grow max-w-md">
                                            <div class="relative">
                                                <input type="search" name="search" value="${param.search}" 
                                                       class="w-full px-4 py-2 text-sm bg-white border border-solid border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none dark:bg-slate-850 dark:border-slate-600 dark:text-white" 
                                                       placeholder="Tìm kiếm theo tên, email, nội dung...">
                                                <input type="hidden" name="action" value="list">
                                                <button type="submit" 
                                                        class="absolute right-2 top-1/2 transform -translate-y-1/2 px-3 py-1 text-xs text-white bg-blue-500 rounded hover:bg-blue-600">
                                                    <i class="fa fa-search"></i>
                                                </button>
                                            </div>
                                        </form>

                                        <a href="feedback-management?action=list" 
                                           class="px-4 py-2 text-sm text-white bg-slate-600 rounded-lg hover:bg-slate-700">
                                            Tất cả
                                        </a>
                                    </div>
                                </div>

                                <!-- Filters -->
                                <!-- Filters -->
                                <div class="px-6 pb-4">
                                    <div class="flex flex-wrap gap-4 mb-4">
                                        <div class="flex-grow max-w-xs">
                                            <select id="filterRating" class="w-full px-3 py-2 text-sm bg-white border border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none dark:bg-slate-850 dark:border-slate-600 dark:text-white" onchange="filterTable()">
                                                <option value="">Tất cả đánh giá</option>
                                                <option value="5">★★★★★ (5 sao)</option>
                                                <option value="4">★★★★☆ (4 sao)</option>
                                                <option value="3">★★★☆☆ (3 sao)</option>
                                                <option value="2">★★☆☆☆ (2 sao)</option>
                                                <option value="1">★☆☆☆☆ (1 sao)</option>
                                            </select>
                                        </div>
                                        <div class="flex-grow max-w-xs">
                                            <select id="filterStatus" class="w-full px-3 py-2 text-sm bg-white border border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none dark:bg-slate-850 dark:border-slate-600 dark:text-white" onchange="filterTable()">
                                                <option value="">Tất cả trạng thái</option>
                                                <option value="visible">Đang hiển thị</option>
                                                <option value="hidden">Đang ẩn</option>
                                                <option value="replied">Đã phản hồi</option>
                                                <option value="not-replied">Chưa phản hồi</option>
                                            </select>
                                        </div>
                                        <button class="px-4 py-2 text-sm text-gray-600 border border-gray-300 rounded-lg hover:bg-gray-50 dark:text-gray-300 dark:border-slate-600 dark:hover:bg-slate-700" onclick="clearSearch()">
                                            <i class="fa fa-times me-1"></i> Xóa bộ lọc
                                        </button>
                                    </div>
                                </div>

                                <!-- Table -->
                                <div class="flex-auto px-0 pt-0 pb-2">
                                    <div class="p-0 overflow-x-auto">
                                        <table class="items-center w-full mb-0 align-top border-gray-200 text-slate-500">
                                            <thead class="align-bottom">
                                                <tr>
                                                    <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70" onclick="sortTable(0)">ID <i class="fas fa-sort ml-1"></i></th>
                                                    <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70" onclick="sortTable(1)">Khách hàng <i class="fas fa-sort ml-1"></i></th>
                                                    <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70" onclick="sortTable(2)">Nội dung <i class="fas fa-sort ml-1"></i></th>
                                                    <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70" onclick="sortTable(3)">Đánh giá <i class="fas fa-sort ml-1"></i></th>
                                                    <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70" onclick="sortTable(4)">Ngày gửi <i class="fas fa-sort ml-1"></i></th>
                                                    <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70" onclick="sortTable(5)">Trạng thái <i class="fas fa-sort ml-1"></i></th>
                                                    <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="feedback" items="${feedbacks}">
                                                    <tr>
                                                        <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <div class="flex px-2 py-1">
                                                                <div class="flex flex-col justify-center">
                                                                    <h6 class="mb-0 text-sm leading-normal dark:text-white">#<c:out value="${feedback.feedbackId}"/></h6>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <div class="flex flex-col justify-center">
                                                                <h6 class="mb-0 text-sm leading-normal dark:text-white customer-name"><c:out value="${feedback.userName}"/></h6>
                                                                <p class="mb-0 text-xs leading-tight text-slate-400 customer-email"><c:out value="${feedback.userEmail}"/></p>
                                                            </div>
                                                        </td>
                                                        <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <div class="flex flex-col justify-center">
                                                                <p class="mb-0 text-sm font-semibold leading-tight dark:text-white preview-text">
                                                                    <c:out value="${feedback.feedbackText}"/>
                                                                </p>
                                                                <c:if test="${not empty feedback.replyText}">
                                                                    <p class="mb-0 text-xs leading-tight text-red-500 reply-preview">
                                                                        <i class="fas fa-reply me-1"></i>
                                                                        <c:out value="${feedback.replyText}"/>
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                        <td class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <div class="star-rating text-yellow-500">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <i class="fa${i <= feedback.starRating ? 's' : 'r'} fa-star"></i>
                                                                </c:forEach>
                                                            </div>
                                                        </td>
                                                        <td class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <span class="text-xs font-semibold leading-tight dark:text-white text-slate-400">
                                                                <fmt:formatDate value="${feedback.postTime}" pattern="dd/MM/yyyy HH:mm" />
                                                            </span>
                                                        </td>
                                                        </td>
                                                        <td class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <c:choose>
                                                                <c:when test="${feedback.visible}">
                                                                    <span class="bg-gradient-to-tl from-emerald-500 to-teal-400 px-2.5 text-xs rounded-1.8 py-1.4 inline-block whitespace-nowrap text-center align-baseline font-bold uppercase leading-none text-white">Hiển thị</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="bg-gradient-to-tl from-red-600 to-orange-600 px-2.5 text-xs rounded-1.8 py-1.4 inline-block whitespace-nowrap text-center align-baseline font-bold uppercase leading-none text-white">Ẩn</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <div class="flex items-center justify-center gap-2">
                                                                <a href="feedback-management?action=detail&id=${feedback.feedbackId}"
                                                                   class="inline-block px-3 py-2 text-xs font-bold text-center text-white uppercase align-middle transition-all rounded-lg cursor-pointer bg-gradient-to-tl from-orange-500 to-yellow-500 leading-normal shadow-md bg-150 bg-x-25 hover:shadow-xs active:opacity-85 hover:scale-102"
                                                                   title="Chi tiết">
                                                                    <i class="fa fa-eye mr-1"></i> 
                                                                </a>
                                                                <button onclick="toggleVisibility('${feedback.feedbackId}', '${!feedback.visible}')" 
                                                                        class="inline-block px-3 py-2 text-xs font-bold text-center text-white uppercase align-middle transition-all rounded-lg cursor-pointer ${feedback.visible ? 'bg-gradient-to-tl from-red-600 to-orange-600' : 'bg-gradient-to-tl from-emerald-500 to-teal-400'} leading-normal shadow-md bg-150 bg-x-25 hover:shadow-xs active:opacity-85 hover:scale-102" 
                                                                        title="${feedback.visible ? 'Ẩn' : 'Hiển thị'}">
                                                                    <i class="fa fa-${feedback.visible ? 'eye-slash' : 'eye'} mr-1"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty feedbacks}">
                                                    <tr>
                                                        <td colspan="7" class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                            <span class="text-sm font-semibold leading-tight dark:text-white text-slate-400">Không có dữ liệu feedback.</span>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="flex flex-wrap -mx-3 mt-6">
                            <div class="flex-none w-full max-w-full px-3">
                                <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                                    <div class="p-6">
                                        <div class="flex justify-center">
                                            <nav aria-label="Feedback pagination">
                                                <ul class="flex items-center space-x-1">
                                                    <!-- First Page -->
                                                    <c:if test="${currentPage > 1}">
                                                        <li>
                                                            <a href="feedback-management?action=list&page=1" 
                                                               class="relative block px-3 py-2 text-sm leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-slate-800 dark:border-slate-600 dark:text-slate-400 dark:hover:bg-slate-700"
                                                               title="Trang đầu">
                                                                <i class="fas fa-angle-double-left"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>

                                                    <!-- Previous Page -->
                                                    <c:if test="${currentPage > 1}">
                                                        <li>
                                                            <a href="feedback-management?action=list&page=${currentPage - 1}" 
                                                               class="relative block px-3 py-2 text-sm leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-slate-800 dark:border-slate-600 dark:text-slate-400 dark:hover:bg-slate-700"
                                                               title="Trang trước">
                                                                <i class="fas fa-angle-left"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>

                                                    <!-- Page Numbers -->
                                                    <c:forEach begin="${currentPage > 2 ? currentPage - 2 : 1}" 
                                                               end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" 
                                                               var="pageNum">
                                                        <li>
                                                            <a href="feedback-management?action=list&page=${pageNum}"
                                                               class="relative block px-3 py-2 text-sm leading-tight ${pageNum == currentPage ? 'text-white bg-blue-500 border-blue-500' : 'text-gray-500 bg-white border-gray-300 hover:bg-gray-100 hover:text-gray-700'} border dark:bg-slate-800 dark:border-slate-600 dark:text-slate-400 dark:hover:bg-slate-700">
                                                                ${pageNum}
                                                            </a>
                                                        </li>
                                                    </c:forEach>

                                                    <!-- Next Page -->
                                                    <c:if test="${currentPage < totalPages}">
                                                        <li>
                                                            <a href="feedback-management?action=list&page=${currentPage + 1}" 
                                                               class="relative block px-3 py-2 text-sm leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-slate-800 dark:border-slate-600 dark:text-slate-400 dark:hover:bg-slate-700"
                                                               title="Trang sau">
                                                                <i class="fas fa-angle-right"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>

                                                    <!-- Last Page -->
                                                    <c:if test="${currentPage < totalPages}">
                                                        <li>
                                                            <a href="feedback-management?action=list&page=${totalPages}" 
                                                               class="relative block px-3 py-2 text-sm leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-slate-800 dark:border-slate-600 dark:text-slate-400 dark:hover:bg-slate-700"
                                                               title="Trang cuối">
                                                                <i class="fas fa-angle-double-right"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </nav>
                                        </div>

                                        <!-- Pagination Info -->
                                        <div class="text-center mt-3">
                                            <span class="text-sm text-gray-500 dark:text-slate-400">
                                                Trang ${currentPage} / ${totalPages} (${feedbacks.size()} feedback)
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </main>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!-- Admin Dashboard JS -->
        <script src="${pageContext.request.contextPath}/Presentation/js/perfect-scrollbar.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/smooth-scrollbar.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/chartjs.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/argon-dashboard-tailwind.js?v=1.0.1"></script>

        <script>
                                                                // Filter table function
                                                                function filterTable() {
                                                                    const ratingFilter = document.getElementById('filterRating').value;
                                                                    const statusFilter = document.getElementById('filterStatus').value;
                                                                    const tbody = document.querySelector('table tbody');
                                                                    const rows = tbody.getElementsByTagName('tr');

                                                                    for (let row of rows) {
                                                                        if (row.querySelector('td[colspan="7"]'))
                                                                            continue; // Skip no data row

                                                                        const ratingDiv = row.cells[3].querySelector('.star-rating');
                                                                        let ratingStars = 0;
                                                                        if (ratingDiv) {
                                                                            ratingStars = ratingDiv.querySelectorAll('.fa-star.fas').length;
                                                                        }

                                                                        const hasReply = row.cells[2].querySelector('.reply-preview') !== null;
                                                                        const statusSpan = row.cells[5].querySelector('span');
                                                                        const isVisible = statusSpan && statusSpan.textContent.trim() === 'Hiển thị';

                                                                        // Rating filter
                                                                        const matchesRating = !ratingFilter || ratingStars == parseInt(ratingFilter);

                                                                        // Status filter
                                                                        let matchesStatus = true;
                                                                        if (statusFilter) {
                                                                            switch (statusFilter) {
                                                                                case 'visible':
                                                                                    matchesStatus = isVisible;
                                                                                    break;
                                                                                case 'hidden':
                                                                                    matchesStatus = !isVisible;
                                                                                    break;
                                                                                case 'replied':
                                                                                    matchesStatus = hasReply;
                                                                                    break;
                                                                                case 'not-replied':
                                                                                    matchesStatus = !hasReply;
                                                                                    break;
                                                                            }
                                                                        }

                                                                        row.style.display = (matchesRating && matchesStatus) ? '' : 'none';
                                                                    }
                                                                }

                                                                // Clear search and filters
                                                                function clearSearch() {
                                                                    document.getElementById('filterRating').value = '';
                                                                    document.getElementById('filterStatus').value = '';
                                                                    filterTable();
                                                                }

                                                                // Sort table function
                                                                let sortDirection = 1;
                                                                let lastSortedColumn = -1;

                                                                function sortTable(columnIndex) {
                                                                    const table = document.querySelector('table');
                                                                    const tbody = table.getElementsByTagName('tbody')[0];
                                                                    const rows = Array.from(tbody.getElementsByTagName('tr')).filter(row => !row.querySelector('td[colspan="7"]'));

                                                                    if (lastSortedColumn !== columnIndex) {
                                                                        sortDirection = 1;
                                                                    } else {
                                                                        sortDirection = -sortDirection;
                                                                    }
                                                                    lastSortedColumn = columnIndex;

                                                                    const headers = table.getElementsByTagName('th');
                                                                    for (let header of headers) {
                                                                        const icon = header.querySelector('i.fas');
                                                                        if (icon)
                                                                            icon.className = 'fas fa-sort ml-1';
                                                                    }

                                                                    const currentHeader = headers[columnIndex];
                                                                    const currentIcon = currentHeader.querySelector('i.fas');
                                                                    if (currentIcon) {
                                                                        currentIcon.className = sortDirection === 1 ? 'fas fa-sort-up ml-1' : 'fas fa-sort-down ml-1';
                                                                    }

                                                                    rows.sort((a, b) => {
                                                                        let aValue = a.cells[columnIndex].textContent.trim();
                                                                        let bValue = b.cells[columnIndex].textContent.trim();

                                                                        if (columnIndex === 3) { // Rating column
                                                                            aValue = a.cells[columnIndex].querySelector('.star-rating').querySelectorAll('.fa-star.fas').length;
                                                                            bValue = b.cells[columnIndex].querySelector('.star-rating').querySelectorAll('.fa-star.fas').length;
                                                                        } else if (columnIndex === 4) { // Date column
                                                                            aValue = new Date(aValue.split(' ').reverse().join(' ')).getTime();
                                                                            bValue = new Date(bValue.split(' ').reverse().join(' ')).getTime();
                                                                        } else if (columnIndex === 0) { // ID column
                                                                            aValue = parseInt(aValue.replace('#', ''));
                                                                            bValue = parseInt(bValue.replace('#', ''));
                                                                        }

                                                                        if (aValue < bValue)
                                                                            return -sortDirection;
                                                                        if (aValue > bValue)
                                                                            return sortDirection;
                                                                        return 0;
                                                                    });

                                                                    rows.forEach(row => tbody.appendChild(row));
                                                                }

                                                                // Toggle visibility function
                                                                function toggleVisibility(feedbackId, visible) {
                                                                    if (!feedbackId || feedbackId === 'undefined') {
                                                                        Swal.fire({
                                                                            title: 'Lỗi!',
                                                                            text: 'Không thể xác định ID của feedback',
                                                                            icon: 'error'
                                                                        });
                                                                        return;
                                                                    }

                                                                    const visibleStr = (visible === true || visible === 'true') ? 'true' : 'false';
                                                                    Swal.fire({
                                                                        title: visibleStr === 'true' ? 'Hiển thị feedback?' : 'Ẩn feedback?',
                                                                        text: visibleStr === 'true' ? 'Feedback này sẽ được hiển thị công khai.' : 'Feedback này sẽ bị ẩn khỏi trang web.',
                                                                        icon: 'warning',
                                                                        showCancelButton: true,
                                                                        confirmButtonColor: '#3085d6',
                                                                        cancelButtonColor: '#d33',
                                                                        confirmButtonText: 'Xác nhận',
                                                                        cancelButtonText: 'Hủy'
                                                                    }).then((result) => {
                                                                        if (result.isConfirmed) {
                                                                            try {
                                                                                window.location.href = 'feedback-management?action=toggle&id=' + feedbackId + '&visible=' + visibleStr;
                                                                            } catch (e) {
                                                                                console.error("Error navigating:", e);
                                                                                Swal.fire({
                                                                                    title: 'Lỗi!',
                                                                                    text: 'Có lỗi xảy ra khi thực hiện thao tác này',
                                                                                    icon: 'error'
                                                                                });
                                                                            }
                                                                        }
                                                                    });
                                                                }
        </script>
    </body>
</html>