package Controller;

import DAO.BookingDAO;
import DAO.EmployeeDAO;
import DAO.MedicalRecordDAO;
import DAO.MedicalRecordMedicineDAO;
import DAO.MedicineDAO;
import Entity.Booking;
import Entity.Employee;
import Entity.MedicalRecord;
import Entity.Medicine;
import Utility.DBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@WebServlet("/MedicalProcess")
@MultipartConfig
public class MedicalProcessServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private MedicineDAO medicineDAO;
    private MedicalRecordDAO medicalRecordDAO;

    private EmployeeDAO getEmployeeDAO() {
        return new EmployeeDAO(new DBContext().connection);
    }

    @Override
    public void init() throws ServletException {
        Connection conn = new DBContext().connection;
        bookingDAO = new BookingDAO(conn);
        medicineDAO = new MedicineDAO();
        medicalRecordDAO = new MedicalRecordDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy bookingId từ request
        String bookingId = request.getParameter("bookingId");

        // Kiểm tra xem bác sĩ đã đăng nhập chưa
        HttpSession session = request.getSession();
        Employee currentDoctor = (Employee) session.getAttribute("doctor");
        if (currentDoctor == null) {
            response.sendRedirect("login-employee");
            return;
        }

        // Kiểm tra bookingId hợp lệ
        if (bookingId == null || bookingId.trim().isEmpty()) {
            response.sendRedirect("ProfileDoctor?error=MissingBookingId");
            return;
        }

        // Lấy thông tin booking từ DB
        Booking booking = bookingDAO.getBookingById(bookingId);
        if (booking == null) {
            response.sendRedirect("ProfileDoctor?error=BookingNotFound");
            return;
        }

        // Lấy danh sách thuốc
        List<Medicine> medicineList = medicineDAO.getAllMediciness();

        // Đặt attribute cho JSP
        request.setAttribute("booking", booking);
        request.setAttribute("medicineList", medicineList);
        request.setAttribute("currentDoctor", currentDoctor);

        // Forward sang trang MedicalProcess.jsp
        request.getRequestDispatcher("/Presentation/MedicalProcess.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String bookingId = request.getParameter("bookingId");
        String employeeId = request.getParameter("employeeId");
        String petId = request.getParameter("petId");
        String symptoms = request.getParameter("symptoms");
        String diagnosis = request.getParameter("diagnosis");
        String testResults = request.getParameter("testResults");
        String[] medicineIds = request.getParameterValues("medicineId");

        try {

            String imagePath = null;
            Part filePart = request.getPart("testFile");
            if (filePart != null && filePart.getSize() > 0) {
                String ext = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));
                String filename = "test_" + System.currentTimeMillis() + ext;
                String folder = "/Presentation/img/test";
                String uploadPath = getServletContext().getRealPath(folder);
                new File(uploadPath).mkdirs();
                filePart.write(uploadPath + File.separator + filename);
                imagePath = folder + "/" + filename;
            }

            MedicalRecord record = new MedicalRecord();
            record.setBookingId(bookingId);
            record.setEmployeeId(employeeId);
            record.setPetId(petId);
            record.setSymptoms(symptoms);
            record.setDiagnosis(diagnosis);
            record.setTestResults(testResults);
            record.setImage(imagePath);
            record.setCreatedAt(LocalDateTime.now());

            int recordId = medicalRecordDAO.insertMedicalRecord(record);
            if (recordId == -1) {
                request.setAttribute("error", "Không thể lưu phiếu khám!");

                Booking booking = bookingDAO.getBookingById(bookingId);
                List<Medicine> medicineList = medicineDAO.getAllMediciness();
                HttpSession session = request.getSession();
                Employee currentDoctor = (Employee) session.getAttribute("doctor");

                request.setAttribute("booking", booking);
                request.setAttribute("medicineList", medicineList);
                request.setAttribute("currentDoctor", currentDoctor);
                request.getRequestDispatcher("/Presentation/MedicalProcess.jsp").forward(request, response);
                return;
            }

            bookingDAO.updateBookingDone(bookingId, "Completed");
            response.sendRedirect("ProfileDoctor?success=1");

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", "Lỗi xử lý phiếu khám (exception).");
            try {
                Booking booking = bookingDAO.getBookingById(bookingId);
                List<Medicine> medicineList = medicineDAO.getAllMediciness();
                HttpSession session = request.getSession();
                Employee currentDoctor = (Employee) session.getAttribute("doctor");

                request.setAttribute("booking", booking);
                request.setAttribute("medicineList", medicineList);
                request.setAttribute("currentDoctor", currentDoctor);
                request.getRequestDispatcher("/Presentation/MedicalProcess.jsp").forward(request, response);
            } catch (Exception innerEx) {
                innerEx.printStackTrace();
                response.sendRedirect("ProfileDoctor?error=MissingBookingId"); // fallback nếu tất cả lỗi
            }
        }
    }

}
