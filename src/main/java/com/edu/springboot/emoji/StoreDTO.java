package com.edu.springboot.emoji;

import lombok.Data;

@Data
public class StoreDTO {
	private int store_idx;
	private int price;
	private String emoji;
	private String title;
	private String descr;
	private String type;
}