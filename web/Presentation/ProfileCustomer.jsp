<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Profile - Pet Clinic</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
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

            .btn-edit-profile {
                font-weight: 500;
                font-size: 1rem;
                background: linear-gradient(45deg, #fd7e14, #ff4d4f);
                color: white;
                border: none;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
            }

            .btn-edit-profile:hover {
                background: linear-gradient(45deg, #ff5722, #e53935);
                transform: scale(1.05);
            }

            .profile-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                padding: 25px;
                margin-top: 20px;
            }

            .card {
                transition: transform 0.2s ease-in-out;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0,0,0,0.08);
            }
            .card:hover {
                transform: scale(1.02);
            }

            .card .btn {
                font-size: 0.8rem;
                padding: 5px 10px;
                border-radius: 6px;
            }

            .card .btn-outline-primary {
                background-color: transparent;
                color: #17a2b8 ;
                border: 1px solid #17a2b8 ;
            }

            .card .btn-outline-primary:hover {
                background-color: #17a2b8 ;
                color: white;
            }

            .btn-outline-danger {
                color: #dc3545;
                border: 1px solid #dc3545;
            }
            .btn-outline-danger:hover {
                background-color: #dc3545;
                color: white;
            }

            .btn-outline-secondary {
                color: #6c757d;
                border: 1px solid #6c757d;
            }
            .btn-outline-secondary:hover {
                background-color: #6c757d;
                color: white;
            }

            .btn-success {
                background-color: #28a745 !important;
                color: white !important;
                border: none;
            }
            .btn-success:hover {
                background-color: #218838 !important;
                color: white;
            }

            .card-body small i {
                color: #666;
                margin-right: 4px;
            }

            .pet-image {
                width: 100%;
                height: 110px;
                object-fit: cover;
                border-radius: 0.375rem;
            }

            .card .action-buttons {
                padding-top: 8px;
                border-top: 1px solid #f0f0f0;
                display: flex;
                justify-content: flex-end;
                gap: 0.5rem;
                padding-right: 1rem;
                padding-bottom: 0.75rem;
            }

            .modal-body {
                padding: 1rem 1.25rem;
            }

            .btn-add-pet {
                font-weight: 500;
                padding: 4px 12px;
                font-size: 0.85rem;
            }

            .avatar-option:hover {
                border: 2px solid #0d6efd;
                box-shadow: 0 0 5px rgba(13, 110, 253, 0.5);
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
                                <nav>
                                    <ul id="navigation">
                                        <li><a href="${pageContext.request.contextPath}/Home">Home</a></li>
                                        <li><a href="#">Services</a></li>
                                        <li><a href="#">Medicine</a></li>
                                        <li><a href="#">Doctor</a></li>
                                            <c:if test="${sessionScope.user.roleId == 4}">
                                            <li><a href="${pageContext.request.contextPath}/BookingForm">Booking</a></li>
                                            </c:if>
                                        <li><a href="${pageContext.request.contextPath}/viewNews?service=listNews">News</a></li>
                                            <c:if test="${sessionScope.user.roleId == 1 || sessionScope.user.roleId == 2 || sessionScope.user.roleId == 3}">
                                            <li><a href="#">Management</a>
                                                <ul class="submenu">
                                                    <li><a href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">Booking</a></li>
                                                    <li><a href="#">Service</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">Medicine</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/News?service=listNews">News</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/Presentation/ManageAboutUsAdmin.jsp">About Us</a></li>
                                                </ul>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                        <!-- User Info -->
                        <div class="col-xl-3 col-lg-3 col-md-3 d-flex align-items-center justify-content-end">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <div class="header-user-info d-flex align-items-center gap-2">
                                        <span class="d-none d-md-block text-dark fw-semibold">Hi, ${sessionScope.user.name}</span>

                                        <div class="dropdown">
                                            <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle"
                                               id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <img src="${pageContext.request.contextPath}/Presentation/img/images/avata/${sessionScope.user.image}"
                                                     alt="Avatar" class="rounded-circle"
                                                     style="width: 35px; height: 35px; object-fit: cover;">
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ProfileCustomer">Trang cá nhân</a></li>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                                                <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="header-user-info">
                                        <a href="${pageContext.request.contextPath}/login" class="header-btn custom-auth-btn">Đăng nhập</a>
                                        <a href="${pageContext.request.contextPath}/register" class="header-btn custom-auth-btn">Đăng ký</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mt-5">
            <div class="row">
                <!-- Avatar + Info -->
                <div class="col-md-4">
                    <div class="profile-card text-center">
                        <img id="mainAvatar" 
                             src="${pageContext.request.contextPath}/Presentation/img/images/avata/${sessionScope.user.image}" 
                             alt="Avatar" 
                             class="rounded-circle d-block mx-auto mb-2" 
                             style="width: 120px; height: 120px; object-fit: cover;">

                        <h4 class="mt-3">${sessionScope.user.name}</h4>
                        <p>Cảm ơn bạn đã đến với chúng tôi</p>
                        <p class="mt-2 mb-0">
                            <i class="bi bi-github me-1"></i> <strong>${petCount}</strong> thú cưng
                        </p>
                        <p class="mb-0">
                            <i class="bi bi-calendar-check me-1"></i> <strong>${appointmentCount}</strong> lần đặt lịch
                        </p>
                        <button class="btn btn-primary btn-edit-profile px-4 py-2 rounded-pill d-inline-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="bi bi-pencil-fill"></i> Chỉnh sửa
                        </button>
                    </div>

                    <div class="profile-card mt-4">
                        <h6>Chức năng</h6>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <a href="#" class="text-decoration-none text-dark" data-bs-toggle="modal" data-bs-target="#myPetsModal">
                                    <i class="bi bi-github me-2"></i> Thú cưng của tôi
                                </a>
                            </li>
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/ProfileCustomer?service=appointments"><i class="bi bi-calendar-check me-2"></i>Lịch hẹn</a>
                            </li>
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/change-password" class="text-decoration-none text-dark">
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

                <!-- Profile Details -->
                <div class="col-md-8">
                    <div class="profile-card">
                        <h5 class="mb-3">Thông tin cá nhân</h5>
                        <table class="table">
                            <tr>
                                <th>Họ tên</th>
                                <td>${sessionScope.user.name}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td>${sessionScope.user.email}</td>
                            </tr>
                            <tr>
                                <th>Số điện thoại</th>
                                <td>${sessionScope.user.phone}</td>
                            </tr>
                            <tr>
                                <th>Địa chỉ</th>
                                <td>${sessionScope.user.address}</td>
                            </tr>
                        </table>
                    </div>

                    <div class="profile-card mt-4">
                        <h5 class="mb-3">Lịch hẹn sắp tới</h5>
                        <ul class="list-group">
                            <c:forEach var="up" items="${requestScope.upcomingAppointments}">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    ${up.formattedDate} - ${up.petName} (${up.serviceName})
                                    <span class="badge bg-warning">${up.status}</span>
                                </li>
                            </c:forEach>
                            <c:if test="${empty upcomingAppointments}">
                                <li class="list-group-item text-muted">Không có lịch hẹn sắp tới.</li>
                                </c:if>
                        </ul>
                    </div>

                    <div class="profile-card mt-4">
                        <h5 class="mb-3">Lịch sử khám gần đây</h5>
                        <ul class="list-group">
                            <c:forEach var="appointment" items="${requestScope.recentAppointments}">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    ${appointment.formattedDate} - ${appointment.petName} (${appointment.serviceName})
                                    <span class="badge bg-success">${appointment.status}</span>
                                </li>
                            </c:forEach>
                            <c:if test="${empty recentAppointments}">
                                <li class="list-group-item text-muted">Chưa có lịch sử khám.</li>
                                </c:if>
                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <!-- Modal Chỉnh sửa hồ sơ -->
        <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <form action="ProfileCustomer" method="post">
                    <input type="hidden" name="service" value="updateProfile">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProfileLabel">📝 Chỉnh sửa hồ sơ</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>

                        <div class="modal-body row g-3 px-3">
                            <!-- Cột avatar -->
                            <div class="col-md-4 text-center">
                                <label class="form-label fw-semibold">Avatar hiện tại</label>
                                <img id="avatarPreview" src="${pageContext.request.contextPath}/Presentation/img/images/avata/${user.image}"
                                     class="rounded-circle img-thumbnail mb-2"
                                     style="width: 120px; height: 120px; object-fit: cover;">
                                <p class="text-muted small">Chọn ảnh đại diện mới:</p>

                                <!-- Danh sách ảnh avatar để chọn -->
                                <div class="d-flex flex-wrap justify-content-center gap-2">
                                    <c:forEach var="i" begin="1" end="6">
                                        <c:set var="currentImage" value="av${i}.jpg" />
                                        <div class="form-check text-center">
                                            <input class="form-check-input d-none avatar-radio" type="radio" name="avatar" id="avatar${i}" value="${currentImage}"
                                                   <c:if test="${user.image == currentImage}">checked</c:if>>
                                            <label class="form-check-label" for="avatar${i}">
                                                <img src="${pageContext.request.contextPath}/Presentation/img/images/avata/${currentImage}"
                                                     class="img-thumbnail avatar-option"
                                                     style="width: 60px; height: 60px; object-fit: cover;">
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Cột thông tin cá nhân -->
                            <div class="col-md-8 row">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên</label>
                                    <input type="text" class="form-control" name="name" value="${user.name}" required
                                           pattern="^[A-Za-zÀ-ỹ\s]{2,50}$"
                                           title="Tên phải từ 2-50 ký tự, chỉ chứa chữ và khoảng trắng">
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${user.email}" required
                                           pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                           title="Email không hợp lệ">
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" class="form-control" name="phone" value="${user.phone}" required
                                           pattern="^0\d{9}$"
                                           title="Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0">

                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" name="address" value="${user.address}" required
                                           pattern=".{2,100}"
                                           title="Địa chỉ không được để trống, tối đa 100 ký tự">
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



        <!-- Modal danh sách thú cưng -->
        <div class="modal fade" id="myPetsModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header d-flex justify-content-between align-items-center">
                        <h5 class="modal-title fw-bold text-dark">🐾 Thú cưng của tôi</h5>
                        <div class="d-flex align-items-center gap-2">
                            <button id="openAddPetBtn"
                                    class="btn btn-sm px-3 py-2 fw-semibold rounded-pill text-white"
                                    style="background: linear-gradient(45deg, #fd7e14, #ff4d4f); border: none;">
                                <i class="bi bi-plus-lg me-1"></i> Thêm thú cưng
                            </button>

                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="pet" items="${requestScope.userPets}">
                            <div class="col-md-6 mb-3">
                                <div class="card h-100 shadow-sm">
                                    <div class="row h-100 g-0">
                                        <!-- Cột ảnh -->
                                        <div class="col-4">
                                            <img src="${pageContext.request.contextPath}/Presentation/img/images/imgPet/${pet.image}" 
                                                 alt="${pet.name}" class="img-fluid rounded-start h-100 w-100 object-fit-cover">
                                        </div>

                                        <!-- Cột thông tin -->
                                        <div class="col-8 d-flex flex-column justify-content-between">
                                            <!-- Thông tin -->
                                            <div class="card-body py-2 px-3"> 
                                                <!-- Kiểu loài + giống -->
                                                <h6 class="text-primary fw-semibold mb-1">
                                                    <i class="bi bi-paw"></i> 
                                                    Kiểu loài: 
                                                    <c:forEach var="type" items="${animalTypes}">
                                                        <c:if test="${type.animalTypeId == pet.petTypeId}">
                                                            ${type.typeName}
                                                        </c:if>
                                                    </c:forEach> 
                                                    (${pet.breed})
                                                </h6>

                                                <!-- Tên Pet -->
                                                <small class="d-block text-muted">
                                                    <i class="bi bi-person-fill"></i> 
                                                    <strong>Tên Pet:</strong> ${pet.name}
                                                </small>

                                                <!-- Trọng lượng -->
                                                <small class="d-block text-muted">
                                                    <i class="bi bi-bar-chart-fill"></i> 
                                                    <strong>Trọng lượng:</strong> ${pet.weight} kg
                                                </small>

                                                <!-- Ngày sinh -->
                                                <small class="d-block text-muted">
                                                    <i class="bi bi-calendar-event-fill"></i> 
                                                    <strong>Ngày Sinh:</strong> ${pet.birthdate}
                                                </small>
                                            </div>


                                            <!-- Nút hành động -->
                                            <div class="d-flex justify-content-end align-items-center px-3 pb-2 gap-2 mt-auto">
                                                <button class="btn btn-sm btn-outline-primary"
                                                        title="Chỉnh sửa"
                                                        data-bs-toggle="modal" data-bs-target="#editPetModal"
                                                        data-pet-id="${pet.petId}"
                                                        data-name="${pet.name}"
                                                        data-breed="${pet.breed}"
                                                        data-weight="${pet.weight}"
                                                        data-birthdate="${pet.birthdate}"
                                                        data-pet-type-id="${pet.petTypeId}"
                                                        data-image="${pet.image}">
                                                    <i class="bi bi-pencil-square"></i>
                                                </button>

                                                <button type="button"
                                                        class="btn btn-sm btn-outline-danger btn-delete-pet"
                                                        data-pet-id="${pet.petId}" title="Xoá">
                                                    <i class="bi bi-trash3"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="editPetModal" tabindex="-1">
            <div class="modal-dialog">
                <form action="ProfileCustomer?service=updatePet" method="post" enctype="multipart/form-data" onsubmit="return validateUpdatePetForm();">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Cập nhật thú cưng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="pet_id" id="editPetId">
                            <input type="text" name="name" id="editName" class="form-control mb-2" placeholder="Tên thú cưng" required>

                            <!-- Loại thú cưng -->
                            <select name="pet_type_id" class="form-control mb-2" id="editPetTypeSelect" onchange="toggleOtherTypeEdit(this)" required>
                                <option disabled value="">-- Chọn loại thú cưng --</option>
                                <c:forEach var="type" items="${animalTypes}">
                                    <option value="${type.animalTypeId}">${type.typeName}</option>
                                </c:forEach>
                            </select>

                            <!-- Giống -->
                            <select name="breed" class="form-control mb-2" id="editBreedSelect" onchange="toggleOtherBreedEdit(this)" required>
                                <option disabled value="">-- Chọn giống --</option>
                                <c:forEach var="b" items="${breeds}">
                                    <option value="${b.breedName}">${b.breedName}</option>
                                </c:forEach>
                                <option value="OTHER">Khác...</option>
                            </select>
                            <input type="text" name="custom_breed" class="form-control mb-2 d-none" id="customBreedEditInput" placeholder="Nhập giống khác" pattern="^[A-Za-zÀ-ỹ ]{2,30}$" title="Tên giống phải từ 2-30 ký tự">

                            <input type="number" step="0.1" name="weight" id="editWeight" class="form-control mb-2" placeholder="Cân nặng (kg)">
                            <input type="date" name="birthdate" id="editBirthdate" class="form-control mb-2" required>

                            <!-- Ảnh -->
                            <input type="hidden" name="old_image" id="oldImage">
                            <input type="file" name="image" class="form-control mb-2" accept="image/*">

                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>


        <!-- Modal thêm thú cưng -->
        <div class="modal fade" id="addPetModal" tabindex="-1">
            <div class="modal-dialog">
                <form action="ProfileCustomer" method="post" enctype="multipart/form-data" onsubmit="return validateAddPetForm();">
                    <input type="hidden" name="service" value="addPet">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm thú cưng mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <input type="text" name="name" id="petName" class="form-control mb-2"
                                   placeholder="Tên thú cưng" required
                                   pattern="^[A-Za-zÀ-ỹ0-9 ]{2,30}$"
                                   title="Tên phải từ 2-30 ký tự, chỉ chứa chữ cái, số và khoảng trắng">

                            <!-- Loại thú cưng -->
                            <select name="pet_type_id" class="form-control mb-2" id="selectPetType" onchange="toggleOtherTypeInput(this)" required>
                                <option disabled selected value="">-- Chọn loại thú cưng --</option>
                                <c:forEach var="type" items="${animalTypes}">
                                    <option value="${type.animalTypeId}">${type.typeName}</option>
                                </c:forEach>                                
                            </select> 

                            <!-- Giống -->
                            <select name="breed" class="form-control mb-2" id="selectBreed" onchange="toggleOtherBreedInput(this)" required>
                                <option disabled selected value="">-- Chọn giống --</option>
                                <c:forEach var="b" items="${breeds}">
                                    <option value="${b.breedName}">${b.breedName}</option>
                                </c:forEach>
                                <option value="OTHER">Khác...</option>
                            </select>

                            <input type="text" name="custom_breed" class="form-control mb-2 mt-2 d-none"
                                   id="customBreedInput" placeholder="Nhập giống khác"
                                   pattern="^[A-Za-zÀ-ỹ ]{2,30}$" title="Tên giống phải từ 2-30 ký tự">

                            <!-- Cân nặng -->
                            <input type="number" step="0.1" name="weight" id="weight" class="form-control mb-2"
                                   placeholder="Cân nặng (kg)" min="0.1" max="200" required>

                            <!-- Ngày sinh -->
                            <input type="date" name="birthdate" id="birthdate" class="form-control mb-2" required>

                            <!-- Ảnh -->
                            <input type="file" name="image" id="image" accept="image/*" class="form-control mb-2" required>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Lưu</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- JS Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/argon-dashboard-tailwind.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/jquery.sticky.js"></script>
        
        <script>
                                document.querySelectorAll('.avatar-radio').forEach(radio => {
                                    radio.addEventListener('change', function () {
                                        const selectedAvatar = this.value; // ví dụ: av1.jpg
                                        const previewImg = document.querySelector('#avatarPreview');

                                        if (previewImg) {
                                            previewImg.src = '${pageContext.request.contextPath}/Presentation/img/images/avata/' + selectedAvatar;
                                        }
                                    });
                                });

                                document.querySelector('#editProfileModal form').addEventListener('submit', function (e) {
                                    const name = this.name.value.trim();
                                    const email = this.email.value.trim();
                                    const phone = this.phone.value.trim();
                                    const address = this.address.value.trim();

                                    const namePattern = /^[A-Za-zÀ-ỹ\s]{2,50}$/;
                                    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                                    const phonePattern = /^0\d{9}$/;

                                    if (!namePattern.test(name)) {
                                        alert("Họ tên không hợp lệ. Chỉ chứa chữ và khoảng trắng, 2-50 ký tự.");
                                        e.preventDefault();
                                        return;
                                    }

                                    if (!emailPattern.test(email)) {
                                        alert("Email không hợp lệ.");
                                        e.preventDefault();
                                        return;
                                    }

                                    if (!phonePattern.test(phone)) {
                                        alert("Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.");
                                        e.preventDefault();
                                        return;
                                    }

                                    if (address.length < 2 || address.length > 100) {
                                        alert("Địa chỉ không hợp lệ. Phải từ 2–100 ký tự.");
                                        e.preventDefault();
                                        return;
                                    }
                                });
        </script>


        <script>
            document.getElementById("openAddPetBtn")?.addEventListener("click", function () {
                const myPetsModal = bootstrap.Modal.getInstance(document.getElementById('myPetsModal'));
                myPetsModal.hide();

                setTimeout(function () {
                    const addModal = new bootstrap.Modal(document.getElementById('addPetModal'));
                    addModal.show();
                }, 300); // đảm bảo modal cũ đã đóng
            });
        </script>


        <script>
            document.querySelectorAll('.btn-delete-pet').forEach(btn => {
                btn.addEventListener('click', function () {
                    if (!confirm('Bạn có chắc chắn muốn xoá thú cưng này?'))
                        return;

                    const petId = this.getAttribute('data-pet-id');

                    fetch('ProfileCustomer?service=deletePet', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                        body: 'pet_id=' + encodeURIComponent(petId)
                    })
                            .then(response => {
                                if (response.ok) {
                                    // Xóa card thú cưng khỏi DOM
                                    this.closest('.col-md-6').remove();
                                } else {
                                    alert('Có lỗi xảy ra khi xoá thú cưng!');
                                }
                            })
                            .catch(error => {
                                console.error('Lỗi khi gọi API:', error);
                            });
                });
            });

        </script>



        <script>
            function toggleOtherTypeInput(select) {
                const otherInput = document.getElementById("customTypeInput");
                if (select.value === "OTHER") {
                    otherInput.classList.remove("d-none");
                    otherInput.setAttribute("required", "true");
                } else {
                    otherInput.classList.add("d-none");
                    otherInput.removeAttribute("required");
                }
            }

            function toggleOtherBreedInput(select) {
                const otherBreed = document.getElementById("customBreedInput");
                if (select.value === "OTHER") {
                    otherBreed.classList.remove("d-none");
                    otherBreed.setAttribute("required", "true");
                } else {
                    otherBreed.classList.add("d-none");
                    otherBreed.removeAttribute("required");
                }
            }
        </script>

        <script>
            const editModal = document.getElementById('editPetModal');
            editModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;

                const petId = button.getAttribute('data-pet-id');
                const name = button.getAttribute('data-name');
                const breed = button.getAttribute('data-breed');
                const weight = button.getAttribute('data-weight');
                const birthdate = button.getAttribute('data-birthdate');
                const petTypeId = button.getAttribute('data-pet-type-id');
                const image = button.getAttribute('data-image');

                // Set các giá trị vào form
                document.getElementById('editPetId').value = petId;
                document.getElementById('editName').value = name;
                document.getElementById('editWeight').value = weight;
                document.getElementById('editBirthdate').value = birthdate;
                document.getElementById('editPetTypeSelect').value = petTypeId;
                document.getElementById('oldImage').value = image;

                // Xử lý giống (breed)
                const breedSelect = document.getElementById('editBreedSelect');
                const customBreedInput = document.getElementById('customBreedEditInput');

                let matchFound = false;
                for (let option of breedSelect.options) {
                    if (option.value === breed) {
                        breedSelect.value = breed;
                        matchFound = true;
                        break;
                    }
                }

                if (!matchFound) {
                    breedSelect.value = "OTHER";
                    customBreedInput.classList.remove("d-none");
                    customBreedInput.value = breed;
                    customBreedInput.required = true;
                } else {
                    customBreedInput.classList.add("d-none");
                    customBreedInput.value = "";
                    customBreedInput.required = false;
                }
            });

            function toggleOtherBreedEdit(select) {
                const input = document.getElementById("customBreedEditInput");
                if (select.value === "OTHER") {
                    input.classList.remove("d-none");
                    input.required = true;
                } else {
                    input.classList.add("d-none");
                    input.required = false;
                }
            }
        </script>
        <script>
            function validateUpdatePetForm() {
                const name = document.getElementById("editName").value.trim();
                const weight = parseFloat(document.getElementById("editWeight").value);
                const birthdate = document.getElementById("editBirthdate").value;
                const today = new Date().toISOString().split("T")[0];

                // Validate tên
                const namePattern = /^[A-Za-zÀ-ỹ0-9 ]{2,30}$/;
                if (!namePattern.test(name)) {
                    alert("Tên thú cưng không hợp lệ. Tên phải từ 2-30 ký tự, chỉ chứa chữ cái, số và khoảng trắng.");
                    return false;
                }

                // Validate cân nặng
                if (isNaN(weight) || weight <= 0 || weight > 200) {
                    alert("Cân nặng phải lớn hơn 0 và nhỏ hơn hoặc bằng 200kg.");
                    return false;
                }

                // Validate ngày sinh
                if (!birthdate || birthdate >= today) {
                    alert("Ngày sinh phải nhỏ hơn hôm nay.");
                    return false;
                }

                // Check tên trùng trong danh sách (trừ chính nó)
                const currentPetId = document.getElementById("editPetId").value;
                const existingPets = [...document.querySelectorAll(".btn[data-pet-id]")];
                const duplicate = existingPets.some(btn => {
                    const id = btn.getAttribute("data-pet-id");
                    const n = btn.getAttribute("data-name");
                    return id !== currentPetId && n.trim().toLowerCase() === name.toLowerCase();
                });

                if (duplicate) {
                    alert("Tên thú cưng đã tồn tại! Vui lòng chọn tên khác.");
                    return false;
                }

                return true;
            }
        </script>


        <script>
            function validateAddPetForm() {
                const name = document.getElementById("petName").value.trim();
                const weight = parseFloat(document.getElementById("weight").value);
                const birthdate = document.getElementById("birthdate").value;
                const today = new Date().toISOString().split("T")[0];

                if (weight <= 0 || weight > 200) {
                    alert("Cân nặng phải lớn hơn 0 và nhỏ hơn 200kg.");
                    return false;
                }

                if (!birthdate || birthdate >= today) {
                    alert("Ngày sinh phải nhỏ hơn hôm nay.");
                    return false;
                }

                // Check tên thú cưng có bị trùng không
                const existingNames = [...document.querySelectorAll(".card-body h6")].map(h => h.textContent.trim().split(" ")[0].toLowerCase());
                if (existingNames.includes(name.toLowerCase())) {
                    alert("Tên thú cưng đã tồn tại! Vui lòng chọn tên khác.");
                    return false;
                }

                return true;
            }
        </script>
        <script>
            $(window).on('load', function () {
                $('#preloader-active').fadeOut('slow');
            });
        </script>




    </body>
</html>
