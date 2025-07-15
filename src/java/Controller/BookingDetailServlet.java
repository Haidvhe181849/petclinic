package Controller;

import DAO.BookingDAO;
import Entity.BookingDetail;
import Utility.DBContext;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "BookingDetailServlet", urlPatterns = {"/BookingDetail"})
public class BookingDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingId = request.getParameter("id");

        if (bookingId == null || bookingId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Missing bookingId\"}");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO(new DBContext().connection);
        BookingDetail detail = bookingDAO.getBookingDetailById(bookingId);

        if (detail == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Booking not found\"}");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        new Gson().toJson(detail, response.getWriter());
    }

    @Override
    public String getServletInfo() {
        return "Returns booking detail by bookingId as JSON";
    }
}
