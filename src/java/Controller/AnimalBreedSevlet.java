// Updated AnimalBreedServlet with image file upload handling
package Controller;

import DAO.AnimalDAO;
import Entity.AnimalType;
import Entity.Breed;
import Utility.DBContext;
import java.sql.SQLException;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "AnimalBreedServlet", urlPatterns = {"/Animal"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class AnimalBreedSevlet extends HttpServlet {

    private AnimalDAO getAnimalDAO() {
        DBContext db = new DBContext();
        return new AnimalDAO(db.connection);
    }

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
        AnimalDAO dao = new AnimalDAO(new DBContext().connection);
        String service = request.getParameter("service");

        if (service == null || service.equals("listType")) {
            // Lấy các tham số lọc
            String name = request.getParameter("name");
            String status = request.getParameter("status");
            String order = request.getParameter("order");

            try {
                // Truy vấn dữ liệu theo bộ lọc
                List<AnimalType> list = dao.getFilteredAnimalTypes(name, status, order);

                // Gửi dữ liệu về JSP
                request.setAttribute("typeList", list);
                request.setAttribute("name", name);
                request.setAttribute("status", status);
                request.setAttribute("order", order);

                // Dùng cho sidebar highlight
                request.setAttribute("currentPage", "animal");

                // Forward về giao diện quản lý
                request.getRequestDispatcher("Presentation/AnimalManagerment.jsp").forward(request, response);
            } catch (SQLException e) {
                throw new ServletException("Error loading animal types", e);
            }

        } else if ("deleteType".equals(service)) {
            String id = request.getParameter("id");

            try {
                boolean success = dao.deleteAnimalType(id);
                if (success) {
                    request.getSession().setAttribute("message", "Deleted successfully!");
                } else {
                    request.getSession().setAttribute("message", "Delete failed or ID not found.");
                }
            } catch (SQLException e) {
                request.getSession().setAttribute("message", "Error occurred during deletion.");
            }

            // Sau khi xóa chuyển hướng lại danh sách
            response.sendRedirect("Animal?service=listType");

        } else {
            // Redirect fallback
            response.sendRedirect("Animal?service=listType");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String service = request.getParameter("service");

        try {
            AnimalDAO aDAO = getAnimalDAO();

            if ("addType".equals(service)) {
                String name = request.getParameter("typeName");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                Part imagePart = request.getPart("image");
                String imagePath = saveFile(imagePart, "images/animal", request);
                aDAO.addAnimalType(new AnimalType(null, imagePath, name, status));
                request.getSession().setAttribute("message", "Add successfully!");
            }

            if ("updateType".equals(service)) {
                String id = request.getParameter("typeId");
                String name = request.getParameter("typeName");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                String oldImage = request.getParameter("oldImage");
                Part imagePart = request.getPart("image");
                String imagePath = imagePart.getSize() > 0 ? saveFile(imagePart, "images/animal", request) : oldImage;
                aDAO.updateAnimalType(new AnimalType(id, imagePath, name, status));
                request.getSession().setAttribute("message", "Update successfully!");
            }
            response.sendRedirect("Animal");

        } catch (Exception e) {
            throw new ServletException("POST Error: " + e.getMessage(), e);
        }
    }
}
