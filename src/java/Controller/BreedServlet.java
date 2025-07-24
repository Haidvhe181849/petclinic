package Controller;

import DAO.AnimalDAO;
import DAO.BreedDAO;
import Entity.AnimalType;
import Entity.Breed;
import Utility.DBContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "BreedServlet", urlPatterns = {"/Breed"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class BreedServlet extends HttpServlet {

    private BreedDAO getBreedDAO() {
        return new BreedDAO(new DBContext().connection);
    }

    private AnimalDAO getAnimalDAO() {
        DBContext db = new DBContext();
        return new AnimalDAO(db.connection);
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // ✅ Đường dẫn tuyệt đối để lưu ảnh vào ổ đĩa ngoài project
        String saveDirectory = "C:/PetClinicUploads/Breed";

        File dir = new File(saveDirectory);
        if (!dir.exists()) {
            dir.mkdirs(); // tạo thư mục nếu chưa có
        }

        // ✅ Ghi file vào thư mục ngoài
        filePart.write(saveDirectory + File.separator + fileName);

        // ✅ Trả về đường dẫn để lưu vào DB (tương đối, dùng cho web hiển thị)
        return "uploads/Breed/" + fileName;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BreedDAO dao = getBreedDAO();
        AnimalDAO aDAO = getAnimalDAO();
        String service = request.getParameter("service");

        try {
            if (service == null || service.equals("listBreed")) {
                String name = request.getParameter("name");
                String status = request.getParameter("status");
                String order = request.getParameter("order");
                String typeId = request.getParameter("typeId");

                List<Breed> breedList = dao.getFilteredBreed(name, status, order, typeId);
                List<AnimalType> typeList = aDAO.getAllAnimalTypes();
                Map<String, String> typeMap = new HashMap<>();

                for (AnimalType type : typeList) {
                    typeMap.put(type.getAnimalTypeId(), type.getTypeName());
                }

                request.setAttribute("Breedlist", breedList);
                request.setAttribute("typeList", typeList);
                request.setAttribute("typeMap", typeMap);
                request.setAttribute("name", name);
                request.setAttribute("status", status);
                request.setAttribute("order", order);
                request.setAttribute("typeId", typeId);
                request.setAttribute("currentPage", "breed");

                request.getRequestDispatcher("Presentation/Breed.jsp").forward(request, response);
            } else if ("deleteBreed".equals(service)) {
                String id = request.getParameter("id");
                boolean success = dao.deleteBreed(id);
                session.setAttribute("message", success ? "Xoá giống thành công!" : "Xoá thất bại!");
                response.sendRedirect("Breed?service=listBreed");
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi GET BreedServlet: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        BreedDAO dao = getBreedDAO();
        String service = request.getParameter("service");

        try {
            if ("addBreed".equals(service)) {
                String name = request.getParameter("breed_name");
                String typeId = request.getParameter("animal_type_id");
                boolean active = Boolean.parseBoolean(request.getParameter("is_active"));
                Part imagePart = request.getPart("image");

                if (dao.isBreedNameExistsInType(name, typeId, null)) {
                    request.getSession().setAttribute("message", "❌ Giống này đã tồn tại trong loài đó!");
                    response.sendRedirect("Breed?service=listBreed");
                    return;
                }

                String imagePath = uploadImage(request);
                boolean success = dao.addBreed(new Breed(null, imagePath, name, typeId, active));
                session.setAttribute("message", success ? "Thêm giống thành công!" : "Thêm giống thất bại!");
            } else if ("updateBreed".equals(service)) {
                String id = request.getParameter("breed_id");
                String name = request.getParameter("breed_name");
                String typeId = request.getParameter("animal_type_id");
                boolean active = Boolean.parseBoolean(request.getParameter("is_active"));
                String oldImage = request.getParameter("oldImage");
                Part imagePart = request.getPart("image");

                if (dao.isBreedNameExistsInType(name, typeId, id)) {
                    request.getSession().setAttribute("message", "❌ Tên giống đã tồn tại trong loài này!");
                    response.sendRedirect("Breed?service=listBreed");
                    return;
                }

                String imagePath = imagePart.getSize() > 0 ? uploadImage(request) : oldImage;
                boolean success = dao.updateBreed(new Breed(id, imagePath, name, typeId, active));
                session.setAttribute("message", success ? "Cập nhật thành công!" : "Cập nhật thất bại!");
            }
            response.sendRedirect("Breed?service=listBreed");
        } catch (Exception e) {
            throw new ServletException("Lỗi POST BreedServlet: " + e.getMessage(), e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Breed management servlet";
    }
}
