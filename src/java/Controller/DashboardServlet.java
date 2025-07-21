/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookingDAO;
import DAO.DoctorDAO;
import DAO.ServiceDAO;
import DAO.UserAccountDAO;
import Entity.Service;
import Entity.UserAccount;
import Utility.DBContext;
import java.sql.Connection;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collections;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
            UserAccount user = (UserAccount) session.getAttribute("user");
            if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
                response.sendRedirect("login");
                return;
            }
        try (Connection conn = new DBContext().connection) {
            // Get filter parameters for revenue statistics
            String period = request.getParameter("period");
            if (period == null || period.isEmpty()) {
                period = "week"; // Default to weekly view
            }
            
            // Get services
            ServiceDAO sDAO = new ServiceDAO(conn);
            List<Service> slist = sDAO.getAllServices();
            
            // Count total doctors
            DoctorDAO doctorDAO = new DoctorDAO(conn);
            int totalDoctors = doctorDAO.getAllDoctors().size();
            request.setAttribute("totalDoctors", totalDoctors);
            
            // Count total services
            int totalServices = slist.size();
            request.setAttribute("totalServices", totalServices);
            
            // Count total bookings
            BookingDAO bookingDAO = new BookingDAO(conn);
            int totalBookings = bookingDAO.getTotalBookings();
            request.setAttribute("totalBookings", totalBookings);
            
            // Count total customers
            UserAccountDAO userDAO = new UserAccountDAO();
            int totalCustomers = userDAO.getTotalCustomers();
            request.setAttribute("totalCustomers", totalCustomers);
            System.out.println(totalCustomers);
            // Get revenue based on selected period
            double filteredRevenue = 0;
            switch (period) {
                case "month":
                    filteredRevenue = getMonthlyRevenue(conn);
                    break;
                case "year":
                    filteredRevenue = getYearlyRevenue(conn);
                    break;
                default:
                    filteredRevenue = getWeeklyRevenue(conn);
                    break;
            }
            request.setAttribute("filteredRevenue", filteredRevenue);
            request.setAttribute("selectedPeriod", period);
            
            // Always get weekly, monthly, and yearly revenue for statistics
            double weeklyRevenue = getWeeklyRevenue(conn);
            request.setAttribute("weeklyRevenue", weeklyRevenue);
            
            double monthlyRevenue = getMonthlyRevenue(conn);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            
            double yearlyRevenue = getYearlyRevenue(conn);
            request.setAttribute("yearlyRevenue", yearlyRevenue);
            
            // Always get last 7 days revenue for chart
            Map<String, Double> last7DaysRevenue = getLast7DaysRevenue(conn);
            request.setAttribute("last7DaysLabels", last7DaysRevenue.keySet());
            request.setAttribute("last7DaysData", last7DaysRevenue.values());
            request.setAttribute("chartTitle", "Last 7 Days Revenue");
            
            request.getRequestDispatcher("Presentation/Dashbroard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cannot load dashboard data.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        doGet(request, response);
    }
    
    private double getWeeklyRevenue(Connection conn) {
        String sql = "SELECT SUM(s.price) AS weekly_revenue " +
                     "FROM Booking b " +
                     "JOIN Service s ON b.service_id = s.service_id " +
                     "WHERE b.booking_time >= DATEADD(day, -7, GETDATE()) " +
                     "AND b.status IN ('Confirmed', 'Complete')";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double revenue = rs.getDouble("weekly_revenue");
                return revenue > 0 ? revenue : 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private double getMonthlyRevenue(Connection conn) {
        String sql = "SELECT SUM(s.price) AS monthly_revenue " +
                     "FROM Booking b " +
                     "JOIN Service s ON b.service_id = s.service_id " +
                     "WHERE b.booking_time >= DATEADD(month, -1, GETDATE()) " +
                     "AND b.status IN ('Confirmed', 'Complete')";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double revenue = rs.getDouble("monthly_revenue");
                return revenue > 0 ? revenue : 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private double getYearlyRevenue(Connection conn) {
        String sql = "SELECT SUM(s.price) AS yearly_revenue " +
                     "FROM Booking b " +
                     "JOIN Service s ON b.service_id = s.service_id " +
                     "WHERE b.booking_time >= DATEADD(year, -1, GETDATE()) " +
                     "AND b.status IN ('Confirmed', 'Complete')";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double revenue = rs.getDouble("yearly_revenue");
                return revenue > 0 ? revenue : 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private Map<String, Double> getLast7DaysRevenue(Connection conn) {
        Map<String, Double> result = new LinkedHashMap<>();  // Sử dụng LinkedHashMap để duy trì thứ tự chèn
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");
        
        // Khởi tạo 7 ngày gần nhất với giá trị 0, từ cũ đến mới
        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            result.put(date.format(formatter), 0.0);
        }
        
        String sql = "SELECT CONVERT(date, b.booking_time) AS booking_day, SUM(s.price) AS daily_revenue " +
                "FROM Booking b " +
                "JOIN Service s ON b.service_id = s.service_id " +
                "WHERE b.booking_time >= DATEADD(day, -7, GETDATE()) " +
                "AND b.status IN ('Confirmed', 'Complete') " +
                "GROUP BY CONVERT(date, b.booking_time)";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate date = rs.getDate("booking_day").toLocalDate();
                String dateStr = date.format(formatter);
                double revenue = rs.getDouble("daily_revenue");
                
                // Chỉ cập nhật nếu ngày nằm trong 7 ngày gần nhất
                if (result.containsKey(dateStr)) {
                    result.put(dateStr, revenue);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    private Map<String, Double> getLastMonthRevenue(Connection conn) {
        Map<String, Double> result = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");
        
        // Initialize last 30 days with zero
        for (int i = 29; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            result.put(date.format(formatter), 0.0);
        }
        
        String sql = "SELECT CONVERT(date, b.booking_time) AS booking_day, SUM(s.price) AS daily_revenue " +
                "FROM Booking b " +
                "JOIN Service s ON b.service_id = s.service_id " +
                "WHERE b.booking_time >= DATEADD(day, -30, GETDATE()) " +
                "AND b.status IN ('Confirmed', 'Complete') " +
                "GROUP BY CONVERT(date, b.booking_time)";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate date = rs.getDate("booking_day").toLocalDate();
                String dateStr = date.format(formatter);
                double revenue = rs.getDouble("daily_revenue");
                
                // Chỉ cập nhật nếu ngày nằm trong 30 ngày gần nhất
                if (result.containsKey(dateStr)) {
                    result.put(dateStr, revenue);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    private Map<String, Double> getLastYearRevenue(Connection conn) {
        Map<String, Double> result = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yyyy");
        
        // Initialize last 12 months with zero
        for (int i = 11; i >= 0; i--) {
            LocalDate date = today.minusMonths(i);
            result.put(date.format(formatter), 0.0);
        }
        
        String sql = "SELECT YEAR(b.booking_time) AS year, MONTH(b.booking_time) AS month, " +
                "SUM(s.price) AS monthly_revenue " +
                "FROM Booking b " +
                "JOIN Service s ON b.service_id = s.service_id " +
                "WHERE b.booking_time >= DATEADD(month, -12, GETDATE()) " +
                "AND b.status IN ('Confirmed', 'Complete') " +
                "GROUP BY YEAR(b.booking_time), MONTH(b.booking_time)";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int year = rs.getInt("year");
                int month = rs.getInt("month");
                LocalDate date = LocalDate.of(year, month, 1);
                String dateStr = date.format(formatter);
                double revenue = rs.getDouble("monthly_revenue");
                
                // Chỉ cập nhật nếu tháng nằm trong 12 tháng gần nhất
                if (result.containsKey(dateStr)) {
                    result.put(dateStr, revenue);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Dashboard controller - loads statistics and data for admin dashboard";
    }
} 