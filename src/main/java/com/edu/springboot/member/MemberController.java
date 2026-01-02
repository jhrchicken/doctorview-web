package com.edu.springboot.member;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.CookieManager;
import utils.FileUtil;
import utils.JSFunction;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService memberDAO;
	@Autowired
	EmailSending email;
	
//	회원가입 페이지로 진입 
	@GetMapping("/member/join.do")
	public String join() {
		return "member/join";
	}
	
//	일반사용자 회원가입 
	@GetMapping("/member/join/user.do")
	public String userJoinGet() {
		return "member/join/user";
	}
	@PostMapping("/member/join/user.do")
	public String userJoinPost(MemberDTO memberDTO, HttpServletRequest req, Model model) {
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String eamil = req.getParameter("email1") + "@" + req.getParameter("email2");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
		
		memberDTO.setTel(tel);
		memberDTO.setEmail(eamil);
		memberDTO.setRrn(rrn);
		
		int joinResult = memberDAO.insertUser(memberDTO);
		
		if (joinResult == 1) {
			return "redirect:/member/login.do";
		}
		else {
			model.addAttribute("joinFaild", "회원가입에 실패했습니다.");
			return "member/join/user";
		}
	} 
	 
//	회원가입: 병원
	@GetMapping("/member/join/hosp.do")
	public String hospJoinGet() {
		return "member/join/hosp";
	}
	@PostMapping("/member/join/hosp.do")
	public String hospJoinPost(MemberDTO memberDTO, DoctorDTO doctorDTO, HoursDTO hoursDTO, HttpServletRequest req, Model model) {
		// member
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String taxid = req.getParameter("taxid1") + "-" + req.getParameter("taxid2") + "-" + req.getParameter("taxid3");
		memberDTO.setTel(tel);
		memberDTO.setTaxid(taxid);
		int memberResult = memberDAO.insertHospMember(memberDTO);
	    
	    // doctor
		doctorDTO.setHosp_ref(memberDTO.getId());
	    String[] doctornamez = req.getParameterValues("doctornamez");
	    String[] majorz = req.getParameterValues("majorz");
	    String[] careerz = req.getParameterValues("careerz");
	    String[] hoursz = req.getParameterValues("hoursz");
	    
	    int doctorResult = 0;
	    for (int i = 0; i < doctornamez.length; i++) {
	        doctorDTO.setDoctorname(doctornamez[i]);
	        doctorDTO.setMajor(majorz[i]);
	        doctorDTO.setCareer(careerz[i]);
	        doctorDTO.setHours(hoursz[i]);
	        doctorResult = memberDAO.insertHospDoctor(doctorDTO);
	    }

	    // hours
	    hoursDTO.setHosp_ref(memberDTO.getId());
	    
	    // 병원 기본 hours 데이터 생성
	    String[] weeks = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"};
	    for (int i = 0; i < weeks.length; i++) {
	    	hoursDTO.setWeek(weeks[i]);
	    	memberDAO.insertHospHours(hoursDTO);
	    }
	    
	    // 병원의 근무 hours 데이터 입력
	    // 야간 진료 판단 (접수마감시간이 8시 이후)
	    if (hoursDTO.getDeadline().compareTo("20:00") > 0) {
	    	hoursDTO.setNight("T"); 
	    } else {
	    	hoursDTO.setNight("F"); 
	    }
	    int hoursResult = 0;
	    weeks = req.getParameterValues("weeks");
	    for(int i=0 ; i<weeks.length ; i++) {
	    	hoursDTO.setWeek(weeks[i]);

	    	// 주말 진료 판단
	    	if (weeks[i].equals("토요일") || weeks[i].equals("일요일")) {
	    		hoursDTO.setWeekend("T"); 
	    	} else {
	    		hoursDTO.setWeekend("F"); 
	    	}
	    	
	    	hoursResult = memberDAO.updateHospHours(hoursDTO);
	    }
	    
	    
		// 회원가입 성공
	    if (memberResult == 1 && doctorResult == 1 && hoursResult == 1) {
	        return "redirect:/";
	    } else {
	    	model.addAttribute("joinFailed", "회원가입에 실패했습니다.");
	    	return "member/join/hosp";
	    }
	}
	
	
