package Controller;

import DAO.UserAccountDAO;
import Entity.UserAccount;
import Utility.EmailUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Presentation/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String status = request.getParameter("status");
        int roleId = 1; // mặc định là User
        

        // Kiểm tra mật khẩu xác nhận
        if (confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("Presentation/Register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng user
        UserAccount user = new UserAccount(0, name, phone, email, username, password, address, roleId, status);

        // Gọi DAO để xử lý đăng ký
        UserAccountDAO userDAO = new UserAccountDAO();
        boolean success = userDAO.createUser(user);

        if (success) {
            // Gửi email thông báo
            String subject = "Register Successfully - Pet Hospital";
            String content = "<h3>Chào mừng bạn đến với Pet Hospital!</h3>"
                    + "<p>Bạn đã đăng ký tài khoản thành công với email: <b>" + email + "</b></p>"
                    + "<p>Bạn có thể đăng nhập và sử dụng các dịch vụ của chúng tôi.</p>"
                    + "<br><p>Trân trọng,<br>Pet Hospital</p>";

            EmailUtil.sendEmail(email, subject, content);

            // Gửi thông báo thành công về trang login
            request.getSession().setAttribute("registerSuccess", "Đăng ký thành công! Bạn có thể đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Đăng ký thất bại
            request.setAttribute("error", "Đăng ký thất bại! Tài khoản hoặc email đã tồn tại.");
            request.getRequestDispatcher("Presentation/Register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký người dùng cho Pet Hospital";
    }
}
