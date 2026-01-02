package com.edu.springboot.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.CommentDTO;
import com.edu.springboot.board.IBoardService;
import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.doctor.DreviewDTO;
import com.edu.springboot.hospital.HospitalDTO;
import com.edu.springboot.hospital.HreviewDTO;
import com.edu.springboot.doctor.IDoctorService;
import com.edu.springboot.hospital.DetailDTO;
import com.edu.springboot.hospital.HashtagDTO;
import com.edu.springboot.hospital.HospitalAppDTO;
import com.edu.springboot.hospital.IHospitalService;
import com.edu.springboot.member.HoursDTO;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.LikesDTO;
import com.edu.springboot.member.MemberDTO;
import com.edu.springboot.member.ReportDTO;
import com.edu.springboot.reserve.IReserveService;
import com.edu.springboot.reserve.ReserveDTO;

@RestController
@RequestMapping("api")
public class ApiController {
	
	
	////////////// 채팅 연결해야 함 //////////////////
	
	@Autowired
	IMemberService memberDAO;
	
	@Autowired
	IBoardService boardDAO;
	
	@Autowired
	IHospitalService hospitalDAO;
	
	@Autowired
	IDoctorService doctorDAO;
	
	@Autowired
	IReserveService reserveDAO;
	
	
	// 회원 목록
	@GetMapping("/member")
	public ResponseEntity<List<MemberDTO>> member() {
		List<MemberDTO> memberLists = memberDAO.getAllMembers();
		return ResponseEntity.ok(memberLists);
	}
	// 커밋용 주석
	
	
	// 전체 좋아요 목록
	@GetMapping("/likes")
	public ResponseEntity<List<LikesDTO>> likes() {
		List<LikesDTO> likeLists = memberDAO.getAllLikes();
		return ResponseEntity.ok(likeLists);
	}
	// 전체 신고 목록
	@GetMapping("/reports")
	public ResponseEntity<List<ReportDTO>> reports() {
		List<ReportDTO> reportLists = memberDAO.getAllReports();
		return ResponseEntity.ok(reportLists);
	}
	// 전체 해시태그 목록
	@GetMapping("/hashtags")
	public ResponseEntity<List<HashtagDTO>> hashtags() {
		List<HashtagDTO> hashtagLists = hospitalDAO.getAllHashtags();
		return ResponseEntity.ok(hashtagLists);
	}
	
	
	// 게시판 목록
	@GetMapping("/board")
	public ResponseEntity<List<BoardDTO>> board() {
		List<BoardDTO> boardLists = boardDAO.getAllBoards();
		return ResponseEntity.ok(boardLists);
	}
	// 댓글 목록
	@GetMapping("/comment")
	public ResponseEntity<List<CommentDTO>> comment() {
		List<CommentDTO> commentLists = boardDAO.getAllComments();
		return ResponseEntity.ok(commentLists);
	}
	
	
	// 병원 목록
	@GetMapping("/hospital")
	public ResponseEntity<List<HospitalAppDTO>> hospital() {
		List<HospitalAppDTO> hospitalLists = hospitalDAO.getAllHospitals();
		return ResponseEntity.ok(hospitalLists);
	}
	// 병원 상세정보 목록
	@GetMapping("/hdetail")
	public ResponseEntity<List<DetailDTO>> hdetail() {
		List<DetailDTO> hdetailLists = hospitalDAO.getAllHDetails();
		return ResponseEntity.ok(hdetailLists);
	}
	// 병원 리뷰 목록
	@GetMapping("/hreview")
	public ResponseEntity<List<HreviewDTO>> hreview() {
		List<HreviewDTO> hreviewLists = hospitalDAO.getAllHReviews();
		System.err.println(hreviewLists);
		return ResponseEntity.ok(hreviewLists);
	}
	// 병원 리뷰의 답변 목록
	@GetMapping("/hreply")
	public ResponseEntity<List<HreviewDTO>> hreply() {
		List<HreviewDTO> hreplyLists = hospitalDAO.getAllHReplies();
		return ResponseEntity.ok(hreplyLists);
	}
	// 병원 영업시간 목록
	@GetMapping("/hours")
	public ResponseEntity<List<HoursDTO>> hours() {
		List<HoursDTO> hoursLists = memberDAO.getAllHours();
		return ResponseEntity.ok(hoursLists);
	}
	
	
	// 의사 목록
	@GetMapping("/doctor")
	public ResponseEntity<List<DoctorDTO>> doctor() {
		List<DoctorDTO> doctorLists = doctorDAO.getAllDoctors();
		return ResponseEntity.ok(doctorLists);
	}
	// 의사 리뷰 목록
	@GetMapping("/dreview")
	public ResponseEntity<List<DreviewDTO>> dreview() {
		List<DreviewDTO> dreviewLists = doctorDAO.getAllDReviews();
		return ResponseEntity.ok(dreviewLists);
	}
	// 의사 리뷰의 답변 목록
	@GetMapping("/dreply")
	public ResponseEntity<List<DreviewDTO>> dreply() {
		List<DreviewDTO> dreplyLists = doctorDAO.getAllDReplies();
		return ResponseEntity.ok(dreplyLists);
	}
	
	
	// 예약 목록
	@GetMapping("/reserve")
	public ResponseEntity<List<ReserveDTO>> reserve() {
		List<ReserveDTO> reserveLists = reserveDAO.getAllReservations();
		return ResponseEntity.ok(reserveLists);
	}
}
