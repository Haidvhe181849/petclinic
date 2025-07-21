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

import java.io.IOException;
import java.sql.Connection;
import java.util.Vector;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "viewNewsBL", urlPatterns = {"/viewNews"})
public class viewNewsBL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DBContext db = new DBContext();
        Connection conn = db.connection;
        NewsDAO nDAO = new NewsDAO();
        ServiceDAO sDAO = new ServiceDAO(conn);


        String submit = request.getParameter("submit");
        String newsId = request.getParameter("id"); 
        Vector<News> nlist;
        Vector<News> lastNews = nDAO.getLatestNews();
        Vector<Service> slist = sDAO.getAllService("SELECT * FROM Service");

        // ✅ Nếu có newsId → vào trang chi tiết
        if (newsId != null && !newsId.trim().isEmpty()) {
            News newsDetail = nDAO.getNewsByID(newsId);
            if (newsDetail != null) {
                request.setAttribute("newsDetail", newsDetail);
                request.setAttribute("top5", lastNews);
                request.getRequestDispatcher("Presentation/NewsDetail.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect("error.jsp");
                return;
            }
        }

        // ✅ Nếu là tìm kiếm
        if (submit != null) {
            String name = request.getParameter("name");
            nlist = nDAO.searchNews("SELECT * FROM News WHERE nameNews LIKE N'%" + name + "%'");
            request.setAttribute("nameNews", name);
        } else {
            nlist = nDAO.getAllNews();
        }

        request.setAttribute("slist", slist);
        request.setAttribute("nlist", nlist);
        request.setAttribute("top5News", lastNews);
        request.getRequestDispatcher("Presentation/viewNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng mọi POST về GET
        response.sendRedirect("viewNews");
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý xem danh sách và chi tiết tin tức";
    }
}
