package com.edu.springboot.member;

import lombok.Data;

@Data
public class ReportDTO {
	private int report_idx;
	private String member_ref;
	private int board_ref;
}
