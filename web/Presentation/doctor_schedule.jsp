<%-- 
    Document   : doctor_schedule
    Created on : Jun 18, 2025, 8:55:36 AM
    Author     : trung123
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Lịch Khám của Bác sĩ</title>
    <style>
        body {
            font-family: Arial;
            background-color: #fff;
        }

        h2 {
            text-align: center;
            color: #cc0000;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #cc0000;
            color: white;
        }

        .action-btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
        }

        .accept {
            background-color: #28a745;
        }

        .decline {
            background-color: #dc3545;
        }
    </style>
</head>
<body>    
    <c:if test="${not empty sessionScope.message}">
    <div style="color: green; text-align: center; font-weight: bold;">
        ${sessionScope.message}
    </div>
    <c:remove var="message" scope="session" />
    </c:if>

   <h2>Lịch khám hôm nay</h2>

<c:if test="${not empty schedule}">
    <table>
        <tr>
            <th>ID Lịch</th>
            <th>Khách hàng</th>
            <th>Thú cưng</th>
            <th>Thời gian</th>
            <th>Ghi chú</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>

        <c:forEach var="b" items="${schedule}">
            <tr>
                <td>${b.bookingId}</td>
                <td>${b.userId}</td>
                <td>${b.petId}</td>
                <td>${b.bookingTime}</td>
                <td>${b.note}</td>
                <td>${b.status}</td>
                <td>
                    <form method="post" action="${pageContext.request.contextPath}/doctor/manage-schedule">
                        <input type="hidden" name="bookingId" value="${b.bookingId}" />
                        <button type="submit" name="action" value="accept" class="action-btn accept">Chấp nhận</button>
                        <button type="submit" name="action" value="decline" class="action-btn decline">Từ chối</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<c:if test="${empty schedule}">
    <p style="text-align: center; color: gray;">Không có lịch khám nào.</p>
</c:if>

</body>
</html>

<script>
    setTimeout(() => {
        const msgBox = document.querySelector("div[style*='margin-bottom']");
        if (msgBox) {
            msgBox.style.transition = "opacity 0.5s ease-out";
            msgBox.style.opacity = 0;
            setTimeout(() => msgBox.remove(), 500);
        }
    }, 3000); // 3 giây
</script>

</html>
