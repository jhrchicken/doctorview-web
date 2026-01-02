package com.edu.springboot.mypage;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.doctor.DreviewDTO;
import com.edu.springboot.hospital.HospitalDTO;
import com.edu.springboot.hospital.HreviewDTO;

@Mapper
public interface IMypageService {

	// 찜한 병원
	// 찜한 병원의 개수를 카운트
	public int countMyHosp(String id);
	// 찜한 병원 목록
	public ArrayList<HospitalDTO> listMyHosp(String id, int start, int end);
	
	
	// 찜한 의사
	// 찜한 의사의 개수를 카운트
	public int countMyDoctor(String id);
	// 찜한 의사 목록
	public ArrayList<DoctorDTO> listMyDoctor(String id, int start, int end);

	
	// 작성한 리뷰
	// 작성한 병원 리뷰
	public ArrayList<HreviewDTO> listMyHreview(String id);
	// 작성한 의사 리뷰
	public ArrayList<DreviewDTO> listMyDreview(String id);
	
	
}
