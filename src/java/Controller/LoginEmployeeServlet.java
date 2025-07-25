package Controller;

import DAO.EmployeeDAO;
import Entity.Employee;
import Utility.DBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "LoginEmployeeServlet", urlPatterns = {"/login-employee"})
public class LoginEmployeeServlet extends HttpServlet {

    private EmployeeDAO getEmployeeDAO() {
        Connection conn = new DBContext().connection;
        return new EmployeeDAO(conn);
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to employee login page
        response.sendRedirect(request.getContextPath() + "/Presentation/LoginEmployee.jsp");
    }

    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        EmployeeDAO employeeDAO = getEmployeeDAO();
        Employee employee = employeeDAO.getEmployeeByEmailAndPassword(email, password);

        if (employee != null) {
            HttpSession session = request.getSession();
            session.setAttribute("staff", employee);
            System.out.println(employee.getRoleId());

            int role = employee.getRoleId();
            switch (role) {
                case 1: // Admin
                    response.sendRedirect("dashboard");
                    break;
                case 2: // Staff
                    response.sendRedirect("ProfileStaff");
                    break;
                case 3: // Doctor
//                    session.setAttribute("doctor", employee);
                    session.setAttribute("employee", employee);
                    session.setAttribute("userName", employee.getNameEmployee());
                    response.sendRedirect("employee-booking");
                    break;
                default:
                    request.setAttribute("error", "Bạn không có quyền truy cập.");
                    request.getRequestDispatcher("/Presentation/LoginEmployee.jsp").forward(request, response);
                    break;
            }
        } else {
            request.setAttribute("error", "Sai email hoặc mật khẩu.");
            request.getRequestDispatcher("/Presentation/LoginEmployee.jsp").forward(request, response);
        }
    }
}
