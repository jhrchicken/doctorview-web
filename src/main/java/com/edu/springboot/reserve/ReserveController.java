package com.edu.springboot.reserve;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReserveController {
	
	@Autowired
	IReserveService reserveDAO;
	
	@Autowired
	IMemberService memberDAO;
	
	// 예약 진행 페이지로 이동
	@GetMapping("/reserve/proceed.do")
	public String proceedGet(Model model, HttpSession session, ReserveDTO reserveDTO) {
		ObjectMapper objectMapper = new ObjectMapper();
		
		// 병원 - 기본정보 
		MemberDTO hospitalInfo  = reserveDAO.getHospital(reserveDTO);
		model.addAttribute("hospitalInfo", hospitalInfo);
		
	    // 병원 - 의사정보
	    List<DoctorDTO> doctorInfo = reserveDAO.getDoctor(hospitalInfo.getId());
	    model.addAttribute("doctorInfo", doctorInfo);
		
		// 병원 - 영업정보
		List<HoursDTO> hospHoursList = memberDAO.selectHospHours(hospitalInfo.getId()); // 진료 시간

		if (!hospHoursList.isEmpty()) {
		    List<String> stringHospHoursList = hospHoursList.get(0).generateTimeSlots().stream()
		        .map(LocalTime::toString)
		        .collect(Collectors.toList()); // 영업정보 데이터 String 배열로 변환
		    
		    try {
		        model.addAttribute("hoursList", objectMapper.writeValueAsString(stringHospHoursList)); // Jackson 라이브러리 이용 영업 시간(hoursList) json 반환
		    } catch (JsonProcessingException e) {
		        throw new RuntimeException("영업시간 JSON 변환 중 오류 발생", e);
		    }
		}
		
		String weeks = hospHoursList.stream()
			    .map(HoursDTO::getWeek)          
			    .map(w -> "'" + w + "'")        
			    .collect(Collectors.joining(",")); // 진료 요일: js 배열 형식으로 반환

		model.addAttribute("weeks", weeks);
		
		// 병원 - 예약정보
	    List<ReserveDTO> reserveList = reserveDAO.getReservationInfo(null, hospitalInfo.getId());
	    Map<String, List<String>> reserveMap = new HashMap<>();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	    for (ReserveDTO reserve : reserveList) {
	        String postdate = dateFormat.format(reserve.getPostdate());
	        String posttime = reserve.getPosttime();
	        String hospRef = reserve.getHosp_ref();

	        boolean isReservable = true;

	        // 1. admin 예약이 있으면 무조건 예약 불가
	        if (reserveDAO.getReservationAdmin(hospRef, postdate, posttime) == 1) {
	            isReservable = false;
	        } 
	        // 2. 해당 시간 예약이 3개 이상이면 체크
	        else if (reserveDAO.getReservationCount(hospRef, postdate, posttime, 0) >= 3) {
	            int hospitalReserveCount = reserveDAO.getReservationHospital(hospRef, postdate, posttime);
	            
	            if (hospitalReserveCount != 0) {
	                int hospitalAppId = reserveDAO.getHospitalAppId(hospRef, postdate, posttime);
	                if (reserveDAO.getReservationCount(hospRef, postdate, posttime, hospitalAppId) >= 3) {
	                    isReservable = false;
	                }
	            } else {
	                isReservable = false;
	            }
	        }

	        /* 디버깅: 예약 제한 개수 변경하기 */
       	 	if( !isReservable ) {
	        	 if (!reserveMap.containsKey(postdate)) {
	        		 reserveMap.put(postdate, new ArrayList<>()); //해당 날짜의 리스트가 존재하지 않으면 새로 생성
	        	 }
	        	 
	        	 reserveMap.get(postdate).add(posttime); // 해당 날짜의 리스트에 posttime 추가
	         }
	    }

	    try {
	        model.addAttribute("hospReserveMap", objectMapper.writeValueAsString(reserveMap));
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }


	    // 개인회원 정보
	    MemberDTO userInfo = memberDAO.loginMember((String)session.getAttribute("userId"),(String)session.getAttribute("userPassword"));
	    model.addAttribute("userInfo", userInfo);
	    
	    String[] tel = userInfo.getTel().split("-"); // 전화번호
        model.addAttribute("tel1", tel[0]);
        model.addAttribute("tel2", tel[1]);
        model.addAttribute("tel3", tel[2]);
	    
	    String rrn = userInfo.getRrn(); // 주민등록번호
        model.addAttribute("birthRrn", rrn.substring(0, 6));
        model.addAttribute("genderRrn", rrn.substring(7, 8));
	    
	    return "reserve/proceed";
	    }
		
	// 예약하기
	@PostMapping("/reserve/proceed.do")
	public String proceedPost(Model model, ReserveDTO reserveDTO, HttpServletRequest req) {
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
		
		reserveDTO.setTel(tel);
		reserveDTO.setRrn(rrn);
		
		// 예약정보 저장
		int reserveResult = reserveDAO.saveReservationInfo(reserveDTO);
		
		if(reserveResult ==1) {
			// 예약에 성공하면
			model.addAttribute("reserveDTO", reserveDTO);
			return "reserve/complete";
		} else {
			// 예약에 실패하면
			return "reserve/error";
		}
	}

	// 예약 취소하기
	@PostMapping("/reserve/cancel.do")
	public String cancel(Model model, HttpSession session, ReserveDTO reserveDTO) {
		reserveDAO.cancelReservation(reserveDTO);
		
		return "redirect:/myReserve.do";
	}
	
	// 예약 내역 숨김 (user)
	@GetMapping("/reserve/delete.do")
	public String delete(ReserveDTO reserveDTO) {
		reserveDAO.hideReservation(reserveDTO);
		
		return "redirect:/myReserve.do";
	}
	
	// 예약 관리
	@GetMapping("/reserve/setTime.do")
	public String setTimeGet(Model model, HttpSession session, ReserveDTO reserveDTO, MemberDTO memberDTO) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		// 병원정보
		memberDTO.setId((String)session.getAttribute("userId"));
		MemberDTO hospitalInfo  = reserveDAO.getMyHospital(memberDTO);
		model.addAttribute("hospitalInfo", hospitalInfo);
		
		
		// 병원 - 영업정보
		List<HoursDTO> hospHoursList = memberDAO.selectHospHours(hospitalInfo.getId()); // 진료 시간

		if (!hospHoursList.isEmpty()) {
		    List<String> stringHospHoursList = hospHoursList.get(0).generateTimeSlots().stream()
		        .map(LocalTime::toString)
		        .collect(Collectors.toList()); // 영업정보 데이터 String 배열로 변환
		    
		    try {
		        model.addAttribute("hoursList", objectMapper.writeValueAsString(stringHospHoursList)); // Jackson 라이브러리 이용 hoursList json 반환
		    } catch (JsonProcessingException e) {
		        throw new RuntimeException("영업시간 JSON 변환 중 오류 발생", e);
		    }
		}
		
		String weeks = hospHoursList.stream()
			    .map(HoursDTO::getWeek)          
			    .map(w -> "'" + w + "'")        
			    .collect(Collectors.joining(",")); // 진료 요일: js 배열 형식으로 반환

		model.addAttribute("weeks", weeks);
		
		// 병원 - 예약정보
	    List<ReserveDTO> reserveList = reserveDAO.getReservationInfo(null, hospitalInfo.getId());
	    Map<String, List<String>> reserveMap = new HashMap<>();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	    for (ReserveDTO reserve : reserveList) {
	        String postdate = dateFormat.format(reserve.getPostdate());
	        String posttime = reserve.getPosttime();
	        String hospRef = reserve.getHosp_ref();

	        boolean isReservable = true;

	        // 1. admin 예약이 있으면 무조건 예약 불가
	        if (reserveDAO.getReservationAdmin(hospRef, postdate, posttime) == 1) {
	            isReservable = false;
	        } 
	        // 2. 해당 시간 예약이 3개 이상이면 체크
	        else if (reserveDAO.getReservationCount(hospRef, postdate, posttime, 0) >= 3) {
	            int hospitalReserveCount = reserveDAO.getReservationHospital(hospRef, postdate, posttime);
	            
	            if (hospitalReserveCount != 0) {
	                int hospitalAppId = reserveDAO.getHospitalAppId(hospRef, postdate, posttime);
	                if (reserveDAO.getReservationCount(hospRef, postdate, posttime, hospitalAppId) >= 3) {
	                    isReservable = false;
	                }
	            } else {
	                isReservable = false;
	            }
	        }

	        /* 디버깅: 예약 제한 개수 변경하기 */
       	 	if( !isReservable ) {
	        	 if (!reserveMap.containsKey(postdate)) {
	        		 reserveMap.put(postdate, new ArrayList<>()); //해당 날짜의 리스트가 존재하지 않으면 새로 생성
	        	 }
	        	 
	        	 reserveMap.get(postdate).add(posttime); // 해당 날짜의 리스트에 posttime 추가
	         }
	    }

	    try {
	        model.addAttribute("hospReserveMap", objectMapper.writeValueAsString(reserveMap));
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }

		return "reserve/setTime";
	}
	
	@PostMapping("/reserve/setTime.do")
	public String setTimePost(HttpServletRequest req, ReserveDTO reserveDTO, RedirectAttributes redirectAttributes) {
		String[] posttimez = req.getParameterValues("posttimez");
		String action = req.getParameter("action"); 
		
		// 예약 닫기
		if (action.equals("close")) {
			for (int i = 0; i < posttimez.length; i++) {
				reserveDTO.setPosttime(posttimez[i]);
				
				reserveDAO.deleteCloseTime(reserveDTO);
				reserveDAO.deleteOpenTime(reserveDTO);
				reserveDAO.closeTime(reserveDTO);
			}
		}
		// 예약 열기
		else {
			for (int i = 0; i < posttimez.length; i++) {
				reserveDTO.setPosttime(posttimez[i]);
				
				reserveDAO.deleteOpenTime(reserveDTO);
				reserveDAO.deleteCloseTime(reserveDTO);
				reserveDAO.openTime(reserveDTO);
			}
		}
		
	    redirectAttributes.addFlashAttribute("setTimeResult", "예약 시간 설정이 완료되었습니다.");
		return "redirect:/reserve/setTime.do";
	}
	
}
