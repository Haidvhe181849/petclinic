package Controller;

import DAO.NewsDAO;
import Entity.News;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "UpdateNewsServlet", urlPatterns = {"/UpdateNews"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateNews extends HttpServlet {

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
        return "Presentation/img/" + folder + "/" + fileName;  // Đường lưu trong DB
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newsId = request.getParameter("id");
        NewsDAO dao = new NewsDAO();
        News news = dao.getNewsByID(newsId);
        request.setAttribute("news", news);
        request.getRequestDispatcher("Presentation/UpdateNews.jsp").forward(request, response);
    }


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String newsId = request.getParameter("newsId");
            String nameNews = request.getParameter("nameNews");
            String description = request.getParameter("description");
            boolean isActive = "1".equals(request.getParameter("isActive"));
            String oldImage = request.getParameter("oldImage");
            Timestamp postTime = new Timestamp(System.currentTimeMillis());

            Part imagePart = request.getPart("imageFile");
            String imageUrl = (imagePart != null && imagePart.getSize() > 0)
                    ? saveFile(imagePart, "images/news", request)
                    : oldImage;

            News updatedNews = new News(newsId, imageUrl, nameNews, postTime, description, isActive);

            NewsDAO dao = new NewsDAO();
            dao.updateNews(updatedNews);

            request.getSession().setAttribute("message", "News updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Update failed: " + e.getMessage());
        }
        response.sendRedirect("News?service=listNews");
    }

    @Override
public String getServletInfo() {
        return "Handles News Update";
    }
}
