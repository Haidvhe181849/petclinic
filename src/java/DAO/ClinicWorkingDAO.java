package DAO;

/**
 *
 * @author quang
 */
import Entity.ClinicWorking;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ClinicWorkingDAO {

    private final Connection conn;

    public ClinicWorkingDAO(Connection conn) {
        this.conn = conn;
    }

    public ClinicWorking getByDayOfWeek(int dayOfWeek) throws SQLException {
        String sql = "SELECT * FROM ClinicWorking WHERE day_of_week = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dayOfWeek);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ClinicWorking(
                        rs.getInt("id"),
                        rs.getInt("day_of_week"),
                        rs.getTime("start_time").toLocalTime(),
                        rs.getTime("end_time").toLocalTime(),
                        rs.getBoolean("is_active")
                );
            }
        }
        return null;
    }

    public List<ClinicWorking> getAll() throws SQLException {
        List<ClinicWorking> list = new ArrayList<>();
        String sql = "SELECT * FROM ClinicWorking ORDER BY day_of_week";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new ClinicWorking(
                        rs.getInt("id"),
                        rs.getInt("day_of_week"),
                        rs.getTime("start_time").toLocalTime(),
                        rs.getTime("end_time").toLocalTime(),
                        rs.getBoolean("is_active")
                ));
            }
        }
        return list;
    }

    public void update(ClinicWorking cw) throws SQLException {
        String sql = "UPDATE ClinicWorking SET start_time = ?, end_time = ?, is_active = ? WHERE day_of_week = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTime(1, Time.valueOf(cw.getStartTime()));
            stmt.setTime(2, Time.valueOf(cw.getEndTime()));
            stmt.setBoolean(3, cw.isActive());
            stmt.setInt(4, cw.getDayOfWeek());
            stmt.executeUpdate();
        }
    }

    public void insert(ClinicWorking cw) throws SQLException {
        String sql = "INSERT INTO ClinicWorking (day_of_week, start_time, end_time, is_active) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cw.getDayOfWeek());
            stmt.setTime(2, Time.valueOf(cw.getStartTime()));
            stmt.setTime(3, Time.valueOf(cw.getEndTime()));
            stmt.setBoolean(4, cw.isActive());
            stmt.executeUpdate();
        }
    }

    public void deleteByDay(int dayOfWeek) throws SQLException {
        String sql = "DELETE FROM ClinicWorking WHERE day_of_week = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dayOfWeek);
            stmt.executeUpdate();
        }
    }

    public List<String> getValidTimeSlotsByDate(LocalDate date) throws SQLException {
    List<String> slots = new ArrayList<>();
    int dayOfWeek = date.getDayOfWeek().getValue(); // Monday = 1, ..., Sunday = 7
    if (dayOfWeek == 7) dayOfWeek = 0; // Đổi về đúng với `day_of_week` trong DB

    String sql = "SELECT start_time, end_time FROM ClinicWorking WHERE day_of_week = ? AND is_active = 1";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, dayOfWeek);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                LocalTime start = rs.getTime("start_time").toLocalTime();
                LocalTime end = rs.getTime("end_time").toLocalTime();
                while (!start.isAfter(end.minusMinutes(30))) {
                    slots.add(start.format(DateTimeFormatter.ofPattern("HH:mm")));
                    start = start.plusMinutes(30);
                }
            }
        }
    }
    return slots;
}


}
