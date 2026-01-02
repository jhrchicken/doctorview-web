package com.edu.springboot.hospital;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;

@Mapper
public interface IHospitalService {
	
	// == 병원 API ==
	// 병원 API 개수 카운트
	public int countHospApi(ParameterDTO parameterDTO);
	// 한 페이지에 출력할 병원 API 출력
	public ArrayList<HospitalDTO> listHospApi(ParameterDTO parameterDTO);
	// 병원 API 조회
	public HospitalDTO viewHospApi(HospitalDTO hospitalDTO);
	
	
	// == 병원 ==
	// 좋아요가 많은 순서대로 4개의 병원
	public List<HospitalDTO> listHospByLikecount();
	// 병원 입점 여부 확인
	public String selectHospId(String name);
	// 병원 일련번호 확인
	public String selectHospIdx(String name);
	// 병원 기본 정보 조회
	public BasicDTO viewHosp(String id);
	// 병원 상세 정보 조회
	public DetailDTO selectDetail(String id);

	
	// == 병원 검색 ==
	// 검색된 병원의 개수를 카운트
	public int countSearchHosp(ParameterDTO parameterDTO);
	// 병원 검색
	public List<HospitalDTO> listSearchHosp(String searchSido, String searchGugun, String searchDong, String searchField, String searchWord, List<String> filterList, int offset, int limit);
	
	
	// == 의사 ==
	// 병원에 소속된 의사 조회
	public ArrayList<DoctorDTO> listDoctor(HospitalDTO hospitalDTO);
	
	
	// == 병원 리뷰 ==
	// 리뷰 목록 조회
	public ArrayList<HreviewDTO> listReview(HospitalDTO hospitalDTO);
	// 리뷰 조회
	public HreviewDTO selectReview(HreviewDTO hreviewDTO);
	// 리뷰 작성
    public int writeReview(HreviewDTO hreviewDTO);
	// 리뷰 수정
	public int editReview(HreviewDTO hreviewDTO);
	// 리뷰 삭제
	public int deleteReview(int review_idx);
	
	
	// == 병원 답변 ==
	// 답변 작성
	public int writeReply(HreviewDTO hreviewDTO);
	// 답변 수정
	public int editReply(HreviewDTO hreviewDTO);
	// 답변 삭제
	public int deleteReply(int review_idx);
	// 리뷰의 모든 답변 삭제
	public int deleteAllReply(int original_idx);

	
	// == 정보 표시 ==
	// 리뷰 수 조회
	public int countReview(int api_idx);
	// 별점 합계 조회
	public int sumScore(int api_idx);
	// 리뷰 작성자 닉네임 인출
	public String selectReviewNickname(HreviewDTO hreviewDTO);
	// 리뷰 작성자 이모지 인출
	public String selectReviewEmoji(HreviewDTO hreviewDTO);
	
	
	// == 병원 좋아요 ==
	// 병원 좋아요 수 카운트
	public int countHospLike(int recodenum);
	// 병원 좋아요 표시 여부 확인
	public int checkHospLike(String userId, int api_idx);
	// 병원 좋아요 증가
	public int plusHospLike(String userId, int api_idx);
	// 병원 좋아요 감소
	public int minusHospLike(String userId, int api_idx);
	
	
	// == 리뷰 좋아요 ==
	// 리뷰 좋아요 수 카운트
	public int countReviewLike(String recodenum);
	// 리뷰 좋아요 표시 여부 확인
	public int checkReviewLike(String id, String review_idx);
	// 리뷰 좋아요 증가
	public int plusReviewLike(String id, String review_idx);
	// 리뷰 좋아요 감소
	public int minusReviewLike(String id, String review_idx);
	// 리뷰의 모든 좋아요 삭제
	public int deleteAllHospReviewLike(int review_idx);
	

	// == 해시태그 ==
	// 해시태그 목록
	public ArrayList<HashtagDTO> listHashtag();
	// 병원 해시태그 목록 조회
	public ArrayList<HashtagDTO> selectHospHashtag(String id);
	// 리뷰 해시태그 작성
	public int writeReviewHashtag(int review_idx, String tag);
	// 리뷰의 모든 해시태그 삭제
	public int deleteAllReviewHashtag(int review_idx);
	
	
	// == 주소 ==
	// 시도 인출
	public List<AddressDTO> selectSido();
	// 시도에 해당하는 시구군을 인출
	public List<AddressDTO> selectGugun(AddressDTO addressDTO);
	// 시구군에 해당하는 읍면동을 인출
	public List<AddressDTO> selectDong(AddressDTO addressDTO);
	
	
	// == 지도 ==
	// 지도에 표시할 병원 목록
	public ArrayList<HospitalDTO> listHospMark(ParameterDTO parameterDTO);
	// 병원의 진료시간 정보
	public ArrayList<HoursDTO> selectHours(String hosp_ref);
	

	// == 플러터 연동 ==
	// 병원 목록
	public List<HospitalAppDTO> getAllHospitals();
	// 병원 상세정보 목록
	public List<DetailDTO> getAllHDetails();
	// 병원 리뷰 목록
	public List<HreviewDTO> getAllHReviews();
	// 병원 리뷰의 답변 목록
	public List<HreviewDTO> getAllHReplies();
	// 전체 해시태그 목록
	public List<HashtagDTO> getAllHashtags();
	
}
