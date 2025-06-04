package Controller;

import DAO.UserDAO;
import DAO.PasswordResetTokenDAO;
import Entity.UserAccount;
import Entity.PasswordResetToken;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Xóa các token đã hết hạn
        PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();
        tokenDAO.deleteExpiredTokens();
        
        // Kiểm tra token có hợp lệ và chưa hết hạn
        PasswordResetToken resetToken = tokenDAO.findByToken(token);
        if (resetToken == null || resetToken.getExpiry().before(new Date())) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("token", token);
        request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        String message = null;
        String status = null;
        
        if (token == null || token.trim().isEmpty()) {
            message = "Token không hợp lệ!";
            status = "error";
        } else if (newPassword == null || newPassword.trim().isEmpty()) {
            message = "Vui lòng nhập mật khẩu mới!";
            status = "error";
        } else if (newPassword.length() < 6) {
            message = "Mật khẩu mới phải có ít nhất 6 ký tự!";
            status = "error";
        } else if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            message = "Vui lòng xác nhận mật khẩu mới!";
            status = "error";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "Xác nhận mật khẩu mới không khớp!";
            status = "error";
        } else {
            PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();
            UserDAO userDAO = new UserDAO();
            
            // Lấy token và kiểm tra
            var resetToken = tokenDAO.findByToken(token);
            if (resetToken == null) {
                message = "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn!";
                status = "error";
            } else {
                // Lấy thông tin user
                UserAccount user = userDAO.getUserById(resetToken.getUserId());
                if (user == null) {
                    message = "Không tìm thấy thông tin người dùng!";
                    status = "error";
                } else if (newPassword.equals(user.getPassword())) {
                    message = "Mật khẩu mới không được trùng với mật khẩu cũ!";
                    status = "error";
                } else {
                    // Cập nhật mật khẩu mới
                    user.setPassword(newPassword);
                    boolean updated = userDAO.updatePassword(user);
                    
                    if (updated) {
                        // Xóa token sau khi đã sử dụng
                        tokenDAO.deleteToken(token);
                        
                        request.setAttribute("resetStatus", "success");
                        request.setAttribute("resetMessage", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.");
                        request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
                        return;
                    } else {
                        message = "Đặt lại mật khẩu thất bại. Vui lòng thử lại!";
                        status = "error";
                    }
                }
            }
        }
        
        if (status != null && status.equals("error")) {
            request.setAttribute("token", token);
            request.setAttribute("resetStatus", status);
            request.setAttribute("resetMessage", message);
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
        }
    }
}

