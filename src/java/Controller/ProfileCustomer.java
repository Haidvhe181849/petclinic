package Controller;

import DAO.AnimalDAO;
import DAO.BookingDAO;
import DAO.PetDAO;
import DAO.BreedDAO;
import DAO.UserAccountDAO;
import Entity.AnimalType;
import Entity.Booking;
import Entity.Breed;
import Entity.Pet;
import Entity.UserAccount;
import Utility.DBContext;
import java.sql.Connection;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
@WebServlet(name = "ProfileCustomer", urlPatterns = {"/ProfileCustomer"})
public class ProfileCustomer extends HttpServlet {

    private BookingDAO getBookingDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new BookingDAO(conn);
    }

    private PetDAO getPetDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new PetDAO(conn);
    }

    private AnimalDAO getAnimalDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new AnimalDAO(conn);
    }

    private BreedDAO getBreedDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new BreedDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        UserAccount user = (UserAccount) session.getAttribute("user");
        String action = request.getParameter("action");

        if (action == null || action.equals("profile")) {
            showProfile(request, response, user);
        } else if (action.equals("myPets")) {
            showMyPets(request, response, user);
        } else if (action.equals("appointments")) {
            showAppointments(request, response, user);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {
        BookingDAO bookingDAO = getBookingDAO();
        PetDAO petDAO = getPetDAO();
        AnimalDAO animalDAO = getAnimalDAO();
        BreedDAO breedDAO = getBreedDAO();

        try {
            int petCount = petDAO.countPetsByOwner(user.getUserId());
            int appointmentCount = bookingDAO.countAppointmentsByUserId(user.getUserId());

            // Lấy danh sách thú cưng của người dùng
            List<Pet> userPets = petDAO.getPetsByOwnerId(user.getUserId());

            // Lấy danh sách lịch hẹn
            List<Booking> upcomingAppointments = bookingDAO.getUpcomingByUser(user.getUserId());
            List<Booking> recentAppointments = bookingDAO.getCompletedByUser(user.getUserId());

            // Lấy danh sách loại động vật (Animal Types)
            List<AnimalType> animalTypes = animalDAO.getAllAnimalTypes();

            // Lấy danh sách giống (breed)
            List<Breed> breeds = breedDAO.getAllBreeds();

            // Gửi dữ liệu về JSP
            request.setAttribute("petCount", petCount);
            request.setAttribute("appointmentCount", appointmentCount);
            request.setAttribute("userPets", userPets);
            request.setAttribute("upcomingAppointments", upcomingAppointments);
            request.setAttribute("recentAppointments", recentAppointments);
            request.setAttribute("animalTypes", animalTypes);
            request.setAttribute("breeds", breeds);

            // Forward sang trang giao diện
            request.getRequestDispatcher("Presentation/ProfileCustomer.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải dữ liệu trang hồ sơ.");
            request.getRequestDispatcher("Presentation/error.jsp").forward(request, response);
        }
    }

    private void showMyPets(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {
        PetDAO petDAO = getPetDAO();
        List<Pet> userPets = petDAO.getPetsByOwnerId(user.getUserId());

        request.setAttribute("petList", userPets);
        request.getRequestDispatcher("Presentation/MyPets.jsp").forward(request, response);
    }

    private void showAppointments(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {
        BookingDAO bookingDAO = getBookingDAO();
        List<Booking> allAppointments = bookingDAO.getAllByUser(user.getUserId());

        request.setAttribute("appointments", allAppointments);
        request.getRequestDispatcher("Presentation/AppointmentList.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            // Lấy dữ liệu từ form
            String name = request.getParameter("name").trim();
            String email = request.getParameter("email").trim();
            String phone = request.getParameter("phone").trim();
            String address = request.getParameter("address").trim();
            String selectedAvatar = request.getParameter("avatar"); // chỉ là tên file, ví dụ: "av1.jpg"

            // Nếu không chọn avatar mới, giữ nguyên avatar hiện tại
            if (selectedAvatar == null || selectedAvatar.isEmpty()) {
                selectedAvatar = user.getImage();
            }

            // Cập nhật thông tin vào user
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setImage(selectedAvatar);

            // Cập nhật DB
            UserAccountDAO dao = new UserAccountDAO();
            dao.updateUser(user);

            // Cập nhật lại session nếu cần
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("successMessage", "Cập nhật hồ sơ thành công!");

            // Redirect về profile
            response.sendRedirect("ProfileCustomer");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật hồ sơ.");
            request.getRequestDispatcher("Presentation/error.jsp").forward(request, response);
        }
    }

    private void addPet(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            String name = request.getParameter("name").trim();
            String breed = request.getParameter("breed").trim();
            double weight = Double.parseDouble(request.getParameter("weight"));
            LocalDate birthdate = LocalDate.parse(request.getParameter("birthdate"));
            String petTypeId = request.getParameter("pet_type_id");
            String customBreed = request.getParameter("custom_breed");

            if ("OTHER".equals(breed) && customBreed != null && !customBreed.trim().isEmpty()) {
                breed = customBreed.trim();
            }
            // Check trùng tên thú cưng cho user
            PetDAO dao = getPetDAO();
            List<Pet> existingPets = dao.getPetsByOwnerId(user.getUserId());
            boolean isDuplicate = existingPets.stream().anyMatch(p -> p.getName().equalsIgnoreCase(name));

            if (isDuplicate) {
                request.setAttribute("errorMessage", "Tên thú cưng đã tồn tại. Vui lòng chọn tên khác.");
                showProfile(request, response, user);
                return;
            }

            // Xử lý ảnh
            Part filePart = request.getPart("image");
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = new File(filePart.getSubmittedFileName()).getName();
                fileName = System.currentTimeMillis() + "_" + submittedFileName;

                String uploadPath = getServletContext().getRealPath("/") + "Presentation/img/images/imgPet";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File imageFile = new File(uploadDir, fileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, imageFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            }

            // Tạo ID mới
            String newPetId = dao.generateNewPetId();

            // Tạo đối tượng Pet
            Pet newPet = new Pet();
            newPet.setPetId(newPetId);
            newPet.setOwnerId(user.getUserId());
            newPet.setName(name);
            newPet.setBreed(breed);
            newPet.setWeight(weight);
            newPet.setBirthdate(birthdate);
            newPet.setPetTypeId(petTypeId);
            newPet.setImage(fileName);

            // Thêm vào DB
            dao.addPet(newPet);

            request.getSession().setAttribute("successMessage", "Thêm thú cưng thành công!");
            response.sendRedirect("ProfileCustomer");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm thú cưng.");
            request.getRequestDispatcher("Presentation/error.jsp").forward(request, response);
        }
    }

    private void updatePet(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            String petId = request.getParameter("pet_id");
            String name = request.getParameter("name").trim();
            String breed = request.getParameter("breed").trim();
            String petTypeId = request.getParameter("pet_type_id");
            double weight = Double.parseDouble(request.getParameter("weight"));
            LocalDate birthdate = LocalDate.parse(request.getParameter("birthdate"));

            String customBreed = request.getParameter("custom_breed");
            if ("OTHER".equals(breed) && customBreed != null && !customBreed.trim().isEmpty()) {
                breed = customBreed.trim();
            }
            // Xử lý ảnh mới nếu có, nếu không giữ ảnh cũ
            Part filePart = request.getPart("image");
            String fileName = null;
            String oldImage = request.getParameter("old_image");

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = new File(filePart.getSubmittedFileName()).getName();
                fileName = System.currentTimeMillis() + "_" + submittedFileName;

                String uploadPath = getServletContext().getRealPath("/") + "Presentation/img/images/imgPet";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File imageFile = new File(uploadDir, fileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, imageFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            } else {
                fileName = oldImage; // giữ lại ảnh cũ nếu không thay mới
            }

            Pet pet = new Pet();
            pet.setPetId(petId);
            pet.setOwnerId(user.getUserId());
            pet.setName(name);
            pet.setBreed(breed);
            pet.setWeight(weight);
            pet.setBirthdate(birthdate);
            pet.setPetTypeId(petTypeId);
            pet.setImage(fileName);

            PetDAO dao = getPetDAO();
            dao.updatePet(pet);

            response.sendRedirect("ProfileCustomer");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật thú cưng.");
            request.getRequestDispatcher("Presentation/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        String service = request.getParameter("service");
        if ("addPet".equals(service)) {
            addPet(request, response, user);
        } else if ("updatePet".equals(service)) {
            updatePet(request, response, user);
        } else if ("deletePet".equals(service)) {
            String petId = request.getParameter("pet_id");
            PetDAO dao = getPetDAO();
            dao.deletePet(petId);
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        } else if ("updateProfile".equals(service)) {
            updateProfile(request, response, user);
        } else {
            doGet(request, response); // fallback
        }
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị hồ sơ khách hàng bao gồm thông tin cá nhân, thú cưng và lịch khám.";
    }
}
