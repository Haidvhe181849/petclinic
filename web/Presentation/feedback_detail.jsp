<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/Presentation/img/apple-icon.png" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Presentation/img/favicon.png" />
        <title>Feedback Detail Management</title>

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
        
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
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

            .rating {
                color: #ffb300;
                font-size: 1.2rem;
            }

            .user-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: #FF3B3B;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-right: 15px;
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
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class=" relative top-0 text-sm leading-normal text-blue-500 ni ni-tv-2"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Dashboard</span>
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
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-caps-small"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Medicine Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/account-management">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-circle-08"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Account Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-calendar-grid-58"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Booking Management</span>
                        </a>
                    </li>
                    
                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 bg-blue-500/13 dark:text-white dark:opacity-80 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap rounded-lg px-4 font-semibold text-slate-700 transition-colors" href="${pageContext.request.contextPath}/feedback-management">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-purple-500 ni ni-chat-round"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Feedback Management</span>
                        </a>
                    </li>

                    <li class="w-full mt-4">
                        <h6 class="pl-6 ml-2 text-xs font-bold leading-tight uppercase dark:text-white opacity-60">Account pages</h6>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="../pages/profile.html">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-slate-700 ni ni-single-02"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Profile</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="../pages/sign-in.html">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-orange-500 ni ni-single-copy-04"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Sign In</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="../pages/sign-up.html">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-collection"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Sign Up</span>
                        </a>
                    </li>
                </ul>
            </div>           
        </aside>
        
        <!-- Content Wrapper -->
        <main class="flex-1 min-h-screen p-6">

            <!-- Navbar -->
            <nav class="relative flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all ease-in shadow-none duration-250 rounded-2xl lg:flex-nowrap lg:justify-start"
                 navbar-main navbar-scroll="false">
                <div class="flex items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit">
                    <nav>
                        <h6 class="mb-0 font-bold text-slate-700 dark:text-white">Chi tiết Feedback</h6>
                    </nav>
                </div>
            </nav>

            <!-- Content -->
            <div class="w-full mx-auto">
                <!-- Alert Messages -->
                <c:if test="${not empty sessionScope.alertMessage}">
                    <div class="p-3 mb-4 text-sm rounded-lg ${sessionScope.alertType == 'success' ? 'text-green-700 bg-green-100' : 'text-red-700 bg-red-100'}">
                        <div id="popup-message">${sessionScope.alertMessage}</div>
                        <script>
                            setTimeout(function () {
                                var popup = document.getElementById("popup-message");
                                if (popup) popup.style.display = "none";
                            }, 3000);
                        </script>
                        <c:remove var="alertMessage" scope="session"/>
                        <c:remove var="alertType" scope="session"/>
                    </div>
                </c:if>

                <!-- Back Button -->
                <div class="flex flex-wrap -mx-3 mb-6">
                    <div class="flex-none w-full max-w-full px-3">
                        <a href="feedback-management?action=list" 
                           class="inline-block px-6 py-3 text-sm font-bold text-center text-white uppercase align-middle transition-all rounded-lg cursor-pointer bg-gradient-to-tl from-red-600 to-orange-600 leading-normal shadow-md bg-150 bg-x-25 hover:shadow-xs active:opacity-85 hover:scale-102">
                            <i class="fa fa-arrow-left mr-2"></i> Quay về danh sách
                        </a>
                    </div>
                </div>

                <c:if test="${not empty feedback}">
                    <div class="flex flex-wrap -mx-3">
                        <!-- Main Content -->
                        <div class="flex-none w-full max-w-full px-3 lg:w-2/3 lg:flex-none">
                            <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                                <div class="p-6">
                                    <!-- Feedback Header -->
                                    <div class="flex items-center mb-6">
                                        <div class="user-avatar">
                                            ${fn:substring(feedback.userName, 0, 1)}
                                        </div>
                                        <div>
                                            <h5 class="mb-1 text-lg font-semibold text-slate-700 dark:text-white">${feedback.userName}</h5>
                                            <p class="mb-0 text-sm leading-normal text-slate-400">${feedback.userEmail}</p>
                                            <div class="flex items-center mt-2 rating">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fa${i <= feedback.starRating ? 's' : 'r'} fa-star text-yellow-500"></i>
                                                </c:forEach>
                                                <span class="ml-2 text-sm text-slate-400">(${feedback.starRating}/5)</span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Badge -->
                                    <div class="mb-4">
                                        <c:choose>
                                            <c:when test="${feedback.visible}">
                                                <span class="bg-gradient-to-tl from-emerald-500 to-teal-400 px-3 py-1 text-xs rounded-lg inline-block whitespace-nowrap text-center align-baseline font-bold uppercase leading-none text-white">Đang hiển thị</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="bg-gradient-to-tl from-red-600 to-orange-600 px-3 py-1 text-xs rounded-lg inline-block whitespace-nowrap text-center align-baseline font-bold uppercase leading-none text-white">Đang ẩn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Feedback Content -->
                                    <div class="mb-4">
                                        <h6 class="mb-2 text-sm font-bold leading-tight uppercase text-slate-400 opacity-70">Nội dung feedback:</h6>
                                        <p class="mb-0 text-sm font-normal leading-normal text-slate-700 dark:text-white">${feedback.feedbackText}</p>
                                    </div>

                                    <!-- Booking Info -->
                                    <div class="mb-4 p-3 bg-gray-50 rounded-lg dark:bg-slate-800">
                                        <p class="mb-0 text-xs leading-tight text-slate-400">
                                            <i class="fas fa-calendar mr-2"></i>
                                            Booking ID: <span class="font-semibold">${feedback.bookingId}</span> | 
                                            Ngày gửi: <span class="font-semibold"><fmt:formatDate value="${feedback.postTime}" pattern="dd/MM/yyyy HH:mm" /></span>
                                        </p>
                                    </div>

                                    <!-- Existing Reply -->
                                    <c:if test="${not empty feedback.replyText}">
                                        <div class="p-4 mb-4 bg-blue-50 border-l-4 border-blue-500 rounded-lg dark:bg-slate-800 dark:border-blue-400">
                                            <h6 class="mb-2 text-sm font-bold text-blue-700 dark:text-blue-400">
                                                <i class="fas fa-reply mr-2"></i>Phản hồi của quản trị viên:
                                            </h6>
                                            <p class="mb-0 text-sm text-blue-600 dark:text-blue-300">${feedback.replyText}</p>
                                        </div>
                                    </c:if>

                                    <!-- Reply Form -->
                                    <div class="pt-4 border-t border-gray-200 dark:border-slate-600">
                                        <h6 class="mb-3 text-sm font-bold leading-tight uppercase text-slate-400 opacity-70">
                                            <c:choose>
                                                <c:when test="${not empty feedback.replyText}">
                                                    Cập nhật phản hồi:
                                                </c:when>
                                                <c:otherwise>
                                                    Gửi phản hồi:
                                                </c:otherwise>
                                            </c:choose>
                                        </h6>
                                        <form action="feedback-management" method="post">
                                            <input type="hidden" name="action" value="reply">
                                            <input type="hidden" name="id" value="${feedback.feedbackId}">
                                            <div class="mb-3">
                                                <textarea name="replyText" 
                                                          class="w-full px-3 py-2 text-sm bg-white border border-gray-300 rounded-lg focus:border-blue-500 focus:outline-none dark:bg-slate-850 dark:border-slate-600 dark:text-white" 
                                                          rows="4" 
                                                          placeholder="Nhập nội dung phản hồi..." 
                                                          required>${feedback.replyText}</textarea>
                                            </div>
                                            <div class="flex gap-2">
                                                <button type="submit" 
                                                        class="inline-block px-6 py-3 text-xs font-bold text-center text-white uppercase align-middle transition-all rounded-lg cursor-pointer bg-gradient-to-tl from-blue-500 to-blue-700 leading-normal shadow-lg bg-150 bg-x-25 hover:shadow-xl active:opacity-85 hover:scale-102 border-0"
                                                        style="background: linear-gradient(135deg, #3b82f6, #1d4ed8) !important; box-shadow: 0 4px 14px 0 rgba(59, 130, 246, 0.3) !important;">
                                                    <i class="fas fa-paper-plane mr-2"></i>
                                                    <c:choose>
                                                        <c:when test="${not empty feedback.replyText}">
                                                            Cập nhật phản hồi
                                                        </c:when>
                                                        <c:otherwise>
                                                            Gửi phản hồi
                                                        </c:otherwise>
                                                    </c:choose>
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sidebar Actions -->
                        <div class="flex-none w-full max-w-full px-3 lg:w-1/3 lg:flex-none">
                            <!-- Actions Card -->
                            <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                                <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                    <h6 class="mb-0 text-slate-700 dark:text-white">
                                        <i class="fas fa-cogs mr-2"></i>Thao tác
                                    </h6>
                                </div>
                                <div class="flex-auto p-6 pt-0">
                                    <div class="flex flex-col gap-3">
                                        <button onclick="toggleVisibility('${feedback.feedbackId}', '${!feedback.visible}')" 
                                                class="inline-block px-6 py-3 text-xs font-bold text-center text-white uppercase align-middle transition-all rounded-lg cursor-pointer ${feedback.visible ? 'bg-gradient-to-tl from-orange-500 to-yellow-500' : 'bg-gradient-to-tl from-emerald-500 to-teal-400'} leading-normal shadow-md bg-150 bg-x-25 hover:shadow-xs active:opacity-85 hover:scale-102">
                                            <i class="fas fa-${feedback.visible ? 'eye-slash' : 'eye'} mr-2"></i>
                                            ${feedback.visible ? 'Ẩn feedback' : 'Hiển thị feedback'}
                                        </button>
                                        
                                        <a href="feedback-management?action=list" 
                                           class="inline-block px-6 py-3 text-xs font-bold text-center text-white uppercase align-middle transition-all rounded-lg cursor-pointer bg-gradient-to-tl from-slate-600 to-slate-400 leading-normal shadow-md bg-150 bg-x-25 hover:shadow-xs active:opacity-85 hover:scale-102">
                                            <i class="fas fa-list mr-2"></i>Danh sách feedback
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Feedback Info Card -->
                            <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                                <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                    <h6 class="mb-0 text-slate-700 dark:text-white">
                                        <i class="fas fa-info-circle mr-2"></i>Thông tin
                                    </h6>
                                </div>
                                <div class="flex-auto p-6 pt-0">
                                    <table class="items-center w-full mb-0 align-top border-gray-200 text-slate-500">
                                        <tbody>
                                            <tr>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-xs font-semibold leading-tight dark:text-white text-slate-400">ID:</p>
                                                </td>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-sm font-semibold leading-tight dark:text-white">${feedback.feedbackId}</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-xs font-semibold leading-tight dark:text-white text-slate-400">User ID:</p>
                                                </td>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-sm font-semibold leading-tight dark:text-white">${feedback.userId}</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-xs font-semibold leading-tight dark:text-white text-slate-400">Booking ID:</p>
                                                </td>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-sm font-semibold leading-tight dark:text-white">${feedback.bookingId}</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-xs font-semibold leading-tight dark:text-white text-slate-400">Đánh giá:</p>
                                                </td>
                                                <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-sm font-semibold leading-tight dark:text-white">${feedback.starRating}/5 sao</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-2 align-middle bg-transparent whitespace-nowrap shadow-transparent">
                                                    <p class="mb-0 text-xs font-semibold leading-tight dark:text-white text-slate-400">Trạng thái:</p>
                                                </td>
                                                <td class="p-2 align-middle bg-transparent whitespace-nowrap shadow-transparent">
                                                    <c:choose>
                                                        <c:when test="${feedback.visible}">
                                                            <span class="bg-gradient-to-tl from-emerald-500 to-teal-400 px-2.5 text-xs rounded-1.8 py-1.4 inline-block whitespace-nowrap text-center align-baseline font-bold uppercase leading-none text-white">Hiển thị</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="bg-gradient-to-tl from-red-600 to-orange-600 px-2.5 text-xs rounded-1.8 py-1.4 inline-block whitespace-nowrap text-center align-baseline font-bold uppercase leading-none text-white">Ẩn</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty feedback}">
                    <div class="flex flex-wrap -mx-3">
                        <div class="flex-none w-full max-w-full px-3">
                            <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                                <div class="p-6 text-center">
                                    <div class="p-4 mb-4 text-orange-700 bg-orange-100 rounded-lg dark:bg-orange-200 dark:text-orange-800">
                                        <i class="fas fa-exclamation-triangle mr-2"></i>
                                        Không tìm thấy thông tin feedback.
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