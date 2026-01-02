package com.edu.springboot.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.edu.springboot.board.BoardDTO;
import com.edu.springboot.board.IFreeboardService;
import com.edu.springboot.board.IQnaboardService;
import com.edu.springboot.board.ParameterDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class BoardAdmController {
	
	@Autowired
	IQnaboardService qnaDAO;
	@Autowired
	IFreeboardService freeDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{boardprops['board.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{boardprops['board.pagesPerBlock']}")
	private int pagesPerBlock;

	@GetMapping("/admin/board_list.do")
	public String board_list(HttpSession session, Model model, HttpServletRequest req, ParameterDTO parameterDTO, HttpServletResponse response) {
		if(session.getAttribute("adminId")==null) {
			JSFunction.alertLocation(response, "관리자로 로그인 해 주세요.", "../admin/index.do");
			return null;
		}
		
		String boardname = req.getParameter("boardname");
			
		// 게시글의 개수
		int total = 0;
		if(boardname.equals("freeboard")) {
			total = freeDAO.countPost(parameterDTO);			
		}
		else if(boardname.equals("qnaboard")) {
			total = qnaDAO.countPost(parameterDTO);			
		} 
				
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
		
		// 게시물의 목록 저장
		ArrayList<BoardDTO> postsList = null;
		if(boardname.equals("freeboard")) {
			postsList = freeDAO.listPost(parameterDTO);			
		}
		else if(boardname.equals("qnaboard")) {
			postsList = qnaDAO.listPost(parameterDTO);
		} 
		
		for (BoardDTO post : postsList) {
			String nickname = freeDAO.selectBoardNickname(post);
			int likecount = freeDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = freeDAO.countComment(post);
			post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postsList", postsList);
		// 게시판 하단에 출력할 페이지 번호를 String으로 저장한 후 Model에 저장
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/admin/board_list.do?boardname="+boardname+"&");
		model.addAttribute("pagingImg", pagingImg);		
		
		return "admin-front/board_list";
	}
	
	@GetMapping("/admin/board_edit.do")
	public String board_edit(HttpSession session, Model model, HttpServletRequest req, ParameterDTO parameterDTO, BoardDTO boardDTO, HttpServletResponse response) {
		if(session.getAttribute("adminId")==null) {
			JSFunction.alertLocation(response, "관리자로 로그인 해 주세요.", "../admin/index.do");
			return null;
		}
		
		String boardname = req.getParameter("boardname");
		
		String nickname = "";		
		if(boardname.equals("freeboard")) {
			boardDTO = freeDAO.viewPost(boardDTO);
			nickname = freeDAO.selectBoardNickname(boardDTO);
		}
		else if(boardname.equals("qnaboard")) {
			boardDTO = qnaDAO.viewPost(boardDTO);
			nickname = qnaDAO.selectBoardNickname(boardDTO);
		} 		
		
		boardDTO.setNickname(nickname);
		model.addAttribute("boardDTO", boardDTO);
		
		return "admin-front/board_edit";
	}
		
	@PostMapping("/admin/board_edit.do")
	public String board_edit(HttpSession session, HttpServletRequest req, ParameterDTO parameterDTO, BoardDTO boardDTO, HttpServletResponse response) {
		if(session.getAttribute("adminId")==null) {
			JSFunction.alertLocation(response, "관리자로 로그인 해 주세요.", "../admin/index.do");
			return null;
		}
		
		String boardname = req.getParameter("boardname");
		
		if(boardname.equals("freeboard")) {
			freeDAO.editPost(boardDTO);
		}
		else if(boardname.equals("qnaboard")) {
			qnaDAO.editPost(boardDTO);
		} 	
		
		return "redirect:board_list.do?boardname="+boardname;		
	}
	
	@GetMapping("/admin/board_delete.do")
	public String deletePostPost(HttpSession session, HttpServletRequest req, HttpServletResponse response) {
		if(session.getAttribute("adminId")==null) {
			JSFunction.alertLocation(response, "관리자로 로그인 해 주세요.", "../admin/index.do");
			return null;
		}
	 
		String boardname = req.getParameter("boardname");
		
		if(boardname.equals("freeboard")) {
			freeDAO.deletePost(req.getParameter("board_idx"));
		}
		else if(boardname.equals("qnaboard")) {
			qnaDAO.deletePost(req.getParameter("board_idx"));
		}
		JSFunction.alertLocation(response, "삭제되었습니다.", "./board_list.do?boardname="+boardname);
		return null;		
	}
}
