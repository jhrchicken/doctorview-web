package com.edu.springboot.hospital;

import java.sql.Date;

import lombok.Data;

@Data
public class HreviewDTO {
	private int review_idx;
	private int original_idx;
	private Date postdate;
	private int score;
	private String content;
	private String cost;
	private String treat;
	private String doctor;
	private String rewrite;
	private String writer_ref;
	private int api_ref;
	
	private String nickname;
	private int likecheck;
	private int likecount;
	
	// api용 추가 컬럼
	private String hosp_ref;
	
	// 작성한 리뷰용 추가 컬럼
	private String hosp_name;
	private String hosp_department;
	private String app_id;
}