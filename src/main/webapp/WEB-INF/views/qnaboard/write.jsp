<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-write.css" />
<script src="/js/qnaboard.js"></script>
</head>

<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<!-- 서브 헤더 -->
		<div class="sub_header">
			<div class="sub_content">
				<div class="sub_loc">
					<ul>
						<li><a href="/freeboard.do">자유게시판</a></li>
						<li  class="active"><a href="/qnaboard.do">상담게시판</a></li>
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
			<div class="content_inner">
				<h2>글 작성하기</h2>
				<form id="writeForm" name="writeForm" method="post" action="/qnaboard/writePost.do">
					<div class="board_wrap">
						<p class="rt_note">필수입력사항</p>
						<table>
							<colgroup>
								<col width="130px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">제목<span class="ess"></span></th>
									<td>
										<span class="form_text">
											<input maxlength="50" name="title" placeholder="제목을 입력해주세요" type="text" value="">
										</span>
									</td>
								</tr>
								<tr>
									<th scope="col">내용<span class="ess"></span></th>
									<td>
										<span class="form_textarea">
											<textarea cols="5" maxlength="500" name="content" placeholder="내용을 입력해주세요" rows="10"></textarea>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<!-- 알림 -->
					<div class="notice">
						<ul>
							<li>· 닥터뷰는 누구나 기분 좋게 참여할 수 있는 커뮤니티를 만들기 위해 커뮤니티 이용규칙을 제정하여 운영하고 있습니다.</li>
							<li>· 욕설, 비속어, 비방성 표현 등 부적절한 내용이 포함된 게시물은 삭제되고 서비스 이용이 일정 기간 제한될 수 있습니다.</li>
						</ul>
					</div>
					<!-- 버튼 -->
					<div class="btn_wrap">
						<a class="cancel_btn" href="/qnaboard.do"><span>취소</span></a>
						<a class="write_btn" href="javascript:void(0);" onclick="if(validateWriteForm(document.writeForm)) { document.writeForm.submit(); }"><span>작성하기</span></a>
					</div>
				</form>
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>










