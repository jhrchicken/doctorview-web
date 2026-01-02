package com.edu.springboot.board;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IFreeboardService {
	
	// == 게시글 ==
	// 게시글 개수 카운트
	public int countPost(ParameterDTO parameterDTO);
	// 한 페이지에 출력할 게시글 목록 인출
	public ArrayList<BoardDTO> listPost(ParameterDTO parameterDTO);
	// 게시글 조회
	public BoardDTO viewPost(BoardDTO boardDTO);
	// 게시글 조회수 증가
	public int plusVisitcount(BoardDTO boardDTO);
	// 게시글 작성
	public int writePost(BoardDTO boardDTO);
	// 게시글 수정
	public int editPost(BoardDTO boardDTO);
	// 게시글 삭제
	public int deletePost(String board_idx);
	
	
	// == 댓글 ==
	// 댓글 개수 카운트
	public int countComment(BoardDTO boardDTO);
	// 댓글 목록 조회
	public ArrayList<CommentDTO> listComment(BoardDTO boardDTO);
	// 댓글 조회
	public CommentDTO selectComment(CommentDTO commentDTO);
	// 댓글 작성
	public int writeComment(CommentDTO commentDTO);
	// 댓글 수정
	public int editComment(CommentDTO commentDTO);
	// 댓글 삭제
	public int deleteComment(String comm_idx);
	
	
	// == 정보 표시 ==
	// 게시글 작성자 닉네임 인출
	public String selectBoardNickname(BoardDTO boardDTO);
	// 게시글 작성자 이모지 인출
	public String selectBoardEmoji(BoardDTO boardDTO);
	// 댓글 작성자 닉네임 인출
	public String selectCommNickname(CommentDTO commentDTO);
	// 댓글 작성자 이모지 인출
	public String selectCommEmoji(CommentDTO commentDTO);
	
	
	// == 좋아요 ==
	// 좋아요 수 조회
	public int countLike(String recodenum);
	// 좋아요 표시 여부 확인
	public int checkLike(String id, String board_idx);
	// 좋아요 수 증가
	public int plusLike(String id, String board_idx);
	// 좋아요 수 감소
	public int minusLike(String id, String board_idx);
	// 게시글의 모든 좋아요 삭제
	public int deleteAllLike(String board_idx);
	
	
	// == 신고 ==
	// 신고 수 조회
	public int countReport(int board_idx);
	// 신고 표시 여부 확인
	public int checkReport(String id, String board_idx);
	// 신고 수 증가
	public int plusReport(String id, String board_idx);
	// 신고 수 감소
	public int minusReport(String id, String board_idx);
	// 게시글의 모든 신고 삭제
	public int deleteAllReport(String board_idx);
}