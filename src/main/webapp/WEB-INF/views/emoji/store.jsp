<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/emoji-store.css" />
<script src="/js/emoji.js"></script>
</head>

<body>
<!-- 이모지 구매 실패 알림 -->
<c:if test="${not empty emojiBuyError}">
    <script>
        alert("${emojiBuyError}");
    </script>
</c:if>

<%@ include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="user_info">
				<h2>이모지 상점</h2>
				<p>
					<c:if test="${ not empty sessionScope.loginMember }">
						<span>${ sessionScope.loginMember.nickname } ${ sessionScope.loginMember.emoji }</span> 님의 포인트는 
						<c:if test="${ not empty sessionScope.loginMember.point }">
						    <span>${ sessionScope.loginMember.point } point</span>
						</c:if>
						<c:if test="${ empty sessionScope.loginMember.point }">
						    <span>0 point</span>
						</c:if>
						입니다.<br/>
					</c:if>
					<c:if test="${ empty sessionScope.loginMember }">
						<p>로그인 후 이용 가능합니다</p>
					</c:if>
					포인트로 귀여운 이모지를 구매해보세요!
				</p>
			</div>
			<div class="tab_menu">
				<ul>
					<li><a href="">ALL</a></li>
					<li><a href="">신규</a></li>
					<li><a href="">인기</a></li>
					<li><a href="">미보유</a></li>
				</ul>
			</div>
			<div class="emoji_list">
				<ul>
					<c:forEach items="${ storeList }" var="row" varStatus="loop">
						<li>
							<form action="/store/buy.do" method="post">
				                <input type="hidden" name="store_idx" value="${ row.store_idx }">
				                <c:if test="${ not empty row.type }">
					                <div class="label">
					                	<span>${ row.type }</span>
					                </div>
				                </c:if>
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
								
								<!-- 회원이 보유한 이모지인지 확인 -->
				                <c:set var="hasEmoji" value="false"/>
				                <c:forEach items="${ emojiList }" var="myEmoji">
				                    <c:if test="${ myEmoji.emoji == row.emoji }">
				                        <c:set var="hasEmoji" value="true"/>
				                    </c:if>
				                </c:forEach>
				
								<div class="emoji_btn">
					                <!-- 이모지 보유 여부에 따라 버튼 표시 -->
					                <c:choose>
					                    <c:when test="${ hasEmoji }">
					                        <button type="button" class="used_btn">보유중</button>
					                    </c:when>
					                    <c:otherwise>
					                        <button type="submit" class="buy_btn"><span>구매하기</span></button>
					                    </c:otherwise>
					                </c:choose>
								</div>
							</form>
						</li>
					</c:forEach>
				</ul>
				<ul>
					<c:forEach items="${ storeList }" var="row" varStatus="loop">
						<c:if test="${ row.type == 'new' }">
							<li>
								<form action="/store/buy.do" method="post">
					                <input type="hidden" name="store_idx" value="${ row.store_idx }">
									<c:if test="${ not empty row.type }">
						                <div class="label">
						                	<span>${ row.type }</span>
						                </div>
					                </c:if>
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
									
									<!-- 회원이 보유한 이모지인지 확인 -->
					                <c:set var="hasEmoji" value="false"/>
					                <c:forEach items="${ emojiList }" var="myEmoji">
					                    <c:if test="${ myEmoji.emoji == row.emoji }">
					                        <c:set var="hasEmoji" value="true"/>
					                    </c:if>
					                </c:forEach>
					
									<div class="emoji_btn">
						                <!-- 이모지 보유 여부에 따라 버튼 표시 -->
						                <c:choose>
						                    <c:when test="${ hasEmoji }">
						                        <button type="button" class="used_btn">보유중</button>
						                    </c:when>
						                    <c:otherwise>
						                        <button type="submit" class="buy_btn"><span>구매하기</span></button>
						                    </c:otherwise>
						                </c:choose>
									</div>
								</form>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				<ul>
					<c:forEach items="${ storeList }" var="row" varStatus="loop">
						<c:if test="${ row.type == 'best' }">
							<li>
								<form action="/store/buy.do" method="post">
					                <input type="hidden" name="store_idx" value="${ row.store_idx }">
									<c:if test="${ not empty row.type }">
						                <div class="label">
						                	<span>${ row.type }</span>
						                </div>
					                </c:if>
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
									
									<!-- 회원이 보유한 이모지인지 확인 -->
					                <c:set var="hasEmoji" value="false"/>
					                <c:forEach items="${ emojiList }" var="myEmoji">
					                    <c:if test="${ myEmoji.emoji == row.emoji }">
					                        <c:set var="hasEmoji" value="true"/>
					                    </c:if>
					                </c:forEach>
					
									<div class="emoji_btn">
						                <!-- 이모지 보유 여부에 따라 버튼 표시 -->
						                <c:choose>
						                    <c:when test="${ hasEmoji }">
						                        <button type="button" class="used_btn">보유중</button>
						                    </c:when>
						                    <c:otherwise>
						                        <button type="submit" class="buy_btn"><span>구매하기</span></button>
						                    </c:otherwise>
						                </c:choose>
									</div>
								</form>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				<ul>
					<c:forEach items="${ storeList }" var="row" varStatus="loop">
						<!-- 회원이 보유한 이모지인지 확인 -->
						<c:set var="hasEmoji" value="false"/>
						<c:forEach items="${ emojiList }" var="myEmoji">
		                    <c:if test="${ myEmoji.emoji == row.emoji }">
		                        <c:set var="hasEmoji" value="true"/>
		                    </c:if>
						</c:forEach>
						
						<c:if test="${ hasEmoji == false }">
							<li>
								<form action="/store/buy.do" method="post">
					                <input type="hidden" name="store_idx" value="${ row.store_idx }">
									<c:if test="${ not empty row.type }">
						                <div class="label">
						                	<span>${ row.type }</span>
						                </div>
					                </c:if>
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
									<div class="emoji_btn">
										<button type="submit" class="buy_btn"><span>구매하기</span></button>
									</div>
								</form>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</main>

<%@ include file="../common/main_footer.jsp" %>
</body>
</html>