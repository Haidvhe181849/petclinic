<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Chi tiết Feedback - PetClinic</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

                    html,
                    body {
                        font-family: 'Poppins', Arial, sans-serif;
                        background: #f6f7f8;
                        color: #222;
                    }

                    .feedback-card {
                        border-left: 5px solid #ff3d3d;
                        background: #fff;
                        border-radius: 12px;
                        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                    }

                    .rating {
                        color: #ffb300;
                        font-size: 1.2rem;
                    }

                    .user-info {
                        display: flex;
                        align-items: center;
                        margin-bottom: 15px;
                    }

                    .user-avatar {
                        width: 50px;
                        height: 50px;
                        border-radius: 50%;
                        background-color: #ff3d3d;
                        color: white;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        margin-right: 15px;
                    }

                    .reply-form {
                        border-top: 1px solid #ffeaea;
                        padding-top: 20px;
                        margin-top: 20px;
                    }

                    .status-badge {
                        padding: 5px 16px;
                        border-radius: 20px;
                        font-weight: 500;
                        font-size: 15px;
                        font-family: 'Poppins', Arial, sans-serif;
                        margin-bottom: 10px;
                        display: inline-block;
                        transition: all 0.3s;
                    }

                    .status-visible {
                        background-color: #e0f2f1;
                        color: #00897b;
                    }

                    .status-hidden {
                        background-color: #ff3d3d;
                        color: #fff;
                    }

                    .reply-box {
                        background-color: #fff0f0;
                        border-left: 5px solid #ff3d3d;
                        padding: 15px;
                        margin-top: 20px;
                        border-radius: 8px;
                    }

                    .btn-primary {
                        background-color: #ff3d3d;
                        border-color: #ff3d3d;
                        padding: 10px 28px;
                        border-radius: 30px;
                        font-weight: 500;
                        font-family: 'Poppins', Arial, sans-serif;
                        font-size: 16px;
                        transition: all 0.3s;
                    }

                    .btn-primary:hover {
                        background-color: #d32f2f;
                        border-color: #d32f2f;
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

                    .lead {
                        color: #222;
                        font-size: 1.1rem;
                        font-family: 'Poppins', Arial, sans-serif;
                    }

                    .card-body h5,
                    .card-body h6 {
                        color: #ff3d3d;
                        font-weight: 600;
                    }

                    .alert-success {
                        background: #e0f2f1;
                        color: #00897b;
                        border: none;
                    }

                    .alert-danger {
                        background: #ffeaea;
                        color: #ff3d3d;
                        border: none;
                    }

                    @media (max-width: 768px) {
                        .feedback-card {
                            padding: 10px;
                        }

                        .reply-form {
                            padding-top: 10px;
                        }

                        .btn-primary,
                        .btn-secondary {
                            font-size: 14px;
                            padding: 8px 14px;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container my-4">
                    <div class="row mb-3">
                        <div class="col-12">
                            <a href="${pageContext.request.contextPath}/feedback-management" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Quay về danh sách feedback
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <c:if test="${empty feedback}">
                                <h4 class="mb-3">Không tìm thấy thông tin feedback</h4>
                            </c:if>
                            <c:if test="${not empty feedback}">
                                <h4 class="mb-3">Chi tiết Feedback #${feedback.feedbackId}</h4>
                            </c:if>

                            <!-- Alert Messages -->
                            <c:if test="${not empty alertMessage}">
                                <div class="alert alert-${alertType == 'success' ? 'success' : 'danger'} alert-dismissible fade show"
                                    role="alert">
                                    <i
                                        class="fas fa-${alertType == 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
                                    ${alertMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"
                                        aria-label="Close"></button>
                                </div>
                            </c:if>

                            <c:if test="${empty feedback}">
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    Không tìm thấy thông tin feedback
                                </div>
                            </c:if>

                            <c:if test="${not empty feedback}">
                                <div class="card feedback-card mb-4">
                                    <div class="card-body">
                                        <div class="user-info">
                                            <div class="user-avatar">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-0">${feedback.userName}</h5>
                                                <small class="text-muted">${feedback.userEmail}</small>
                                            </div>
                                        </div>
                                        <span
                                            class="status-badge ${feedback.visible ? 'status-visible' : 'status-hidden'}">
                                            ${feedback.visible ? 'Hiển thị' : 'Ẩn'}
                                        </span>
                                    </div>

                                    <div class="rating mb-2">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fa${i <= feedback.starRating ? 's' : 'r'} fa-star"></i>
                                        </c:forEach>
                                    </div>

                                    <div class="mb-3">
                                        <h6 class="text-muted">Ngày gửi:
                                            <fmt:formatDate value="${feedback.postTime}" pattern="dd/MM/yyyy HH:mm" />
                                        </h6>
                                    </div>

                                    <div class="mb-4">
                                        <h6>Nội dung feedback:</h6>
                                        <p class="lead">${feedback.feedbackText}</p>
                                    </div>

                                    <c:if test="${not empty feedback.bookingId}">
                                        <div class="mb-3">
                                            <h6>Mã đặt lịch: <span
                                                    class="badge bg-secondary">${feedback.bookingId}</span></h6>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty feedback.replyText}">
                                        <div class="reply-box">
                                            <h6><i class="fas fa-reply me-2"></i>Phản hồi:</h6>
                                            <p>${feedback.replyText}</p>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Reply Form -->
                                <div class="reply-form">
                                    <h5 class="mb-3"><i class="fas fa-reply me-2"></i>${empty feedback.replyText ?
                                        'Phản hồi feedback' : 'Cập nhật phản hồi'}</h5>
                                    <form action="feedback-management" method="post">
                                        <input type="hidden" name="action" value="reply">
                                        <input type="hidden" name="id" value="${feedback.feedbackId}">

                                        <div class="mb-3">
                                            <textarea class="form-control" name="replyText" rows="4"
                                                required>${feedback.replyText}</textarea>
                                        </div>

                                        <div class="d-flex justify-content-between">
                                            <a href="feedback-management" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left me-1"></i> Quay lại
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-paper-plane me-1"></i> Gửi phản hồi
                                            </button>
                                        </div>
                                    </form>
                                </div>
                        </div>
                    </div>
                    </c:if>
                </div>
                </div>
                </div> <!-- Bootstrap & jQuery JS -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function toggleVisibility(feedbackId, visible) {
                        // Kiểm tra xem feedbackId có hợp lệ không
                        if (!feedbackId || feedbackId === 'undefined') {
                            Swal.fire({
                                title: 'Lỗi!',
                                text: 'Không thể xác định ID của feedback',
                                icon: 'error'
                            });
                            return;
                        }

                        Swal.fire({
                            title: visible === 'true' ? 'Hiển thị feedback?' : 'Ẩn feedback?',
                            text: visible === 'true' ? 'Feedback này sẽ được hiển thị công khai.' : 'Feedback này sẽ bị ẩn khỏi trang web.',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Xác nhận',
                            cancelButtonText: 'Hủy'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                try {
                                    window.location.href = 'feedback-management?action=toggle&id=' + feedbackId + '&visible=' + visible;
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