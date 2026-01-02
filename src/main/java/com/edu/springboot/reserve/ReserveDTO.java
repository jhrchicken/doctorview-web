package com.edu.springboot.reserve;

import java.sql.Date;

import lombok.Data;

@Data
public class ReserveDTO {
	private int app_id;
	private String hospname;
	private String doctorname;
	private String username;
	private String tel;
	private String rrn;
	private String address;
	private Date postdate;
	private String posttime;
	private String alarm;
	private String review;
	private String hide;
	private String user_ref;
	private String hosp_ref;
	private String user_memo;
	private String hosp_memo;
	private String cancel;
	private String hosp_review;
	private String doc_review;
	
	
	//추가컬럼
	private int api_idx;
	private String doc_idx;
}