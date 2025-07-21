package Controller;

import DAO.UserAccountDAO;
import Entity.Employee;
import Entity.UserAccount;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AccountManagementServlet", urlPatterns = { "/account-management" })
public class AccountManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Kiểm tra đăng nhập và phân quyền
            HttpSession session = request.getSession();
//            Employee currentUser = (Employee) session.getAttribute("staff");
//            if (currentUser == null || (currentUser.getRoleId() != 1 && currentUser.getRoleId() != 2)) {
//                response.sendRedirect("login");
//                return;
//            }

            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            UserAccountDAO dao = new UserAccountDAO();            switch (action) {
                case "list":
                    // Lấy các tham số lọc
                    String searchTerm = request.getParameter("search");
                    String roleFilter = request.getParameter("role");
                    String statusFilter = request.getParameter("status");
                    
                    // Phân tích tham số role
                    int roleId = 0;
                    if (roleFilter != null && !roleFilter.isEmpty()) {
                        try {
                            roleId = Integer.parseInt(roleFilter);
                        } catch (NumberFormatException e) {
                            roleId = 0; // Nếu không phân tích được, không lọc theo role
                        }
                    }
                    
                    // Gọi phương thức lọc danh sách tài khoản
                    List<UserAccount> accounts;
                    if (searchTerm != null || roleId > 0 || (statusFilter != null && !statusFilter.isEmpty())) {
                        accounts = dao.getFilteredAccounts(roleId, statusFilter, searchTerm);
                    } else {
                        accounts = dao.getAllAccounts();
                    }
                    
                    request.setAttribute("accounts", accounts);
                    request.setAttribute("searchTerm", searchTerm != null ? searchTerm : "");
                    request.setAttribute("roleFilter", roleFilter != null ? roleFilter : "");
                    request.setAttribute("statusFilter", statusFilter != null ? statusFilter : "");
                    
                    request.getRequestDispatcher("Presentation/account_list.jsp").forward(request, response);
                    break;

                case "create":
                    request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                    break;

                case "edit":
                    int userId = Integer.parseInt(request.getParameter("id"));
                    UserAccount user = dao.getUserById(userId);
                    if (user != null) {
                        request.setAttribute("accountUser", user);
                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                    } else {
                        request.setAttribute("alertMessage", "Không tìm thấy tài khoản!");
                        request.setAttribute("alertType", "error");
                        response.sendRedirect("account-management");
                    }
                    break;

                case "detail":
                    userId = Integer.parseInt(request.getParameter("id"));
                    UserAccount accountDetail = dao.getUserById(userId);
                    if (accountDetail != null) {
                        request.setAttribute("accountUser", accountDetail);
                        request.getRequestDispatcher("Presentation/account_detail.jsp").forward(request, response);
                    } else {
                        request.setAttribute("alertMessage", "Không tìm thấy tài khoản!");
                        request.setAttribute("alertType", "error");
                        request.getRequestDispatcher("Presentation/account_detail.jsp").forward(request, response);
                    }
                    break;

                case "toggleStatus":
                    userId = Integer.parseInt(request.getParameter("id"));
                    String newStatus = request.getParameter("status");
                    System.out.println("Toggle status for User ID: " + userId + " to status: " + newStatus);

                    if (dao.updateUserStatus(userId, newStatus)) {
                        session.setAttribute("alertMessage", "Cập nhật trạng thái thành công!");
                        session.setAttribute("alertType", "success");
                    } else {
                        session.setAttribute("alertMessage", "Cập nhật trạng thái thất bại!");
                        session.setAttribute("alertType", "error");
                    }
                    response.sendRedirect("account-management");
                    break;

                case "delete":
                    userId = Integer.parseInt(request.getParameter("id"));
                    if (dao.deleteUser(userId)) {
                        session.setAttribute("alertMessage", "Xóa tài khoản thành công!");
                        session.setAttribute("alertType", "success");
                    } else {
                        session.setAttribute("alertMessage", "Xóa tài khoản thất bại!");
                        session.setAttribute("alertType", "error");
                    }
                    response.sendRedirect("account-management");
                    break;

                default:
                    response.sendRedirect("account-management");
                    break;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("alertMessage", "ID không hợp lệ!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/account_list.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in AccountManagementServlet-doGet: " + e.getMessage());
            request.setAttribute("alertMessage", "Có lỗi xảy ra!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/account_list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Kiểm tra đăng nhập và phân quyền
            HttpSession session = request.getSession();
            Employee currentUser = (Employee) session.getAttribute("staff");
            if (currentUser == null || (currentUser.getRoleId() != 1 && currentUser.getRoleId() != 2)) {
                response.sendRedirect("login-employee");
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                response.sendRedirect("account-management");
                return;
            }

            UserAccountDAO dao = new UserAccountDAO();
            String message = "";

            switch (action) {
                case "create":
                    // Lấy dữ liệu từ form
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String confirmPassword = request.getParameter("confirmPassword");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    int roleId = Integer.parseInt(request.getParameter("roleId"));
                    String status = request.getParameter("status");

                    // Validate
                    if (!password.equals(confirmPassword)) {
                        request.setAttribute("alertMessage", "Mật khẩu và nhập lại mật khẩu không khớp!");
                        request.setAttribute("alertType", "error");

                        // Giữ lại thông tin đã nhập
                        UserAccount user = new UserAccount();
                        user.setName(name);
                        user.setEmail(email);
                        user.setUsername(username);
                        user.setPhone(phone);
                        user.setAddress(address);
                        user.setRoleId(roleId);
                        user.setStatus(status);
                        request.setAttribute("accountUser", user);

                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                        return;
                    }

                    // Kiểm tra email tồn tại
                    if (dao.isEmailExists(email, 0)) {
                        request.setAttribute("alertMessage", "Email đã tồn tại trong hệ thống!");
                        request.setAttribute("alertType", "error");

                        // Giữ lại thông tin đã nhập
                        UserAccount user = new UserAccount();
                        user.setName(name);
                        user.setEmail(email);
                        user.setUsername(username);
                        user.setPhone(phone);
                        user.setAddress(address);
                        user.setRoleId(roleId);
                        user.setStatus(status);
                        request.setAttribute("accountUser", user);

                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                        return;
                    }

                    // Kiểm tra username tồn tại
                    if (dao.isUsernameExists(username, 0)) {
                        request.setAttribute("alertMessage", "Username đã tồn tại trong hệ thống!");
                        request.setAttribute("alertType", "error");

                        // Giữ lại thông tin đã nhập
                        UserAccount user = new UserAccount();
                        user.setName(name);
                        user.setEmail(email);
                        user.setUsername(username);
                        user.setPhone(phone);
                        user.setAddress(address);
                        user.setRoleId(roleId);
                        user.setStatus(status);
                        request.setAttribute("accountUser", user);

                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                        return;
                    }

                    // Tạo tài khoản
                    UserAccount newUser = new UserAccount();
                    newUser.setName(name);
                    newUser.setEmail(email);
                    newUser.setUsername(username);
                    newUser.setPassword(password);
                    newUser.setPhone(phone);
                    newUser.setAddress(address);
                    newUser.setRoleId(roleId);
                    newUser.setStatus(status);

                    if (dao.createUser(newUser)) {
                        session.setAttribute("alertMessage", "Tạo tài khoản thành công!");
                        session.setAttribute("alertType", "success");
                        response.sendRedirect("account-management");
                    } else {
                        request.setAttribute("alertMessage", "Tạo tài khoản thất bại!");
                        request.setAttribute("alertType", "error");
                        request.setAttribute("accountUser", newUser);
                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                    }
                    break;

                case "edit":
                    // Lấy dữ liệu từ form
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    name = request.getParameter("name");
                    email = request.getParameter("email");
                    username = request.getParameter("username");
                    password = request.getParameter("password");
                    phone = request.getParameter("phone");
                    address = request.getParameter("address");
                    roleId = Integer.parseInt(request.getParameter("roleId"));
                    status = request.getParameter("status");

                    // Kiểm tra email tồn tại (loại trừ user hiện tại)
                    if (dao.isEmailExists(email, userId)) {
                        request.setAttribute("alertMessage", "Email đã tồn tại trong hệ thống!");
                        request.setAttribute("alertType", "error");

                        // Giữ lại thông tin đã nhập
                        UserAccount user = new UserAccount();
                        user.setUserId(userId);
                        user.setName(name);
                        user.setEmail(email);
                        user.setUsername(username);
                        user.setPhone(phone);
                        user.setAddress(address);
                        user.setRoleId(roleId);
                        user.setStatus(status);
                        request.setAttribute("accountUser", user);

                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                        return;
                    } // Khi cập nhật tài khoản, không cho phép thay đổi username
                    // Lấy username cũ từ database để đảm bảo không thay đổi
                    UserAccount existingUser = dao.getUserById(userId);
                    if (existingUser == null) {
                        request.setAttribute("alertMessage", "Không tìm thấy tài khoản!");
                        request.setAttribute("alertType", "error");
                        response.sendRedirect("account-management");
                        return;
                    }
                    username = existingUser.getUsername(); // Sử dụng username cũ

                    // Cập nhật tài khoản
                    UserAccount updateUser = new UserAccount();
                    updateUser.setUserId(userId);
                    updateUser.setName(name);
                    updateUser.setEmail(email);
                    updateUser.setUsername(username);
                    updateUser.setPassword(password); // Nếu rỗng, DAO sẽ không cập nhật password
                    updateUser.setPhone(phone);
                    updateUser.setAddress(address);
                    updateUser.setRoleId(roleId);
                    updateUser.setStatus(status);

                    if (dao.updateUser(updateUser)) {
                        session.setAttribute("alertMessage", "Cập nhật tài khoản thành công!");
                        session.setAttribute("alertType", "success");
                        response.sendRedirect("account-management");
                    } else {
                        request.setAttribute("alertMessage", "Cập nhật tài khoản thất bại!");
                        request.setAttribute("alertType", "error");
                        request.setAttribute("accountUser", updateUser);
                        request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
                    }
                    break;

                 case "toggleStatus":
                    userId = Integer.parseInt(request.getParameter("id"));
                    String newStatus = request.getParameter("status");
                    System.out.println("Toggle status for User ID: " + userId + " to status: " + newStatus);
                    
                    if (dao.updateUserStatus(userId, newStatus)) {
                        session.setAttribute("alertMessage", "Cập nhật trạng thái thành công!");
                        session.setAttribute("alertType", "success");
                    } else {
                        session.setAttribute("alertMessage", "Cập nhật trạng thái thất bại!");
                        session.setAttribute("alertType", "error");
                    }
                    response.sendRedirect("account-management?action=list");
                    break;

                default:
                    response.sendRedirect("account-management");
                    return;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("alertMessage", "Dữ liệu không hợp lệ!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in AccountManagementServlet-doPost: " + e.getMessage());
            request.setAttribute("alertMessage", "Có lỗi xảy ra!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/account_form.jsp").forward(request, response);
        }
    }
}
