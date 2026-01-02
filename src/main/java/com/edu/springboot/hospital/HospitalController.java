package com.edu.springboot.hospital;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;
import com.edu.springboot.member.MemberDTO;
import com.edu.springboot.reserve.IReserveService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class HospitalController {
	
	@Autowired
	IHospitalService hospitalDAO;
	@Autowired
	IReserveService reserveDAO;
	
	@GetMapping("/hospital.do")
	public String hospital(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {

		// 페이지 진입 시 시도 부분은 미리 셀렉트 후 태그에 표시
		model.addAttribute("sidoList", hospitalDAO.selectSido());
		
		return "hospital/list";
	}
	
	@GetMapping("/hospital/hospListContent.do")
	public String hospListContentGet(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		
		String searchSido = req.getParameter("searchSido");
		String searchGugun = req.getParameter("searchGugun");
		String searchDong = req.getParameter("searchDong");
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String filters = req.getParameter("filters");
		int offset = Integer.parseInt(req.getParameter("offset"));
		int limit = Integer.parseInt(req.getParameter("limit"));
		int count = 0;
		
		List<String> filterList = filters != null ? Arrays.asList(filters.split(",")) : new ArrayList<>();
		// 병원 API 레코드 개수
		parameterDTO.setSearchSido(searchSido);
		parameterDTO.setSearchGugun(searchGugun);
		parameterDTO.setSearchDong(searchDong);
		parameterDTO.setSearchField(searchField);
		parameterDTO.setSearchWord(searchWord);
		parameterDTO.setFilters(filterList);
		parameterDTO.setOffset(offset);
		parameterDTO.setLimit(limit);

		count = hospitalDAO.countSearchHosp(parameterDTO);
		
		// 병원 목록
		List<HospitalDTO> hospList = hospitalDAO.listSearchHosp(searchSido, searchGugun, searchDong, searchField, searchWord, filterList, offset, limit);
		for (HospitalDTO hospital : hospList) {
        	String id = hospitalDAO.selectHospId(hospital.getName());
        	// 입점
        	if (id != null) {
        		hospital.setEnter("T");
        		hospital.setId(id);
        		// 입점 병원 상세 정보
        		DetailDTO detailDTO = hospitalDAO.selectDetail(id);
        		if (detailDTO != null) {
        			if (detailDTO.getPhoto() != null) {
        				hospital.setPhoto(detailDTO.getPhoto());
        			}
        		}
        	}
        	// 미입점
        	else {
        		hospital.setEnter("F");
        	}
        	// 기능과 관련된 정보
        	int hosplikecount = hospitalDAO.countHospLike(hospital.getApi_idx());
        	int reviewcount = hospitalDAO.countReview(hospital.getApi_idx());
        	int scoresum = hospitalDAO.sumScore(hospital.getApi_idx());
        	if (reviewcount != 0) {
        		hospital.setScore(scoresum / reviewcount);
        	}
        	else {
        		hospital.setScore(0);
        	}
        	hospital.setLikecount(hosplikecount);
        	hospital.setReviewcount(reviewcount);
        }
        
        // 해시태그
        ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
        model.addAttribute("hashtagList", hashtagList);
        
        model.addAttribute("hospList", hospList);
        model.addAttribute("count", count);
		
		return "hospital/listContent";
	}
	


   // 시구군 동적 셀렉트
   @RequestMapping("/hospital/getGugun.do")
   @ResponseBody
   public Map<String, Object> address1(AddressDTO addressDTO) {
      List<AddressDTO> gugunList = hospitalDAO.selectGugun(addressDTO);
      Map<String, Object> maps = new HashMap<>();
      maps.put("result", gugunList);
      return maps;
   }
   
   // 읍면동 동적 셀렉트
   @RequestMapping("/hospital/getDong.do")
   @ResponseBody
   public Map<String, Object> address2(AddressDTO addressDTO) {
      List<AddressDTO> dongList = hospitalDAO.selectDong(addressDTO);
      Map<String, Object> maps = new HashMap<>();
      maps.put("result", dongList);
      return maps;
   }
   
   
   	// == 병원 상세보기 ==
   	@RequestMapping("/hospital/viewHosp.do")
   	public String viewHospReq(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, HospitalDTO hospitalDTO) {
		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 병원 API 정보
		hospitalDTO = hospitalDAO.viewHospApi(hospitalDTO);
		String hospId = hospitalDAO.selectHospId(hospitalDTO.getName());
		if (hospId != null) {
			hospitalDTO.setEnter("T");
			hospitalDTO.setId(hospId);
			// 입점 병원 기본 정보
			BasicDTO basicDTO = hospitalDAO.viewHosp(hospId);
			hospitalDTO.setNickname(basicDTO.getNickname());
			hospitalDTO.setPassword(basicDTO.getPassword());
			hospitalDTO.setNickname(basicDTO.getNickname());
			hospitalDTO.setTaxid(basicDTO.getTaxid());
			// 입점 병원 시간 정보
			ArrayList<HoursDTO> hourList = hospitalDAO.selectHours(hospId);
			model.addAttribute("hourList", hourList);
			// 입점 병원 상세 정보
			DetailDTO detailDTO = hospitalDAO.selectDetail(hospId);
			if (detailDTO != null) {
				if (detailDTO.getPhoto() != null) {
					hospitalDTO.setPhoto(detailDTO.getPhoto());
				}
				if (detailDTO.getIntroduce() != null) {
					hospitalDTO.setIntroduce(detailDTO.getIntroduce());
				}
				if (detailDTO.getParking() != null) {
					hospitalDTO.setParking(detailDTO.getParking());
				}
				if (detailDTO.getPcr() != null) {
					hospitalDTO.setPcr(detailDTO.getPcr());
				}
				if (detailDTO.getHospitalize() != null) {
					hospitalDTO.setHospitalize(detailDTO.getHospitalize());
				}
				if (detailDTO.getSystem() != null) {
					hospitalDTO.setSystem(detailDTO.getSystem());
				}
			}
			ArrayList<DoctorDTO> doctorList = hospitalDAO.listDoctor(hospitalDTO);
			model.addAttribute("doctorList", doctorList);
			// 해시태그
			ArrayList<HashtagDTO> hospHashtagList = hospitalDAO.selectHospHashtag(hospId);
			model.addAttribute("hospHashtagList", hospHashtagList);
		}
		// 병원 좋아요 수
		int likecount = hospitalDAO.countHospLike(hospitalDTO.getApi_idx());
		hospitalDTO.setLikecount(likecount);
		// 병원 좋아요 클릭 여부
		int hosplikecheck = hospitalDAO.checkHospLike(id, hospitalDTO.getApi_idx());
		model.addAttribute("hosplikecheck", hosplikecheck);
		// 병원 리뷰 요약과 관련된 정보
    	int hosplikecount = hospitalDAO.countHospLike(hospitalDTO.getApi_idx());
    	int reviewcount = hospitalDAO.countReview(hospitalDTO.getApi_idx());
    	int scoresum = hospitalDAO.sumScore(hospitalDTO.getApi_idx());
    	if (reviewcount != 0) {
    		hospitalDTO.setScore(scoresum / reviewcount);
    	}
    	else {
    		hospitalDTO.setScore(0);
    	}
    	hospitalDTO.setLikecount(hosplikecount);
    	hospitalDTO.setReviewcount(reviewcount);
		// 리뷰 처리
		ArrayList<HreviewDTO> reviewList = hospitalDAO.listReview(hospitalDTO);
		for (HreviewDTO review : reviewList) {
			String nickname = hospitalDAO.selectReviewNickname(review);
			String emoji = hospitalDAO.selectReviewEmoji(review);
			if (emoji != null) review.setNickname(nickname + " " + emoji);
			else review.setNickname(nickname);
			// 리뷰 좋아요 수
			likecount = hospitalDAO.countReviewLike(Integer.toString(review.getReview_idx()));
			review.setLikecount(likecount);
			// 리뷰 좋아요 클릭 여부
			review.setLikecheck(hospitalDAO.checkReviewLike(id, Integer.toString(review.getReview_idx())));	
		}
		// 해시태그
		ArrayList<HashtagDTO> hashtagList = hospitalDAO.listHashtag();
		model.addAttribute("hashtagList", hashtagList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("hospitalDTO", hospitalDTO);
		return "hospital/view";
	}
   
   	
   	
   	// == 리뷰 작성 ==
   	@PostMapping("/hospital/writeReview.do")
   	public String writeReviewPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, HreviewDTO hreviewDTO) {
		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		String app_id = hreviewDTO.getApp_id();
		
		hreviewDTO.setWriter_ref(id);
		hospitalDAO.writeReview(hreviewDTO);
		hreviewDTO = hospitalDAO.selectReview(hreviewDTO);
		reserveDAO.updateHospReviewFlag(app_id);
		
		// 해시태그 처리
		String hashtags = req.getParameter("hashtags");
		if (hashtags != null && !hashtags.isEmpty()) {
			String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
			for (String hashtag : hashtagArray) {
				hospitalDAO.writeReviewHashtag(hreviewDTO.getReview_idx(), hashtag.trim());
			}
		}
		return "redirect:../hospital/viewHosp.do?api_idx=" + hreviewDTO.getApi_ref();
	}
   	
   	
   	// == 리뷰 수정 ==
   	@PostMapping("/hospital/editReview.do")
   	public String editReviewPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, HreviewDTO hreviewDTO) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 댓글 수정
   		hospitalDAO.editReview(hreviewDTO);
   		
   		// 해시태그 처리
   		String hashtags = req.getParameter("hashtags");
   		if (hashtags != null && !hashtags.isEmpty()) {
   			String[] hashtagArray = hashtags != null ? hashtags.split(",") : new String[0];
   			hospitalDAO.deleteAllReviewHashtag(hreviewDTO.getReview_idx());
   			for (String hashtag : hashtagArray) {
   				hospitalDAO.writeReviewHashtag(hreviewDTO.getReview_idx(), hashtag.trim());
   			}
   		}
   		return "redirect:../hospital/viewHosp.do?api_idx=" + hreviewDTO.getApi_ref();
   	}
   	
   	
   	// == 리뷰 삭제 ==
   	@PostMapping("/hospital/deleteReview.do")
   	public String deleteReviewGet(HttpServletRequest req) {
   		int review_idx = Integer.parseInt(req.getParameter("review_idx"));
   		hospitalDAO.deleteReview(review_idx);
   		hospitalDAO.deleteAllReply(review_idx);
   		hospitalDAO.deleteAllHospReviewLike(review_idx);
   		return "redirect:../hospital/viewHosp.do?api_idx=" + req.getParameter("api_ref");
   	}
   	
   	
   	// == 답변 작성 ==
   	@PostMapping("/hospital/writeReply.do")
   	public String writeReplyPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, HreviewDTO hreviewDTO) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 답변 작성
		hreviewDTO.setWriter_ref(id);
		hospitalDAO.writeReply(hreviewDTO);
		
		return "redirect:../hospital/viewHosp.do?api_idx=" + hreviewDTO.getApi_ref();
	}
   	
   	
   	// == 답변 수정 ==
   	@PostMapping("/hospital/editReply.do")
   	public String editReplyPost(HttpSession session, HttpServletRequest req, HttpServletResponse response, HreviewDTO hreviewDTO) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 답변 수정
		hospitalDAO.editReply(hreviewDTO);
		
		return "redirect:../hospital/viewHosp.do?api_idx=" + hreviewDTO.getApi_ref();
	}
   	
   	
   	// == 답변 삭제 ==
   	@PostMapping("/hospital/deleteReply.do")
   	public String deleteReplyGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
   		
   		hospitalDAO.deleteReply(Integer.parseInt(req.getParameter("review_idx")));
   		return "redirect:../hospital/viewHosp.do?api_idx=" + req.getParameter("api_ref");
   	}
   	
   	
   	// == 병원 좋아요 ==
   	@GetMapping("hospital/clickHospLike.do")
   	public String clickLikeGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 병원 좋아요
   		String api_idx = req.getParameter("api_idx");
   		int likecheck = hospitalDAO.checkHospLike(id, Integer.parseInt(api_idx));
   		if (likecheck == 0) {
   			hospitalDAO.plusHospLike(id, Integer.parseInt(api_idx));
   		}
   		else {
   			hospitalDAO.minusHospLike(id, Integer.parseInt(api_idx));
   		}
   		return "redirect:../hospital/viewHosp.do?api_idx=" + api_idx;
   	}
   	
   	
   	// == 리뷰 좋아요 ==
   	@GetMapping("/hospital/clickReviewLike.do")
   	public String clickReviewGet(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
   		
   		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
   		
		// 리뷰 좋아요
   		String api_ref = req.getParameter("api_ref");
   		String review_idx = req.getParameter("review_idx");
   		int likecheck = hospitalDAO.checkReviewLike(id, review_idx);
   		if (likecheck == 0) {
   			// 좋아요 증가
   			hospitalDAO.plusReviewLike(id, review_idx);
   		}
   		else {
   			// 좋아요 취소
   			hospitalDAO.minusReviewLike(id, review_idx);
   		}
   		return "redirect:../hospital/viewHosp.do?api_idx=" + api_ref;
   	}
 
   
	// 지도
	@GetMapping("/hospital/map.do")
	public String map(Model model, ParameterDTO parameterDTO) {
		ArrayList<HospitalDTO> hospList = hospitalDAO.listHospMark(parameterDTO);
		for (HospitalDTO hospital : hospList) {
			String id = hospitalDAO.selectHospId(hospital.getName());
			hospital.setOpen("F");
			hospital.setNight("F");
			hospital.setWeekend("F");
			// 입점
			if (id != null) {
				hospital.setEnter("T");
				hospital.setId(id);
				ArrayList<HoursDTO> hoursList = hospitalDAO.selectHours(id);
				// 현재 요일
		        Date now = new Date();
		        SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE");
		        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		        for (HoursDTO hour : hoursList) {
		        	// 오늘 요일
		        	if (hour.getWeek().equals(dayFormat.format(now))) {
		        		hospital.setNight(hour.getNight());
		        		if (hour.getStarttime() != "00:00") {
		        			if (timeFormat.format(now).compareTo(hour.getStarttime()) > 0 && timeFormat.format(now).compareTo(hour.getEndtime()) < 0) {
		        				hospital.setOpen("T");
		        			}
		        		}
		        	}
		        	// 토요일 일요일
		        	if (hour.getWeek().equals("토요일")) {
		        		if (hour.getStarttime() != "00:00") {
		        			hospital.setWeekend("T");
		        		}
		        	}
		        	if (hour.getWeek().equals("일요일")) {
		        		if (hour.getStarttime() != "00:00") {
		        			hospital.setWeekend("T");
		        		}
		        	}
		        }
			}
			// 미입점
			else {
				hospital.setEnter("F");
			}
		}
		model.addAttribute("hospList", hospList);
		return "/hospital/map";
	}

}
