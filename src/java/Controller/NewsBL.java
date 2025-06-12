/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.NewsDAO;
import Entity.News;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Vector;

/**
 *
 * @author LENOVO
 */
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "NewsBL", urlPatterns = {"/News"})
public class NewsBL extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        NewsDAO nDAO = new NewsDAO();

        String service = request.getParameter("service");
        if (service == null || service.equals("listNews") || service.equals("nlist")) {
            String submit = request.getParameter("submit");
            String order = request.getParameter("order"); 
            if (order == null || (!order.equalsIgnoreCase("asc") && !order.equalsIgnoreCase("desc"))) {
                order = "desc"; // mặc định giảm dần
            }
            Vector<News> nlist;
            Vector<News> lastNews = nDAO.getLatestNews();

            if (submit != null) {
                String name = request.getParameter("name");
                name = name.trim().replaceAll("\\s+", "%");
                nlist = nDAO.searchNews("Select*from News\n"
                        + "Where nameNews like N'%" + name + "%'");
                request.setAttribute("nameNews", name);
            } else {
                String sql = "SELECT * FROM News ORDER BY post_time " + order;
                nlist = nDAO.getAllNews(sql);
            }

            request.setAttribute("nlist", nlist);
            request.setAttribute("top5News", lastNews);
            request.setAttribute("order", order);
            request.getRequestDispatcher("Presentation/NewsManagerment.jsp").forward(request, response);
        }

        if ("addNews".equals(service)) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                response.sendRedirect("News.jsp");
            } else {
                String newsId = nDAO.generateNextNewsId(); // tự sinh ID
                String nameNews = request.getParameter("nameNews");
                String description = request.getParameter("description");
                Boolean isActive = Boolean.valueOf(request.getParameter("isActive"));

                Timestamp timestampNow = new Timestamp(System.currentTimeMillis());

                Part filePart = request.getPart("imageFile");
                String imageUrl = "";

                if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("/") + "img/news";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    filePart.write(uploadPath + File.separator + fileName);
                    imageUrl = "img/news/" + fileName;
                } else {
                    imageUrl = "img/news/default.jpg";
                }

                News n = new News(newsId, imageUrl, nameNews, timestampNow, description, isActive);
                nDAO.insertNews(n);

                request.getSession().setAttribute("message", "Added successful!");
                response.sendRedirect("News?service=listNews");
            }
        }

        if (service.equals("deleteNews")) {
            String nID = request.getParameter("nID");
            int n = nDAO.deleteNews(nID);
            request.getSession().setAttribute("message", "Deleted successful!");
            response.sendRedirect("News?service=listNews");

        }

        if ("updateNews".equals(service)) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                response.sendRedirect("News.jsp");
            } else {
                String newsId = request.getParameter("newsId");
                String nameNews = request.getParameter("nameNews");
                Timestamp postTime = new Timestamp(System.currentTimeMillis());
                String description = request.getParameter("description");
                Boolean isActive = "1".equals(request.getParameter("isActive"));

                Part filePart = request.getPart("imageFile");
                String imageUrl;

                if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {

                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("/") + "img/news";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    filePart.write(uploadPath + File.separator + fileName);
                    imageUrl = "img/news/" + fileName;
                } else {

                    imageUrl = request.getParameter("oldImage");
                }

                News n = new News(newsId, imageUrl, nameNews, postTime, description, isActive);
                nDAO.updateNews(n);
                request.getSession().setAttribute("message", "Update successful!");
                response.sendRedirect("News?service=listNews");
            }
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
        processRequest(request, response);
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
