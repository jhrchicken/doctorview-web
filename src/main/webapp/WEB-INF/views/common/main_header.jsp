<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<script src="/js/main-header.js"></script>

<header id="header">
	<div class="inner">
		<h1 class="logo">
			<a href="/">닥터뷰</a>
		</h1>
		<nav class="gnb">
			<ul>
				<li>
					<a class="depth1" href="#none">병원/의사 찾기</a>
					<div class="depth2">
						<ul>
							<li><a href="/hospital.do">병원 찾기</a></li>
							<li><a href="/doctor.do">의사 찾기</a></li>
							<li><a href="/hospital/map.do">지도로 찾기</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a class="depth1" href="#none">게시판</a>
					<div class="depth2">
						<ul>
							<li><a href="/freeboard.do">자유게시판</a></li>
							<li><a href="/qnaboard.do">상담게시판</a></li>
							<li><a href="/board/bestPost.do">베스트게시판</a></li>
							<li><a href="/board/myPost.do">내가 쓴 글</a></li>
							<li><a href="/board/myComment.do">댓글 단 글</a></li>
							<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' }">
								<li><a href="/board/waitComment.do">댓글을 기다리는 글</a></li>
							</c:if>
						</ul>
					</div>
				</li>
				<li>
					<a class="depth1" href="#none">이모지</a>
					<div class="depth2">
						<ul>
							<li><a href="/myEmoji.do">나의 이모지</a></li>
							<li><a href="/store.do">이모지 상점</a></li>  
						</ul>
					</div>
				</li>
				<li>
					<a class="depth1" href="#none">마이페이지</a>
					<div class="depth2">
						<ul>
							<!-- 공통: 개인정보 수정 -->
							<c:if test="${ sessionScope.userAuth != 'ROLE_HOSP' }">
								<li><a href="/member/checkMember.do">개인정보 수정</a></li>
							</c:if>
							<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' }">
								<li><a href="/member/checkMember.do">개인정보 수정</a></li>
							</c:if>
							<!-- 병원 권한: 의사 관리 -->
							<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' }">
								<li><a href="/member/doctorInfo.do">의사 관리</a></li>
							</c:if>
							<c:if test="${ sessionScope.userAuth != 'ROLE_HOSP' }">
								<li><a href="/myReserve.do">예약 내역</a></li>
							</c:if>
							<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' }">
								<li><a href="/reserve/setTime.do?id=${ userId }">예약 관리</a></li>
								<!-- **************** 이거 요청명 수정해야 할듯 *********** -->
								<li><a href="/myReserve.do">예약 리스트</a></li>
							</c:if>
							<!-- 일반 사용자 권한: 찜한 병원 및 찜한 의사 / 작성한 리뷰 / 출석체크 -->
							<c:if test="${ sessionScope.userAuth != 'ROLE_HOSP' }">
								<li><a href="/mypage/myHosp.do">찜한 병원</a></li>
								<li><a href="/mypage/myDoctor.do">찜한 의사</a></li>
								<li><a href="/mypage/myReview.do">작성한 리뷰</a></li>
								<li><a href="/mypage/attend.do">출석체크</a></li>
							</c:if>
						</ul>
					</div>
				</li>
			</ul>
		</nav>
		
		<div class="util_menu">
			<ul>
				<!-- 로그인 하지 않은 상태 -->
				<c:if test="${ empty sessionScope.userId }">
					<li><a href="/member/login.do">로그인</a></li>
					<li><a href="/member/join.do">회원가입</a></li>
					<li class="global_btn"><a href="#none"></a></li>
				</c:if>
				<!-- 로그인 한 상태 -->
				<c:if test="${ not empty sessionScope.userId }">
					<li><p class="user_name">${ loginMember.nickname } ${ loginMember.emoji }</p><p>님</p></li>
					<li><a href="/member/logout.do">로그아웃</a></li>
					<li><a href="/myReserve.do">나의 예약</a></li>
					<li class="chat_btn"><a href="javascript:void(0);" onclick="openChatList('${ sessionScope.userName }', '${ hospitalDTO.name }');"></a></li>
				</c:if>
			</ul>
		</div>
	
	
	</div>
</header>