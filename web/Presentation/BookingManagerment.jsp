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
        <title>Service Managerment</title>

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
                <h2 class="text-2xl font-bold text-gray-700">Booking Management</h2>
            </div>
            <div class="w-full px-6 py-6 mx-auto">
                <!-- table 1 -->

                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-end">
                                    <div class="flex gap-2 items-center">
                                        <form action="${pageContext.request.contextPath}/ConfirmBooking" method="get" class="d-flex gap-2 align-items-center flex-wrap">
                                            <input type="hidden" name="service" value="blist" />

                                            <!-- Search by Booking ID -->
                                            <input type="text" name="keyword" style="min-width: 300px"
                                                   placeholder="Booking ID hoặc tên bác sĩ..." value="${param.keyword}" />

                                            <!-- Status Filter -->
                                            <select name="status" class="form-select form-select-sm w-auto">
                                                <option value="">All Status</option>
                                                <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                <option value="Confirmed" ${param.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                                <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                            </select>

                                            <!-- From Date -->
                                            <label for="fromDate" class="form-label m-0">From</label>
                                            <input type="date" id="fromDate" name="fromDate" class="form-control form-control-sm w-auto"
                                                   value="${param.fromDate}" />

                                            <!-- To Date -->
                                            <label for="toDate" class="form-label m-0">To</label>
                                            <input type="date" id="toDate" name="toDate" class="form-control form-control-sm w-auto"
                                                   value="${param.toDate}" />

                                            <!-- Sort by Time -->
                                            <select name="order" class="form-select form-select-sm w-auto">
                                                <option value="">Sort by time</option>
                                                <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>Newest</option>
                                                <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>Oldest</option>
                                            </select>

                                            <!-- Submit Filter -->
                                            <button type="submit" class="btn btn-sm btn-primary">Filter</button>

                                            <!-- Reset All -->
                                            <a href="${pageContext.request.contextPath}/ConfirmBooking?service=blist" 
                                               class="btn btn-sm btn-secondary">All</a>
                                        </form>
                                    </div>
                                </div>



                            </div>
                            <div class="flex-auto px-0 pt-0 pb-2">
                                <div class="p-0 overflow-x-auto">
                                    <table class="items-center w-full mb-0 align-top border-collapse dark:border-white/40 text-slate-500">
                                        <thead class="align-bottom">
                                            <tr>
                                        <thead>
                                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Booking ID</th>
                                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Customer</th>
                                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Pet</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Type</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Service</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Doctor</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Booking Time</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Status</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Accept</th>
                                        <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-collapse border-solid shadow-none dark:border-white/40 dark:text-white tracking-none whitespace-nowrap text-slate-400 opacity-70">Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="b" items="${blist}">
                                                <tr>
                                                    <!-- Booking ID -->
                                                    <td>
                                                        <c:out value="${b.bookingId}" />
                                                    </td>

                                                    <!-- Customer Name -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">
                                                        <c:out value="${b.customerName}" />
                                                    </td>

                                                    <!-- Pet Name -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.petName}" />
                                                    </td>

                                                    <!-- Pet Type -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.petType}" />
                                                    </td>

                                                    <!-- Service Name -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.serviceName}" />
                                                    </td>

                                                    <!-- Doctor Name -->
                                                    <td class="...">
                                                        <c:choose>
                                                            <c:when test="${not empty b.employeeName}">
                                                                <c:out value="${b.employeeName}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                Not selected yet
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <!-- Booking Time -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <fmt:formatDate value="${b.bookingTime}" pattern="yyyy-MM-dd HH:mm" />
                                                    </td>
                                                    <!-- Status -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.status}" />
                                                    </td>

                                                    <!-- Accept -->
                                                    <td class="text-center">
                                                        <form action="${pageContext.request.contextPath}/ConfirmBooking" method="post">
                                                            <input type="hidden" name="service" value="updateStatus" />
                                                            <input type="hidden" name="bookingId" value="${b.bookingId}" />

                                                            <select name="status"
                                                                    class="text-sm rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 p-1 bg-white dark:bg-slate-800 dark:text-white"
                                                                    onchange="handleStatusChange(this, '${b.bookingId}')"
                                                                    data-current-status="${b.status}">

                                                                <option value="Pending">Choose Status</option>
                                                                <c:if test="${b.status eq 'Pending' || b.status eq 'Cancelled_Pending'}">
                                                                    <option value="Confirmed">Confirmed</option>
                                                                    <option value="Cancelled">Cancelled</option>
                                                                </c:if>

                                                                <c:if test="${b.status ne 'Pending' && b.status ne 'Cancelled_Pending'}">
                                                                    <option value="${b.status}" selected>${b.status}</option>
                                                                </c:if>

                                                            </select>

                                                            <!-- Hiện input nhập lý do khi chọn Cancelled -->
                                                            <div id="cancelReasonDiv-${b.bookingId}" style="display:none; margin-top: 5px;">
                                                                <input type="text" name="cancelReason" placeholder="Enter cancel reason"
                                                                       class="text-sm p-1 rounded border border-red-400 w-full" />
                                                            </div>
                                                        </form>
                                                    </td>
                                                    <!-- Actions -->
                                                    <td class="text-center">
                                                        <a href="ConfirmBooking?service=bookingDetail&bookingId=${b.bookingId}"
                                                           class="text-blue-600 hover:text-blue-800"
                                                           title="Xem chi tiết">
                                                            <i class="fa fa-eye"></i>
                                                        </a>

                                                        <!-- View Invoice -->
                                                        <a href="${pageContext.request.contextPath}/ViewInvoice?bookingId=${b.bookingId}"
                                                           class="text-green-600 hover:text-green-800 me-2"
                                                           title="Xem hóa đơn">
                                                            <i class="fas fa-file-invoice"></i>
                                                        </a>

                                                        <!-- Delete -->
                                                        <form action="ConfirmBooking" method="get" style="display:inline;" 
                                                              onsubmit="return confirm('Bạn có chắc chắn muốn xoá booking này không?');">
                                                            <input type="hidden" name="service" value="deleteBooking"/>
                                                            <input type="hidden" name="bookingId" value="${b.bookingId}"/>
                                                            <button type="submit" class="text-red-600 hover:text-red-800" title="Xoá">
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
                        </div>
                    </div>
                </div>
            </div>




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


            <!-- Booking Detail Modal -->
            <c:if test="${not empty bookingDetail}">
                <div class="mt-6 p-6 rounded-lg border bg-white shadow-md text-slate-700 dark:bg-slate-800 dark:text-white">
                    <h2 class="text-xl font-bold mb-4">Booking Detail Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">

                        <div><strong>Booking ID:</strong> ${bookingDetail.bookingId}</div>
                        <div><strong>Customer Name:</strong> ${bookingDetail.customerName}</div>
                        <div><strong>Phone Number:</strong> ${bookingDetail.customerPhone}</div>
                        <div><strong>Email:</strong> ${bookingDetail.customerEmail}</div>
                        <div><strong>Pet Name:</strong> ${bookingDetail.petName}</div>
                        <div><strong>Breed:</strong> ${bookingDetail.breed}</div>
                        <div><strong>Pet Type:</strong> ${bookingDetail.petType}</div>
                        <div><strong>Service:</strong> ${bookingDetail.serviceName}</div>
                        <div><strong>Doctor:</strong> ${bookingDetail.employeeName}</div>
                        <div><strong>Booking Time:</strong> 
                            <fmt:formatDate value="${bookingDetail.bookingTime}" pattern="yyyy-MM-dd HH:mm" />
                        </div>
                        <div><strong>Note:</strong> ${bookingDetail.note}</div>
                        <div><strong>Status:</strong> ${bookingDetail.status}</div>

                        <c:if test="${bookingDetail.status eq 'Cancelled'}">
                            <div class="text-red-600 col-span-2"><strong>Cancel Reason:</strong> ${bookingDetail.cancelReason}</div>
                        </c:if>

                        <c:if test="${bookingDetail.actualCheckinTime != null}">
                            <div class="text-green-600 col-span-2"><strong>Actual Check-in:</strong> 
                                <fmt:formatDate value="${bookingDetail.actualCheckinTime}" pattern="yyyy-MM-dd HH:mm" />
                            </div>
                        </c:if>

                    </div>
                </div>
            </c:if>








        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <c:if test="${not empty bookingDetail}">
            <script>
                    $(document).ready(function () {
                        $("#BookingDetailModal").modal("show");

                        $("#BookingDetailModal input[name='bookingId']").val("${bookingDetail.bookingId}");
                        $("#BookingDetailModal input[name='customerName']").val("${bookingDetail.customerName}");
                        $("#BookingDetailModal input[name='customerPhone']").val("${bookingDetail.customerPhone}");
                        $("#BookingDetailModal input[name='customerEmail']").val("${bookingDetail.customerEmail}");
                        $("#BookingDetailModal input[name='petName']").val("${bookingDetail.petName}");
                        $("#BookingDetailModal input[name='petType']").val("${bookingDetail.petType}");
                        $("#BookingDetailModal input[name='breed']").val("${bookingDetail.breed}");
                        $("#BookingDetailModal input[name='serviceName']").val("${bookingDetail.serviceName}");
                        $("#BookingDetailModal input[name='employeeName']").val("${bookingDetail.employeeName}");
                        $("#BookingDetailModal input[name='bookingTime']").val("${bookingDetail.bookingTime}");
                        $("#BookingDetailModal input[name='status']").val("${bookingDetail.status}");
                        $("#BookingDetailModal input[name='actualCheckinTime']").val("${bookingDetail.actualCheckinTime}");
                        $("#BookingDetailModal textarea[name='cancelReason']").val("${bookingDetail.cancelReason}");
                        $("#BookingDetailModal textarea[name='note']").val("${bookingDetail.note}");
                    });

                    if ("${bookingDetail.status}" === "Cancelled") {
                        $("textarea[name='cancelReason']").closest(".mb-3").show();
                    } else {
                        $("textarea[name='cancelReason']").closest(".mb-3").hide();
                    }

            </script>
        </c:if>


        <script>
            function handleStatusChange(selectElement, bookingId) {
                var selectedValue = selectElement.value;

                if (selectedValue === "Cancelled") {
                    // Gán giá trị vào modal để biết booking nào đang sửa
                    $('#failStatusModal input[name="bookingId"]').val(bookingId);
                    $('#failStatusModal input[name="status"]').val(selectedValue);

                    // Hiện modal để nhập lý do
                    $('#failStatusModal').modal('show');
                } else {
                    // Tự động submit với các status khác
                    selectElement.form.submit();
                }
            }
        </script>

        <script>
            function handleStatusChange(selectElement, bookingId) {
                const selectedValue = selectElement.value;
                const currentStatus = selectElement.dataset.currentStatus;
                const reasonDiv = document.getElementById('cancelReasonDiv-' + bookingId);

                // Chỉ hiện ô nhập lý do nếu chọn Cancelled và trạng thái hiện tại KHÔNG phải là Cancelled_Pending
                if (selectedValue === 'Cancelled' && currentStatus !== 'Cancelled_Pending') {
                    if (reasonDiv) {
                        reasonDiv.style.display = 'block';
                    }
                } else {
                    if (reasonDiv) {
                        reasonDiv.style.display = 'none';
                    }
                    // Submit luôn nếu không cần lý do
                    selectElement.form.submit();
                }
            }
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
