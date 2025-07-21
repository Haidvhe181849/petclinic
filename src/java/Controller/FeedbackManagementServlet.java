package Controller;

import DAO.FeedbackDAO;
import Entity.Feedback;
import Entity.UserAccount;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "FeedbackManagementServlet", urlPatterns = { "/feedback-management" })
public class FeedbackManagementServlet extends HttpServlet {

    private static final int FEEDBACKS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Kiểm tra đăng nhập và phân quyền
            HttpSession session = request.getSession();
            UserAccount user = (UserAccount) session.getAttribute("user");
            if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
                response.sendRedirect("login");
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            FeedbackDAO dao = new FeedbackDAO();
            String message = null;
            String messageType = null;

            switch (action) {
                case "list":
                    // Get pagination parameters
                    int page = 1;
                    String pageStr = request.getParameter("page");
                    if (pageStr != null && !pageStr.isEmpty()) {
                        try {
                            page = Integer.parseInt(pageStr);
                            if (page < 1) page = 1;
                        } catch (NumberFormatException e) {
                            page = 1;
                        }
                    }
                    
                    // Get total count of feedbacks
                    int totalFeedbacks = dao.getTotalFeedbackCount();
                    int totalPages = (int) Math.ceil((double) totalFeedbacks / FEEDBACKS_PER_PAGE);
                    if (page > totalPages && totalPages > 0) {
                        page = totalPages;
                    }
                    
                    // Get paginated feedbacks
                    List<Feedback> feedbacks = dao.getFeedbacksByPage(page, FEEDBACKS_PER_PAGE);
                    
                    System.out.println("FeedbackManagementServlet: Retrieved "
                            + (feedbacks != null ? feedbacks.size() : "null") + " feedbacks");
                    
                    request.setAttribute("feedbacks", feedbacks);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("feedbacksPerPage", FEEDBACKS_PER_PAGE);
                    request.getRequestDispatcher("Presentation/feedback_list.jsp").forward(request, response);
                    break;
                case "detail":
                    int id = Integer.parseInt(request.getParameter("id"));
                    System.out.println("FeedbackManagementServlet: Getting feedback detail for ID: " + id);

                    Feedback feedback = dao.getFeedbackById(id);
                    if (feedback != null) {
                        System.out.println("FeedbackManagementServlet: Found feedback - ID: " + feedback.getFeedbackId()
                                + ", Text: " + feedback.getFeedbackText()
                                + ", User: " + feedback.getUserName()
                                + ", Rating: " + feedback.getStarRating());

                        request.setAttribute("feedback", feedback);
                        // Forward any session message to request scope
                        String sessionMessage = (String) session.getAttribute("alertMessage");
                        String sessionType = (String) session.getAttribute("alertType");
                        if (sessionMessage != null) {
                            request.setAttribute("alertMessage", sessionMessage);
                            request.setAttribute("alertType", sessionType);
                            session.removeAttribute("alertMessage");
                            session.removeAttribute("alertType");
                        }
                        request.getRequestDispatcher("Presentation/feedback_detail.jsp").forward(request, response);
                    } else {
                        System.out.println("FeedbackManagementServlet: No feedback found with ID: " + id);
                        message = "Không tìm thấy feedback với ID: " + id;
                        messageType = "error";
                        session.setAttribute("alertMessage", message);
                        session.setAttribute("alertType", messageType);
                        response.sendRedirect("feedback-management?action=list");
                    }
                    break;

                case "toggle":
                    id = Integer.parseInt(request.getParameter("id"));
                    boolean visible = Boolean.parseBoolean(request.getParameter("visible"));
                    if (dao.toggleVisibility(id, visible)) {
                        message = "Cập nhật trạng thái thành công!";
                        messageType = "success";
                    } else {
                        message = "Cập nhật trạng thái thất bại!";
                        messageType = "error";
                    }
                    response.sendRedirect("feedback-management?action=list");
                    break;

                default:
                    response.sendRedirect("feedback-management?action=list");
                    break;
            }

            if (message != null) {
                session.setAttribute("alertMessage", message);
                session.setAttribute("alertType", messageType);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("alertMessage", "ID không hợp lệ!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/feedback_list.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in FeedbackManagementServlet-doGet: " + e.getMessage());
            request.setAttribute("alertMessage", "Có lỗi xảy ra!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/feedback_list.jsp").forward(request, response);
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
            UserAccount user = (UserAccount) session.getAttribute("user");
            if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
                response.sendRedirect("login");
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                response.sendRedirect("feedback-management?action=list");
                return;
            }

            FeedbackDAO dao = new FeedbackDAO();
            String message = null;
            String messageType = null;

            switch (action) {
                case "reply":
                    int id = Integer.parseInt(request.getParameter("id"));
                    String replyText = request.getParameter("replyText");

                    if (replyText == null || replyText.trim().isEmpty()) {
                        message = "Nội dung phản hồi không được để trống!";
                        messageType = "error";
                    } else if (dao.replyToFeedback(id, replyText.trim())) {
                        message = "Gửi phản hồi thành công!";
                        messageType = "success";
                    } else {
                        message = "Gửi phản hồi thất bại!";
                        messageType = "error";
                    }
                    response.sendRedirect("feedback-management?action=detail&id=" + id);
                    break;

                default:
                    response.sendRedirect("feedback-management?action=list");
                    break;
            }

            if (message != null) {
                session.setAttribute("alertMessage", message);
                session.setAttribute("alertType", messageType);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("alertMessage", "ID không hợp lệ!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/feedback_list.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in FeedbackManagementServlet-doPost: " + e.getMessage());
            request.setAttribute("alertMessage", "Có lỗi xảy ra!");
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("Presentation/feedback_list.jsp").forward(request, response);
        }
    }
}
