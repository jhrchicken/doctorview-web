package com.edu.springboot.member;

import lombok.Data;

@Data
public class LikesDTO {
	private int like_idx;
	private String member_ref;
	private String tablename;
	private String recodenum;
}
