package Controller;

import DAO.BookingDAO;
import DAO.DoctorDAO;
import DAO.PetDAO;
import Entity.Employee;
import Entity.Pet;
import Entity.UserAccount;
import Utility.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet(name = "BookingTimeLoaderServlet", urlPatterns = {"/LoadBookingTimes"})
public class BookingTimeLoaderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        int userId = user.getUserId();
        String doctorId = request.getParameter("doctorSelect");
        String date = request.getParameter("appointmentDate");

        DBContext dbContext = new DBContext();
        Connection conn = null;

        try {
            conn = dbContext.connection;

            PetDAO petDAO = new PetDAO(conn);
            DoctorDAO doctorDAO = new DoctorDAO(conn);
            BookingDAO bookingDAO = new BookingDAO(conn);

            List<Pet> pets = petDAO.getPetsByOwnerId(userId);
            List<Employee> doctors = doctorDAO.getAllDoctors();
            List<String> bookedTimes = null;

            if (doctorId != null && date != null && !doctorId.isEmpty() && !date.isEmpty()) {
                bookedTimes = bookingDAO.getBookedTimesForDateAndDoctor(date, doctorId);
            }

            request.setAttribute("pets", pets);
            request.setAttribute("doctors", doctors);
            request.setAttribute("bookedTimes", bookedTimes);
            request.setAttribute("selectedDate", date);
            request.setAttribute("selectedDoctor", doctorId);
            

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải giờ đã đặt: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        request.getRequestDispatcher("Presentation/BookingSchedule.jsp").forward(request, response);
    }
}
