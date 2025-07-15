package Entity;

import java.time.LocalTime;

/**
 *
 * @author quang
 */
public class ClinicWorking {

    private int id;
    private int dayOfWeek;           // 0 = Sunday, 1 = Monday, ..., 6 = Saturday
    private LocalTime startTime;
    private LocalTime endTime;
    private boolean isActive;

    public ClinicWorking() {
    }

    public ClinicWorking(int id, int dayOfWeek, LocalTime startTime, LocalTime endTime, boolean isActive) {
        this.id = id;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDayOfWeek(int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
