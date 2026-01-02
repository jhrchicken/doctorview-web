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
<link rel="stylesheet" href="/css/doc-list.css" />
<script src="/js/doctor.js"></script>
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>의사 찾기</h2>
			<h3>의사 이름과 전공으로 검색해보세요</h3>
			
			<!-- 검색 메뉴 -->
			<div class="search_menu">
				<form class="search_form" name="searchForm">
					<div class="search_keyword">
						<select class="search_field" name="searchField">
							<option value="name">-- 조건 선택 --</option>
							<option value="name">이름</option>
							<option value="major">전공</option>
						</select>
						<input type="text" class="search_word" name="searchWord" placeholder="검색어를 입력하세요.">
						<input type="submit" class="search_btn" value="">
					</div>
				</form>
			</div>
			
			<!--  병원 목록 -->
			<div id="doctorListContent"></div>
			
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