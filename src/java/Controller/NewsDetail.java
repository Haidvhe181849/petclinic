/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.NewsDAO;
import DAO.ServiceDAO;
import Entity.News;
import Entity.Service;
import Utility.DBContext;

import java.sql.Connection;
import java.util.Vector;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "NewsDetail", urlPatterns = {"/newsdetail"})
public class NewsDetail extends HttpServlet {

    DBContext db = new DBContext();
    Connection conn = db.connection;
    NewsDAO nDAO = new NewsDAO();
    ServiceDAO sDAO = new ServiceDAO(conn);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        Vector<Service> slist = sDAO.getAllService("SELECT * FROM Service");
        try {
            String newsId = request.getParameter("id");

            if (newsId != null && !newsId.trim().isEmpty()) {
                News newsDetail = nDAO.getNewsByID(newsId);
                if (newsDetail == null) {
                    response.sendRedirect("error.jsp");
                    return;
                }
                request.setAttribute("slist", slist);
                request.setAttribute("newsDetail", newsDetail);
                request.setAttribute("top5", nDAO.getLatestNews());
                request.getRequestDispatcher("Presentation/NewsDetail.jsp").forward(request, response);
                return;
            }

            // ❌ Không có id → quay lại trang danh sách
            response.sendRedirect("viewNews");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
