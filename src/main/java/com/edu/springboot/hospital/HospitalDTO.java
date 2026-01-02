package com.edu.springboot.hospital;

import lombok.Data;

@Data
public class HospitalDTO {
	// API
	private int api_idx;
	private String name;
	private String department;
	private String tel;
	private String address;
	
	private String enter;
	
	// 필수 정보
	private String id;
	private String password;
	private String nickname;
	private String taxid;
	                                                                                                                       
	// 상세 정보
	private String photo;
	private String introduce;
	private String parking;
	private String pcr;
	private String hospitalize;
	private String system;
	private String open;
	private String night;
	private String weekend;

	// 추가
	private double score;
	private int likecount;
	private int reviewcount;
	private String distance;
	
}

