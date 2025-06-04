/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MedicineDAO;
import Entity.Medicine;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;

/**
 *
 * @author quang
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "MedicineServlet", urlPatterns = {"/Medicine"})
public class MedicineServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            String service = request.getParameter("service");
            MedicineDAO medicineDAO = new MedicineDAO();
            if (service == null || "getAllMedicines".equals(service)) {
                List<Medicine> list = medicineDAO.getAllMedicines();
                request.setAttribute("medicineList", list);

                // Lấy message từ session và xóa nó đi
                String message = (String) request.getSession().getAttribute("message");
                if (message != null) {
                    request.setAttribute("message", message);
                    request.getSession().removeAttribute("message");
                }

                request.getRequestDispatcher("/Presentation/Medicine.jsp").forward(request, response);
                return;

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String service = request.getParameter("service");

        try {
            MedicineDAO medicineDAO = new MedicineDAO();
            if ("addMedicine".equals(service)) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    request.getRequestDispatcher("/Presentation/Medicine.jsp").forward(request, response);
                } else {
                    String medicineId = medicineDAO.generateNextMedicineId();
                    String medicineName = request.getParameter("medicineName");
                    String supplier = request.getParameter("supplier");
                    String type = request.getParameter("type");
                    String dosage = request.getParameter("dosage");

                    Part filePart = request.getPart("imageFile");
                    String image = "";

                    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String uploadPath = getServletContext().getRealPath("/Presentation/img/medicine");
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        filePart.write(uploadPath + File.separator + fileName);
                        image = "Presentation/img/medicine/" + fileName;
                    }

                    Medicine m = new Medicine(medicineId, medicineName, image, supplier, type, dosage);
                    medicineDAO.addMedicine(m);

                    request.getSession().setAttribute("message", "Add medicine successful!");
                    List<Medicine> list = medicineDAO.getAllMedicines();
                    request.setAttribute("medicineList", list);
                    String contextPath = request.getContextPath();
                    response.sendRedirect(contextPath + "/Medicine?service=getAllMedicines");
                    return;
                }

            } else if ("updateMedicine".equals(service)) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    response.sendRedirect("Presentation/Medicine.jsp");
                } else {
                    String medicineId = request.getParameter("medicineId");
                    String medicineName = request.getParameter("medicineName");
                    String supplier = request.getParameter("supplier");
                    String type = request.getParameter("type");
                    String dosage = request.getParameter("dosage");

                    String image;
                    Part filePart = request.getPart("imageFile");
                    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String uploadPath = getServletContext().getRealPath("/Presentation/img/medicine");
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        filePart.write(uploadPath + File.separator + fileName);
                        image = "Presentation/img/medicine/" + fileName;
                    } else {
                        image = request.getParameter("oldImage");
                    }

                    Medicine m = new Medicine(medicineId, medicineName, image, supplier, type, dosage);
                    medicineDAO.updateMedicine(m);

                    request.getSession().setAttribute("message", "Update successful!");
                    List<Medicine> list = medicineDAO.getAllMedicines();
                    request.setAttribute("medicineList", list);
                    String contextPath = request.getContextPath();
                    response.sendRedirect(contextPath + "/Medicine?service=getAllMedicines");
                    return;
                }
            } else if ("deleteMedicine".equals(service)) {
                String medicineId = request.getParameter("medicineId");
                medicineDAO.deleteMedicine(medicineId);

                request.getSession().setAttribute("message", "Delete medicine successful!");
                List<Medicine> list = medicineDAO.getAllMedicines();
                request.setAttribute("medicineList", list);
                String contextPath = request.getContextPath();
                    response.sendRedirect(contextPath + "/Medicine?service=getAllMedicines");
                    return;

            } else if ("searchMedicine".equals(service)) {
                String keyword = request.getParameter("keyword");
                List<Medicine> list = medicineDAO.searchMedicineByNameOrSupplier(keyword);
                request.setAttribute("medicineList", list);
                request.setAttribute("searchKeyword", keyword);  // giữ lại từ khóa cho form

                request.getRequestDispatcher("Presentation/Medicine.jsp").forward(request, response);
            } else if ("sortByName".equals(service)) {
                List<Medicine> list = medicineDAO.getAllMedicinesSortedByName();
                request.setAttribute("medicineList", list);
                request.getRequestDispatcher("Presentation/Medicine.jsp").forward(request, response);
            } else if ("sortBySupplier".equals(service)) {
                List<Medicine> list = medicineDAO.getMedicinesByExactSupplierSorted();
                request.setAttribute("medicineList", list);
                request.getRequestDispatcher("Presentation/Medicine.jsp").forward(request, response);
            } else if ("filterByType".equals(service)) {
                String type = request.getParameter("medicineType");

                List<Medicine> list;
                if (type == null || type.isEmpty()) {
                    list = medicineDAO.getAllMedicines(); // Không lọc gì
                } else {
                    list = medicineDAO.getMedicinesByType(type);
                }

                request.setAttribute("medicineList", list);
                request.setAttribute("selectedType", type); // để giữ lại filter đã chọn
                request.getRequestDispatcher("Presentation/Medicine.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
