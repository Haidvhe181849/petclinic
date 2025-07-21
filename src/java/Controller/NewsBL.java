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
import java.time.LocalDate;
import java.util.Optional;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "NewsBL", urlPatterns = {"/News"})
public class NewsBL extends HttpServlet {

    private String saveFile(Part filePart, String folder, HttpServletRequest request) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        String uploadPath = request.getServletContext().getRealPath("/Presentation/img/" + folder);
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        filePart.write(uploadPath + File.separator + fileName);

        return "Presentation/img/" + folder + "/" + fileName;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        NewsDAO nDAO = new NewsDAO();
        String service = request.getParameter("service");
        if (service == null || service.equals("listNews") || service.equals("nlist")) {
            String order = Optional.ofNullable(request.getParameter("order")).orElse("desc");
            String status = request.getParameter("status");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String name = Optional.ofNullable(request.getParameter("name")).orElse("").trim();
            String pageParam = request.getParameter("page");

            

            Timestamp fromDate = null, toDate = null;
            try {
                if (fromDateStr != null && !fromDateStr.isEmpty()) {
                    fromDate = Timestamp.valueOf(LocalDate.parse(fromDateStr).atStartOfDay());
                }
                if (toDateStr != null && !toDateStr.isEmpty()) {
                    toDate = Timestamp.valueOf(LocalDate.parse(toDateStr).atTime(23, 59, 59));
                }
            } catch (Exception ignored) {
            }

            Vector<News> newsList = nDAO.filterNews(name, status, fromDate, toDate, order);
            
           
            Vector<News> top5 = nDAO.getLatestNews();

            // Set attributes
            request.setAttribute("nlist", newsList);
            request.setAttribute("top5News", top5);
            request.setAttribute("order", order);
            request.setAttribute("nameNews", name);
            request.setAttribute("status", status);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);
            request.setAttribute("currentPage", "news");
            request.getRequestDispatcher("Presentation/NewsManagerment.jsp").forward(request, response);
        } else if ("deleteNews".equals(service)) {
            String newsId = request.getParameter("nID");
            if (newsId != null) {
                int result = nDAO.deleteNews(newsId);
                if (result > 0) {
                    request.getSession().setAttribute("message", "Deleted successfully!");
                } else {
                    request.getSession().setAttribute("message", "Delete failed!");
                }
            }
            response.sendRedirect("News?service=listNews");
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
        NewsDAO nDAO = new NewsDAO();
        String service = request.getParameter("service");

        if ("addNews".equals(service)) {
            String newsId = nDAO.generateNextNewsId();
            String nameNews = request.getParameter("nameNews");
            Part imagePart = request.getPart("imageFile");
            String imagePath = saveFile(imagePart, "images/news", request);
            String description = request.getParameter("description");
            Boolean isActive = Boolean.valueOf(request.getParameter("isActive"));
            Timestamp timestampNow = new Timestamp(System.currentTimeMillis());
            News news = new News(newsId, imagePath, nameNews, timestampNow, description, isActive);
            nDAO.insertNews(news);

            request.getSession().setAttribute("message", "Added successful!");
            response.sendRedirect("News?service=listNews");
        } else if ("updateNews".equals(service)) {
            String newsId = request.getParameter("newsId");
            String nameNews = request.getParameter("nameNews");
            Timestamp postTime = new Timestamp(System.currentTimeMillis());
            String description = request.getParameter("description");
            Boolean isActive = "1".equals(request.getParameter("isActive"));
            String oldImage = request.getParameter("oldImage");
            Part imagePart = request.getPart("imageFile");
            String imagePath = imagePart.getSize() > 0 ? saveFile(imagePart, "images/news", request) : oldImage;

            News news = new News(newsId, imagePath, nameNews, postTime, description, isActive);
            nDAO.updateNews(news);

            request.getSession().setAttribute("message", "Update successful!");
            response.sendRedirect("News?service=listNews");
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
