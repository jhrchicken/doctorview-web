<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="/js/freeboard.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-view.css" />
</head>

<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<!-- 서브 헤더 -->
		<div class="sub_header">
			<div class="sub_content">
				<div class="sub_loc">
					<ul>
						<li class="active"><a href="/freeboard.do">자유게시판</a></li>
						<li><a href="/qnaboard.do">상담게시판</a></li>
						<li><a href="/board/bestPost.do">베스트게시판</a></li>
						<li><a href="/board/myPost.do">내가 쓴 글</a></li>
						<li><a href="/board/myComment.do">댓글 단 글</a></li>
						<c:if test="${ sessionScope.loginMember.auth == 'ROLE_HOSP' }">
							<li><a href="/board/waitComment.do">댓글을 기다리는 글</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="content">
			<div class="board_wrap">
				<div class="board">
					<div class="board_title">
						<strong class="title">${ boardDTO.title }</strong>
						<ul class="detail">
							<li>
								<span>작성자 : <em>${ boardDTO.nickname }</em></span>
								<span>작성일 : <em>${ boardDTO.postdate }</em></span>
								<span>조회수 : <em>${ boardDTO.visitcount }</em></span>
							</li>
						</ul>
						<!-- 게시글 수정/삭제 버튼 -->
						<div class="btn_wrap">
							<c:if test="${ boardDTO.writer_ref == sessionScope.userId }">
								<a class="edit_btn" href="/freeboard/editPost.do?board_idx=${ param.board_idx }"><span>수정하기</span></a>
								<a class="delete_btn" href="javascript:void(0);" onclick="deletePost(${ param.board_idx });"><span>삭제하기</span></a>
							</c:if>
						</div>
					</div>
					
					<div class="board_content">
						${ boardDTO.content }
						
						<!-- 좋아요 및 신고 -->
						<div class="reaction_btn">
					        <button id="likeButton" type="button" class="${likecheck == 1 ? 'push' : ''}" onclick="clickLike(${boardDTO.board_idx});">
					            <span class="like_count" id="likeCount">${boardDTO.likecount}</span>
					        </button>
					        <button id="reportButton" type="button" class="${reportcheck == 1 ? 'push' : ''}" onclick="clickReport(${boardDTO.board_idx});">
					            <span class="report_count" id="reportCount">${boardDTO.reportcount}</span>
					        </button>
					    </div>
					</div>
				</div>
				
				<div class="list_btn">
					<a href="/freeboard.do">목록보기</a>
				</div>
				
				<!-- 게시글 삭제를 위한 폼 -->
				<form name="deletePostForm">
					<input type="hidden" name="board_idx" value="${ boardDTO.board_idx }" />
				</form>
				
				<!-- == 댓글 == -->
				<div class="comment">
					<!-- 댓글 작성 -->
					<form class="comment_form" id="writeCommentForm" onsubmit="return writeComment();">
					    <input type="hidden" id="comm_write_board_ref" value="${ param.board_idx }" />
	                    <textarea class="write_comment" id="comm_write_content" placeholder="로그인 후 작성 가능합니다."></textarea>
	                    <button type="submit">작성하기</button>
					</form>
					
					<table>
						<colgroup>
							<col width="150px">
							<col width="*">
							<col width="150px">
							<col width="150px">
						</colgroup>
						<tbody>
							<c:choose>
								<c:when test="${ empty commentList }">
									<tr>
										<td colspan="4" align="center">
											첫 댓글을 남겨보세요
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${ commentList }" var="row" varStatus="loop">
										<tr id="comment-${row.comm_idx}" align="center">
								            <td class="writer">${ row.nickname }</td>
								            <td class="comm_content" align="left">${ row.content }</td> 
								            <td class="postdate">${ row.postdate }</td>
								            
								            <!-- 댓글 수정/삭제 버튼 -->
										  	<td class="comm_btn">
												<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
										            <button type="button" data-bs-toggle="modal" data-bs-target="#editCommentModal"
										                    onclick="openEditModal(${ row.comm_idx }, '${ row.content }', '${ row.writer_ref }', ${ row.board_ref })">
										                수정
										            </button>
													<button type="button" onclick="deleteComment(${ row.comm_idx }, '${ row.writer_ref }', ${ row.board_ref });">
														삭제
													</button>
												</c:if>
											</td>
								        </tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>

			</div>
		</div>	
	</main>
    <%@include file="../common/main_footer.jsp" %>


	<!-- == 댓글 수정 모달창 == -->
	<form id="editCommentForm" onsubmit="return editComment();">
		<input type="hidden" id="comm_edit_comm_idx" value="">
		<input type="hidden" id="comm_edit_writer_ref" value="" />
		<input type="hidden" id="comm_edit_board_ref" value="" />
		<div class="modal" id="editCommentModal" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">댓글 수정</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<textarea class="form-control" id="comm_edit_content" style="height: 100px;"></textarea>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">수정하기</button>
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	
</body>   
</html>