/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MedicineDAO;
import Entity.Medicine;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author quang
 */
@WebServlet(name = "ViewMedicineServlet", urlPatterns = {"/ViewMedicine"})
public class ViewMedicineServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewMedicineServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewMedicineServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        processRequest(request, response);
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
            if ("searchMedicine".equals(service)) {
                String keyword = request.getParameter("keyword");
                List<Medicine> list = medicineDAO.searchMedicineByNameOrSupplier(keyword);
                request.setAttribute("medicineList", list);
                request.setAttribute("searchKeyword", keyword);  // giữ lại từ khóa cho form

                request.getRequestDispatcher("Presentation/ViewMedicine.jsp").forward(request, response);
            } else if ("sortByName".equals(service)) {
                List<Medicine> list = medicineDAO.getAllMedicinesSortedByName();
                request.setAttribute("medicineList", list);
                request.getRequestDispatcher("Presentation/ViewMedicine.jsp").forward(request, response);
            } else if ("sortBySupplier".equals(service)) {
                List<Medicine> list = medicineDAO.getMedicinesByExactSupplierSorted();
                request.setAttribute("medicineList", list);
                request.getRequestDispatcher("Presentation/ViewMedicine.jsp").forward(request, response);
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
                request.getRequestDispatcher("Presentation/ViewMedicine.jsp").forward(request, response);
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
