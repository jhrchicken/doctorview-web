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
<link rel="stylesheet" href="/css/hosp-list.css" />
<script src="/js/hospital-list.js"></script>
</head>

<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>병원 찾기</h2>
			<h3>병원명, 지역명, 해시태그 등으로 검색해보세요</h3>
			
			<!-- 검색 메뉴 -->
			<div class="search_menu">
				<form class="search_form" name="searchForm">
					<!-- 지역 선택 -->
					<div class="search_region">
						<select class="search_field" id="sido" name="searchSido">
							<option value="">-- 시/도 선택 --</option>
							<c:forEach items="${ sidoList }" var="sido">
								<option value="${ sido.sido }">${ sido.sido }</option>
							</c:forEach>
						</select>
						<select id="gugun" name="searchGugun" class="search_field">
							<option value="">-- 시/군/구 선택 --</option>
						</select>
						<select id="dong" name="searchDong" class="search_field">
							<option value="">-- 읍/면/동 선택 --</option>
						</select>
					</div>
					
					<!-- 키워드 검색 -->
					<div class="search_keyword">
						<select class="search_field" name="searchField">
							<option value="name">-- 조건 선택 --</option>
							<option value="name">병원명</option>
							<option value="department">진료과목</option>
							<option value="hashtag">해시태그</option>
						</select>
						<input type="text" class="search_word" name="searchWord" placeholder="검색어를 입력하세요.">
						<button type="submit" class="search_btn" onclick="searchHosp(event)"></button>
					</div>
					
					<!-- 검색 필터 -->
					<div class="search_filter">
						<button type="button" class="filter-button" data-filter="parking" data-default-text="주차 가능">주차</button>
						<button type="button" class="filter-button" data-filter="pcr" data-default-text="PCR 검사 가능">PCR 검사</button>
						<button type="button" class="filter-button" data-filter="hospitalize" data-default-text="입원 가능">입원</button>
						<button type="button" class="filter-button" data-filter="system" data-default-text="예약 가능">예약</button>
						<button type="button" class="filter-button" data-filter="night" data-default-text="예약 가능">야간진료</button>
						<button type="button" class="filter-button" data-filter="weekend" data-default-text="예약 가능">주말진료</button>
					</div>
				</form>
			</div>
			
			<!--  병원 목록 -->
			<div id="hospListContent"></div>
		
			<!-- 더보기 버튼 -->
			<div class="btn_wrap">
				<a class="more_btn" href="">
					<span>더보기</span>
				</a>
			</div>
		</div>
		
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>