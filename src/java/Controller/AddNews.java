package Controller;

import DAO.NewsDAO;
import Entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;

@WebServlet(name = "AddNews", urlPatterns = {"/AddNews"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddNews extends HttpServlet {

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
        request.getRequestDispatcher("Presentation/AddNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            NewsDAO nDAO = new NewsDAO();
            String newsId = nDAO.generateNextNewsId();

            String nameNews = request.getParameter("nameNews");
            String description = request.getParameter("description");
            boolean isActive = "1".equals(request.getParameter("isActive"));
            Timestamp postTime = new Timestamp(System.currentTimeMillis());

            Part imagePart = request.getPart("imageFile");
            String imagePath = (imagePart != null && imagePart.getSize() > 0)
                    ? saveFile(imagePart, "images/news", request)
                    : null;

            if (imagePath == null || nameNews == null || nameNews.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin và chọn ảnh.");
                request.getRequestDispatcher("Presentation/AddNews.jsp").forward(request, response);
                return;
            }

            News news = new News(newsId, imagePath, nameNews, postTime, description, isActive);
            int inserted = nDAO.insertNews(news);

            if (inserted > 0) {
                response.sendRedirect("News?service=listNews");
            } else {
                request.setAttribute("error", "Không thể thêm tin tức.");
                request.getRequestDispatcher("Presentation/AddNews.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi thêm tin: " + e.getMessage());
            request.getRequestDispatcher("Presentation/AddNews.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet để thêm tin tức mới";
    }
}
