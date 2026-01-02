package com.edu.springboot.emoji;

import lombok.Data;

@Data
public class EmojiDTO {
	private int emoji_idx;
	private String user_ref;
	private int store_ref;
	
	// 추가 컬럼
	private int price;
	private String emoji;
	private String title;
	private String descr;
}