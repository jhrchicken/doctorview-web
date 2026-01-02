<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 병원 예약</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-alert.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">
      	
      	<div class="complete_wrap">
	      	<div class="complete">
	      		<img src="/images/complete.svg" alt="" />
	      		
	      		<p>예약이 완료되었습니다.</p>
				<p class="caution">방문 시 신분증을 꼭 지참해주세요!</p>
	      		
	      		<div class="table_wrap">
		      		<div class="table">
		      			<table>
		      				<tr>
		      					<td class="left">병원</td>
		      					<td>${ reserveDTO.hospname }</td>
		      				</tr>
		      				<tr>
		      					<td class="left">날짜 및 시간</td>
		      					<td>${ reserveDTO.postdate } ${ reserveDTO.posttime }</td>
		      				</tr>
		      				<tr>
		      					<td class="left">방문자</td>
		      					<td>${ reserveDTO.username }</td>
		      				</tr>
						</table>
		      		</div>
	      		</div>
							
				<div class="btn_wrap">
					<a href="/myReserve.do">예약관리 페이지로 이동</a>
				</div>
	      	</div>
      	</div>
            
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>