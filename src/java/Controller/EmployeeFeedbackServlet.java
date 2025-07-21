package Controller;

import DAO.RateDoctorDAO;
import Entity.RateDoctor;
import Utility.DBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * Servlet to handle employee feedback requests
 */
@WebServlet(name = "EmployeeFeedbackServlet", urlPatterns = {"/EmployeeFeedback"})
public class EmployeeFeedbackServlet extends HttpServlet {

    private RateDoctorDAO getRateDoctorDAO() {
        DBContext db = new DBContext();
        Connection conn = db.connection;
        return new RateDoctorDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String employeeId = request.getParameter("employeeId");
        
        try {
            RateDoctorDAO dao = getRateDoctorDAO();
            List<RateDoctor> feedbackList = dao.getRatingsByDoctor(employeeId);
            
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("employeeId", employeeId);
            
            // Forward to a JSP fragment that will be loaded via AJAX
            request.getRequestDispatcher("Presentation/employee_feedback_content.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<div class='alert alert-danger'>Error loading feedback: " + e.getMessage() + "</div>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle employee feedback listing";
    }
}
