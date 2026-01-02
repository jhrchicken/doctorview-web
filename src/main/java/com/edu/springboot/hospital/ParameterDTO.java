package com.edu.springboot.hospital;

import java.util.List;

import lombok.Data;

@Data
public class ParameterDTO {
	// 지역 선택
	private String searchSido;
	private String searchGugun;
	private String searchDong;
	
	// 검색어
	private String searchField;
	private String searchWord;
	
	// 필터
	private List<String> filters;

	// 게시물 구간
	private int offset;
	private int limit;
}
