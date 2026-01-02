<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 로그인</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-login.css" />
<script>
// 	폼값 검증
function validateForm(form) {
	if (form.password.value == '') {
		alert("비밀번호를 입력하세요.");
		form.password.focus();
		return false;
	}

	return true;
}
</script>
</head>
<body>
	<%@ include file="../common/main_header.jsp" %>
	<main id="container">
	  <div class="content">
	    <div class="content_inner">
	      <div class="login_wrap">
	        <h2>회원 인증</h2>
	        <p>로그인한 회원의 비밀번호를 입력해주세요.</p>
	        
          	<!-- 회원인증 실패 시 메시지 -->
	        <c:if test="${ not empty checkMemberFaild }">
				<!-- css 변경필요 -->
		   		<p class="fail">${ checkMemberFaild }</p>
	        </c:if>
	        <form name="loginFrm" method="post" action="../member/checkMember.do" onsubmit="return validateForm(this);">
	          <div class="login">
	            <input type="hidden" name="id" value="${ userId }">
	            <p>비밀번호</p>
	            <input type="password" name="password" value="" placeholder="비밀번호 입력">
	          </div>
              <input class="login_btn" type="submit" value="회원인증"/>
	        </form>
	      </div>
	    </div>
	  </div>
	</main>	
	<%@ include file="../common/main_footer.jsp" %>
</body>
</html>