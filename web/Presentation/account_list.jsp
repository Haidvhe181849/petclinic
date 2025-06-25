<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <title>Danh sách tài khoản</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

            html,
            body {
                font-family: 'Poppins', Arial, sans-serif;
                background: #f6f7f8;
                color: #222;
            }

            .container {
                padding: 40px 15px;
            }

            h2.mb-4 {
                color: #ff3d3d;
                font-weight: 600;
                letter-spacing: 0.5px;
            }

            .table {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                font-family: 'Poppins', Arial, sans-serif;
            }

            .table thead th {
                background-color: #fff;
                color: #222;
                border: none;
                font-weight: 600;
                font-size: 16px;
            }

            .table-hover tbody tr:hover {
                background: #fff0f0;
                box-shadow: 0 8px 32px rgba(255, 32, 32, 0.08);
                transition: all 0.3s;
            }

            .table td {
                padding: 14px 10px;
                vertical-align: middle;
                border-color: #f0f0f0;
                font-size: 15px;
                color: #222;
            }

            .btn-info {
                background: #03a9f4;
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 8px;
                box-shadow: none;
                transition: all 0.3s;
                font-family: 'Poppins', Arial, sans-serif;
            }

            .btn-info:hover {
                background: #0288d1;
                transform: translateY(-2px);
            }

            .btn-warning {
                background: #ff3d3d;
                border: none;
                color: #fff;
                font-weight: 600;
                border-radius: 8px;
                box-shadow: none;
                transition: all 0.3s;
                font-family: 'Poppins', Arial, sans-serif;
            }

            .btn-warning:hover {
                background: #d32f2f;
                transform: translateY(-2px);
            }

            .btn-secondary {
                border: 2px solid #ff3d3d;
                color: #ff3d3d;
                font-weight: 500;
                border-radius: 30px;
                padding: 10px 25px;
                background: #fff;
                transition: all 0.3s;
                font-family: 'Poppins', Arial, sans-serif;
                font-size: 16px;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-secondary:hover {
                background-color: #ff3d3d;
                color: #fff;
                border-color: #ff3d3d;
                transform: translateY(-2px);
            }

            .badge {
                font-size: 14px;
                border-radius: 8px;
                padding: 6px 16px;
                font-weight: 500;
                font-family: 'Poppins', Arial, sans-serif;
                transition: all 0.3s;
            }

            .bg-success {
                background: #e0f2f1 !important;
                color: #00897b !important;
            }

            .bg-secondary {
                background: #ececec !important;
                color: #616161 !important;
            }

            .bg-danger,
            .bg-hide {
                background: #ff3d3d !important;
                color: #fff !important;
                border: none !important;
            }

            .action-btn {
                padding: 4px 8px;
                margin: 0 2px;
                font-size: 13px;
                border-radius: 8px;
                transition: all 0.3s;
            }

            .action-btn.btn-info:hover,
            .action-btn.btn-warning:hover,
            .action-btn.btn-success:hover {
                box-shadow: 0 4px 16px rgba(255, 32, 32, 0.10);
                transform: translateY(-2px);
            }
        </style>
    </head>

    <body>
        <div class="container mt-4">
            <h2 class="mb-4">Danh sách tài khoản</h2>

            <c:if test="${not empty sessionScope.alertMessage}">
                <div class="alert alert-${sessionScope.alertType eq 'success' ? 'success' : 'danger'} alert-dismissible fade show"
                     role="alert">
                    ${sessionScope.alertMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="alertMessage" scope="session" />
                <c:remove var="alertType" scope="session" />
            </c:if>

            <div class="mb-3 d-flex flex-wrap gap-2 align-items-center">
                <button class="btn btn-secondary" onclick="location.href = '${pageContext.request.contextPath}/Presentation/Dashbroard.jsp'"> <i
                        class="fas fa-arrow-left me-2"></i>Quay về quản
                    lý</button>
                <button class="btn btn-success" onclick="location.href = 'account-management?action=create'">Tạo tài
                    khoản mới</button>
                <input id="searchInput" type="text" class="form-control" style="max-width:250px;"
                       placeholder="Tìm kiếm...">
                <select id="roleFilter" class="form-select" style="max-width:150px;">
                    <option value="">Tất cả vai trò</option>
                    <option value="1">Admin</option>
                    <option value="2">Nhân viên</option>
                    <option value="3">Khách hàng</option>
                    <option value="4">Bác sĩ</option>
                </select>
                <select id="statusFilter" class="form-select" style="max-width:150px;">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
            </div>

            <table class="table table-bordered table-hover" id="accountTable">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Email</th>
                        <th>Username</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="acc" items="${accounts}">
                        <tr>
                            <td>${acc.userId}</td>
                            <td>${acc.name}</td>
                            <td>${acc.email}</td>
                            <td>${acc.username}</td>
                            <td data-role="${acc.roleId}">
                                <c:choose>
                                    <c:when test="${acc.roleId == 1}">Admin</c:when>
                                    <c:when test="${acc.roleId == 2}">Nhân viên</c:when>
                                     <c:when test="${acc.roleId == 3}">Khách hàng</c:when>
                                    <c:otherwise>Bác sĩ</c:otherwise>
                                </c:choose>
                            </td>
                            <td data-status="${acc.status}">
                                <span
                                    class="badge ${acc.status eq 'Active' ? 'bg-success' : 'bg-secondary'}">${acc.status}</span>
                            </td>
                            <td>
                                <a href="account-management?action=detail&id=${acc.userId}"
                                   class="btn btn-info btn-sm action-btn">Chi tiết</a>
                                <a href="account-management?action=edit&id=${acc.userId}"
                                   class="btn btn-warning btn-sm action-btn">Sửa</a>
                                <c:choose>
                                    <c:when test="${acc.status eq 'Active'}">
                                        <button onclick="toggleAccountStatus('${acc.userId}', 'Inactive')"
                                                class="btn btn-sm btn-warning action-btn" title="Ẩn">
                                            <i class="fas fa-eye-slash"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="toggleAccountStatus('${acc.userId}', 'Active')"
                                                class="btn btn-sm btn-success action-btn" title="Hiện">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- JavaScript lọc bảng -->
        <script>
            const searchInput = document.getElementById('searchInput');
            const roleFilter = document.getElementById('roleFilter');
            const statusFilter = document.getElementById('statusFilter');
            const table = document.getElementById('accountTable');

            function filterTable() {
                const search = searchInput.value.toLowerCase();
                const role = roleFilter.value;
                const status = statusFilter.value;

                for (let row of table.tBodies[0].rows) {
                    const name = row.cells[1].textContent.toLowerCase();
                    const email = row.cells[2].textContent.toLowerCase();
                    const username = row.cells[3].textContent.toLowerCase();
                    const rowRole = row.cells[4].getAttribute('data-role');
                    const rowStatus = row.cells[5].getAttribute('data-status');

                    let show = true;
                    if (search && !(name.includes(search) || email.includes(search) || username.includes(search))) {
                        show = false;
                    }
                    if (role && rowRole !== role) {
                        show = false;
                    }
                    if (status && rowStatus !== status) {
                        show = false;
                    }

                    row.style.display = show ? '' : 'none';
                }
            }

            // Gắn sự kiện lọc
            searchInput.addEventListener('input', filterTable);
            roleFilter.addEventListener('change', filterTable);
            statusFilter.addEventListener('change', filterTable);

            // Áp dụng lọc ban đầu khi tải trang
            window.addEventListener('DOMContentLoaded', filterTable);
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function toggleAccountStatus(userId, newStatus) {
                Swal.fire({
                    title: newStatus === 'Active' ? 'Hiển thị tài khoản?' : 'Ẩn tài khoản?',
                    text: newStatus === 'Active' ? 'Tài khoản sẽ được kích hoạt.' : 'Tài khoản sẽ bị vô hiệu hóa.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#ff3d3d',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Xác nhận',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'account-management?action=toggleStatus&id=' + userId + '&status=' + newStatus;
                    }
                });
            }
        </script>
    </body>

</html>