// 	회원가입: 아이디 중복 확인
    @GetMapping("/member/join/checkId.do")
    @ResponseBody
    public String checkId(@RequestParam("join_id") String joinID) {
        int checkOk = memberDAO.checkId(joinID);
        
        return String.valueOf(checkOk);
    }
    
// 	회원가입: 아이디 랜덤 생성
    @RequestMapping("/member/join/getNick.do")
    @ResponseBody
    public String getNick(Model model) {
    	String[] firstNick = {"촉촉한", "파닥파닥", "싱싱한", "상큼한", "야망있는", "살금살금", "제멋대로", "거친 파도 속", "신출귀몰한", "야생의", "시들시들한", "트렌디한", "철푸덕", "새콤달콤한", "수줍어하는", "카리스마있는", "졸렬한", "배고픈", "비열한","뒷 골목의", "불타는", "노란머리","버섯머리", "버석한", "기괴한", "더조은","용의주도한", "괴로운", "비염걸린", "눈물 흘리는", "코찔찔이", "꼬들한", "소극적인", "화끈한"};	
    	String[] lastNick = {"열대어", "팽이버섯", "오리", "야자수", "숙주나물", "수박", "도둑", "어부", "헌터", "뽀야미", "파수꾼", "대주주", "알부자", "사천왕", "수족 냉증", "불주먹", "물주먹", "스나이퍼", "파스타", "수면핑", "농구공", "바다의 왕자", "아기돼지", "김치볶음밥", "파인애플", "지하철", "회리", "하림", "다영", "꼬질이"};
    	
        String randomFirstNick = firstNick[(int) (Math.random() * firstNick.length)];
        String randomLastNick = lastNick[(int) (Math.random() * lastNick.length)];
        String randomNick = randomFirstNick + " " +randomLastNick;

        return randomNick;
    }

//  회원탈퇴
    @PostMapping("/member/withdraw.do") 
    public String withdraw(HttpServletRequest req, HttpSession session, RedirectAttributes redirectAttributes) {
		memberDAO.deleteMember(req.getParameter("id"));
		session.invalidate();
		
		redirectAttributes.addFlashAttribute("withdraw", "회원탈퇴가 완료되었습니다.");
    	return "redirect:/";
    }
    
//	로그인
	@GetMapping("/member/login.do")
	public String login() {
		return "member/login"; 
	}
	@PostMapping("/member/login.do")
	public String login(MemberDTO memberDTO, Model model, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
//	    MemberDTO loginUser = memberDAO.loginMember(memberDTO);
	    MemberDTO loginMember = memberDAO.loginMember(memberDTO.getId(), memberDTO.getPassword());

	    if(loginMember == null) {
	        model.addAttribute("loginFailed", "아이디 혹은 비밀번호가 일치하지않습니다.");
	        return "member/login"; 
	    }
	    if(loginMember.getEnable() == 0) {
	    	// 회원가입 승인 대기 처리 추가
	    	model.addAttribute("loginFailed", "회원 승인 대기 상태입니다.");
	    	return "member/login";
	    }
	    session.setAttribute("userId", loginMember.getId()); 
	    session.setAttribute("userPassword", loginMember.getPassword()); 
	    session.setAttribute("userName", loginMember.getName());
	    session.setAttribute("userAuth", loginMember.getAuth());
	    session.setAttribute("userEmoji", loginMember.getEmoji());
	    session.setAttribute("loginMember", loginMember);
	    
	    // 아이디 저장
	    loginMember.setSaveId(memberDTO.getSaveId());
	    if(loginMember.getSaveId() != null) {
	    	model.addAttribute("checked", "checked");
	        CookieManager.makeCookie(resp, "saveId", loginMember.getId(), 86400);
	    } else {
	        CookieManager.deleteCookie(resp, "saveId");
	    }

	    return "redirect:/";
	}
	
