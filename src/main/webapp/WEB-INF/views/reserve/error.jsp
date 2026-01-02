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
	      		<img src="/images/cancel.svg" alt="" />
	      		<div class="message">
					<p>예약이 실패되었습니다.</p>
					<p>해당 병원으로 문의 부탁드립니다.</p>
	      		</div>
				<a href="../../hospital.do">병원 찾으러 가기</a>
	      	</div>
      	</div>
    
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>