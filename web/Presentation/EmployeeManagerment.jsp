<%-- 
    Document   : EmployeeManagerment
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
        <title>Employee Managerment</title>

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
                <h2 class="text-2xl font-bold text-gray-700">Employee Management</h2>
            </div> 

            <div class="w-full px-6 py-6 mx-auto">
                <!-- table 1 -->

                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-end">
                                    <div class="flex gap-2 items-center">
                                        <!-- Nút Filter -->
                                        <form action="${pageContext.request.contextPath}/Employee" method="get" class="flex items-center ml-2">
                                            <input type="text" name="name" class="form-control" style="min-width: 180px"
                                                   value="${param.name}" placeholder="Employee name..." />

                                            <input type="text" name="phone" class="form-control mx-2" style="min-width: 150px"
                                                   value="${param.phone}" placeholder="Phone..." />

                                            <select name="roleId" class="form-select form-select-sm w-auto mx-2">
                                                <option value="">All Roles</option>
                                                <option value="1" ${param.roleId == '1' ? 'selected' : ''}>Admin</option>
                                                <option value="2" ${param.roleId == '2' ? 'selected' : ''}>Staff</option>
                                                <option value="3" ${param.roleId == '3' ? 'selected' : ''}>Doctor</option>
                                            </select>

                                            <select name="status" class="form-select form-select-sm w-auto mx-2">
                                                <option value="">All</option>
                                                <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                                                <option value="false" ${param.status == 'false' ? 'selected' : ''}>Inactive</option>
                                            </select>

                                            <select name="sortColumn" class="form-select form-select-sm w-auto mx-2">
                                                <option value="">Sort by</option>
                                                <option value="name" ${param.sortColumn == 'name' ? 'selected' : ''}>Name</option>
                                                <option value="email" ${param.sortColumn == 'email' ? 'selected' : ''}>Email</option>
                                                <option value="role_id" ${param.sortColumn == 'role_id' ? 'selected' : ''}>Role</option>
                                            </select>

                                            <select name="sortType" class="form-select form-select-sm w-auto mx-2">
                                                <option value="asc" ${param.sortType == 'asc' ? 'selected' : ''}>ASC</option>
                                                <option value="desc" ${param.sortType == 'desc' ? 'selected' : ''}>DESC</option>
                                            </select>

                                            <button type="submit" class="btn btn-sm btn-outline-secondary ms-2">Filter</button>
                                        </form>





                                        <!-- Nút All -->
                                        <form action="${pageContext.request.contextPath}/Employee" method="get">
                                            <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                All
                                            </button>
                                        </form>

                                        <!-- Nút Add Employee -->
                                        <button class="btn btn-sm btn-outline-secondary"
                                                data-bs-toggle="modal"
                                                data-bs-target="#addEmployeeModal">
                                            Add Employee
                                        </button>
                                    </div>
                                </div>



                            </div>
                            <div class="flex-auto px-0 pt-0 pb-2">
                                <div class="p-0 overflow-x-auto">
                                    <table class="table table-bordered table-hover align-middle">
                                        <thead class="table-primary">
                                            <tr>
                                                <th style="width: 60px;">ID</th>
                                                <th style="width: 120px;">Image</th>
                                                <th>Name</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <th style="width: 180px;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="e" items="${elist}">
                                                <tr>
                                                    <td><c:out value="${e.employeeId}"/></td>
                                                    <td>
                                                        <c:if test="${not empty e.image}">
                                                            <img src="${pageContext.request.contextPath}/${e.image}" alt="Employee Image"
                                                                 style="width: 100px; height: 60px; object-fit: cover; border-radius: 6px;">
                                                        </c:if>
                                                        <c:if test="${empty e.image}">
                                                            <div class="bg-secondary text-white text-center" style="width: 100px; height: 60px; display: flex; align-items: center; justify-content: center; border-radius: 6px;">
                                                                No Image
                                                            </div>
                                                        </c:if>
                                                    </td>
                                                    <td><c:out value="${e.name}"/></td>
                                                    <td><c:out value="${e.phone}"/></td>
                                                    <td><c:out value="${e.email}"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${e.roleId == 1}">
                                                                <span class="badge bg-danger">Admin</span>
                                                            </c:when>
                                                            <c:when test="${e.roleId == 2}">
                                                                <span class="badge bg-info">Staff</span>
                                                            </c:when>
                                                            <c:when test="${e.roleId == 3}">
                                                                <span class="badge bg-primary">Doctor</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">${e.roleId}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${e.status}">
                                                                <span class="badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Inactive</span>
                                                            </c:otherwise>

                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <a href="#" class="btn btn-sm btn-outline-primary view-btn"
                                                           data-bs-toggle="modal" data-bs-target="#viewEmployeeModal"
                                                           data-id="${e.employeeId}"
                                                           data-name="${e.name}"
                                                           data-phone="${e.phone}"
                                                           data-email="${e.email}"
                                                           data-address="${e.address}"
                                                           data-role="${e.roleId}"
                                                           data-experience="${e.experience}"
                                                           data-workinghours="${e.workingHours}"
                                                           data-status="${e.status ? 1 : 0}"
                                                           data-image="${e.image}">
                                                            <i class="fa fa-eye"></i>
                                                        </a>

                                                        <!-- View Feedback Button (only for doctors - role_id = 3) -->
                                                        <c:if test="${e.roleId == 3}">
                                                            <a href="#" class="btn btn-sm btn-outline-info me-1 feedback-btn"
                                                               data-bs-toggle="modal" data-bs-target="#feedbackModal"
                                                               data-employee-id="${e.employeeId}"
                                                               data-employee-name="${e.name}"
                                                               title="View Feedback">
                                                                <i class="fas fa-comments"></i>
                                                            </a>
                                                        </c:if>

                                                        <a href="#" class="btn btn-sm btn-outline-primary me-2 update-btn"
                                                           data-bs-toggle="modal"
                                                           data-bs-target="#editEmployeeModal"
                                                           data-id="${e.employeeId}"
                                                           data-image="${e.image}"
                                                           data-name="${e.name}"
                                                           data-phone="${e.phone}"
                                                           data-email="${e.email}"
                                                           data-role="${e.roleId}"
                                                           data-address="${e.address}"
                                                           data-experience="${e.experience}"
                                                           data-workinghours="${e.workingHours}"
                                                           data-status="${e.status ? 1 : 0}"
                                                           data-oldimage="${e.image}"
                                                           title="Edit Employee">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <a href="Employee?service=delete&employeeId=<c:out value='${e.employeeId}'/>"
                                                           onclick="return confirm('Are you sure to delete this employee?');"
                                                           class="btn btn-sm btn-outline-danger" title="Delete">
                                                            <i class="fa fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty elist}">
                                                <tr>
                                                    <td colspan="8" class="text-center">No employee found.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>

                                    <!-- PHÂN TRANG -->
                                    <c:if test="${totalPages > 1}">
                                        <nav class="mt-3 d-flex justify-content-center">
                                            <ul class="pagination pagination-sm">
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link"
                                                           href="Employee?page=${i}
                                                           &name=${name}&email=${email}&phone=${phone}
                                                           &roleId=${roleId}&status=${status}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </nav>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- View Employee Modal -->
            <div class="modal fade" id="viewEmployeeModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thông tin chi tiết nhân viên</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <div class="text-center mb-3">
                                <img id="viewImage" src="" alt="Ảnh nhân viên"
                                     style="max-height: 120px; border-radius: 10px; object-fit: cover;">
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label><strong>ID</strong></label>
                                    <div id="viewEmployeeId" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-6">
                                    <label><strong>Họ tên</strong></label>
                                    <div id="viewName" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-6">
                                    <label><strong>Số điện thoại</strong></label>
                                    <div id="viewPhone" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-6">
                                    <label><strong>Email</strong></label>
                                    <div id="viewEmail" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-6">
                                    <label><strong>Địa chỉ</strong></label>
                                    <div id="viewAddress" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-6">
                                    <label><strong>Role ID</strong></label>
                                    <div id="viewRoleId" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-12">
                                    <label><strong>Kinh nghiệm</strong></label>
                                    <div id="viewExperience" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-12">
                                    <label><strong>Giờ làm việc</strong></label>
                                    <div id="viewWorkingHours" class="form-control-plaintext border-bottom">-</div>
                                </div>
                                <div class="col-md-12">
                                    <label><strong>Trạng thái</strong></label><br>
                                    <span id="viewStatus" class="badge bg-secondary">-</span>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer justify-content-end">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Add Employee Modal -->
            <!-- Add Employee Modal -->
            <div id="addEmployeeModal" class="modal fade" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form id="addEmployeeForm" method="post" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h4 class="modal-title">Add Employee</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">
                                <div id="add-error" class="text-danger fw-bold mt-2"></div>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label>Name</label>
                                        <input type="text" name="name" class="form-control" required 
                                               pattern="^[^\s].{1,98}[^\s]$"
                                               title="Tên không được để trống hoặc chỉ chứa khoảng trắng. Tối đa 100 ký tự">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Phone</label>
                                        <input type="text" name="phone" class="form-control" required 
                                               pattern="^0\d{9}$"
                                               title="Số điện thoại phải bắt đầu bằng 0 và đủ 10 chữ số">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Email</label>
                                        <input type="email" name="email" class="form-control" required
                                               pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                               title="Email phải đúng định dạng">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="password">Password</label>
                                        <div class="input-group">
                                            <input type="password" name="password" id="password" class="form-control"
                                                   required minlength="6" maxlength="50"
                                                   title="Tối thiểu 6 ký tự">
                                            <span class="input-group-text" onclick="togglePasswordVisibility()" style="cursor: pointer;">
                                                <i class="fa fa-eye" id="toggleIcon"></i>
                                            </span>
                                        </div>
                                    </div>


                                    <div class="col-md-6">
                                        <label>Address</label>
                                        <input type="text" name="address" class="form-control" maxlength="255" required
                                               title="Tối đa 255 ký tự">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Role</label>
                                        <select name="roleId" class="form-select" required>
                                            <option value="">-- Select Role --</option>
                                            <option value="1">Admin</option>
                                            <option value="2">Staff</option>
                                            <option value="3">Doctor</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Experience</label>
                                        <input type="text" name="experience" class="form-control" maxlength="255"
                                               title="Tối đa 255 ký tự">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Working Hours</label>
                                        <input type="text" name="workingHours" class="form-control" placeholder="e.g. 8:00-17:00"
                                               pattern="^\d{1,2}:\d{2}-\d{1,2}:\d{2}$"
                                               title="Định dạng hợp lệ: 8:00-17:00" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Image</label>
                                        <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Status</label><br>
                                        <input type="radio" name="status" value="true" checked/> Active
                                        <input type="radio" name="status" value="false" /> Inactive
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <input type="hidden" name="service" value="addEmployee">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success">Add</button>

                            </div>
                        </form>
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

            <!-- Update Employee Modal -->
            <!-- Update Employee Modal -->
            <div id="editEmployeeModal" class="modal fade" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form id="editEmployeeForm" action="${pageContext.request.contextPath}/Employee" method="post" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h4 class="modal-title">Cập Nhật Nhân Viên</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">
                                <!-- Thông báo lỗi / thành công -->
                                <div id="edit-error" class="text-danger mb-2"></div>
                                <div id="edit-success" class="text-success mb-2"></div>

                                <!-- ID ẩn -->
                                <input type="hidden" name="employeeId" required readonly>
                                <input type="hidden" name="old_image" readonly>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label>Image</label>
                                        <input type="file" name="imageFile" class="form-control" accept="image/*">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Name</label>
                                        <input type="text" name="name" class="form-control"
                                               required pattern="^[^\s].{1,98}[^\s]$"
                                               title="Tên không được để trống hoặc chỉ chứa khoảng trắng. Tối đa 100 ký tự">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Phone</label>
                                        <input type="text" name="phone" class="form-control"
                                               required pattern="^0\d{9}$"
                                               title="Số điện thoại phải bắt đầu bằng 0 và đủ 10 chữ số">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Email</label>
                                        <input type="email" name="email" class="form-control"
                                               required pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                               title="Email phải đúng định dạng">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Mật khẩu</label>
                                        <div class="input-group">
                                            <input type="password" name="password" id="password" class="form-control"
                                                   required minlength="6" maxlength="50"
                                                   title="Tối thiểu 6 và tối đa 50 ký tự">
                                            <span class="input-group-text" onclick="togglePassword()" style="cursor: pointer;">
                                                <i class="fa fa-eye" id="eyeIcon"></i>
                                            </span>
                                        </div>
                                    </div>


                                    <div class="col-md-6">
                                        <label>Address</label>
                                        <input type="text" name="address" class="form-control"
                                               maxlength="255"
                                               title="Tối đa 255 ký tự">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Role</label>
                                        <select name="roleId" class="form-select">
                                            <option value="1">Admin</option>
                                            <option value="2">Staff</option>
                                            <option value="3">Doctor</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Experience</label>
                                        <textarea name="experience" class="form-control" maxlength="255"
                                                  title="Tối đa 255 ký tự" rows="3"></textarea>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Working Hours</label>
                                        <input type="text" name="workingHours" class="form-control"
                                               placeholder="e.g. 08:00-17:00"
                                               pattern="^[0-2]?[0-9]:[0-5][0-9]-[0-2]?[0-9]:[0-5][0-9]$"
                                               title="Định dạng hợp lệ: 08:00-17:00">
                                    </div>

                                    <div class="col-md-6">
                                        <label>Status</label><br>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="status" value="true" id="statusActive">
                                            <label class="form-check-label" for="statusActive">Active</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="status" value="false" id="statusInactive">
                                            <label class="form-check-label" for="statusInactive">Inactive</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <input type="hidden" name="service" value="update">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <input type="submit" class="btn btn-info" value="Save">
                            </div>
                        </form>
                    </div>
                </div>
            </div>




            <!-- Feedback Modal -->
            <div class="modal fade" id="feedbackModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Doctor Feedback</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div id="feedbackContent">
                                <div class="text-center">
                                    <div class="spinner-border" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                    <p>Loading feedback...</p>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                                $(".update-btn").click(function () {
                                                    $("#editEmployeeModal input[name='employeeId']").val($(this).data("id"));
                                                    $("#editEmployeeModal input[name='old_image']").val($(this).data("image"));
                                                    $("#editEmployeeModal input[name='name']").val($(this).data("name"));
                                                    $("#editEmployeeModal input[name='phone']").val($(this).data("phone"));
                                                    $("#editEmployeeModal input[name='email']").val($(this).data("email"));
                                                    $("#editEmployeeModal input[name='password']").val("123"); // hoặc bỏ trống nếu không sửa
                                                    $("#editEmployeeModal input[name='address']").val($(this).data("address"));
                                                    $("#editEmployeeModal select[name='roleId']").val($(this).data("role"));
                                                    $("#editEmployeeModal textarea[name='experience']").val($(this).data("experience"));
                                                    $("#editEmployeeModal input[name='workingHours']").val($(this).data("workinghours"));

                                                    const status = $(this).data("status");
                                                    $("#editEmployeeModal input[name='status'][value='true']").prop("checked", status == 1);
                                                    $("#editEmployeeModal input[name='status'][value='false']").prop("checked", status == 0);
                                                });

                                                $(".view-btn").click(function () {
                                                    const roleId = $(this).data("role");
                                                    let roleName = "Unknown";

                                                    switch (roleId) {
                                                        case 1:
                                                        case "1":
                                                            roleName = "Admin";
                                                            break;
                                                        case 2:
                                                        case "2":
                                                            roleName = "Staff";
                                                            break;
                                                        case 3:
                                                        case "3":
                                                            roleName = "Doctor";
                                                            break;
                                                    }

                                                    $("#viewEmployeeId").text($(this).data("id"));
                                                    $("#viewName").text($(this).data("name"));
                                                    $("#viewPhone").text($(this).data("phone"));
                                                    $("#viewEmail").text($(this).data("email"));
                                                    $("#viewAddress").text($(this).data("address"));
                                                    $("#viewRoleId").text(roleName); // ✅ Đã chuyển thành tên role
                                                    $("#viewExperience").text($(this).data("experience"));
                                                    $("#viewWorkingHours").text($(this).data("workinghours"));

                                                    const imagePath = $(this).data("image");
                                                    $("#viewImage").attr("src", "Presentation/img/images/Employee/" + imagePath);

                                                    const status = $(this).data("status");
                                                    const statusText = status == 1 ? "Active" : "Inactive";
                                                    const statusClass = status == 1 ? "bg-success" : "bg-danger";
                                                    $("#viewStatus").text(statusText).removeClass("bg-success bg-danger").addClass(statusClass);
                                                });

                                                // Handle feedback button click
                                                $(".feedback-btn").click(function () {
                                                    const employeeId = $(this).data("employee-id");
                                                    const employeeName = $(this).data("employee-name");

                                                    // Update modal title
                                                    $("#feedbackModal .modal-title").text("Feedback for " + employeeName);                        // Reset content to loading state
                                                    $("#feedbackContent").html(`
                            <div class="text-center">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                                <p>Loading feedback...</p>
                            </div>
                        `);

                                                    // Load feedback via AJAX
                                                    $.ajax({
                                                        url: "${pageContext.request.contextPath}/EmployeeFeedback",
                                                        method: "GET",
                                                        data: {employeeId: employeeId},
                                                        success: function (response) {
                                                            $("#feedbackContent").html(response);
                                                        },
                                                        error: function (xhr, status, error) {
                                                            $("#feedbackContent").html(`
                                    <div class="alert alert-danger">
                                        <i class="fas fa-exclamation-triangle"></i>
                                        Error loading feedback: ` + error + `
                                    </div>
                                `);
                                                        }
                                                    });
                                                });

        </script>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const form = document.getElementById("addEmployeeForm");
                const errorDiv = document.getElementById("add-error");

                form.addEventListener("submit", function (e) {
                    e.preventDefault(); // Ngăn reload mặc định

                    const formData = new FormData(form);

                    fetch("Employee", {
                        method: "POST",
                        body: formData
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.status === "error") {
                                    // Hiển thị lỗi trong modal
                                    errorDiv.textContent = data.message;
                                } else if (data.status === "success") {
                                    // Reset form + ẩn modal + thông báo
                                    errorDiv.textContent = "";
                                    form.reset();
                                    const modal = bootstrap.Modal.getInstance(document.getElementById("addEmployeeModal"));
                                    modal.hide();

                                    // Hiển thị toast/thông báo đơn giản
                                    alert(data.message);

                                    // Có thể reload bảng nhân viên (nếu có)
                                    location.reload(); // nếu muốn reload danh sách
                                }
                            })
                            .catch(err => {
                                console.error("Lỗi fetch:", err);
                                errorDiv.textContent = "❌ Đã xảy ra lỗi hệ thống.";
                            });
                });
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const editForm = document.getElementById("editEmployeeForm");

                if (editForm) {
                    editForm.addEventListener("submit", async function (e) {
                        e.preventDefault();

                        const formData = new FormData(this);
                        formData.append("service", "update");

                        try {
                            const response = await fetch("Employee", {
                                method: "POST",
                                body: formData
                            });

                            const contentType = response.headers.get("content-type");

                            // Nếu là JSON, nghĩa là có lỗi -> hiển thị
                            if (contentType && contentType.includes("application/json")) {
                                const result = await response.json();

                                if (result.status === "error") {
                                    document.getElementById("edit-error").innerText = result.message;
                                    return;
                                }
                            }

                            // Nếu không phải JSON, coi như update thành công
                            window.location.reload();

                        } catch (error) {
                            console.error("Lỗi khi gửi request:", error);
                            document.getElementById("edit-error").innerText = "❌ Đã xảy ra lỗi hệ thống.";
                        }
                    });
                }
            });
        </script>

        <script>
            function togglePassword() {
                const pwd = document.getElementById("password");
                const icon = document.getElementById("eyeIcon");
                if (pwd.type === "password") {
                    pwd.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    pwd.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>

        <script>
            function togglePasswordVisibility() {
                const passwordInput = document.getElementById("password");
                const icon = document.getElementById("toggleIcon");

                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordInput.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>




    </body>
</html>
