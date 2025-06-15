<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Page</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .form-container { display: flex; flex-wrap: wrap; gap: 20px; }
        .form-left, .form-right { flex: 1; min-width: 280px; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: bold; }
        input[type="text"], input[type="email"], input[type="date"], select, textarea {
            width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc; margin-top: 5px;
        }
        .pet-image img, #doctorImage { max-width: 150px; margin-top: 10px; }
        select option[disabled] { color: gray; }
    </style>
</head>
<body>
<h2>Pet Service Appointment</h2>

<c:if test="${not empty error}"><div style="color:red">${error}</div></c:if>
<c:if test="${not empty success}"><div style="color:green">${success}</div></c:if>

<form id="timeReloadForm" action="${pageContext.request.contextPath}/LoadBookingTimes" method="post" style="display:none;">
    <input type="hidden" name="doctorSelect" id="hiddenDoctorId">
    <input type="hidden" name="appointmentDate" id="hiddenDate">
    <input type="hidden" name="description" id="hiddenDescription">
    <input type="hidden" name="petId" id="hiddenPetId">
    <input type="hidden" name="customerName" id="hiddenCustomerName">
    <input type="hidden" name="phone" id="hiddenPhone">
    <input type="hidden" name="email" id="hiddenEmail">
    <input type="hidden" name="address" id="hiddenAddress">
    <input type="hidden" name="appointmentTime" id="hiddenAppointmentTime">
</form>

<form id="mainBookingForm" action="${pageContext.request.contextPath}/Booking" method="post">
    <div class="form-container">
        <div class="form-left">
            <div class="form-group">
                <label>Customer Name:</label>
                <input type="text" name="customerName" value="${customerName != null ? customerName : sessionScope.user.name}" required>
            </div>
            <div class="form-group">
                <label>Phone Number:</label>
                <input type="text" name="phone" value="${phone != null ? phone : sessionScope.user.phone}" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" value="${email != null ? email : sessionScope.user.email}" required>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" value="${address != null ? address : sessionScope.user.address}" required>
            </div>
            <div class="form-group">
                <label>Choose Pet:</label><br/>
                <c:forEach var="pet" items="${pets}" varStatus="loop">
                    <input type="radio" id="pet_${pet.petId}" name="petId" value="${pet.petId}"
                           onclick="document.getElementById('petImage').src = '${pet.image}'"
                           <c:if test="${pet.petId == petId || (empty petId && loop.first)}">checked</c:if>>
                    <label for="pet_${pet.petId}">${pet.name}</label><br/>
                </c:forEach>
                <div class="pet-image">
                    <c:forEach var="pet" items="${pets}" varStatus="loop">
                        <c:if test="${pet.petId == petId || (empty petId && loop.first)}">
                            <img id="petImage" src="${pet.image}" alt="Pet Image" style="display:block;" />
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="form-right">
            <div class="form-group">
                <label>Note:</label>
                <textarea name="description" rows="3" required>${description != null ? description : ''}</textarea>
            </div>
            <div class="form-group">
                <label>Choose Doctor:</label>
                <select id="doctorSelect" name="doctorSelect" onchange="submitTimeReload()">
                    <option value="">No choose</option>
                    <c:forEach var="doctor" items="${doctors}">
                        <option value="${doctor.employeeId}" data-image="${doctor.image}"
                                <c:if test="${selectedDoctor == doctor.employeeId}">selected</c:if>>
                            ${doctor.name}</option>
                    </c:forEach>
                </select>
                <div>
                    <img id="doctorImage" src="" alt="Doctor Image" style="display:none;" />
                    <p id="doctorNameDisplay" style="font-weight: bold;"></p>
                </div>
            </div>
            <div class="form-group">
                <label>Choose Date:</label>
                <input type="date" id="appointmentDate" name="appointmentDate" value="${selectedDate}" onchange="submitTimeReload()" required>
            </div>
            <div class="form-group">
                <label>Choose Time:</label>
                <select name="appointmentTime" id="appointmentTime" required>
                    <option value="">-- Choose Time --</option>
                    <c:forEach var="time" items="${fn:split('07:00,08:00,09:00,10:00,11:00,13:00,14:00,15:00,16:00,17:00', ',')}">
                        <c:set var="isBooked" value="false" />
                        <c:if test="${not empty bookedTimes}">
                            <c:forEach var="b" items="${bookedTimes}">
                                <c:if test="${b == time}"><c:set var="isBooked" value="true" /></c:if>
                            </c:forEach>
                        </c:if>
                        <option value="${time}"
                                <c:if test="${isBooked}">disabled</c:if>
                                <c:if test="${appointmentTime == time}">selected</c:if>>
                            ${time} <c:if test="${isBooked}">(Booked)</c:if>
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <div style="text-align:center; margin-top:20px">
        <input type="submit" value="Đặt lịch" style="padding: 10px 30px; background-color: green; color: white; border:none; border-radius:6px; cursor:pointer;"/>
    </div>
</form>

<script>
    window.onload = function () {
        const doctorSelect = document.getElementById('doctorSelect');
        if (doctorSelect) {
            const selectedOption = doctorSelect.options[doctorSelect.selectedIndex];
            const imageUrl = selectedOption.getAttribute("data-image");
            const doctorImage = document.getElementById("doctorImage");
            const doctorName = document.getElementById("doctorNameDisplay");
            if (imageUrl) {
                doctorImage.src = imageUrl;
                doctorImage.style.display = "block";
                doctorName.innerText = selectedOption.text;
            }
        }
    }

    function submitTimeReload() {
        const doctorSelect = document.getElementById("doctorSelect");
        const dateInput = document.getElementById("appointmentDate");

        if (!doctorSelect.value || !dateInput.value) return;

        const nameInput = document.querySelector("input[name='customerName']");
        const phoneInput = document.querySelector("input[name='phone']");
        const emailInput = document.querySelector("input[name='email']");
        const addressInput = document.querySelector("input[name='address']");
        const descriptionInput = document.querySelector("textarea[name='description']");
        const appointmentTimeSelect = document.querySelector("select[name='appointmentTime']");
        const petRadio = document.querySelector("input[name='petId']:checked");

        console.log("Customer Name:", nameInput?.value);
        console.log("Phone:", phoneInput?.value);
        console.log("Email:", emailInput?.value);
        console.log("Address:", addressInput?.value);
        console.log("Description:", descriptionInput?.value);
        console.log("Appointment Time:", appointmentTimeSelect?.value);
        console.log("Pet ID:", petRadio?.value);

        document.getElementById("hiddenDoctorId").value = doctorSelect.value;
        document.getElementById("hiddenDate").value = dateInput.value;
        document.getElementById("hiddenDescription").value = descriptionInput?.value || "";
        document.getElementById("hiddenPetId").value = petRadio?.value || "";
        document.getElementById("hiddenCustomerName").value = nameInput?.value || "";
        document.getElementById("hiddenPhone").value = phoneInput?.value || "";
        document.getElementById("hiddenEmail").value = emailInput?.value || "";
        document.getElementById("hiddenAddress").value = addressInput?.value || "";
        document.getElementById("hiddenAppointmentTime").value = appointmentTimeSelect?.value || "";

        document.getElementById("timeReloadForm").submit();
    }
</script>

</body>
</html>
