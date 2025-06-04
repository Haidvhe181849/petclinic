<%-- 
    Document   : ManageAboutUsAdmin
    Created on : Jun 3, 2025, 8:28:59 AM
    Author     : trung123
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.List, Entity.AboutUs" %>
<%
    session.setAttribute("role", "admin");

    String url = "jdbc:sqlserver://localhost:1433;databaseName=PetHospital;encrypt=false";
    String dbUser = "sa";
    String dbPass = "123";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String role = (String) session.getAttribute("role");
    if (role == null) role = "customer";

    String action = request.getParameter("action");
    String id = request.getParameter("about_id");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String description = request.getParameter("description");

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        if ("admin".equals(role)) {
            if ("add".equals(action)) {
                ps = conn.prepareStatement("INSERT INTO AboutUs VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, id);
                ps.setString(2, address);
                ps.setString(3, phone);
                ps.setString(4, email);
                ps.setString(5, description);
                ps.executeUpdate();
                response.sendRedirect("ManageAboutUsAdmin.jsp");
                return;
            } else if ("edit".equals(action)) {
                ps = conn.prepareStatement("UPDATE AboutUs SET address=?, phone=?, email=?, description=? WHERE about_id=?");
                ps.setString(1, address);
                ps.setString(2, phone);
                ps.setString(3, email);
                ps.setString(4, description);
                ps.setString(5, id);
                ps.executeUpdate();
                response.sendRedirect("ManageAboutUsAdmin.jsp");
                return;
            } else if ("delete".equals(action)) {
                ps = conn.prepareStatement("DELETE FROM AboutUs WHERE about_id=?");
                ps.setString(1, id);
                ps.executeUpdate();
                response.sendRedirect("ManageAboutUsAdmin.jsp");
                return;
            }
        }

        ps = conn.prepareStatement("SELECT * FROM AboutUs");
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý About Us</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-image: url('https://petnhatrang.com/wp-content/uploads/2016/07/1527681338-485.png');
            background-size: cover;
            background-position: center;
            color: #222;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: darkred;
            background: rgba(255, 255, 255, 0.8);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.9);
        }

        th, td {
            border: 1px solid #cc0000;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f8d7da;
        }

        .admin-form {
            background: rgba(255, 255, 255, 0.9);
            width: 60%;
            margin: 30px auto;
            padding: 20px;
            border-radius: 10px;
        }

        input, textarea {
            width: 95%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #cc0000;
            border-radius: 5px;
            font-size: 1em;
        }

        input[type="submit"] {
            background-color: #cc0000;
            color: white;
            cursor: pointer;
        }

        a {
            color: #cc0000;
            margin-right: 10px;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Quản lý thông tin About Us</h2>

    <% if ("admin".equals(role)) {
        String editId = request.getParameter("editId");
        String editAddress = "", editPhone = "", editEmail = "", editDesc = "";
        if (editId != null) {
            PreparedStatement psEdit = conn.prepareStatement("SELECT * FROM AboutUs WHERE about_id=?");
            psEdit.setString(1, editId);
            ResultSet rsEdit = psEdit.executeQuery();
            if (rsEdit.next()) {
                editAddress = rsEdit.getString("address");
                editPhone = rsEdit.getString("phone");
                editEmail = rsEdit.getString("email");
                editDesc = rsEdit.getString("description");
            }
            rsEdit.close(); psEdit.close();
    %>
    <form class="admin-form" method="post">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="about_id" value="<%= editId %>">
        <input name="address" placeholder="Địa chỉ" value="<%= editAddress %>" required><br>
        <input name="phone" placeholder="Số điện thoại" value="<%= editPhone %>" required><br>
        <input name="email" placeholder="Email" value="<%= editEmail %>" required><br>
        <textarea name="description" rows="3" placeholder="Mô tả"><%= editDesc %></textarea><br>
        <input type="submit" value="Cập nhật">
    </form>
    <% } else { %>
    <form class="admin-form" method="post">
        <input type="hidden" name="action" value="add">
        <input name="about_id" placeholder="Mã ID" required><br>
        <input name="address" placeholder="Địa chỉ"><br>
        <input name="phone" placeholder="Số điện thoại"><br>
        <input name="email" placeholder="Email"><br>
        <textarea name="description" rows="3" placeholder="Mô tả"></textarea><br>
        <input type="submit" value="Thêm mới">
    </form>
    <% }} %>

    <table>
        <tr>
            <th>ID</th><th>Địa chỉ</th><th>Điện thoại</th><th>Email</th><th>Mô tả</th>
            <% if ("admin".equals(role)) { %><th>Hành động</th><% } %>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("about_id") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("description") %></td>
            <% if ("admin".equals(role)) { %>
            <td>
                <a href="ManageAboutUsAdmin.jsp?editId=<%= rs.getString("about_id") %>">Sửa</a>
                <a href="ManageAboutUsAdmin.jsp?action=delete&about_id=<%= rs.getString("about_id") %>" onclick="return confirm('Xác nhận xóa?')">Xóa</a>
            </td>
            <% } %>
        </tr>
        <% } %>
    </table>
</body>
</html>

<%
    } catch (Exception e) {
        out.println("<script>alert('Lỗi: " + e.getMessage() + "');</script>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
