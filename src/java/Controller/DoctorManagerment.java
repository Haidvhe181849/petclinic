/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Utility.DBContext;
import DAO.DoctorDAO;
import DAO.EmployeeDAO;
import Entity.Employee;
import java.sql.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;

/**
 *
 * @author LENOVO
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "DoctorManagerment", urlPatterns = {"/DoctorManagerment"})
public class DoctorManagerment extends HttpServlet {

    private DoctorDAO getDoctorDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new DoctorDAO(conn);
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("imageFile");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // ✅ Đường dẫn tuyệt đối để lưu ảnh vào ổ đĩa ngoài project
        String saveDirectory = "C:/PetClinicUploads/Doctor";

        File dir = new File(saveDirectory);
        if (!dir.exists()) {
            dir.mkdirs(); // tạo thư mục nếu chưa có
        }

        // ✅ Ghi file vào thư mục ngoài
        filePart.write(saveDirectory + File.separator + fileName);

        // ✅ Trả về đường dẫn để lưu vào DB (tương đối, dùng cho web hiển thị)
        return "uploads/Doctor/" + fileName;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DoctorDAO doctorDAO = getDoctorDAO();
        String service = request.getParameter("service");

        // Hiển thị danh sách nhân viên với filter
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String roleIdRaw = request.getParameter("roleId");
        String statusRaw = request.getParameter("status");
        String sortColumn = request.getParameter("sortColumn");
        String sortType = request.getParameter("sortType");

        Integer roleId = null;
        Boolean status = null;

        try {
            if (roleIdRaw != null && !roleIdRaw.isEmpty()) {
                roleId = Integer.parseInt(roleIdRaw);
            }
            if (statusRaw != null && !statusRaw.isEmpty()) {
                status = Boolean.parseBoolean(statusRaw);
            }
        } catch (Exception e) {
            e.printStackTrace(); // optional
        }

        List<Employee> dlist = doctorDAO.filterDoctors(name, phone, sortColumn, sortType, status);

        // Gửi dữ liệu về JSP
        request.setAttribute("dlist", dlist);
        request.setAttribute("name", name);
        request.setAttribute("phone", phone);
        request.setAttribute("roleId", roleIdRaw);
        request.setAttribute("status", statusRaw);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortType", sortType);
        request.setAttribute("currentPage", "doctor");

        request.getRequestDispatcher("Presentation/ManageDoctor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DoctorDAO doctorDAO = getDoctorDAO();
        String service = request.getParameter("service");

        if (service == null) {
            response.sendRedirect("DoctorManagerment");
            return;
        }

        if (service.equals("addDoctor")) {
            try {
                String employeeId = doctorDAO.generateNextDoctorId();
                String name = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String email = request.getParameter("email").trim();
                String password = request.getParameter("password").trim();
                String address = request.getParameter("address").trim();
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String experience = request.getParameter("experience");
                String workingHours = request.getParameter("workingHours");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                // Upload ảnh
                String imagePath = uploadImage(request);

                // === VALIDATION ===
                if (name == null || name.trim().isEmpty() || name.trim().length() < 2 || name.trim().length() > 100) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Tên không hợp lệ: từ 2-100 ký tự và không toàn khoảng trắng.\"}");
                    return;
                }

                if (phone == null || !phone.matches("^0[0-9]{9}$")) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và đủ 10 chữ số).\"}");
                    return;
                }

                if (doctorDAO.isPhoneExists(phone, employeeId)) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Số điện thoại đã tồn tại trong hệ thống.\"}");
                    return;
                }

                if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Email không đúng định dạng.\"}");
                    return;
                }

                if (doctorDAO.isEmailExists(email, employeeId)) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Email đã tồn tại trong hệ thống.\"}");
                    return;
                }

                if (password == null || password.length() < 6 || password.length() > 50) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Mật khẩu phải từ 6 đến 50 ký tự.\"}");
                    return;
                }

                if (address == null || address.trim().isEmpty() || address.trim().length() > 255) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Địa chỉ không hợp lệ (không được để trống và tối đa 255 ký tự).\"}");
                    return;
                }

                if (experience == null || experience.trim().isEmpty() || experience.trim().length() > 255) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Mô tả kinh nghiệm không hợp lệ (không được để trống và tối đa 255 ký tự).\"}");
                    return;
                }

                if (workingHours == null || !workingHours.matches("^[0-2]?[0-9]:[0-5][0-9]-[0-2]?[0-9]:[0-5][0-9]$")) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Giờ làm việc phải theo định dạng HH:mm-HH:mm (VD: 08:00-17:00).\"}");
                    return;
                }

                Employee emp = new Employee(employeeId, name, imagePath, phone, email, password,
                        address, roleId, experience, workingHours, status);
                doctorDAO.insertDoctor(emp);

                // ✅ Trả về JSON thành công
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                PrintWriter out = response.getWriter();
                out.print("{\"status\":\"success\",\"message\":\"✅ Thêm bác sĩ thành công!\"}");
                out.flush();

            } catch (Exception e) {
                e.printStackTrace();

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Lỗi hệ thống khi thêm nhân viên.\"}");
            }
            return;
        } else if (service.equals("update")) {
            try {
                String employeeId = request.getParameter("employeeId").trim();
                String name = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String email = request.getParameter("email").trim();
                String password = request.getParameter("password").trim();
                String address = request.getParameter("address").trim();
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String experience = request.getParameter("experience");
                String workingHours = request.getParameter("workingHours");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                String imagePath = uploadImage(request);
                if (imagePath == null || imagePath.isEmpty()) {
                    imagePath = request.getParameter("old_image");
                }

                response.setContentType("application/json");

                // ===== VALIDATION =====
                if (name.length() < 2 || name.length() > 100) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Tên không hợp lệ: từ 2-100 ký tự.\"}");
                    return;
                }

                if (!phone.matches("^0[0-9]{9}$")) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Số điện thoại không hợp lệ.\"}");
                    return;
                }

                if (doctorDAO.isPhoneExists(phone, employeeId)) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Số điện thoại đã tồn tại.\"}");
                    return;
                }

                if (!email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Email không hợp lệ.\"}");
                    return;
                }

                if (doctorDAO.isEmailExists(email, employeeId)) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Email đã tồn tại.\"}");
                    return;
                }

                if (password.length() < 6 || password.length() > 50) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Mật khẩu từ 6-50 ký tự.\"}");
                    return;
                }

                if (address.isEmpty() || address.length() > 255) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Địa chỉ không hợp lệ.\"}");
                    return;
                }

                if (experience.isEmpty() || experience.length() > 255) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Kinh nghiệm không hợp lệ.\"}");
                    return;
                }

                if (!workingHours.matches("^[0-2]?[0-9]:[0-5][0-9]-[0-2]?[0-9]:[0-5][0-9]$")) {
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Giờ làm phải đúng định dạng HH:mm-HH:mm.\"}");
                    return;
                }

                Employee emp = new Employee(employeeId, name, imagePath, phone, email, password,
                        address, roleId, experience, workingHours, status);

                doctorDAO.updateDoctor(emp);

                request.getSession().setAttribute("message", "✅ Cập nhật bác sĩ thành công!");
                response.sendRedirect("DoctorManagerment");

            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"❌ Lỗi hệ thống.\"}");
            }
        }

        response.sendRedirect("DoctorManagerment");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
