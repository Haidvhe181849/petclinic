<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hóa đơn - Pet Hospital</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>

        <style>
            .invoice-container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            .invoice-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .invoice-body {
                padding: 30px;
            }

            .invoice-info {
                display: flex;
                justify-content: space-between;
                margin-bottom: 30px;
            }

            .info-card {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                border-left: 4px solid #667eea;
            }

            .amount-highlight {
                font-size: 1.5rem;
                font-weight: bold;
                color: #28a745;
            }

            .status-badge {
                font-size: 0.9rem;
                padding: 8px 16px;
                border-radius: 20px;
            }

            .no-invoice {
                text-align: center;
                padding: 50px;
                color: #6c757d;
            }

            .no-invoice i {
                font-size: 4rem;
                margin-bottom: 20px;
                color: #dee2e6;
            }
        </style>
    </head>

    <body class="bg-light">
        <div class="container py-5">
            <div class="invoice-container">
                <!-- Header -->
                <div class="invoice-header">
                    <h1><i class="fas fa-file-invoice-dollar"></i> HÓA ĐƠN DỊCH VỤ</h1>
                    <p class="mb-0">Pet Hospital - Chăm sóc thú cưng chuyên nghiệp</p>
                </div>

                <!-- Body -->
                <div class="invoice-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${hasInvoice}">
                            <!-- Invoice exists -->
                            <div class="invoice-info">
                                <div class="info-card flex-fill me-3">
                                    <h6 class="text-muted mb-2">THÔNG TIN HÓA ĐƠN</h6>
                                    <p class="mb-1"><strong>Mã hóa đơn:</strong> #${invoice.invoiceId}</p>
                                    <p class="mb-1"><strong>Mã booking:</strong> ${invoice.bookingId}</p>
                                    <p class="mb-0">
                                        <strong>Ngày tạo:</strong> 
                                        ${invoice.invoiceDate.toString().substring(0, 10)} ${invoice.invoiceDate.toString().substring(11, 16)}
                                    </p>
                                </div>

                                <div class="info-card flex-fill ms-3">
                                    <h6 class="text-muted mb-2">THANH TOÁN</h6>
                                    <p class="mb-1"><strong>Phương thức:</strong> ${invoice.paymentMethod}</p>
                                    <p class="mb-1">
                                        <strong>Trạng thái:</strong> 
                                        <span class="status-badge
                                              ${invoice.paymentStatus == 'Paid' ? 'bg-success text-white' : 
                                                invoice.paymentStatus == 'Pending' ? 'bg-warning text-dark' : 'bg-danger text-white'}">
                                                  ${invoice.paymentStatus}
                                              </span>
                                        </p>
                                        <p class="mb-0 amount-highlight">
                                            ${invoice.totalAmount} ₫
                                        </p>
                                    </div>
                                </div>

                                <!-- Invoice Details -->
                                <div class="row">
                                    <div class="col-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Mô tả</th>
                                                        <th class="text-end">Số tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Dịch vụ khám chữa bệnh thú cưng</td>
                                                        <td class="text-end">
                                                            ${invoice.totalAmount} ₫
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot class="table-light">
                                                    <tr>
                                                        <th>TỔNG CỘNG</th>
                                                        <th class="text-end amount-highlight">
                                                            ${invoice.totalAmount} ₫
                                                        </th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <!-- Footer Note -->
                                <div class="mt-4 p-3 bg-light rounded">
                                    <p class="mb-0 text-muted small">
                                        <i class="fas fa-info-circle"></i>
                                        Cảm ơn bạn đã sử dụng dịch vụ của Pet Hospital. 
                                        Mọi thắc mắc xin vui lòng liên hệ với chúng tôi.
                                    </p>
                                </div>

                            </c:when>
                            <c:otherwise>
                                <!-- No invoice -->
                                <div class="no-invoice">
                                    <i class="fas fa-file-invoice"></i>
                                    <h4>Không có hóa đơn</h4>
                                    <p class="lead">${message}</p>
                                    <p class="text-muted">Booking ID: ${bookingId}</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- Action Buttons -->
                        <c:if test="${sessionScope.user.roleId == 1}">
                            <div class="text-center mt-4">
                                <button onclick="window.print()" class="btn btn-primary me-2">
                                    <i class="fas fa-print"></i> In hóa đơn
                                </button>
                            </div>
                        </c:if>
                        <c:choose>
                            <c:when test="${sessionScope.user.roleId == 1}">
                                <a href="dashboard" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </c:when> 
                            <c:otherwise>
                                <a href="ViewBooking" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </div>

        <!-- Print Styles -->
        <style media="print">
            body {
                background: white !important;
            }
            .container {
                padding: 0 !important;
            }
            .invoice-container {
                box-shadow: none !important;
                margin: 0 !important;
            }
            .btn {
                display: none !important;
            }
            .no-invoice {
                page-break-inside: avoid;
            }
        </style>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
