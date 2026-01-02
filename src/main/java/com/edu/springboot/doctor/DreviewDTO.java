package com.edu.springboot.doctor;

import java.sql.Date;

import lombok.Data;

@Data
public class DreviewDTO {
	private int review_idx;
	private int original_idx;
	private Date postdate;
	private int score;
	private String content;
	private String rewrite;
	private String writer_ref;
	private int doc_ref;
	
	// 추가
	private String nickname;
	private int likecount;
	private int likecheck;
	
	// 작성한 리뷰
	private String doc_name;
	private String hospname;
	private String app_id;
}