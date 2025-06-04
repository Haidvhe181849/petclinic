package Controller;

import DAO.UserDAO;
import DAO.PasswordResetTokenDAO;
import Entity.UserAccount;
import Entity.PasswordResetToken;
import Utility.EmailUtil;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Presentation/ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("mailStatus", "error");
            request.setAttribute("mailMessage", "Vui lòng nhập email!");
            request.getRequestDispatcher("Presentation/ForgotPassword.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        UserAccount user = userDAO.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("mailStatus", "error");
            request.setAttribute("mailMessage", "Email không tồn tại trong hệ thống!");
            request.getRequestDispatcher("Presentation/ForgotPassword.jsp").forward(request, response);
            return;
        }

        // Tạo token mới
        String token = UUID.randomUUID().toString();
        // Token có hiệu lực trong 30 phút
        Date expiry = new Date(System.currentTimeMillis() + 30 * 60 * 1000);

        // Lưu token vào database
        PasswordResetToken resetToken = new PasswordResetToken(0, user.getUserId(), token, expiry);
        boolean tokenSaved = new PasswordResetTokenDAO().createToken(resetToken);

        if (!tokenSaved) {
            request.setAttribute("mailStatus", "error");
            request.setAttribute("mailMessage", "Có lỗi xảy ra. Vui lòng thử lại sau!");
            request.getRequestDispatcher("Presentation/ForgotPassword.jsp").forward(request, response);
            return;
        }

        // Tạo link reset password
        String resetLink = request.getRequestURL().toString().replace("/forgot-password", "/reset-password") 
                + "?token=" + token;

        // Tạo nội dung email
        String subject = "Dat lai mat khau - Pet Hospital";
        String content = "<h3>Xin chào " + user.getName() + ",</h3>"
                + "<p>Bạn vừa yêu cầu đặt lại mật khẩu cho tài khoản Pet Hospital.</p>"
                + "<p>Vui lòng nhấn vào liên kết bên dưới để tiến hành đặt lại mật khẩu:</p>"
                + "<a href='" + resetLink + "' style='display:inline-block; padding:10px 20px; "
                + "background:#ff3d3d; color:white; text-decoration:none; border-radius:5px; "
                + "margin:15px 0;'>Đặt lại mật khẩu</a>"
                + "<p style='margin-top:15px;'><b>Lưu ý:</b> Liên kết này sẽ hết hạn sau 30 phút.</p>"
                + "<br><p>Trân trọng,<br>Pet Hospital</p>";

        // Gửi email
        boolean emailSent = EmailUtil.sendEmail(email, subject, content);

        if (emailSent) {
            request.setAttribute("mailStatus", "success");
            request.setAttribute("mailMessage", "Đã gửi email đặt lại mật khẩu. Vui lòng kiểm tra hộp thư của bạn!");
        } else {
            request.setAttribute("mailStatus", "error");
            request.setAttribute("mailMessage", "Gửi email thất bại. Vui lòng thử lại!");
            // Xóa token nếu gửi mail thất bại
            new PasswordResetTokenDAO().deleteToken(token);
        }

        request.getRequestDispatcher("Presentation/ForgotPassword.jsp").forward(request, response);
    }
} 