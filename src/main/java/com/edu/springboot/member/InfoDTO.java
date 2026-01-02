package com.edu.springboot.member;

import lombok.Data;

// 메일 작성폼과 동일하게 DTO 구성
@Data
public class InfoDTO {

	private String mailServer;
	private String form;
	private String to;
	private String subject;
	private String format;
	private String content;
}
