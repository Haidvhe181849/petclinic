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

@WebServlet(name = "ResetFormServlet", urlPatterns = {"/reset-form"})
public class ResetFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();
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
        
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Token không hợp lệ!");
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();
        PasswordResetToken resetToken = tokenDAO.findByToken(token);
        if (resetToken == null || resetToken.getExpiry().before(new Date())) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Vui lòng nhập mật khẩu mới!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Xác nhận mật khẩu mới không khớp!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        UserAccount user = userDAO.getUserById(resetToken.getUserId());
        if (user == null) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Không tìm thấy thông tin người dùng!");
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.equals(user.getPassword())) {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
            return;
        }
        
        user.setPassword(newPassword);
        boolean updated = userDAO.updatePassword(user);
        
        if (updated) {
            tokenDAO.deleteToken(token);
            request.setAttribute("resetStatus", "success");
            request.setAttribute("resetMessage", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.");
        } else {
            request.setAttribute("resetStatus", "error");
            request.setAttribute("resetMessage", "Đặt lại mật khẩu thất bại. Vui lòng thử lại!");
            request.setAttribute("token", token);
        }
        
        request.getRequestDispatcher("Presentation/ResetPasswordForm.jsp").forward(request, response);
    }
} 