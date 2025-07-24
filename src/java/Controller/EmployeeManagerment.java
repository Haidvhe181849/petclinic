package Controller;

import DAO.EmployeeDAO;
import Entity.Employee;
import Utility.DBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.List;

@WebServlet(name = "EmployeeManagerment", urlPatterns = {"/Employee"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EmployeeManagerment extends HttpServlet {

    private EmployeeDAO getEmployeeDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new EmployeeDAO(conn);
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

        EmployeeDAO dao = getEmployeeDAO();
        String service = request.getParameter("service");

        if ("delete".equals(service)) {
            String id = request.getParameter("employeeId");
            if (id != null && !id.isEmpty()) {
                dao.deleteEmployee(id);
                request.getSession().setAttribute("message", "Deleted successfully!");
            } else {
                request.getSession().setAttribute("message", "Employee ID not found!");
            }
            response.sendRedirect("Employee?service=listEmployee");
            return;
        }

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

        List<Employee> elist = dao.filterEmployees(name, phone, roleId, sortColumn, sortType, status);

        // Gửi dữ liệu về JSP
        request.setAttribute("elist", elist);
        request.setAttribute("name", name);
        request.setAttribute("phone", phone);
        request.setAttribute("roleId", roleIdRaw);
        request.setAttribute("status", statusRaw);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortType", sortType);
        request.setAttribute("currentPage", "employee");

        request.getRequestDispatcher("Presentation/EmployeeManagerment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO dao = getEmployeeDAO();
        String service = request.getParameter("service");

        if (service == null) {
            response.sendRedirect("Employee");
            return;
        }

        if (service.equals("addEmployee")) {
            try {
                String employeeId = dao.generateNextEmployeeId();
                String name = request.getParameter("name").trim();
                String phone = request.getParameter("phone").trim();
                String email = request.getParameter("email").trim();
                String password = request.getParameter("password").trim();
                String address = request.getParameter("address").trim();
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String experience = request.getParameter("experience");
                String workingHours = request.getParameter("workingHours");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));

                if (dao.isEmailExists(email, employeeId == null ? "" : employeeId)) {
                    request.getSession().setAttribute("message", "❌ Email đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("Employee");
                    return;
                }

                if (dao.isPhoneExists(phone, employeeId == null ? "" : employeeId)) {
                    request.getSession().setAttribute("message", "❌ Số điện thoại đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("Employee");
                    return;
                }
                // Upload ảnh
                String imagePath = uploadImage(request);

                Employee emp = new Employee(employeeId, name, imagePath, phone, email, password,
                        address, roleId, experience, workingHours, status);

                dao.addEmployee(emp);
                request.getSession().setAttribute("message", "Employee added successfully!");

            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("message", "Error adding employee!");
            }

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

                if (dao.isEmailExists(email, employeeId)) {
                    request.getSession().setAttribute("message", "❌ Email đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("Employee");
                    return;
                }

                if (dao.isPhoneExists(phone, employeeId)) {
                    request.getSession().setAttribute("message", "❌ Số điện thoại đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("Employee");
                    return;
                }
                String imagePath = uploadImage(request);
                if (imagePath == null || imagePath.isEmpty()) {
                    imagePath = request.getParameter("old_image");
                }

                Employee emp = new Employee(employeeId, name, imagePath, phone, email, password,
                        address, roleId, experience, workingHours, status);

                dao.updateEmployee(emp);
                request.getSession().setAttribute("message", "Employee updated successfully!");

            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("message", "Error updating employee!");
            }
        }

        response.sendRedirect("Employee");
    }

    @Override
    public String getServletInfo() {
        return "Employee management servlet";
    }
}
