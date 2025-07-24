package Controller;

import DAO.UserDAO;
import Entity.UserAccount;
import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import org.json.JSONObject;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {

    
    private static final String CLIENT_ID = "591468416411-bnfsuhr21g4vfth1pt534emgp5qenqvt.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/PetClinic/google-login";
    private static final String SCOPE = "profile email";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        OAuth20Service service = new ServiceBuilder(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .defaultScope(SCOPE)
                .callback(REDIRECT_URI)
                .build(GoogleApi20.instance());

        if (code == null) {
            // Bước 1: Chưa có mã code → chuyển hướng sang trang xác thực của Google
            String authorizationUrl = service.getAuthorizationUrl();
            response.sendRedirect(authorizationUrl);
        } else {
            // Bước 2: Đã có mã code → lấy Access Token và thông tin người dùng
            try {
                OAuth2AccessToken accessToken = service.getAccessToken(code);

                OAuthRequest oauthRequest = new OAuthRequest(Verb.GET, "https://www.googleapis.com/oauth2/v2/userinfo");
                service.signRequest(accessToken, oauthRequest);

                Response oauthResponse = service.execute(oauthRequest);

                if (oauthResponse.getCode() == 200) {
                    String body = oauthResponse.getBody();

                    // Phân tích JSON để lấy email và tên người dùng
                    JSONObject json = new JSONObject(body);
                    String email = json.getString("email");
                    String name = json.getString("name");

                    UserDAO userDAO = new UserDAO();
                    UserAccount user = userDAO.getUserByEmail(email);
                    
                    if (user == null) {
                        // Tạo user mới nếu chưa có trong DB
                        user = new UserAccount();
                        user.setName(name);
                        user.setEmail(email);
                        user.setUsername(email); // Sử dụng email làm username
                        user.setPassword(""); // Password rỗng cho Google login
                        user.setPhone(""); // Phone rỗng, có thể cập nhật sau
                        user.setAddress(""); // Address rỗng, có thể cập nhật sau
                        user.setRoleId(4); // Role mặc định (ví dụ: 3 = customer)
                        user.setStatus("Active"); // Status active
                        
                        boolean isRegistered = userDAO.register(user);
                        if (isRegistered) {
                            // Lấy lại user từ DB để có user_id
                            user = userDAO.getUserByEmail(email);
                        } else {
                            response.getWriter().println("Lỗi tạo tài khoản người dùng");
                            return;
                        }
                    }
                    
                    // Kiểm tra status của tài khoản
                    if ("Inactive".equals(user.getStatus())) {
                        response.getWriter().println("Tài khoản của bạn đã bị vô hiệu hóa. Vui lòng liên hệ quản trị viên!");
                        return;
                    }

                    // Set session như LoginServlet
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);

                    response.sendRedirect("Home");

//                    response.sendRedirect(request.getContextPath() + "/Presentation/Home.jsp");
                } else {
                    response.getWriter().println("Lỗi xác thực Google: " + oauthResponse.getBody());
                }
            } catch (InterruptedException | ExecutionException e) {
                throw new ServletException("Lỗi xử lý OAuth", e);
            }
        }
    }
}
