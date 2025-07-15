<%-- 
    Document   : ProfileStaff
    Created on : Jul 14, 2025, 4:50:16 AM
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ nhân viên</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <!-- Custom Styles -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Presentation/css/style.css">
        <!-- Argon Dashboard (Tailwind base) -->
        <link href="${pageContext.request.contextPath}/Presentation/css/nucleo-icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Presentation/css/nucleo-svg.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/Presentation/css/argon-dashboard-tailwind.css?v=1.0.1" rel="stylesheet">

        <style>
            body {
                background-image: url('${pageContext.request.contextPath}/Presentation/img/hero/hero2.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
            .profile-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                padding: 25px;
                margin-top: 20px;
            }
            .btn-edit-profile {
                font-weight: 500;
                background: linear-gradient(45deg, #fd7e14, #ff4d4f);
                color: white;
                border: none;
            }
            .btn-edit-profile:hover {
                background: linear-gradient(45deg, #ff5722, #e53935);
            }
            .avatar {
                width: 120px;
                height: 120px;
                object-fit: cover;
            }

            #preloader-active {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: #f9f9f9;
                z-index: 9999;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .preloader {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .preloader-circle {
                position: absolute;
                width: 100px;
                height: 100px;
                border-radius: 50%;
                border: 2px solid transparent;
                border-top-color: #ff3d3d;
                animation: spin 1s linear infinite;
            }

            .pere-text {
                position: relative;
                z-index: 2;
            }

            .pere-text img {
                display: block;
                width: 50px;
                height: auto;
                object-fit: contain;
                margin: auto;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

        </style>
    </head>
    <body class="bg-light">
        <!-- Preloader Start -->
        <div id="preloader-active">
            <div class="preloader d-flex align-items-center justify-content-center">
                <div class="preloader-inner position-relative">
                    <div class="preloader-circle"></div>
                    <div class="preloader-img pere-text">
                        <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" alt="logo" style="width: 80px;">
                    </div>
                </div>
            </div>
        </div>
        <div class="header-area header-transparent">
            <div class="main-header header-sticky">
                <div class="container-fluid">
                    <div class="row align-items-center" style="min-height: 80px;">
                        <!-- Logo -->
                        <div class="col-xl-2 col-lg-2 col-md-2 d-flex align-items-center">
                            <div class="logo">
                                <a href="${pageContext.request.contextPath}/Home">
                                    <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" alt="PetCare Logo">
                                </a>
                            </div>
                        </div>

                        <!-- Navigation Menu -->
                        <div class="col-xl-7 col-lg-7 col-md-7">
                            <div class="main-menu f-right d-none d-lg-block">
                                <c:if test="${sessionScope.staff.roleId == 2}">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="${pageContext.request.contextPath}/Service?service=listService">Service</a></li>
                                            <li><a href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">Medicine</a></li>
                                            <li><a href="${pageContext.request.contextPath}/News?service=listNews">News</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </div>
                        </div>

                        <!-- User Info -->
                        <div class="col-xl-3 col-lg-3 col-md-3 d-flex align-items-center justify-content-end">
                            <c:choose>
                                <c:when test="${not empty currentStaff}">
                                    <div class="header-user-info d-flex align-items-center gap-2">
                                        <span class="d-none d-md-block text-dark fw-semibold">Hi, ${currentStaff.name}</span>

                                        <div class="dropdown">
                                            <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle"
                                               id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <img src="${pageContext.request.contextPath}/Presentation/img/images/avtEmp/${currentStaff.image}"
                                                     alt="Avatar" class="rounded-circle"
                                                     style="width: 35px; height: 35px; object-fit: cover;">
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ProfileStaff">Trang cá nhân</a></li>
                                                    <c:if
                                                        test="${currentStaff.roleId == 1 || currentStaff.roleId == 2}">
                                                    <li>
                                                        <hr class="dropdown-divider">
                                                    </li>
                                                    <li><a class="dropdown-item"
                                                           href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp">Managerment</a></li>

                                                </c:if>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password-employee">Đổi mật khẩu</a></li>
                                                <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </c:when>

                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container mt-5">
            <div class="row">
                <!-- Avatar + Basic Info -->
                <div class="col-md-4">
                    <div class="profile-card text-center">
                        <img id="mainAvatar" 
                             src="${pageContext.request.contextPath}/Presentation/img/images/avtEmp/${currentStaff.image}" 
                             alt="Avatar" 
                             class="rounded-circle d-block mx-auto mb-2" 
                             style="width: 120px; height: 120px; object-fit: cover;">

                        <h4 class="mt-3">${currentStaff.name}</h4>

                        <p>Nhân Viên Phòng Khám</p>
                        <p class="mt-2 mb-0">
                            <i class="bi bi-github me-1"></i> <strong>${currentStaff.experience}</strong>
                        </p>
                        <p class="mb-0">
                            <i class="bi bi-calendar-check me-1"></i> <strong>${pendingBookingCount}</strong> Số Booking đang chờ
                        </p>
                        <button class="btn btn-primary btn-edit-profile px-4 py-2 rounded-pill d-inline-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="bi bi-pencil-fill"></i> Chỉnh sửa
                        </button>
                    </div>

                    <div class="profile-card mt-4">
                        <h6>Chức năng</h6>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/DoctorManagerment?service=listDoctor" class="text-decoration-none text-dark">
                                    <i class="bi bi-github me-2"></i> Quản lí Doctor
                                </a>
                            </li>
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking" class="text-decoration-none text-dark">
                                    <i class="bi bi-calendar-check me-2"></i>Managerment Booking
                                </a>
                            </li>
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/change-password-employee" class="text-decoration-none text-dark">
                                    <i class="bi bi-key me-2"></i> Đổi mật khẩu
                                </a>
                            </li>
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/logout" class="text-decoration-none text-dark">
                                    <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Detailed Info -->
                <div class="col-md-8">
                    <div class="profile-card">
                        <h5 class="mb-3">Thông tin cá nhân</h5>
                        <table class="table">
                            <tr>
                                <th>Email</th>
                                <td>${currentStaff.email}</td>
                            </tr>
                            <tr>
                                <th>Số điện thoại</th>
                                <td>${currentStaff.phone}</td>
                            </tr>
                            <tr>
                                <th>Địa chỉ</th>
                                <td>${currentStaff.address}</td>
                            </tr>
                            <tr>
                                <th>Kinh nghiệm</th>
                                <td>${currentStaff.experience}</td>
                            </tr>
                            <tr>
                                <th>Giờ làm việc</th>
                                <td>${currentStaff.workingHours}</td>
                            </tr>
                        </table>
                    </div>

                    <div class="profile-card mt-4">
                        <h5 class="mb-3">📅 Lịch Phân Công</h5>

                        <!-- Dropdown chọn bác sĩ -->
                        <form method="get" action="ProfileStaff" class="mb-3">
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
                            <table class="table table-bordered text-center align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Khung giờ</th>
                                            <c:forEach var="date" items="${dateList}">
                                            <th><fmt:formatDate value="${date}" pattern="dd/MM/yyyy"/></th>
                                            </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="hour" items="${hourSlots}">
                                        <tr>
                                            <th>${hour}</th>
                                                <c:forEach var="date" items="${dateList}">
                                                <td>
                                                    <c:set var="key"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/>_${hour}</c:set>
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
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Modal Chỉnh sửa hồ sơ (Staff) -->
        <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <form action="ProfileStaff" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="updateProfile">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProfileLabel">📝 Chỉnh sửa hồ sơ nhân viên</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>

                        <div class="modal-body row g-3 px-3">
                            <!-- Cột avatar -->
                            <div class="col-md-4 text-center">
                                <label class="form-label fw-semibold">Avatar hiện tại</label>
                                <img id="avatarPreview" src="${pageContext.request.contextPath}/Presentation/img/images/avtEmp/${currentStaff.image}"
                                     class="rounded-circle img-thumbnail mb-2"
                                     style="width: 120px; height: 120px; object-fit: cover;">
                                <p class="text-muted small">Chọn ảnh đại diện mới (PNG, JPG):</p>
                                <input type="file" class="form-control" name="avatarFile" accept="image/png, image/jpeg" onchange="previewAvatar(this)">
                            </div>

                            <!-- Cột thông tin cá nhân -->
                            <div class="col-md-8 row">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên</label>
                                    <input type="text" class="form-control" name="name" value="${currentStaff.name}" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${currentStaff.email}" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" class="form-control" name="phone" value="${currentStaff.phone}" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" name="address" value="${currentStaff.address}" required>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Kinh nghiệm</label>
                                    <textarea class="form-control" name="experience" rows="3">${currentStaff.experience}</textarea>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Giờ làm việc</label>
                                    <input type="text" class="form-control" name="workingHours" value="${currentStaff.workingHours}" required readonly>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Lưu thay đổi
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Assign Doctor Modal -->
        <div class="modal fade" id="assignModal" tabindex="-1">
            <div class="modal-dialog">
                <form action="ProfileStaff" method="post">
                    <input type="hidden" name="bookingId" id="modalBookingId">
                    <input type="hidden" id="modalDate">
                    <input type="hidden" id="modalHour">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Phân công bác sĩ</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <label class="form-label">Chọn bác sĩ:</label>
                            <select name="doctorId" class="form-select" id="doctorSelectDropdown" required>
                                <!-- Sẽ được đổ bằng JavaScript -->
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.sticky.js"></script>
        <script>
                                    function previewAvatar(input) {
                                        const file = input.files[0];
                                        if (file) {
                                            const reader = new FileReader();
                                            reader.onload = function (e) {
                                                document.getElementById('avatarPreview').src = e.target.result;
                                            };
                                            reader.readAsDataURL(file);
                                        }
                                    }
        </script>





        <script>
            const doctorList = <c:out value="${doctorListJson}" escapeXml="false" />;
            const doctorBusyMap = <c:out value="${doctorBusyMapJson}" escapeXml="false" />;

            const assignModal = document.getElementById('assignModal');
            assignModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const bookingId = button.getAttribute('data-booking-id');
                const bookingDate = button.getAttribute('data-date');
                const bookingHour = button.getAttribute('data-hour');

                document.getElementById('modalBookingId').value = bookingId;
                document.getElementById('modalDate').value = bookingDate;
                document.getElementById('modalHour').value = bookingHour;

                const dropdown = document.getElementById('doctorSelectDropdown');
                dropdown.innerHTML = ''; // clear old options

                const key = `${bookingDate}_${bookingHour}`;
                        doctorList.forEach(doc => {
                            const isBusy = doctorBusyMap[key] && doctorBusyMap[key].includes(doc.employeeId);
                            if (!isBusy) {
                                const opt = document.createElement('option');
                                opt.value = doc.employeeId;
                                opt.textContent = doc.name;
                                dropdown.appendChild(opt);
                            }
                        });
                    });
        </script>
        <script>
            $(window).on('load', function () {
                $('#preloader-active').fadeOut('slow');
            });
        </script>

    </body>
</html>
