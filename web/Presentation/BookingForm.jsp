<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đặt lịch khám</title>
        <meta charset="UTF-8">
        <script>
            function loadAvailableTimes() {
                const doctorId = document.getElementById("doctorId").value;
                const date = document.getElementById("date").value;

                if (!date)
                    return; // Nếu chưa chọn ngày thì không xử lý

                // Xây dựng URL với tham số. Nếu doctorId rỗng thì không truyền tham số đó
                let url = "CheckTime?date=" + date;
                if (doctorId) {
                    url += "&doctorId=" + doctorId;
                }

                fetch(url)
                        .then(res => res.json())
                        .then(times => {
                            const timeSelect = document.getElementById("time");
                            timeSelect.innerHTML = '';
                            if (times.length === 0) {
                                const opt = document.createElement("option");
                                opt.text = "Không còn giờ trống";
                                opt.disabled = true;
                                opt.selected = true;
                                timeSelect.appendChild(opt);
                            } else {
                                times.forEach(t => {
                                    const option = document.createElement("option");
                                    option.value = t;
                                    option.text = t;
                                    timeSelect.appendChild(option);
                                });
                            }
                        });
            }
        </script>

    </head>
    <body>
        <h2>🩺 Đặt lịch khám thú cưng</h2>

        <!-- Hiển thị thông báo nếu có -->
        <c:if test="${param.success eq 'true'}">
            <p style="color:green">✅ Đặt lịch thành công!</p>
        </c:if>
        <c:if test="${not empty param.error}">
            <p style="color:red">❌ ${param.error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/SubmitBooking" method="post">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <p>Họ tên: <input type="text" name="customerName" value="${sessionScope.user.name}" readonly /></p>
                    <p>SĐT: <input type="text" name="phone" value="${sessionScope.user.phone}" readonly /></p>
                    <p>Email: <input type="text" name="email" value="${sessionScope.user.email}" readonly /></p>
                    </c:when>
                    <c:otherwise>
                    <p style="color:red">⚠ Bạn chưa đăng nhập. <a href="Presentation/Login.jsp">Đăng nhập</a></p>
                </c:otherwise>
            </c:choose>

            <p>Chọn thú cưng:
                <select name="petId" required>
                    <c:forEach var="pet" items="${pets}">
                        <option value="${pet.petId}">${pet.name}</option>
                    </c:forEach>
                </select>
            </p>

            <p>
                <label for="service">Chọn dịch vụ:</label><br>
                <select name="serviceId" id="service" required>
                    <option value="">-- Vui lòng chọn dịch vụ --</option>
                    <c:forEach var="s" items="${services}">
                        <option value="${s.serviceId}">${s.serviceName} - ${s.price} VNĐ</option>
                    </c:forEach>
                </select>
            </p>
            
            <p>Chọn bác sĩ:
                <select name="doctorId" id="doctorId" onchange="loadAvailableTimes()">
                    <option value="">-- Không chọn bác sĩ --</option>
                    <c:forEach var="doc" items="${doctors}">
                        <option value="${doc.employeeId}">${doc.name}</option>
                    </c:forEach>
                </select>
            </p>


            <p>Chọn ngày:
                <input type="date" name="date" id="date" onchange="loadAvailableTimes()" required />
            </p>

            <p>Chọn giờ:
                <select name="time" id="time" required>
                    <option selected disabled>-- Chọn giờ --</option>
                </select>
            </p>

            <p>Ghi chú:
                <textarea name="note" rows="3" cols="40" placeholder="Triệu chứng hoặc yêu cầu thêm..."></textarea>
            </p>

            <button type="submit">✅ Xác nhận đặt lịch</button>
        </form>
    </body>
</html>
