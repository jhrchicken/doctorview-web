package com.edu.springboot.member;

import lombok.Data;

@Data
public class DoctorDTO {
	private String doc_idx;
	private String name;
	private String major;
	private String career;
	private String photo;
	private String hours;
	private String hosp_ref;
	
	// 추가 컬럼
	private String doctorname;
}