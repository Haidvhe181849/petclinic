<%-- 
    Document   : UpdateNews
    Created on : Jul 23, 2025, 2:16:42 AM
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
                        </ol>
                    </nav>                    
                </div>
            </nav>

            <!-- Header title on pink background -->
            <div class="w-full bg-pink-100 py-4 flex justify-center items-center">
                <h2 class="text-2xl font-bold text-gray-700"> Schedule Management</h2>
            </div> 

            <div class="w-full px-6 py-6 mx-auto">
                <div class="profile-card mt-4">
                    <h5 class="mb-3">📅 Lịch Phân Công</h5>

                    <!-- Dropdown chọn bác sĩ -->
                    <form method="get" action="ScheduleManagement" class="mb-3">
                        <label class="form-label fw-semibold">Chọn bác sĩ:</label>
                        <select name="doctorId" class="form-select w-100" onchange="this.form.submit()">
                            <c:forEach var="doc" items="${doctorList}">
                                <option value="${doc.employeeId}" ${selectedDoctor.employeeId == doc.employeeId ? 'selected' : ''}>
                                    ${doc.name}
                                </option>
                            </c:forEach>
                        </select>
                    </form>

                    <!-- Bảng lịch theo giờ và ngày -->
                    <div class="table-responsive mt-3">
                        <table class="table table-bordered text-center align-middle mt-3">
                            <thead class="table-light">
                                <tr>
                                    <th>Khung giờ</th>
                                        <c:forEach var="date" items="${dateList}">
                                        <th><fmt:formatDate value="${date}" pattern="dd/MM/yyyy"/></th>
                                        </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="hour" items="${allHourSlots}">
                                    <tr>
                                        <th>${hour}</th>
                                            <c:forEach var="date" items="${dateList}">
                                                <c:set var="dateKey"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/></c:set>
                                                <c:set var="hourSlots" value="${hourSlotMap[dateKey]}" />
                                                <c:choose>
                                                    <c:when test="${hourSlots != null && hourSlots.contains(hour)}">
                                                        <c:set var="key" value="${dateKey}_${hour}" />
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${bookingMap[key] != null}">
                                                                <c:forEach var="b" items="${bookingMap[key]}">
                                                                    <div class="schedule-entry">
                                                                        <div title="${b.petName}">🐾${b.petName}</div>
                                                                        <div title="${b.serviceName}">💠${b.serviceName}</div>
                                                                        <div>
                                                                            <span class="line-label">👤
                                                                                <c:choose>
                                                                                    <c:when test="${b.employeeName != null}">
                                                                                        ${b.employeeName}
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <button class="btn btn-sm btn-outline-primary"
                                                                                                data-bs-toggle="modal"
                                                                                                data-bs-target="#assignModal"
                                                                                                data-booking-id="${b.bookingId}"
                                                                                                data-date="${b.formattedDate}"
                                                                                                data-hour="${b.formattedTime}">
                                                                                            Chưa phân công
                                                                                        </button>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">–</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td class="bg-light text-muted">×</td>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>



            <!-- Modal chọn bác sĩ -->
            <div class="modal fade" id="assignModal" tabindex="-1" aria-labelledby="assignModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form method="post" action="ScheduleManagement">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Phân công bác sĩ</h5>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="bookingId" id="modalBookingId" />
                                <div class="mb-3">
                                    <label for="doctorId" class="form-label">Chọn bác sĩ</label>
                                    <select name="doctorId" id="modalDoctorSelect" class="form-select" required>
                                        <option>Đang tải danh sách...</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Phân công</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>


        </main>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const assignModal = document.getElementById("assignModal");

                                assignModal.addEventListener("show.bs.modal", function (event) {
                                    const button = event.relatedTarget;
                                    const bookingId = button.getAttribute("data-booking-id");
                                    const formattedDate = button.getAttribute("data-date");
                                    const formattedTime = button.getAttribute("data-hour");
                                    const isoDateTime = formattedDate + 'T' + formattedTime;

                                    // Gán bookingId vào input ẩn
                                    document.getElementById("modalBookingId").value = bookingId;

                                    const select = document.getElementById("modalDoctorSelect");
                                    select.innerHTML = "<option>Đang tải danh sách bác sĩ...</option>";

                                    fetch('ScheduleManagement?action=availableDoctors&datetime=' + encodeURIComponent(isoDateTime))
                                            .then(response => response.json())
                                            .then(data => {
                                                console.log("📦 Dữ liệu nhận được:", data);

                                                if (!Array.isArray(data)) {
                                                    console.error("❌ Không phải mảng:", data);
                                                    select.innerHTML = "<option>Lỗi tải danh sách</option>";
                                                    return;
                                                }
                                                select.innerHTML = "";
                                                if (data.length === 0) {
                                                    const opt = document.createElement("option");
                                                    opt.text = "Không có bác sĩ nào rảnh";
                                                    opt.disabled = true;
                                                    select.appendChild(opt);
                                                } else {
                                                    data.forEach(doctor => {
                                                        const opt = document.createElement("option");
                                                        opt.value = doctor.employeeId;
                                                        opt.text = "Bác sĩ " + doctor.name;
                                                        select.appendChild(opt);
                                                    });
                                                }
                                            })
                                            .catch(error => {
                                                console.error("Lỗi khi tải bác sĩ:", error);
                                                select.innerHTML = "<option>Lỗi tải danh sách</option>";
                                            });
                                });
                            });
        </script>

        <script>
            function loadAvailableDoctors(formattedDate, formattedTime, bookingId) {
                const isoDateTime = formattedDate + 'T' + formattedTime;
                console.log("🧪 Gọi API với:", isoDateTime);
                fetch('ScheduleManagement?action=availableDoctors&datetime=' + encodeURIComponent(isoDateTime))
                        .then(response => response.json())
                        .then(data => {
                            const select = document.getElementById('doctorSelect-' + bookingId);
                            select.innerHTML = ""; // clear old

                            if (data.length === 0) {
                                const opt = document.createElement("option");
                                opt.text = "Không có bác sĩ nào rảnh";
                                select.add(opt);
                                select.disabled = true;
                            } else {
                                select.disabled = false;
                                data.forEach(doctor => {
                                    const opt = document.createElement("option");
                                    opt.value = doctor.employeeId;
                                    opt.text = "Bác sĩ " + doctor.name;
                                    select.add(opt);
                                });
                            }
                        })
                        .catch(error => {
                            console.error("Error loading doctors: ", error);
                        });
            }
        </script>


    </body>


</html>
