<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Quản lý Feedback - PetClinic</title>
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

                    .container {
                        padding: 40px 15px;
                    }

                    .card.shadow {
                        border-radius: 18px;
                        box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
                        border: none;
                    }

                    .card-header.bg-primary {
                        background: #ff3d3d !important;
                        color: #fff !important;
                        border-radius: 18px 18px 0 0;
                        border: none;
                        font-size: 24px;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                    }

                    .table {
                        background: #fff;
                        border-radius: 0 0 18px 18px;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                        margin-top: 0;
                        font-family: 'Poppins', Arial, sans-serif;
                    }

                    .table thead th {
                        background-color: #fff;
                        color: #222;
                        border: none;
                        font-weight: 600;
                        font-size: 16px;
                    }

                    .table-striped>tbody>tr:nth-of-type(odd) {
                        background-color: #f8f9fa;
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

                    .badge,
                    .status-badge {
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
                    .bg-pink,
                    .bg-hide,
                    .status-hidden {
                        background: #ff3d3d !important;
                        color: #fff !important;
                        border: none !important;
                    }

                    .status-visible {
                        background-color: #e0f2f1 !important;
                        color: #00897b !important;
                    }

                    .reply-status.has-reply {
                        background: #e0f2f1;
                        color: #00897b;
                    }

                    .reply-status {
                        background: #ececec;
                        color: #616161;
                    }

                    .star-rating .fa-star,
                    .rating .fa-star {
                        margin-right: 2px;
                        color: #ffd600 !important;
                    }

                    .star-rating .fa-regular.text-secondary,
                    .rating .fa-regular.text-secondary {
                        color: #bdbdbd !important;
                    }

                    .customer-name {
                        font-weight: 600;
                        color: #ff3d3d;
                    }

                    .customer-email {
                        font-size: 12px;
                        color: #6c757d;
                    }

                    .preview-text {
                        max-width: 300px;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;
                        color: #222;
                    }

                    .reply-preview {
                        font-size: 13px;
                        color: #ff3d3d;
                        font-style: italic;
                        margin-top: 4px;
                        display: block;
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

                    @media (max-width: 768px) {
                        .card-header.bg-primary {
                            font-size: 18px;
                        }

                        .table td,
                        .table th {
                            padding: 8px 4px;
                            font-size: 13px;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container my-4">
                    <div class="row mb-3">
                        <div class="col-12">
                            <a href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp"
                                class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Quay về</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow">
                                <div class="card-header bg-primary text-white">
                                    <h4 class="mb-0"><i class="fas fa-comments me-2"></i>Quản lý Feedback</h4>
                                </div>
                                <div class="card-body">
                                    <!-- Alert Messages -->
                                    <c:if test="${not empty sessionScope.alertMessage}">
                                        <div class="alert alert-${sessionScope.alertType == 'success' ? 'success' : 'danger'} alert-dismissible fade show"
                                            role="alert">
                                            <i
                                                class="fas fa-${sessionScope.alertType == 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
                                            ${sessionScope.alertMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                        <% session.removeAttribute("alertMessage"); %>
                                            <% session.removeAttribute("alertType"); %>
                                    </c:if>

                                    <!-- Search Box and Filters -->
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-text">
                                                    <i class="fas fa-search"></i>
                                                </span>
                                                <input type="text" id="searchInput" class="form-control"
                                                    placeholder="Tìm kiếm theo tên, email, nội dung...">
                                                <button class="btn btn-outline-secondary" type="button"
                                                    onclick="clearSearch()">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <select id="filterRating" class="form-select" onchange="filterTable()">
                                                <option value="">Tất cả đánh giá</option>
                                                <option value="5">★★★★★ (5 sao)</option>
                                                <option value="4">★★★★☆ (4 sao)</option>
                                                <option value="3">★★★☆☆ (3 sao)</option>
                                                <option value="2">★★☆☆☆ (2 sao)</option>
                                                <option value="1">★☆☆☆☆ (1 sao)</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <select id="filterStatus" class="form-select" onchange="filterTable()">
                                                <option value="">Tất cả trạng thái</option>
                                                <option value="visible">Đang hiển thị</option>
                                                <option value="hidden">Đang ẩn</option>
                                                <option value="replied">Đã phản hồi</option>
                                                <option value="not-replied">Chưa phản hồi</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Feedback Table -->
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th onclick="sortTable(0)">ID <i class="fas fa-sort"></i></th>
                                                    <th onclick="sortTable(1)">Khách hàng <i class="fas fa-sort"></i>
                                                    </th>
                                                    <th onclick="sortTable(2)">Nội dung <i class="fas fa-sort"></i></th>
                                                    <th onclick="sortTable(3)">Đánh giá <i class="fas fa-sort"></i></th>
                                                    <th onclick="sortTable(4)">Ngày gửi <i class="fas fa-sort"></i></th>
                                                    <th onclick="sortTable(5)">Trạng thái <i class="fas fa-sort"></i>
                                                    </th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${empty feedbacks}">
                                                    <tr>
                                                        <td colspan="7" class="text-center">Không có dữ liệu feedback
                                                        </td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach var="feedback" items="${feedbacks}">
                                                    <tr>
                                                        <td>${feedback.feedbackId}</td>
                                                        <td>
                                                            <div class="customer-info">
                                                                <div class="customer-name">${feedback.userName}</div>
                                                                <div class="customer-email">${feedback.userEmail}</div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="preview-text">${feedback.feedbackText}</div>
                                                            <c:if test="${not empty feedback.replyText}">
                                                                <span class="reply-preview">
                                                                    <i class="fas fa-reply me-1"></i>
                                                                    ${feedback.replyText}
                                                                </span>
                                                            </c:if>
                                                        </td>
                                                        <td class="rating text-center">
                                                            <div class="d-flex align-items-center">
                                                                <div class="rating">
                                                                    <c:forEach begin="1" end="5" var="i">
                                                                        <i
                                                                            class="fa${i <= feedback.starRating ? 's' : 'r'} fa-star"></i>
                                                                    </c:forEach>
                                                                </div>
                                                                <c:choose>
                                                                    <c:when test="${not empty feedback.replyText}">
                                                                        <span class="reply-status has-reply">
                                                                            <i class="fas fa-check-circle me-1"></i>Đã
                                                                            phản hồi
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="reply-status">
                                                                            <i class="fas fa-clock me-1"></i>Chưa phản
                                                                            hồi
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="datetime">
                                                                <fmt:formatDate value="${feedback.postTime}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="status-badge ${feedback.visible ? 'status-visible' : 'status-hidden'}">
                                                                ${feedback.visible ? 'Hiển thị' : 'Ẩn'}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <a href="feedback-management?action=detail&id=${feedback.feedbackId}"
                                                                class="btn btn-sm btn-info action-btn" title="Chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <button
                                                                onclick="toggleVisibility('${feedback.feedbackId}', '${!feedback.visible}')"
                                                                class="btn btn-sm ${feedback.visible ? 'btn-warning' : 'btn-success'} action-btn"
                                                                title="${feedback.visible ? 'Ẩn' : 'Hiển thị'}">
                                                                <i
                                                                    class="fas fa-${feedback.visible ? 'eye-slash' : 'eye'}"></i>
                                                            </button>
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

                <!-- Bootstrap & jQuery -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    const searchInput = document.getElementById('searchInput');
                    const filterRating = document.getElementById('filterRating');
                    const filterStatus = document.getElementById('filterStatus');
                    let timeoutId;

                    // Debounce function
                    function debounce(func, delay) {
                        clearTimeout(timeoutId);
                        timeoutId = setTimeout(func, delay);
                    }

                    // Search input event
                    searchInput.addEventListener('input', () => {
                        debounce(filterTable, 300);
                    });

                    // Clear search and filters
                    function clearSearch() {
                        searchInput.value = '';
                        filterRating.value = '';
                        filterStatus.value = '';
                        filterTable();
                    }

                    // Filter table function
                    function filterTable() {
                        const searchTerm = searchInput.value.toLowerCase();
                        const ratingFilter = filterRating.value;
                        const statusFilter = filterStatus.value;
                        const tbody = document.querySelector('table tbody');
                        const rows = tbody.getElementsByTagName('tr');

                        for (let row of rows) {
                            if (row.classList.contains('no-data')) continue;

                            const customerCol = row.cells[1].textContent.toLowerCase();
                            const contentCol = row.cells[2].textContent.toLowerCase();
                            let ratingStars = 0;
                            const ratingDiv = row.cells[3].querySelector('.rating');
                            if (ratingDiv) {
                                ratingStars = ratingDiv.querySelectorAll('.fa-star.fas').length;
                            }
                            const hasReply = row.cells[2].querySelector('.reply-preview') !== null;
                            const statusBadge = row.cells[5].querySelector('.status-badge');
                            const isVisible = statusBadge && statusBadge.classList.contains('status-visible');

                            // Search filter
                            const matchesSearch = !searchTerm ||
                                customerCol.includes(searchTerm) ||
                                contentCol.includes(searchTerm);

                            // Rating filter
                            const matchesRating = !ratingFilter || ratingStars == parseInt(ratingFilter);

                            // Status filter
                            let matchesStatus = true;
                            if (statusFilter) {
                                switch (statusFilter) {
                                    case 'visible':
                                        matchesStatus = isVisible;
                                        break;
                                    case 'hidden':
                                        matchesStatus = !isVisible;
                                        break;
                                    case 'replied':
                                        matchesStatus = hasReply;
                                        break;
                                    case 'not-replied':
                                        matchesStatus = !hasReply;
                                        break;
                                }
                            }

                            row.style.display = (matchesSearch && matchesRating && matchesStatus) ? '' : 'none';
                        }
                    }

                    // Sort table function
                    let sortDirection = 1;
                    let lastSortedColumn = -1;

                    function sortTable(columnIndex) {
                        const table = document.querySelector('table');
                        const tbody = table.getElementsByTagName('tbody')[0];
                        const rows = Array.from(tbody.getElementsByTagName('tr'));

                        // Reset sort direction if clicking on a new column
                        if (lastSortedColumn !== columnIndex) {
                            sortDirection = 1;
                        } else {
                            sortDirection = -sortDirection;
                        }
                        lastSortedColumn = columnIndex;

                        // Remove existing sort indicators
                        const headers = table.getElementsByTagName('th');
                        for (let header of headers) {
                            const icon = header.querySelector('i.fas');
                            if (icon) icon.className = 'fas fa-sort';
                        }

                        // Sort the rows
                        rows.sort((a, b) => {
                            let aValue = a.cells[columnIndex].textContent.trim();
                            let bValue = b.cells[columnIndex].textContent.trim();

                            // Special handling for rating column
                            if (columnIndex === 3) {
                                aValue = a.cells[columnIndex].querySelector('.rating').querySelectorAll('.fa-star.fas').length;
                                bValue = b.cells[columnIndex].querySelector('.rating').querySelectorAll('.fa-star.fas').length;
                            }
                            // Special handling for date column
                            else if (columnIndex === 4) {
                                aValue = new Date(aValue.split(' ').reverse().join(' ')).getTime();
                                bValue = new Date(bValue.split(' ').reverse().join(' ')).getTime();
                            }

                            if (aValue < bValue) return -sortDirection;
                            if (aValue > bValue) return sortDirection;
                            return 0;
                        });

                        // Reinsert the sorted rows
                        rows.forEach(row => tbody.appendChild(row));
                    }

                    // Toggle visibility function
                    function toggleVisibility(feedbackId, visible) {
                        if (!feedbackId || feedbackId === 'undefined') {
                            Swal.fire({
                                title: 'Lỗi!',
                                text: 'Không thể xác định ID của feedback',
                                icon: 'error'
                            });
                            return;
                        }
                        // Chuyển visible thành true/false string cho backend
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