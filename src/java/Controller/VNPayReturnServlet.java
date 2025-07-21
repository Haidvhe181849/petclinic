package Controller;

import DAO.BookingDAO;
import DAO.InvoiceDAO;
import Entity.Invoice;
import Entity.UserAccount;
import Utility.DBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/vnpay_return")
public class VNPayReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Lấy thông tin booking đã tạo từ session
        String bookingId = (String) session.getAttribute("pendingBookingId");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
        String vnp_Amount = request.getParameter("vnp_Amount");
        
        // Kiểm tra mã giao dịch có khớp với mã đã lưu trong session không
        String sessionTxnRef = (String) session.getAttribute("vnp_TxnRef");
        
        if (bookingId == null || sessionTxnRef == null || !vnp_TxnRef.startsWith(bookingId)) {
            response.sendRedirect("BookingForm?error=Không tìm thấy thông tin đặt lịch");
            return;
        }
        
        // Xác thực chữ ký từ VNPay
        Map<String, String> fields = new HashMap<>();
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldName.startsWith("vnp_") && !fieldName.equals("vnp_SecureHash")) {
                fields.put(fieldName, fieldValue);
            }
        }
        System.out.println(vnp_TransactionStatus);
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        String signValue = VNPayConfig.hashAllFields(fields);
        System.out.println(signValue);
        System.out.println(vnp_SecureHash);
        // Kiểm tra chữ ký và trạng thái thanh toán
        if
            ("00".equals(vnp_ResponseCode)) {
            
            // Thanh toán thành công
            try (Connection conn = new DBContext().connection) {
                BookingDAO bookingDAO = new BookingDAO(conn);
                InvoiceDAO invoiceDAO = new InvoiceDAO(conn);
                UserAccount user = (UserAccount) session.getAttribute("user");
                
                // Tạo hóa đơn
                double amount = Long.parseLong(vnp_Amount) / 100.0;
                BigDecimal amountDecimal = BigDecimal.valueOf(amount);
                Invoice invoice = new Invoice(bookingId, amountDecimal, "Thanh toán qua VNPay", "Success");
                
                int invoiceId = invoiceDAO.insertInvoice(invoice);
                
                if (invoiceId > 0) {
                    // Cập nhật trạng thái booking
                    bookingDAO.insertBookingDetail(bookingId, user);
                    
                    // Xóa thông tin booking tạm khỏi session
                    session.removeAttribute("pendingBookingId");
                    session.removeAttribute("vnp_TxnRef");
                    
                    // Chuyển hướng đến trang thành công
                    response.sendRedirect("BookingForm?success=true");
                } else {
                    response.sendRedirect("BookingForm?error=Lỗi khi lưu hóa đơn");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("BookingForm?error=Lỗi xử lý thanh toán: " + e.getMessage());
            }
        } else {
            // Thanh toán thất bại
            try (Connection conn = new DBContext().connection) {
                BookingDAO bookingDAO = new BookingDAO(conn);
                
                // Xóa booking tạm
                bookingDAO.deleteBooking(bookingId);
                
                // Xóa thông tin booking tạm khỏi session
                session.removeAttribute("pendingBookingId");
                session.removeAttribute("vnp_TxnRef");
                
                response.sendRedirect("BookingForm?error=Payment Fail");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("BookingForm?error=Lỗi xử lý thanh toán: " + e.getMessage());
            }
        }
    }
} 