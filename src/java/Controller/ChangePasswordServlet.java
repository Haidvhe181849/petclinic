package Controller;

import DAO.UserDAO;
import Entity.UserAccount;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("Presentation/ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        UserAccount sessionUser = (UserAccount) session.getAttribute("user");
        UserDAO userDAO = new UserDAO();
        UserAccount user = userDAO.getUserById(sessionUser.getUserId());
        
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String message = null;
        String status = null;
        
        // Kiểm tra mật khẩu cũ
        if (oldPassword == null || oldPassword.trim().isEmpty()) {
            message = "Vui lòng nhập mật khẩu cũ!";
            status = "error";
        } else if (!oldPassword.equals(user.getPassword())) {
            // Kiểm tra mật khẩu cũ có đúng không
            message = "Mật khẩu cũ không đúng!";
            status = "error";
        } 
        // Kiểm tra mật khẩu mới
        else if (newPassword == null || newPassword.trim().isEmpty()) {
            message = "Vui lòng nhập mật khẩu mới!";
            status = "error";
        } else if (newPassword.length() < 6) {
            message = "Mật khẩu mới phải có ít nhất 6 ký tự!";
            status = "error";
        } else if (oldPassword.equals(newPassword)) {
            message = "Mật khẩu mới không được trùng với mật khẩu cũ!";
            status = "error";
        } 
        // Kiểm tra xác nhận mật khẩu
        else if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            message = "Vui lòng xác nhận mật khẩu mới!";
            status = "error";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "Xác nhận mật khẩu mới không khớp!";
            status = "error";
        } else {
            // Kiểm tra lại mật khẩu cũ một lần nữa trước khi cập nhật
            UserAccount latestUser = userDAO.getUserById(user.getUserId());
            if (!oldPassword.equals(latestUser.getPassword())) {
                message = "Mật khẩu cũ không đúng. Vui lòng kiểm tra lại!";
                status = "error";
            } else {
                // Cập nhật mật khẩu mới
                user.setPassword(newPassword);
                boolean updated = userDAO.updatePassword(user);
                if (updated) {
                    request.setAttribute("changeStatus", "success");
                    request.setAttribute("changeMessage", "Đổi mật khẩu thành công!");
                    request.getRequestDispatcher("Presentation/ChangePassword.jsp").forward(request, response);
                    return;
                } else {
                    message = "Đổi mật khẩu thất bại. Vui lòng thử lại!";
                    status = "error";
                }
            }
        }
        
        if (status != null && status.equals("error")) {
            request.setAttribute("changeStatus", status);
            request.setAttribute("changeMessage", message);
            request.getRequestDispatcher("Presentation/ChangePassword.jsp").forward(request, response);
        }
    }
} 