package com.edu.springboot.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.edu.springboot.member.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;
import utils.PagingUtil;

@Controller
public class BoardController {
	
	@Autowired
	IBoardService boardDAO;
	
	// 페이지당 출력할 게시물 수
	@Value("#{boardprops['board.postsPerPage']}")
	private int postsPerPage;
	// 한 블록당 출력할 페이지 번호 수
	@Value("#{boardprops['board.pagesPerBlock']}")
	private int pagesPerBlock;
	
	
	// == 베스트 게시판 ==
	@GetMapping("/board/bestPost.do")
	public String bestPostGet(Model model, HttpSession session, HttpServletRequest req, HttpServletResponse response, ParameterDTO parameterDTO) {
		
		// 게시물의 개수를 통해 페이징 기능 구현
		int total = boardDAO.countBestPost();
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		Map<String, Object> maps = new HashMap<String, Object>();
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/myPost.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		// 게시물의 목록
		ArrayList<BoardDTO> postList = boardDAO.listBestPost(parameterDTO);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			String emoji = boardDAO.selectBoardEmoji(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			if (emoji != null) post.setNickname(nickname + " " + emoji);
			else post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		
		return "board/bestPost";
 	}
	
	
	// == 내가 쓴 글 ==
	@GetMapping("/board/myPost.do")
	public String myPostGet(Model model, HttpServletRequest req, HttpServletResponse response, HttpSession session, ParameterDTO parameterDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 게시글의 개수를 통해 페이징 기능 구현
		int total = boardDAO.countMyPost(id);
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/myPost.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		// 게시글의 목록
		ArrayList<BoardDTO> postList = boardDAO.listMyPost(id, parameterDTO);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			String emoji = boardDAO.selectBoardEmoji(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			if (emoji != null) post.setNickname(nickname + " " + emoji);
			else post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		
		return "board/myPost";
	}
	
	
	// == 내가 단 글 ==
	@GetMapping("/board/myComment.do")
	public String myCommentGet(Model model, HttpServletRequest req, HttpServletResponse response, HttpSession session, ParameterDTO parameterDTO) {
		
		// 로그인 여부 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		String id = loginMember.getId();
		
		// 게시글의 개수를 고려하여 페이징 기능 구현
		int total = boardDAO.countMyComment(id);
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/myComment.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		// 게시글의 목록
		ArrayList<BoardDTO> postList = boardDAO.listMyComment(id, parameterDTO);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			String emoji = boardDAO.selectBoardEmoji(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			if (emoji != null) post.setNickname(nickname + " " + emoji);
			else post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		
		return "board/myComment";
	}
	
	
	// == 댓글을 기다리는 글 ==
	@GetMapping("/board/waitComment.do")
	public String WaitCommentGet(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response, ParameterDTO parameterDTO) {
		
		// 로그인 여부 및 권한 검증
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		if (loginMember == null) {
			JSFunction.alertLocation(response, "로그인 후 이용해 주세요", "../member/login.do");
			return null;
		}
		
		// 게시글의 개수를 고려하여 페이징 기능 구현
		int total = boardDAO.countNoComment();
		int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * postsPerPage + 1;
		int end = pageNum * postsPerPage;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("total", total);
		maps.put("postsPerPage", postsPerPage);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		String pagingImg = PagingUtil.pagingImg(total, postsPerPage, pagesPerBlock, pageNum, req.getContextPath()+"/board/waitComment.do?");
		model.addAttribute("pagingImg", pagingImg);
		
		// 게시물의 목록
		ArrayList<BoardDTO> postList = boardDAO.listNoComment(parameterDTO);
		for (BoardDTO post : postList) {
			String nickname = boardDAO.selectBoardNickname(post);
			String emoji = boardDAO.selectBoardEmoji(post);
			int likecount = boardDAO.countLike(Integer.toString(post.getBoard_idx()));
			int commentcount = boardDAO.countComment(post);
			if (emoji != null) post.setNickname(nickname + " " + emoji);
			else post.setNickname(nickname);
			post.setLikecount(likecount);
			post.setCommentcount(commentcount);
		}
		model.addAttribute("postList", postList);
		
		return "board/waitComment";
 	}

}