//	로그아웃
	@GetMapping("/member/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
//	아이디찾기
	@GetMapping("/member/findId.do")
	public String findIdGet() {
		return "member/findId";
	}
	@PostMapping("/member/findId.do")
	public String findIdPost(MemberDTO memberDTO, Model model) {
		String findId = memberDAO.findIdMember(memberDTO);
		
		if(findId != null) {
			model.addAttribute("foundId", findId);
			return "member/findId";
		}
		else {
			model.addAttribute("notfountId", "회원정보가 없습니다.");
			return "member/findId";
		}
	}
	
//	비밀번호찾기
	@GetMapping("/member/findPass.do")
	public String findPassGet() {
		return "member/findPass";
	}
	@PostMapping("/member/findPass.do")
	public String findPassPost(MemberDTO memberDTO, Model model) {
		MemberDTO findPass = memberDAO.findPassMember(memberDTO);
		
//		입력된 아이디와 이메일과 일치하는 회원이 있는지 확인
		if(findPass != null) {
			InfoDTO infoDTO = new InfoDTO();
			
//			비번랜덤생성
			String newPassword = randomPass();
//			랜덤생성된 비밀번호로 변경
			memberDAO.updateNewPass(newPassword, findPass.getId(), findPass.getEmail());
			
			String name = findPass.getName();
			
			infoDTO.setTo(findPass.getEmail());
			infoDTO.setSubject("[닥터뷰] 임시 비밀번호 안내");
			infoDTO.setContent("안녕하세요 " + name + "님!\n닥터뷰에서 회원님의 임시 비밀번호를 알려드립니다.\n로그인 후 비밀번호를 재설정해주세요.\n\n- 임시 비밀번호 : " + newPassword);
			infoDTO.setFormat("text");
			email.myEmailSender(infoDTO);
			
			model.addAttribute("passInfo", "임시 비밀번호가 발급되었습니다.<br/>메일함을 확인하세요.");
			return "member/findPass";
		}
		else {
			model.addAttribute("notfountPass", "회원정보가 없습니다.");
			return "member/findPass";
		}
	}
	
//	회원인증: 로그인 유저 비밀번호 인증
	@GetMapping("/member/checkMember.do")
	public String checkMemberGet(HttpSession session, HttpServletResponse response) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		return "member/checkMember";
	}
	@PostMapping("/member/checkMember.do")
	public String checkMemberPost(MemberDTO memberDTO, Model model) {
		MemberDTO loginUser = memberDAO.loginMember(memberDTO.getId(), memberDTO.getPassword());
		
		if(loginUser != null) {
//			주민번호 데이터가 있으면 개인회원
			if(loginUser.getRrn() != null) {
				return "redirect:/member/editUser.do";
			}
//			병원회원
			return "redirect:/member/editHosp.do";
		}
		else {
			model.addAttribute("checkMemberFaild", "비밀번호가 일치하지 않습니다.");
			return "member/checkMember";
		}
	}
	
//	회원수정: user
//	회원정보 수정: user
	@GetMapping("/member/editUser.do")
	public String editUserGet(Model model, HttpSession session, HttpServletResponse response) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
	    
		MemberDTO loginUser = memberDAO.loginMember((String) session.getAttribute("userId"), (String) session.getAttribute("userPassword"));
		String[] tel =  loginUser.getTel().split("-");
		String[] email =  loginUser.getEmail().split("@");
		String[] rrn =  loginUser.getRrn().split("-");
		
		model.addAttribute("loginUserInfo", loginUser);
		model.addAttribute("tel", tel);
		model.addAttribute("email", email);
		model.addAttribute("rrn1", rrn[0]);
		model.addAttribute("rrn2", rrn[1].substring(0,1));
		
		return "member/editUser";
	}
	@PostMapping("/member/editUser.do")
	public String editUserPost(MemberDTO memberDTO, Model model, HttpSession session, HttpServletRequest req, RedirectAttributes redirectAttributes) {
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String eamil = req.getParameter("email1") + "@" + req.getParameter("email2");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
		
		memberDTO.setTel(tel);
		memberDTO.setEmail(eamil);
		memberDTO.setRrn(rrn);
		
		int editUserResult = memberDAO.editUser(memberDTO);
		
		if (editUserResult == 1) {
			// 새로운 비밀번호 session에 저장
			session.setAttribute("userPassword", memberDTO.getPassword());
			memberDTO.setEmoji((String) session.getAttribute("userEmoji"));
			session.setAttribute("loginMember", memberDTO);
			
			redirectAttributes.addFlashAttribute("editUserResult", "회원정보 수정에 성공했습니다.");
			return "redirect:/member/editUser.do";
		}
		else {
			redirectAttributes.addFlashAttribute("editUserResult", "회원정보 수정에 실패했습니다.");
			return "member/editUser";
		}
	}

