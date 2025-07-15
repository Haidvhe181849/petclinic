package Controller;

import DAO.ServiceDAO;
import Entity.Service;
import Utility.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.List;
import java.util.Vector;

@WebServlet(name = "ServiceServlet", urlPatterns = {"/Service"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ServiceServlet extends HttpServlet {

    private ServiceDAO getServiceDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new ServiceDAO(conn);
    }

    private String uploadImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            fileName = fileName.replaceAll("[^a-zA-Z0-9.\\-_]", "_");

            String uploadDir = getServletContext().getRealPath("/uploads");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            String filePath = uploadDir + File.separator + fileName;
            filePart.write(filePath);

            return "uploads/" + fileName;
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceDAO sDAO = getServiceDAO();
        String service = request.getParameter("service");

        if (service == null || service.equals("listService") || service.equals("slist")) {
            String name = request.getParameter("name");
            String status = request.getParameter("status");
            String order = request.getParameter("order");

            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");

            Double minPrice = null, maxPrice = null;
            try {
                if (minPriceStr != null && !minPriceStr.isEmpty()) {
                    minPrice = Double.parseDouble(minPriceStr);
                }
                if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                    maxPrice = Double.parseDouble(maxPriceStr);
                }
            } catch (NumberFormatException e) {
            }
            List<Service> slist = sDAO.searchFilteredServices(name, status, order, minPrice, maxPrice);

            // Trả lại dữ liệu cho JSP để hiển thị lại input đã nhập
            request.setAttribute("slist", slist);
            request.setAttribute("service_name", name);
            request.setAttribute("status", status);
            request.setAttribute("order", order);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
            request.setAttribute("currentPage", "service");

            request.getRequestDispatcher("Presentation/ServiceManagerment.jsp").forward(request, response);
        } else if ("deleteService".equals(service)) {
            String sID = request.getParameter("sID");
            int result = sDAO.deleteService(sID);

            if (result > 0) {
                request.getSession().setAttribute("message", "Deleted successfully!");
            } else {
                request.getSession().setAttribute("message", "Failed to delete service.");
            }

            response.sendRedirect("Service?service=listService");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceDAO sDAO = getServiceDAO();
        String service = request.getParameter("service");

        if ("addService".equals(service)) {
            String service_id = sDAO.generateNextServiceId();
            String service_name = request.getParameter("service_name").trim();
            Double price = Double.valueOf(request.getParameter("price"));
            String description = request.getParameter("description");
            String imagePath = uploadImage(request);

            Service s = new Service(service_id, imagePath, service_name, price, description, true);
            if (sDAO.isDuplicateServiceName(service_name, null)) {
                request.getSession().setAttribute("message", "Service name already exists!");
                response.sendRedirect("Service?service=listService");
                return;
            }

            sDAO.insertService(s);

            request.getSession().setAttribute("message", "Added successfully!");
            response.sendRedirect("Service?service=listService");

        } else if ("updateService".equals(service)) {
            String service_id = request.getParameter("service_id");
            String service_name = request.getParameter("service_name").trim();
            Double price = Double.valueOf(request.getParameter("price"));
            String description = request.getParameter("description");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            String imagePath = uploadImage(request);
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = request.getParameter("old_image");
            }

            Service s = new Service(service_id, imagePath, service_name, price, description, status);
            if (sDAO.isDuplicateServiceName(service_name, service_id)) {
                request.getSession().setAttribute("message", "Service name already exists!");
                response.sendRedirect("Service?service=listService");
                return;
            }
            sDAO.updateService(s);

            request.getSession().setAttribute("message", "Updated successfully!");
            response.sendRedirect("Service?service=listService");

        } else {
            response.sendRedirect("Service?service=listService");
        }
    }

    @Override
    public String getServletInfo() {
        return "Service management servlet";
    }
}
