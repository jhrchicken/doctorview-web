package com.edu.springboot.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.springboot.board.ParameterDTO;
import com.edu.springboot.reserve.IReserveService;
import com.edu.springboot.reserve.ReserveDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CookieManager;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class ReserveAdmController {

	@Autowired
	IReserveService reserveDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{boardprops['board.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{boardprops['board.pagesPerBlock']}")
	private int pagesPerBlock;
	
			
	@GetMapping("/admin/reserve_list.do")
	public String reserve_list(HttpSession session, ParameterDTO parameterDTO, HttpServletRequest req, Model model, HttpServletResponse response) {
		if(session.getAttribute("adminId")==null) {
			JSFunction.alertLocation(response, "관리자로 로그인 해 주세요.", "../admin/index.do");
			return null;
		}
		
		// 게시글의 개수
		int total = reserveDAO.getCountReservationInfo();
		// 현재 페이지
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		// 현재 페이지에 출력할 게시글의 구간 계산 및 저장
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		// 뷰에서 게시글의 가상번호 계산을 위한 값 저장
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		List<ReserveDTO> reserveList = reserveDAO.getAllReservationInfo(parameterDTO);
		model.addAttribute("reserveList", reserveList);
		
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/admin/reserve_list.do?");
		model.addAttribute("pagingImg", pagingImg);		
		
		return "admin-front/reserve_list";
	}
	
	
	@GetMapping("/admin/reserve_change.do")
	public String reserve_change(HttpSession session, ParameterDTO parameterDTO, HttpServletRequest req, Model model, HttpServletResponse response) {
		if(session.getAttribute("adminId")==null) {
			JSFunction.alertLocation(response, "관리자로 로그인 해 주세요.", "../admin/index.do");
			return null;
		}
		
		String app_id = req.getParameter("app_id");
		String cancel = req.getParameter("cancel");
		if(cancel.equals("T")) {
			reserveDAO.changeReserve(app_id, "F");
			System.out.println("F로변경");
		}
		else {
			reserveDAO.changeReserve(app_id, "T");
			System.out.println("T로변경");
		}
						
		return "redirect:reserve_list.do";
	}
	
}