//	회원정보 수정: hosp
	@GetMapping("/member/editHosp.do")
	public String editHospGet(MemberDTO memberDTO, DetailDTO detailDTO, HttpSession session, Model model, HttpServletResponse response) {
//		memberDTO.setId((String) session.getAttribute("userId"));
//		memberDTO.setPassword((String) session.getAttribute("userPassword"));
		
		// member 
//		MemberDTO loginUser = memberDAO.loginMember(memberDTO);
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    } 
		MemberDTO loginUser = memberDAO.loginMember(id, (String) session.getAttribute("userPassword"));
		
		String[] tel =  loginUser.getTel().split("-");
		String[] taxid =  loginUser.getTaxid().split("-");
		model.addAttribute("loginUserInfo", loginUser);
		model.addAttribute("tel", tel);
		model.addAttribute("taxid", taxid);
		
		// hours
		List<HoursDTO> hoursDTO = memberDAO.selectHospHours(id);
		String[] weeks = new String[hoursDTO.size()];
		for (int i = 0; i < hoursDTO.size(); i++) {
		    weeks[i] = hoursDTO.get(i).getWeek();
		}
		
		HoursDTO hoursInfo = hoursDTO.get(0);
		LocalTime starttime = LocalTime.parse(hoursInfo.getStarttime(), DateTimeFormatter.ofPattern("HH:mm"));
		LocalTime endtime = LocalTime.parse(hoursInfo.getEndtime(), DateTimeFormatter.ofPattern("HH:mm"));
		LocalTime startbreak = LocalTime.parse(hoursInfo.getStartbreak(), DateTimeFormatter.ofPattern("HH:mm"));
		LocalTime endbreak = LocalTime.parse(hoursInfo.getEndbreak(), DateTimeFormatter.ofPattern("HH:mm"));
		LocalTime deadline = LocalTime.parse(hoursInfo.getDeadline(), DateTimeFormatter.ofPattern("HH:mm"));
		
		model.addAttribute("weeks", weeks);
		model.addAttribute("hoursInfo", hoursInfo);
		model.addAttribute("starttime", starttime);
		model.addAttribute("endtime", endtime);
		model.addAttribute("startbreak", startbreak);
		model.addAttribute("endbreak", endbreak);
		model.addAttribute("deadline", deadline);
		
		// detail
		DetailDTO hospDatilInfo = memberDAO.selectHospDatail(id);
		model.addAttribute("hospDatilInfo", hospDatilInfo);
		
		
		return "member/editHosp";
	}
	@PostMapping("/member/editHosp.do")
	public String editHospPost(MemberDTO memberDTO, HoursDTO hoursDTO, DetailDTO detailDTO, HttpServletRequest req, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		// member
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String taxid = req.getParameter("taxid1") + "-" + req.getParameter("taxid2") + "-" + req.getParameter("taxid3");
		memberDTO.setTel(tel);
		memberDTO.setTaxid(taxid);
		memberDAO.updateHospMember(memberDTO);
		
		int hospMemberResult = memberDAO.updateHospMember(memberDTO);
		
		// hours
	    // 현재 선택된 병원의 기존 영업시간 데이터 초기화
	    String[] weeks = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"};
	    for (int i = 0; i < weeks.length; i++) {
	    	hoursDTO.setWeek(weeks[i]);
	    	memberDAO.resetHospHours(hoursDTO);
	    }
		
		// 새로 수정된 영업시간 데이터 update
	    // 종료 시간이 8시 이후이면 야간 진료 표시
	    if (hoursDTO.getDeadline().compareTo("20:00") > 0) {
	    	hoursDTO.setNight("T"); 
	    } else {
	    	hoursDTO.setNight("F"); 
	    }
	    weeks = req.getParameterValues("weeks");
	    int hospHoursResult = 0;
	    for(int i=0 ; i<weeks.length ; i++) {
	    	hoursDTO.setWeek(weeks[i]);
	    	// 주말 진료 판단 (주말인 경우 주말 진료 표시)
	    	if (weeks[i].equals("토") || weeks[i].equals("일")) {
	    		hoursDTO.setWeekend("T"); 
	    	} else {
	    		hoursDTO.setWeekend("F"); 
	    	}
	    	hospHoursResult = memberDAO.updateHospHours(hoursDTO);
	    }
	    
	    // detail
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
 				detailDTO.setPhoto(photo);
 			}
 			else {
 				System.out.println("파일 비었음!!");
 			}
 		}
 		catch (Exception e) {
 			e.printStackTrace();
 		}
 		int hospDatailResult;
	    // detail 데이터가 있으면
	    if(memberDAO.selectHospDatail(memberDTO.getId()) != null ) {
//	    	update 쿼리
	    	hospDatailResult = memberDAO.updateHospDetail(detailDTO);
	    } else {
//	    	insert 쿼리
	    	hospDatailResult = memberDAO.insertHospDetail(detailDTO);
	    }
		
	    
		if (hospMemberResult == 1 && hospHoursResult == 1 && hospDatailResult == 1) {
			session.setAttribute("userPassword", memberDTO.getPassword());
			redirectAttributes.addFlashAttribute("editUserResult", "회원정보 수정에 성공했습니다.");
			return "redirect:/member/editHosp.do";
		}
		else {
			redirectAttributes.addFlashAttribute("editUserResult", "회원정보 수정에 실패했습니다.");
			return "member/editHosp";
		}
		
	} 
	
