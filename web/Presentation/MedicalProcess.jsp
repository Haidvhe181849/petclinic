<%-- 
    Document   : ProfileDoctor
    Created on : Jul 16, 2025, 8:07:16 AM
    Author     : quang
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ Doctor</title>
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
                                <c:if test="${sessionScope.doctor.roleId == 3}">
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
                                <c:when test="${not empty currentDoctor}">
                                    <div class="header-user-info d-flex align-items-center gap-2">
                                        <span class="d-none d-md-block text-dark fw-semibold">Hi, ${currentDoctor.name}</span>

                                        <div class="dropdown">
                                            <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle"
                                               id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <img src="${pageContext.request.contextPath}/Presentation/img/images/avata/${currentDoctor.image}"
                                                     alt="Avatar" class="rounded-circle"
                                                     style="width: 35px; height: 35px; object-fit: cover;">
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ProfileStaff">Trang cá nhân</a></li>
                                                    <c:if
                                                        test="${currentDoctor.roleId == 3}">
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
        <div class="container" style="margin-top: 80px;">
            <div class="row">
                <!-- Avatar + Basic Info -->

                <div class="col-md-3">
                    <div class="card mb-2" style="margin-top: 25px;">
                        <div class="card-header bg-info text-white fw-semibold">📋 Thông Tin Lịch Khám</div>
                        <div class="card-body small">
                            <p><strong>🐾 Thú cưng:</strong> ${booking.petName}</p>
                            <p><strong>💠 Dịch vụ:</strong> ${booking.serviceName}</p>
                            <p><strong>💵 Giá:</strong> ${booking.servicePrice} ₫</p>
                            <p><strong>🕒 Thời gian:</strong> ${booking.formattedDate} - ${booking.formattedTime}</p>
                            <p><strong>📝 Ghi chú:</strong> ${booking.note}</p>
                        </div>
                    </div>

                    <div class="profile-card text-center">
                        <img id="mainAvatar" 
                             src="${pageContext.request.contextPath}/Presentation/img/images/avata/${currentDoctor.image}" 
                             alt="Avatar" 
                             class="rounded-circle d-block mx-auto mb-2" 
                             style="width: 120px; height: 120px; object-fit: cover;">

                        <h4 class="mt-3">${currentDoctor.name}</h4>

                        <p class="mt-2 mb-0">
                            <i class="bi bi-github me-1"></i> <strong>${currentDoctor.experience}</strong>
                        </p>
                        <p class="mb-0">
                            <i class="bi bi-calendar-check me-1"></i> <strong>${pendingBookingCount}</strong> Số Booking đang chờ
                        </p>
                    </div>


                </div>

                <!-- Detailed Info -->
                <div class="col-md-9">
                    <div class="profile-card mt-4">


                        <div class="card">
                            <div class="card-header bg-secondary text-white fw-semibold">🩺 Thông tin khám bệnh</div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/MedicalProcess" method="post" enctype="multipart/form-data">
                                    <!-- Hidden -->
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                    <input type="hidden" name="petId" value="${booking.petId}" />
                                    <input type="hidden" name="employeeId" value="${currentDoctor.employeeId}" />


                                    <!-- Triệu chứng -->
                                    <div class="mb-3 form-section">
                                        <label for="symptoms">Triệu chứng:</label>
                                        <textarea id="symptoms" name="symptoms" class="form-control" rows="3" required></textarea>
                                    </div>

                                    <!-- Chẩn đoán -->
                                    <div class="mb-3 form-section">
                                        <label for="diagnosis">Chẩn đoán:</label>
                                        <textarea id="diagnosis" name="diagnosis" class="form-control" rows="3" required></textarea>
                                    </div>

                                    <!-- Kết quả xét nghiệm -->
                                    <div class="mb-3 form-section">
                                        <label for="testResults">Kết quả xét nghiệm:</label>
                                        <textarea id="testResults" name="testResults" class="form-control" rows="3"></textarea>
                                    </div>

                                    <!-- File xét nghiệm -->
                                    <div class="mb-4 form-section">
                                        <label for="testFile">Tải lên kết quả xét nghiệm (PDF, ảnh...):</label>
                                        <input type="file" name="testFile" id="testFile" class="form-control" accept="image/*,application/pdf">
                                    </div>

                                    <!-- Thuốc -->
                                    <div class="mb-4 form-section">
                                        <label for="medicineId">Thuốc điều trị (chọn nhiều):</label>
                                        <select name="medicineId[]" id="medicine-select" class="form-select" multiple="multiple" required>
                                            <c:forEach var="m" items="${medicineList}">
                                                <option value="${m.medicineId}">${m.medicineName}</option>
                                            </c:forEach>
                                        </select>
                                        <small class="text-muted">* Bạn có thể gõ để tìm thuốc và chọn nhiều thuốc dễ dàng</small>
                                    </div>


                                    <!-- Nút -->
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-success">✅ Hoàn tất khám</button>
                                    </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div>




            </div>
        </div>




        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.sticky.js"></script>
        <!-- Select2 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

        <!-- jQuery (yêu cầu cho Select2) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Select2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>


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
            $(window).on('load', function () {
                $('#preloader-active').fadeOut('slow');
            });
        </script>

        <script>
            $(document).ready(function () {
                $('#medicine-select').select2({
                    placeholder: "Chọn thuốc điều trị...",
                    width: '100%' // để nó không bị co lại
                });
            });
        </script>


    </body>
</html>





