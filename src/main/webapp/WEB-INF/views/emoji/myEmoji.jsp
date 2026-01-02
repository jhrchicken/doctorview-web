<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/emoji-my.css" />
</head>

<body>
	<%@ include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
				<h2>MY EMOJI</h2>
				
				<div class="emoji_list">
					<ul>
						<!-- 프로필 -->
						<li>
							<div class="member_info">
								<dl>
									<dt>${ sessionScope.loginMember.name }님</dt>
									<dd><strong>${ sessionScope.loginMember.point }P</strong></dd>
								</dl>
								<a class="store_btn" href="/store.do">
									<span>상점으로 가기</span>
								</a>
							</div>
						</li>
						<!-- 이모지 목록 -->
						<c:forEach items="${ emojiList }" var="row" varStatus="loop">
							<li>
								<form action="/emoji/editEmoji.do" method="post">
									<div class="emoji">
										<p>${ row.emoji }</p>
										<input type="hidden" name="emoji" value="${ row.emoji }">
									</div>
									<div class="tit">
										<strong>${ row.title }</strong>
										<input type="hidden" name="title" value="${ row.title }">
									</div>
									<span class="sub">${ row.descr }</span>
									<div class="price">
										<span>${ row.price } point</span>
										<input type="hidden" name="price" value="${ row.price }">
									</div>
							        <!-- 이모지 사용 여부에 따라 버튼 표시 -->
									<div class="emoji_btn">
						                <c:choose>
						                    <c:when test="${ row.emoji == sessionScope.loginMember.emoji }">
						                        <button type="submit" class="used_btn"><span>해제하기</span></button>
						                        <input type="hidden" name="state" value="disable">
						                    </c:when>
						                    <c:otherwise>
						                        <button type="submit" class="change_btn"><span>사용하기</span></button>
						                        <input type="hidden" name="state" value="enable">
						                    </c:otherwise>
						                </c:choose>
									</div>
								</form>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="../common/main_footer.jsp" %>
</body>
</html>