//	의료진 관리 (의사정보)
	@GetMapping("/member/doctorInfo.do")
	public String doctorInfoGet(Model model, HttpSession session, HttpServletResponse response) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setId((String) session.getAttribute("userId"));
		List<DoctorDTO> doctorDTO = memberDAO.selectHospDoctor(memberDTO.getId());
		
//		모델 저장
		model.addAttribute("doctorDTO", doctorDTO);
		
		return "member/doctorList";
	}
	
//	출석체크
	@GetMapping("/mypage/attend.do")
	public String attendGet(Model model, HttpSession session, HttpServletResponse response) {
		// 로그인 여부 확인
		String id = (String) session.getAttribute("userId");
	    if (id == null) {
	        JSFunction.alertLocation(response, "로그인 후 이용해 주세요.", "../member/login.do");
	        return null;
	    }
		// 현재 날짜 가져오기
        LocalDate today = LocalDate.now();
        // 날짜 포맷팅
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String todayDate = today.format(formatter);
        // 출력
        model.addAttribute("todayDate", todayDate);
        
        MemberDTO memberDTO= memberDAO.loginMember((String) session.getAttribute("userId"), (String) session.getAttribute("userPassword"));
		model.addAttribute("memberDTO", memberDTO);
		
		return "mypage/attend";
	}
	@PostMapping("/mypage/attend.do")
	public String attendPost(HttpSession session, Model model, HttpServletRequest req) {
		MemberDTO memberDTO= memberDAO.loginMember((String) session.getAttribute("userId"), (String) session.getAttribute("userPassword"));
		
		String attend = req.getParameter("attendDate");
		// 오늘날짜로 attend 컬럼 설정
		memberDTO.setAttend(attend);
		System.out.println(memberDTO);
		
		System.out.println(attend);
		if (attend instanceof String) {
		    System.out.println("String타입.");
		} else {
		    System.out.println("String타입 아님");
		}
		
		// 10포인트 추가
		memberDTO.setPoint(memberDTO.getPoint() + 10);
		memberDAO.userAttend(memberDTO);
		
		return "mypage/attend";
	}
	
	
//	비밀번호 랜덤생성 함수
	 public static String randomPass() {
	 	Random random = new Random();
	 	int[] passPattern = {0, 1, 2};
	 	char randomChar;
	 	String newPassword = "";
	 	
        for (int i = 0; i < 4; i++) {
        	for (int pass : passPattern) {
        		switch (pass) {
//	        		대문자
                case 0:
	                randomChar = (char) ('A' + random.nextInt(26));
	                newPassword += randomChar;
                    break;
//	                소문자
                case 1:
                	randomChar = (char) ('a' + random.nextInt(26));
                	newPassword += randomChar;
                    break;
//	                숫자
                case 2:
                	int passNum = (int) (Math.random() * 10);
                	newPassword += passNum;
                    break;
	            }
	        }
    	}
        
        return newPassword;
        }

	
	

}
