package com.edu.springboot.emoji;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@Controller
public class EmojiController {
	
	@Autowired
	IEmojiService emojiDAO;
	
	@Autowired
	IMemberService memberDAO;
	
	
	// == 나의 이모지 ==
	@GetMapping("/myEmoji.do")
	public String myEmoji(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response) {

		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 특정 유저가 보유한 이모지 목록 가져오기
		List<EmojiDTO> emojiList = emojiDAO.listMyEmoji(loginMember.getId());
		model.addAttribute("emojiList", emojiList);
		
		return "emoji/myEmoji";
	}
	
	
	// == 이모지 변경 ==
	@PostMapping("/emoji/editEmoji.do")
	public String editEmoji(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 현재 로그인 한 유저의 emoji 컬럼 업데이트
		String state = req.getParameter("state");
		if (state.equals("disable")) {
			// 비활성화
			emojiDAO.updateEmoji(loginMember.getId(), "");
			loginMember.setEmoji("");
			session.setAttribute("loginMember", loginMember);
		}
		else if (state.equals("enable")) {
			// 활성화
			emojiDAO.updateEmoji(loginMember.getId(), req.getParameter("emoji"));
			loginMember.setEmoji(req.getParameter("emoji"));
			session.setAttribute("loginMember", loginMember);
		}

		return "redirect:/myEmoji.do";
	}
	
	
	// == 이모지 상점 ==
	@GetMapping("/store.do")
	public String store(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		
		// 상점 이모지 목록 가져오기
		List<StoreDTO> storeList = emojiDAO.listStore();
		model.addAttribute("storeList", storeList);

		// 회원인 경우
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember != null) {
			// 유저의 보유 이모지 목록
			List<EmojiDTO> emojiList = emojiDAO.listMyEmoji(loginMember.getId());
			model.addAttribute("emojiList", emojiList);
		}

		return "emoji/store";
	}
	
	
	// == 이모지 구매 ==
	@PostMapping("/store/buy.do")
	public String buy(HttpSession session, HttpServletResponse response, StoreDTO storeDTO, EmojiDTO emojiDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		if (loginMember.getPoint() >= storeDTO.getPrice() ) {
			// 회원 이모지 추가
			emojiDTO.setUser_ref(loginMember.getId());
			emojiDTO.setStore_ref(storeDTO.getStore_idx());
			emojiDAO.buyEmoji(emojiDTO);
			
			// 회원 포인트 감소
			loginMember.setPoint(loginMember.getPoint() - storeDTO.getPrice());
			memberDAO.decreaseUserPoint(loginMember);
		}
		else {
		    // 이모지 구매 실패
			JSFunction.alertBack(response, "포인트가 부족합니다");
			return null;
		}
		
		return "redirect:/store.do";
	}

}
