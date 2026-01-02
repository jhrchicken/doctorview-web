package com.edu.springboot.doctor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.hospital.HashtagDTO;

@Mapper
public interface IDoctorService {
	
	// == 의사 ==
	// 의사 개수 카운트
	public int countDoctor(ParameterDTO parameterDTO);
	// 한 페이지에 출력할 의사 인출
	public ArrayList<DoctorDTO> listDoctor(ParameterDTO parameterDTO);
	// 의사 목록 조회
	public ArrayList<DoctorDTO> listDoctorContent(Map<String, Object> param);
	// 의사 일련번호 조회
	public String selectDoctorIdx(String doctorname, String hosp_ref);
	// 의사 좋아요 순서대로 4개
	public List<DoctorDTO> listDoctorByLikecount();
	
	// 의사 조회
	public DoctorDTO viewDoctor(DoctorDTO doctorDTO);
	// 의사 등록
	public int writeDoctor(DoctorDTO doctorDTO);
	// 의사 수정
	public int editDoctor(DoctorDTO doctorDTO);
	// 의사 삭제
	public int deleteDoctor(int doc_idx);
   
	// == 의사 리뷰 ==
	// 리뷰 수 조회
	public int countReview(String doc_ref);
	// 리뷰 목록 조회
	public ArrayList<DreviewDTO> listReview(DoctorDTO doctorDTO);
	// 리뷰 조회
	public DreviewDTO selectReview(DreviewDTO dreviewDTO);
	// 리뷰 작성
	public int writeReview(DreviewDTO dreviewDTO);
	// 리뷰 수정
	public int editReview(DreviewDTO dreviewDTO);
	// 리뷰 삭제
	public int deleteReview(int review_idx);

	
	// == 의사 답변 ==
	// 답변 작성
	public int writeReply(DreviewDTO dreviewDTO);
	// 답변 수정
	public int editReply(DreviewDTO dreviewDTO);
	// 답변 삭제
	public int deleteReply(int review_idx);
	// 리뷰의 모든 답변 삭제
	public int deleteAllReply(int original_idx);

	
	// == 정보 표시 ==
	// 의사의 소속 병원명 인출
	public String selectHospName(DoctorDTO doctorDTO);
	// 리뷰 작성자 닉네임 인출
	public String selectReviewNickname(DreviewDTO dreviewDTO);
	// 리뷰 작성자 이모지 인출
	public String selectReviewEmoji(DreviewDTO dreviewDTO);
	
	
	// == 의사 좋아요 ==
	// 의사 좋아요 수 카운트
	public int countDocLike(String recodenum);
	// 의사 좋아요 표시 여부 확인
	public int checkDocLike(String id, String doc_idx);
	// 의사 좋아요 증가
	public int plusDocLike(String id, String doc_idx);
	// 의사 좋아요 감소
	public int minusDocLike(String id, String doc_idx);
	// 의사의 모든 좋아요 삭제
	public int deleteAllDocLike(int doc_idx);
	
	
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
	public int deleteAllReviewLike(int review_idx);
	// 의사의 모든 리뷰의 모든 좋아요 삭제
	public int deleteAllDocReviewLike(int doc_idx);
	
	
	// == 별점 ==
	// 별점 합계 계산
	public int sumScore(String doc_idx);
	
   
	// == 해시태그 ==
	// 해시태그 목록
	public ArrayList<HashtagDTO> listHashtag();
	// 리뷰 해시태그 작성
	public int writeReviewHashtag(int review_idx, String tag);
	// 리뷰의 모든 해시태그 삭제
	public int deleteAllReviewHashtag(int review_idx);

	
	// == 플러터 연동 ==
	// 의사 전체 목록
	public List<DoctorDTO> getAllDoctors();
	// 의사 리뷰 목록
	public List<DreviewDTO> getAllDReviews();
	// 의사 리뷰의 답변 목록
	public List<DreviewDTO> getAllDReplies();
   
}
