<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 회원가입</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-join.css" />
</head>
<body>
	<%@ include file="../common/main_header.jsp" %>
	<main id="container">
	  <div class="content">
	    <div class="content_inner">
	      <div class="login_wrap">
	        <h2>회원가입</h2>
	        <p>가입하실 계정을 선택해주세요.</p>
	        <div class="btn_wrap">
	          <a href="../member/join/user.do"><span>🧍‍♂️</span><p>일반회원</p></a>
	          <a href="../member/join/hosp.do"><span>🏥</span><p>병원회원</p></a>        
	        </div>
	      </div>
	    </div>
	  </div>
	</main>
	<%@ include file="../common/main_footer.jsp" %>
</body>
</html>