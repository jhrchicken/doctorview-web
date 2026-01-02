<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 로그인</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-findPass.css" />
<script>
	function validateForm(form) {
		if (!form.id.value) {
			alert("아이디를 입력하세요.");
			form.id.focus();
			return false;
		}
		if (!form.email.value) {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return false;
		}
	}
</script>
</head>
<body>

<%@ include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
      	
		<%-- <div class="alertPass">
	      	<p>${ passInfo }</p>
			<p>${ notfountPass }</p>
      	</div> --%>

      	
		
      
        <h2>비밀번호 찾기</h2>
        
        <!-- 알림 메세지 -->
        <p>${ passInfo }</p>
		<p>${ notfountPass }</p>
		
		
        <form name="findPassFrm" method="post" action="../member/findPass.do" onsubmit="return validateForm(this);">
          <div class="login">
            <p>아이디</p>
            <input type="text" name="id" value="" placeholder="아이디 입력" />
            <span></span>
            <p>이메일</p>
            <input type="email" name="email" value="" placeholder="이메일 입력" />
          </div>
	      <div class="login_btn">
	        <input type="submit" value="임시 비밀번호 발급"/>
	      </div>
        </form>
        <div class="other_wrap">
          <p>아이디가 기억나지 않는다면?<a href="/member/findId.do">아이디 찾기</a></p>
        </div>
      </div>
    </div>
  </div>
</main>
	
<%@include file="../common/main_footer.jsp" %>

</body>
</html>