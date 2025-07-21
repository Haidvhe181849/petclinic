package Controller;

import DAO.BookingDAO;
import DAO.ServiceDAO;
import Entity.Booking;
import Entity.Service;
import Utility.DBContext;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Connection;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Lấy thông tin booking đã tạo từ session
        String bookingId = (String) session.getAttribute("pendingBookingId");
        
        if (bookingId == null || bookingId.isEmpty()) {
            response.sendRedirect("BookingForm?error=Không tìm thấy thông tin đặt lịch");
            return;
        }
        
        try (Connection conn = new DBContext().connection) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            ServiceDAO serviceDAO = new ServiceDAO(conn);
            
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null) {
                response.sendRedirect("BookingForm?error=Không tìm thấy thông tin đặt lịch");
                return;
            }
            
            // Lấy thông tin dịch vụ để tính tiền
            Service service = serviceDAO.getServiceById(booking.getServiceId());
            if (service == null) {
                response.sendRedirect("BookingForm?error=Không tìm thấy thông tin dịch vụ");
                return;
            }
            
            // Tạo thông tin thanh toán VNPay
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String vnp_OrderInfo = "Thanh toan dich vu " + service.getServiceName() + " - Ma dat lich: " + bookingId;
            String orderType = "billpayment";
            
            // Số tiền thanh toán (VNPay yêu cầu đơn vị là VND và không có dấu phẩy)
            long amount = (long) (service.getPrice() * 100);
            
            // Tạo mã giao dịch
            String vnp_TxnRef = bookingId + "-" + VNPayConfig.getRandomNumber(4);
            
            // Lưu mã giao dịch vào session để kiểm tra khi VNPay callback
            session.setAttribute("vnp_TxnRef", vnp_TxnRef);
            
            // Tạo URL thanh toán
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");
            
            // Ngôn ngữ hiển thị trên cổng thanh toán
            vnp_Params.put("vnp_Locale", "vn");
            
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", orderType);
            
            // Lấy địa chỉ IP của khách hàng
            String vnp_IpAddr = VNPayConfig.getIpAddress(request);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
            
            // Tạo URL return khi thanh toán xong
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            
            // Thời gian tạo giao dịch
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            
            // Thời gian hết hạn giao dịch
            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
            
            // Tạo URL với các tham số đã được sắp xếp
            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);
            
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            
            Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    // Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    
                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            
            String queryUrl = query.toString();
            String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            
            String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;
            
            // Chuyển hướng đến trang thanh toán VNPay
            response.sendRedirect(paymentUrl);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("BookingForm?error=Lỗi khi tạo thanh toán: " + e.getMessage());
        }
    }
} 