<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Chi tiết tài khoản</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

                .card {
                    border-radius: 18px;
                    box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
                    border: none;
                }

                .card-header.bg-primary {
                    background: #ff3d3d !important;
                    color: #fff !important;
                    border-radius: 18px 18px 0 0;
                    border: none;
                    font-size: 22px;
                    font-weight: 600;
                    letter-spacing: 0.5px;
                }

                .list-group-item {
                    font-size: 16px;
                    font-family: 'Poppins', Arial, sans-serif;
                    border: none;
                    border-bottom: 1px solid #f0f0f0;
                    padding: 14px 18px;
                }

                .list-group-item:last-child {
                    border-bottom: none;
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

                .alert-danger {
                    background: #ffeaea;
                    color: #ff3d3d;
                    border: none;
                }

                @media (max-width: 768px) {
                    .card-header.bg-primary {
                        font-size: 16px;
                    }

                    .list-group-item {
                        font-size: 13px;
                        padding: 10px 8px;
                    }
                }
            </style>
        </head>

        <body>
            <div class="container mt-4">
                <a href="account-management" class="btn btn-secondary mb-3">Quay lại danh sách</a>
                <c:if test="${not empty alertMessage}">
                    <script>
                        Swal.fire({
                            icon: '${alertType == "success" ? "success" : "error"}',
                            title: '${alertType == "success" ? "Thành công" : "Lỗi"}',
                            text: '${alertMessage}'
                        });
                    </script>
                </c:if>
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4>Thông tin chi tiết tài khoản</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty accountUser}">
                            <div class="alert alert-danger">Không tìm thấy tài khoản!</div>
                        </c:if>
                        <c:if test="${not empty accountUser}">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><b>ID:</b> ${accountUser.userId}</li>
                                <li class="list-group-item"><b>Tên:</b> ${accountUser.name}</li>
                                <li class="list-group-item"><b>Email:</b> ${accountUser.email}</li>
                                <li class="list-group-item"><b>Username:</b> ${accountUser.username}</li>
                                <li class="list-group-item"><b>Phone:</b> ${accountUser.phone}</li>
                                <li class="list-group-item"><b>Address:</b> ${accountUser.address}</li>
                                <li class="list-group-item"><b>Role:</b>
                                    <c:choose>
                                        <c:when test="${accountUser.roleId == 1}">Admin</c:when>
                                        <c:when test="${accountUser.roleId == 2}">Nhân viên</c:when>
                                        <c:otherwise>Khách hàng</c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="list-group-item"><b>Status:</b>
                                    <span
                                        class="badge ${accountUser.status eq 'Active' ? 'bg-success' : 'bg-secondary'}">
                                        ${accountUser.status}
                                    </span>
                                </li>
                            </ul>
                        </c:if>
                    </div>

                </div>
            </div>

        </body>

        </html>