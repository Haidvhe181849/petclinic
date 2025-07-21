package Controller;

import DAO.InvoiceDAO;
import Entity.Invoice;
import Utility.DBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;

/**
 *
 * @author User
 */
@WebServlet(name = "ViewInvoiceServlet", urlPatterns = {"/ViewInvoice"})
public class ViewInvoiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookingId = request.getParameter("bookingId");
        
        if (bookingId == null || bookingId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Booking ID không hợp lệ");
            request.getRequestDispatcher("Presentation/ViewInvoice.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = new DBContext().connection) {
            InvoiceDAO invoiceDAO = new InvoiceDAO(conn);
            Invoice invoice = invoiceDAO.getInvoiceByBookingId(bookingId);
            
            if (invoice != null) {
                request.setAttribute("invoice", invoice);
                request.setAttribute("hasInvoice", true);
            } else {
                request.setAttribute("hasInvoice", false);
                request.setAttribute("message", "Không có hóa đơn cho lịch khám này");
            }
            
            request.setAttribute("bookingId", bookingId);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải hóa đơn: " + e.getMessage());
        }
        
        request.getRequestDispatcher("Presentation/ViewInvoice.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet để xem hóa đơn theo booking ID";
    }
}
