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
	if (form.id.value == '') {
		alert("아이디를 입력하세요.");
		form.id.focus();
		return false;
	}
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
        <h2>회원 로그인</h2>
        <p>닥터뷰 회원으로 로그인하시면 제공하는<br>
          다양한 서비스를 이용할 수 있습니다.</p>
          
        <!-- 로그인 실패 시 메시지 -->
        <c:if test="${ not empty loginFailed }">
	   		<p class="fail">${ loginFailed }</p>
        </c:if>
	
        <form name="loginFrm" method="post" action="../member/login.do" onsubmit="return validateForm(this);">
          <div class="login">
            <p>아이디</p>
            <input type="text" name="id" value="${ cookie.saveId.value }" placeholder="아이디 입력">
            <span></span>
            <p>비밀번호</p>
            <input type="password" name="password" value="" placeholder="비밀번호 입력">
          </div>
          <label class="checkbox_wrap">
			<c:if test="${ not empty cookie.saveId.value }">
			  <input id="rememberId" name="saveId" value="save" type="checkbox" checked>
			</c:if>
			<c:if test="${ empty cookie.saveId.value }">
			  <input id="rememberId" name="saveId" value="save" type="checkbox" >
			</c:if>
            <label for="rememberId">아이디 저장</label>
          </label>
             <input class="login_btn" type="submit" value="로그인"/>
        </form>
        <div class="other_wrap">
          <ul>
            <li><a href="../member/findId.do">아이디 찾기</a></li>
            <li>|</li>
            <li><a href="../member/findPass.do">비밀번호 찾기</a></li>
            <li>|</li>
            <li><a href="../member/join.do">회원가입</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</main>	
<%@ include file="../common/main_footer.jsp" %>
</body>
</html>