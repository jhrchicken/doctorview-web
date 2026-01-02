package com.edu.springboot.board;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBoardService {
	
	// == 베스트 게시판 ==
	// 게시글 개수 카운트
	public int countBestPost();
	// 한 페이지에 출력할 게시글 목록 인출
	public ArrayList<BoardDTO> listBestPost(ParameterDTO parameterDTO);
	

	// == 내가 쓴 글 ==
	// 게시글 개수 카운트
	public int countMyPost(String id);
	// 한 페이지에 출력할 게시글 목록 인출
	public ArrayList<BoardDTO> listMyPost(String id, ParameterDTO parameterDTO);
	
	
	// == 댓글 단 글 ==
	// 게시글 개수 카운트
	public int countMyComment(String id);
	// 한 페이지에 출력할 게시글 목록 인출
	public ArrayList<BoardDTO> listMyComment(String id, ParameterDTO parameterDTO);
	
	
	// == 댓글을 기다리는 글 ==
	// 게시글 개수 카운트
	public int countNoComment();
	// 한 페이지에 출력할 게시글 목록 인출
	public ArrayList<BoardDTO> listNoComment(ParameterDTO parameterDTO);

	
	// == 정보 표시 ==
	// 게시글 작성자의 닉네임 인출
	public String selectBoardNickname(BoardDTO boardDTO);
	// 게시글 작성자의 이모지 인출
	public String selectBoardEmoji(BoardDTO boardDTO);
	// 좋아요 수 조회
	public int countLike(String recodenum);
	// 댓글 수 조회
	public int countComment(BoardDTO boardDTO);
	
	
	// == 플러터 연동 ==
	// 게시판 목록
	public List<BoardDTO> getAllBoards();
	// 댓글 목록
	public List<CommentDTO> getAllComments();
	
}
