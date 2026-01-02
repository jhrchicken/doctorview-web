package com.edu.springboot.member;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class HoursDTO {
	private String hours_idx;
	private String week;
	private String starttime;
	private String endtime;
	private String startbreak;
	private String endbreak;
	private String deadline; 
	private String hosp_ref;
	private String open_week;
	private String weekend;
	private String night;
	private String open;
	
	// 30분단위 시간 계산
	public List<LocalTime> generateTimeSlots() {
		List<LocalTime> timeSlots = new ArrayList<>();
		LocalTime currentTime = LocalTime.parse(starttime);
		
		// 휴게 시간 확인
	    LocalTime startBreak = LocalTime.parse(startbreak);
	    LocalTime endBreak = LocalTime.parse(endbreak);
		
        while (currentTime.isBefore(LocalTime.parse(deadline)) || currentTime.equals(LocalTime.parse(deadline))) {
			if (currentTime.isBefore(startBreak) || currentTime.isAfter(endBreak) || currentTime.equals(endBreak)) {
				timeSlots.add(currentTime);
			}
			currentTime = currentTime.plusMinutes(30);
        }
		
        return timeSlots;
    }
	

	
	
	
}