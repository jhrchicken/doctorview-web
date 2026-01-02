package com.edu.springboot.reserve;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.doctor.DreviewDTO;
import com.edu.springboot.hospital.HreviewDTO;
import com.edu.springboot.member.MemberDTO;

@Mapper
public interface IReserveService {
	
	// 예약 목록
	public List<ReserveDTO> getAllReservations();
	
	// 예약할 병원 정보
	public MemberDTO getHospital(ReserveDTO reserveDTO);
	public MemberDTO getMyHospital(MemberDTO memberDTO);
	// 예약할 병원의 의사 정보
	public List<DoctorDTO> getDoctor(String hosp_ref);

	// 예약 정보 저장
	public int saveReservationInfo(ReserveDTO reserveDTO);
	
	// 예약 목록 가져옴
	public List<ReserveDTO> getReservationInfo(@Param("user_ref") String user_ref, @Param("hosp_ref") String hosp_ref);
	
	// 특정 날짜, 특정시간의 예약내역 개수
	public int getReservationCount(String hosp_ref, String postdate, String posttime, @Param("app_id") int app_id);
	

	
	//예약 목록 페이징(관리자모드)
	public int getCountReservationInfo();
	public List<ReserveDTO> getAllReservationInfo(ParameterDTO parameterDTO);
	public int changeReserve(String app_id, String cancel);
	
	// 선택한 예약 정보 가져옴
	public ReserveDTO getReservationDetails(int app_id);
	// 예약 메모 추가
	public int updateReservationDetails(@Param("app_id") int app_id, @Param("user_memo") String user_memo, @Param("hosp_memo") String hosp_memo);
	
	// 예약 취소
	public int cancelReservation(ReserveDTO reserveDTO);

	// 에약내역 숨김
	public int hideReservation(ReserveDTO reserveDTO);
	
	
	// open, close 예약내역 (예약관리)
	public int getReservationHospital(String hosp_ref, String postdate, String posttime);
	public int getReservationAdmin(String hosp_ref, String postdate, String posttime);
	
	
	
	
	public int getHospitalAppId(String hosp_ref, String postdate, String posttime);
	
	
	
	// 예약시간 close
	public int deleteOpenTime(ReserveDTO reserveDTO);
	public int closeTime(ReserveDTO reserveDTO);
	
	// 예약시간 open
	public int deleteCloseTime(ReserveDTO reserveDTO);
	public int openTime(ReserveDTO reserveDTO);
	
	// 특정 예약의 병원 리뷰 작성 여부를 변경
	public int updateHospReviewFlag(String appId);
	// 특정 예약의 의사 리뷰 작성 여부를 변경
	public int updateDocReviewFlag(String appId);
}