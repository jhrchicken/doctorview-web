package com.edu.springboot.hospital;

import lombok.Data;

@Data
public class HospitalAppDTO {
	private String id;
	private String name;
	private String nickname;
	private String tel;
	private String address;
	private String department;
	
	private String pcr;
	private String system;
}
