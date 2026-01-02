package com.edu.springboot.doctor;

import lombok.Data;

@Data
public class DoctorDTO {
	private int doc_idx;
	private String name;
	private String major;
	private String career;
	private String photo;
	private String hours;
	private String hosp_ref;
	
	// 추가 컬럼
	private String api_ref;
	private String hospname;
	private int likecount;
	private int reviewcount;
	private double score;
}