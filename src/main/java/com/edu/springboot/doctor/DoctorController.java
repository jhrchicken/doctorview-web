package com.edu.springboot.doctor;

import java.io.File;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.crypto.dsig.keyinfo.RetrievalMethod;

import org.springframework.aop.IntroductionAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.hospital.HashtagDTO;
import com.edu.springboot.hospital.IHospitalService;
import com.edu.springboot.member.MemberDTO;
import com.edu.springboot.reserve.IReserveService;

import jakarta.mail.Session;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.FileUtil;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class DoctorController {
   
	@Autowired
	IDoctorService doctorDAO;
	@Autowired
	IHospitalService hospitalDAO;
	@Autowired
	IReserveService reserveDAO;
   
	// == 의사 목록 ==
	@GetMapping("/doctor.do")
	public String doctor(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		return "doctor/list";
	}
	
	
	// == 의사 목록 내용 조회 ==
	@GetMapping("/doctor/doctorListContent.do")
	public String doctorListContentGet(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		int offset = Integer.parseInt(req.getParameter("offset"));
		int limit = Integer.parseInt(req.getParameter("limit"));
		int count = 0;
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
		param.put("offset", offset);
		param.put("limit", limit);

		// 의사의 목록
		ArrayList<DoctorDTO> doctorList = doctorDAO.listDoctorContent(param);
		count = doctorDAO.countDoctor(parameterDTO);
		for (DoctorDTO doctor : doctorList) {
			String hospname = doctorDAO.selectHospName(doctor);
			int doclikecount = doctorDAO.countDocLike(Integer.toString(doctor.getDoc_idx()));
			int reviewcount = doctorDAO.countReview(Integer.toString(doctor.getDoc_idx()));
			int scoresum = doctorDAO.sumScore(Integer.toString(doctor.getDoc_idx()));
			doctor.setHospname(hospname);
			doctor.setLikecount(doclikecount);
			doctor.setReviewcount(reviewcount);
			if (reviewcount != 0) {
				doctor.setScore(scoresum / reviewcount);
			}
			else {
				doctor.setScore(0);
			}
		}
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("count", count);
		
		return "doctor/listContent";
	}
	
	
	// == 의사 상세보기 ==
	@GetMapping("/doctor/viewDoctor.do")
	public String viewDoctorReq(Model model, HttpServletResponse response, DoctorDTO doctorDTO, HttpSession session) {
      
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
	    
		// 의사
		doctorDTO = doctorDAO.viewDoctor(doctorDTO);
		String hospname = doctorDAO.selectHospName(doctorDTO);
		String apiRef = hospitalDAO.selectHospIdx(hospname);
		int doclikecount = doctorDAO.countDocLike(Integer.toString(doctorDTO.getDoc_idx()));
		int reviewcount = doctorDAO.countReview(Integer.toString(doctorDTO.getDoc_idx()));
		int scoresum = doctorDAO.sumScore(Integer.toString(doctorDTO.getDoc_idx()));
		doctorDTO.setHospname(hospname);
		doctorDTO.setLikecount(doclikecount);
		doctorDTO.setReviewcount(reviewcount);
		if (reviewcount != 0) {
			doctorDTO.setScore(scoresum / reviewcount);
		}
		else {
			doctorDTO.setScore(0);
		}
		doctorDTO.setHospname(hospname);
		doctorDTO.setApi_ref(apiRef);
		model.addAttribute("doctorDTO", doctorDTO);
	      
		// 리뷰 목록
		ArrayList<DreviewDTO> reviewsList = doctorDAO.listReview(doctorDTO);
		for (DreviewDTO review : reviewsList) {
			String nickname = doctorDAO.selectReviewNickname(review);
			String emoji = doctorDAO.selectReviewEmoji(review);
			if (emoji != null) review.setNickname(nickname + emoji);
			else review.setNickname(nickname);
			// 리뷰 좋아요 수
			int likecount = doctorDAO.countReviewLike(Integer.toString(review.getReview_idx()));
			review.setLikecount(likecount);
			// 리뷰 좋아요 클릭 여부
			review.setLikecheck(doctorDAO.checkReviewLike(id, Integer.toString(review.getReview_idx())));
		}
		model.addAttribute("reviewsList", reviewsList);
      
		// 의사 찜 수
		int likecount = doctorDAO.countDocLike(Integer.toString(doctorDTO.getDoc_idx()));
		doctorDTO.setLikecount(likecount);

		// 의사 찜 클릭 여부
		int doclikecheck = doctorDAO.checkDocLike(id, Integer.toString(doctorDTO.getDoc_idx()));
		model.addAttribute("doclikecheck", doclikecheck);
      
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = doctorDAO.listHashtag();
		model.addAttribute("hashtagList", hashtagList);
      
		return "doctor/view";
	}

	
	// == 의사 등록 ==
	@GetMapping("/doctor/writeDoctor.do")
	public String writeDoctorGet(Model model, HttpSession session, HttpServletResponse response) {
      
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}

		return "doctor/write";
	}
	
	
	// == 의사 등록 ==
	@PostMapping("/doctor/writeDoctor.do")
	public String writeDoctorPost(HttpSession session, HttpServletRequest req, DoctorDTO doctorDTO) {
      
		// 파일 업로드
		String photo = null;
		try {
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			Part part = req.getPart("file");
			String partHeader = part.getHeader("content-disposition");
			String[] phArr = partHeader.split("filename=");
			String filename = phArr[1].trim().replace("\"", "");
			if (!filename.isEmpty()) {
				part.write(uploadDir + File.separator + filename);
				photo = FileUtil.renameFile(uploadDir, filename);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		doctorDTO.setPhoto(photo);
      
		// 의사 등록
		String id = ((MemberDTO) session.getAttribute("loginMember")).getId();
		doctorDTO.setHosp_ref(id);
		doctorDAO.writeDoctor(doctorDTO);

		return "redirect:../doctor.do";
	}
	
	
	// == 의사 수정 ==
	@GetMapping("/doctor/editDoctor.do")
	public String editDoctorGet(Model model, HttpSession session, HttpServletResponse response, DoctorDTO doctorDTO) {
      
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
      
		// 의사 조회
		doctorDTO = doctorDAO.viewDoctor(doctorDTO);
		model.addAttribute("doctorDTO", doctorDTO);
      
		return "doctor/edit";
	}
	
	@PostMapping("/doctor/editDoctor.do")
	public String editDoctorPost(HttpServletRequest req, DoctorDTO doctorDTO) {
		
		// 파일업로드
		try {
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			Part part = req.getPart("file");
			String partHeader = part.getHeader("content-disposition");
			String[] phArr = partHeader.split("filename=");
			String filename = phArr[1].trim().replace("\"", "");
			if (!filename.isEmpty()) {
				part.write(uploadDir + File.separator + filename);
				String photo = FileUtil.renameFile(uploadDir, filename);
				doctorDTO.setPhoto(photo);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// 의사 수정
		doctorDAO.editDoctor(doctorDTO);
		
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doctorDTO.getDoc_idx();
	}
	
	
	// == 의사 삭제 ==
	@PostMapping("/doctor/deleteDoctor.do")
	public String deleteDoctorPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
      
		// 의사 삭제 및 의사 좋아요 리뷰 삭제
		int doc_idx = Integer.parseInt(req.getParameter("doc_idx"));
		doctorDAO.deleteDoctor(doc_idx);
		doctorDAO.deleteAllDocLike(doc_idx);
		doctorDAO.deleteAllDocReviewLike(doc_idx);
      
		return "redirect:/member/doctorInfo.do";
	}

	
	// == 리뷰 작성 ==
	@PostMapping("/doctor/writeReview.do")
	public String writeReviewPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, DreviewDTO dreviewDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		String app_id = dreviewDTO.getApp_id();
		
		// 리뷰 작성
		dreviewDTO.setWriter_ref(id);
		doctorDAO.writeReview(dreviewDTO);
		dreviewDTO = doctorDAO.selectReview(dreviewDTO);
		reserveDAO.updateDocReviewFlag(app_id);
		
		// 해시태그 처리
		String hashtags = req.getParameter("hashtags");
		if (hashtags != null && !hashtags.isEmpty()) {
			String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
			for (String hashtag : hashtagArray) {
				doctorDAO.writeReviewHashtag(dreviewDTO.getReview_idx(), hashtag.trim());
			}
		}
		
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + dreviewDTO.getDoc_ref();
	}
	
	
	// == 리뷰 수정 ==
	@PostMapping("/doctor/editReview.do")
	public String editReviewPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, DreviewDTO dreviewDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 댓글 수정
      	doctorDAO.editReview(dreviewDTO);
      	
      	// 해시태그 처리
      	String hashtags = req.getParameter("hashtags");
      	if (hashtags != null && !hashtags.isEmpty()) {
      		String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
      		doctorDAO.deleteAllReviewHashtag(dreviewDTO.getReview_idx());
      		for (String hashtag : hashtagArray) {
      			doctorDAO.writeReviewHashtag(dreviewDTO.getReview_idx(), hashtag.trim());
      		}
      	}
      	return "redirect:../doctor/viewDoctor.do?doc_idx=" + dreviewDTO.getDoc_ref();
	}

	
	// == 리뷰 삭제 ==
	@PostMapping("/doctor/deleteReview.do")
	public String deleteReviewGet(HttpSession session, HttpServletRequest req, HttpServletResponse  response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
		doctorDAO.deleteReview(review_idx);
		doctorDAO.deleteAllReply(review_idx);
		doctorDAO.deleteAllReviewLike(review_idx);
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + req.getParameter("doc_ref");
	}
	
	
	// == 답변 작성 ==
	@PostMapping("/doctor/writeReply.do")
	public String writeReplyPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, DreviewDTO dreviewDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 답변 작성
		dreviewDTO.setWriter_ref(id);
		doctorDAO.writeReply(dreviewDTO);
		
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + dreviewDTO.getDoc_ref();
	}
	
	
	// == 답변 수정 ==
	@PostMapping("/doctor/editReply.do")
	public String editReplyPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, DreviewDTO dreviewDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 답변 수정
		doctorDAO.editReply(dreviewDTO);
		
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + dreviewDTO.getDoc_ref();
	}
	
	
	// == 답변 삭제 ==
	@PostMapping("/doctor/deleteReply.do")
	public String deleteReplyGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		doctorDAO.deleteReply(Integer.parseInt(req.getParameter("review_idx")));
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + req.getParameter("doc_ref");
	}
	
	
	// == 의사 좋아요 ==
	@GetMapping("/doctor/clickDocLike.do")
	public String clickLikeGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 좋아요 증가 감소
		String doc_idx = req.getParameter("doc_idx");
		int likecheck = doctorDAO.checkDocLike(id, doc_idx);
		if (likecheck == 0) {
			doctorDAO.plusDocLike(id, doc_idx);
		}
		else {
			doctorDAO.minusDocLike(id, doc_idx);
		}
		
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_idx;
	}
	
	
	// == 리뷰 좋아요 ==
	@GetMapping("/doctor/clickReviewLike.do")
	public String clickReviewGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 좋아요 증가 감소
		String doc_ref = req.getParameter("doc_ref");
		String review_idx = req.getParameter("review_idx");
		int likecheck = doctorDAO.checkReviewLike(id, review_idx);
		if (likecheck == 0) {
			// 좋아요 증가
			doctorDAO.plusReviewLike(id, review_idx);
		}
		else {
			// 좋아요 취소
			doctorDAO.minusReviewLike(id, review_idx);
		}
		
		return "redirect:../doctor/viewDoctor.do?doc_idx=" + doc_ref;
	}
}