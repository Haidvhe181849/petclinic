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
                int page = 1;
                int pageSize = 10;
                List<Medicine> mlist = medicineDAO.getAllMedicines();
                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    try {
                        page = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                }

                int totalMedicines = medicineDAO.countAllMedicines();
                int totalPages = (int) Math.ceil((double) totalMedicines / pageSize);

                List<Medicine> list = medicineDAO.getMedicinesByPage(page, pageSize);
                request.setAttribute("mlist", mlist);
                request.setAttribute("medicineList", list);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);

                // Lấy message từ session và xóa nó đi
                String message = (String) request.getSession().getAttribute("message");
                if (message != null) {
                    request.setAttribute("message", message);
                    request.getSession().removeAttribute("message");
                }

                request.getRequestDispatcher("/Presentation/MedicineManagerment.jsp").forward(request, response);
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
                    request.getRequestDispatcher("/Presentation/MedicineManagerment.jsp").forward(request, response);
                } else {
                    String medicineId = medicineDAO.generateNextMedicineId();
                    String medicineName = request.getParameter("medicineName").trim();
                    String supplier = request.getParameter("supplier");
                    String type = request.getParameter("type");
                    String dosage = request.getParameter("dosage");

                    if (medicineDAO.isMedicineNameExists(medicineName)) {
                        request.getSession().setAttribute("message", "Error! Madicine Name Exist.");
                        List<Medicine> list = medicineDAO.getAllMedicines();
                        request.setAttribute("medicineList", list);
                        response.sendRedirect("Medicine?service=getAllMedicines");
                        return;
                    }

                    Part filePart = request.getPart("imageFile");
                    String image = "";

                    if (filePart != null && filePart.getSize() > 0) {
                        String ext = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));

                        String nameSlug = medicineName.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
                        if (nameSlug.length() > 10) {
                            nameSlug = nameSlug.substring(0, 10);
                        }
                        String fileName = "med_" + nameSlug + "_" + medicineId + ext;

                        String folder = "/Presentation/img/medicine";
                        String uploadPath = getServletContext().getRealPath(folder);
                        new File(uploadPath).mkdirs();

                        filePart.write(uploadPath + File.separator + fileName);
                        image = folder + "/" + fileName;
                    }

                    Medicine m = new Medicine(medicineId, medicineName, image, supplier, type, dosage);
                    medicineDAO.addMedicine(m);

                    request.getSession().setAttribute("message", "Add medicine successful!");
                    List<Medicine> list = medicineDAO.getAllMedicines();
                    request.setAttribute("medicineList", list);
                    int totalMedicines = medicineDAO.countAllMedicines();
                    int lastPage = (int) Math.ceil((double) totalMedicines / 10.0);

                    response.sendRedirect("Medicine?service=getAllMedicines&page=" + lastPage);
                    return;
                }

            } else if ("updateMedicine".equals(service)) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    response.sendRedirect("Presentation/MedicineManagerment.jsp");
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
                    int page = 1;
                    try {
                        page = Integer.parseInt(request.getParameter("page"));
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                    response.sendRedirect("Medicine?service=getAllMedicines&page=" + page);
                    return;
                }
            } else if ("deleteMedicine".equals(service)) {
                int page = 1;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
                String medicineId = request.getParameter("medicineId");
                medicineDAO.deleteMedicine(medicineId);
                request.getSession().setAttribute("message", "Delete medicine successful!");
                List<Medicine> list = medicineDAO.getAllMedicines();
                request.setAttribute("medicineList", list);
                int totalMedicines = medicineDAO.countAllMedicines();
                int totalPages = (int) Math.ceil((double) totalMedicines / 10.0);
                if (page > totalPages && totalPages > 0) {
                    page = totalPages;
                }
                response.sendRedirect("Medicine?service=getAllMedicines&page=" + page);
                return;

            } else if ("manageQuery".equals(service)) {
                String keyword = request.getParameter("keyword");
                String type = request.getParameter("medicineType");
                String sortBy = request.getParameter("sortBy");

                int page = 1;
                int pageSize = 10;

                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    try {
                        page = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                }

                int totalFiltered = medicineDAO.countFilteredMedicines(keyword, type);
                int totalPages = (int) Math.ceil((double) totalFiltered / pageSize);
                int offset = (page - 1) * pageSize;

                List<Medicine> list = medicineDAO.getFilteredMedicinesPaged(keyword, type, sortBy, offset, pageSize);

                request.setAttribute("medicineList", list);
                request.setAttribute("searchKeyword", keyword);
                request.setAttribute("selectedType", type);
                request.setAttribute("selectedSort", sortBy);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);

                request.getRequestDispatcher("Presentation/MedicineManagerment.jsp").forward(request, response);
                return;
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
