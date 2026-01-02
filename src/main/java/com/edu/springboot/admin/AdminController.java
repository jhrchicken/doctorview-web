package com.edu.springboot.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CookieManager;

//관리자모드 컨트롤러
@Controller
public class AdminController {
	
	@Autowired
	IMemberService memberDAO;

	/*
	관리자모드의 첫번째 페이지는 로그인이어야 함. 
	만약 프론트에서 관리자로 이미 인증되었다면 자동으로 redirect됨. 
	 */
	@GetMapping("/admin/index.do")
	public String index(HttpSession session, HttpServletRequest req, Model model) {			
		
		model.addAttribute("adminSaveId", CookieManager.readCookie(req, "adminSaveId"));
		return "admin-front/login";
	}
	
	/*
	관리자 로그인 : AUTH가 ROLE_ADMIN인 경우에만 인증 가능. 
	 */
	@PostMapping("/admin/login.do")
	public String login(MemberDTO memberDTO, Model model, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		
	    MemberDTO loginUser = memberDAO.loginMember(memberDTO.getId(), memberDTO.getPassword());
	    //관리자 로그인에 성공하면 대시보드로 이동
	    String returnStr = "redirect:main.do";

	    if(loginUser == null) {
	        model.addAttribute("loginFailed", "아이디 혹은 비밀번호가 일치하지않습니다.");
	        returnStr = "admin-front/login";
	    }
	    else if(loginUser.getEnable() == 0) {
	    	// 회원가입 승인 대기 처리 추가
	    	model.addAttribute("loginFailed", "회원 승인 대기 상태입니다.");
	    	returnStr = "admin-front/login";
	    }
	    else if(loginUser.getAuth().equals("ROLE_ADMIN")) {
	    	session.setAttribute("adminId", loginUser.getId()); 
	    	session.setAttribute("adminPassword", loginUser.getPassword()); 
	    	session.setAttribute("adminName", loginUser.getName());
	    	session.setAttribute("adminAuth", loginUser.getAuth());
	    	session.setAttribute("adminEmoji", loginUser.getEmoji());

	    	// 아이디 저장
	    	loginUser.setSaveId(memberDTO.getSaveId());
	    	if(loginUser.getSaveId() != null) {	    		
	    		CookieManager.makeCookie(resp, "adminSaveId", memberDTO.getId(), 86400);
	    	} 
	    	else {
	    		CookieManager.deleteCookie(resp, "adminSaveId");
	    	}
	    }
	    else {
	    	model.addAttribute("loginFailed", "관리자만 접근할 수 있습니다.");
	    	returnStr = "admin-front/login";
	    }
	    

	    return returnStr;
	}
	
	//로그아웃
	@GetMapping("/admin/logout.do")
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		model.addAttribute("alertFlag", "alert02");
		//각종 Alert를 사용하기 위한 View
		return "admin-front/alert";
		//return "redirect:../admin/index.do";
	}
	
	//대시보드 
	@GetMapping("/admin/main.do")
	public String main(HttpSession session, Model model) {
		//관리자 로그인 체크
		if(session.getAttribute("adminId")==null) {
			model.addAttribute("alertFlag", "alert01");
			//각종 Alert를 사용하기 위한 View
			return "admin-front/alert";
		}
		else {
			model.addAttribute("adminId", session.getAttribute("adminId"));			
		}
			
		return "admin-front/main";
	}
}
