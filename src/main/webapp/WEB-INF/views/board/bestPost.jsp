<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-list.css" />
</head>

<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="sub_header">
			<div class="sub_content">
				<div class="sub_loc">
					<ul>
						<li><a href="/freeboard.do">자유게시판</a></li>
						<li><a href="/qnaboard.do">상담게시판</a></li>
						<li class="active"><a href="/board/bestPost.do">베스트게시판</a></li>
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
			<h2>베스트게시판</h2>
			<div class="board_wrap">
				<div class="board_content">
					<p class="board_total">총 <strong>${ maps.total }</strong>건의 게시글이 있습니다.</p>
					
					<!-- 게시글 목록 -->
					<table class="board">
						<thead>
							<tr>
								<th width="100px">NO</th>
								<th width="150px">게시판</th>
								<th>내용</th>
								<th width="150px">작성자</th>
								<th width="120px">작성일</th>
								<th width="80px">좋아요</th>
								<th width="80px">댓글</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty postList }">
									<tr>
										<td colspan="7" align="center">등록된 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${ postList }" var="row" varStatus="loop">
										<!-- 자유게시판 게시물 -->
										<c:if test="${ row.boardname == 'freeboard' }">
											<tr onclick="location.href='/freeboard/viewPost.do?board_idx=${ row.board_idx }'">
												<td class="num">${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
												<td class="boardname">자유게시판</td>
												<td>
													<p class="title">${ row.title }</p>
													<p class="intro">${ row.content }</p>
												</td>
												<td class="nickname">${ row.nickname }</td>
												<td class="date">${ row.postdate }</td>
												<td class="like">${ row.likecount }</td>
												<td class="comment">${ row.commentcount }</td>
											</tr>
										</c:if>
										<!-- 상담게시판 게시물 -->
										<c:if test="${ row.boardname == 'qnaboard' }">
											<tr onclick="location.href='/qnaboard/viewPost.do?board_idx=${ row.board_idx }'">
												<td class="num">${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
												<td class="boardname">상담게시판</td>
												<td>
													<p class="title">${ row.title }</p>
													<p class="intro">${ row.content }</p>
												</td>
												<td class="nickname">${ row.nickname }</td>
												<td class="date">${ row.postdate }</td>
												<td class="like">${ row.likecount }</td>
												<td class="comment">${ row.commentcount }</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
	
					<!-- 페이지네이션 -->
					<c:if test="${ not empty postList }">
						<div class="pagination">
							<div class="pagination_inner">
								${ pagingImg }
							</div>
						</div>	
					</c:if>
				</div>
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>

