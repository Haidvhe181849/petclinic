/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ClinicWorkingDAO;
import Entity.ClinicWorking;
import Utility.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.sql.Connection;
import java.sql.SQLException;
import java.io.IOException;
import java.time.LocalTime;

/**
 *
 * @author quang
 */
@WebServlet("/ClinicWorking")
public class ClinicWorkingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = new DBContext().connection) {
            ClinicWorkingDAO dao = new ClinicWorkingDAO(conn);
            List<ClinicWorking> workingList = dao.getAll();

            request.setAttribute("workingList", workingList);
            request.setAttribute("currentPage", "time");
            
            request.getRequestDispatcher("/Presentation/ClinicWorking.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
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
        String updateDayStr = request.getParameter("updateDay");
        if (updateDayStr == null) {
            response.sendRedirect("clinicWorking.jsp?error=nodata");
            return;
        }

        int day = Integer.parseInt(updateDayStr);

        try (Connection conn = new DBContext().connection) {
            ClinicWorkingDAO dao = new ClinicWorkingDAO(conn);

            String startTimeStr = request.getParameter("day" + day + "_start");
            String endTimeStr = request.getParameter("day" + day + "_end");
            String activeStr = request.getParameter("day" + day + "_active");

            if (startTimeStr != null && endTimeStr != null) {
                ClinicWorking cw = new ClinicWorking();
                cw.setDayOfWeek(day);
                cw.setStartTime(LocalTime.parse(startTimeStr));
                cw.setEndTime(LocalTime.parse(endTimeStr));
                cw.setActive("on".equals(activeStr));

                if (dao.getByDayOfWeek(day) != null) {
                    dao.update(cw);
                } else {
                    dao.insert(cw);
                }
            }

            response.sendRedirect("ClinicWorking");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("clinicWorking.jsp?error=1");
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
