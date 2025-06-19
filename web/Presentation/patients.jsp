<%-- 
    Document   : patients
    Created on : Jun 18, 2025, 8:57:42 AM
    Author     : trung123
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách bệnh nhân</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            color: #cc0000;
            margin-top: 30px;
        }
        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(204, 0, 0, 0.3);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            width: 20%;
        }
        th {
            background-color: #cc0000;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #ffe6e6;
        }
    </style>
</head>
<body>
    <h2>Danh sách bệnh nhân</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Loại thú cưng</th>
            <th>Email</th>
            <th>Điện thoại</th>
        </tr>
        <c:forEach var="u" items="${patients}">
            <tr>
                <td>${u.userId}</td>
                <td>${u.name}</td>
                <td>${u.animalType}</td> <!-- Thêm property animalType -->
                <td>${u.email}</td>
                <td>${u.phone}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>

