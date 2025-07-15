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
        String saveDir = "/Presentation/img/images/Doctor";

        String realPath = request.getServletContext().getRealPath(saveDir);
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Lưu ảnh
        filePart.write(realPath + File.separator + fileName);

        return saveDir.substring(1) + "/" + fileName;  // Bỏ dấu "/" đầu
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

                if (doctorDAO.isEmailExists(email, employeeId == null ? "" : employeeId)) {
                    request.getSession().setAttribute("message", "❌ Email đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("DoctorManagerment?service=listDoctor");
                    return;
                }

                if (doctorDAO.isPhoneExists(phone, employeeId == null ? "" : employeeId)) {
                    request.getSession().setAttribute("message", "❌ Số điện thoại đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("DoctorManagerment?service=listDoctor");
                    return;
                }
                // Upload ảnh
                String imagePath = uploadImage(request);

                Employee emp = new Employee(employeeId, name, imagePath, phone, email, password,
                        address, roleId, experience, workingHours, status);

                doctorDAO.insertDoctor(emp);
                request.getSession().setAttribute("message", "Doctor added successfully!");

            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("message", "Error adding Doctor!");
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

                if (doctorDAO.isEmailExists(email, employeeId)) {
                    request.getSession().setAttribute("message", "❌ Email đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("DoctorManagerment?service=listDoctor");
                    return;
                }

                if (doctorDAO.isPhoneExists(phone, employeeId)) {
                    request.getSession().setAttribute("message", "❌ Số điện thoại đã được sử dụng bởi nhân viên khác.");
                    response.sendRedirect("DoctorManagerment?service=listDoctor");
                    return;
                }
                String imagePath = uploadImage(request);
                if (imagePath == null || imagePath.isEmpty()) {
                    imagePath = request.getParameter("old_image");
                }

                Employee emp = new Employee(employeeId, name, imagePath, phone, email, password,
                        address, roleId, experience, workingHours, status);

                doctorDAO.updateDoctor(emp);
                request.getSession().setAttribute("message", "Doctor updated successfully!");

            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("message", "Error updating Doctor!");
            }
        }

        response.sendRedirect("DoctorManagerment?service=listDoctor");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
