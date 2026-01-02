package com.edu.springboot.board;

import lombok.Data;

@Data
public class ParameterDTO {
	// 검색어
	private String searchField;
	private String searchWord;
	// 게시물 구간
	private int start;
	private int end;
}
