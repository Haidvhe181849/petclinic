<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.ClinicWorking" %>

<%
    List<ClinicWorking> workingList = (List<ClinicWorking>) request.getAttribute("workingList");
    String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
%>

<h2>Clinic Working Schedule</h2>

<form action="${pageContext.request.contextPath}/ClinicWorking" method="post">
    <table border="1" cellpadding="8">
        <tr>
            <th>Day</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Active</th>
            <th>Action</th>
        </tr>

        <% for (ClinicWorking cw : workingList) { %>
        <tr>
            <td><%= days[cw.getDayOfWeek()] %></td>

            <td>
                <input type="time" name="day<%= cw.getDayOfWeek() %>_start"
                       value="<%= cw.getStartTime() %>">
            </td>

            <td>
                <input type="time" name="day<%= cw.getDayOfWeek() %>_end"
                       value="<%= cw.getEndTime() %>">
            </td>

            <td>
                <input type="checkbox" name="day<%= cw.getDayOfWeek() %>_active"
                       <%= cw.isActive() ? "checked" : "" %>>
            </td>

            <td>
                <button type="submit" name="updateDay" value="<%= cw.getDayOfWeek() %>">Update</button>
            </td>
        </tr>
        <% } %>
    </table>
</form>
