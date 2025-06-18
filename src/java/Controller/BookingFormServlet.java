/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.DoctorDAO;
import DAO.PetDAO;
import DAO.ServiceDAO;
import Entity.UserAccount;
import Utility.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;

/**
 *
 * @author quang
 */
@WebServlet("/BookingForm")
public class BookingFormServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");

        if (userObj == null || !(userObj instanceof UserAccount)) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        UserAccount user = (UserAccount) userObj;

        try (Connection conn = new DBContext().connection) {
            PetDAO petDAO = new PetDAO(conn);
            DoctorDAO doctorDAO = new DoctorDAO(conn);
            ServiceDAO serviceDAO = new ServiceDAO(conn);

            request.setAttribute("services", serviceDAO.getAllServices());
            request.setAttribute("pets", petDAO.getPetsByOwnerId(user.getUserId()));
            request.setAttribute("doctors", doctorDAO.getAllDoctors());

            request.getRequestDispatcher("Presentation/BookingForm.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // in console

            response.setContentType("text/plain"); // in lên trình duyệt
            response.getWriter().println("LỖI TỪ SERVLET:");
            e.printStackTrace(response.getWriter());
        }
    }
}
