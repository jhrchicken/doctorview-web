<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 로그인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-findId.css" />
<script>
	function validateForm(form) {
		if (!form.email.value) {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return false;
		}
		if (!form.password.value) {
			alert("비밀번호를 입력하세요.");
			form.password.focus();
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
      	
      	<!-- 아이디 찾기 후 알림 -->
        <c:if test="${ not empty foundId or not empty notfountId }">
        	<c:if test="${ not empty foundId }">
	        <div class="alertId">
		      	<p>회원님의 아이디는<br /><strong>'${ foundId }'</strong>입니다.</p>
				<p>${ notfountId }</p>
	      	</div>
        	</c:if>
			<c:if test="${ not empty notfountId }">
	        <div class="alertId">
				<p>${ notfountId }</p>
	      	</div>
        	</c:if>
        </c:if>
      	
        <h2>아이디 찾기</h2>
        <form name="findIdFrm" method="post" action="../member/findId.do" onsubmit="return validateForm(this);">
          <div class="login">
            <p>이메일</p>
            <input type="text" name="email" value="" placeholder="이메일 입력">
            <span></span>
            <p>비밀번호</p>
            <input type="password" name="password" value="" placeholder="이메일 입력">
          </div>
          
          <!-- a 태그 css 적용 필요 -->
	      <div class="login_btn">
		    <c:if test="${empty foundId and empty notfountId}">
		        <input type="submit" value="회원인증"/>
		    </c:if>
		    
		    <c:if test="${not empty foundId}">
		        <a href="/member/login.do">로그인</a>
		    </c:if>
		    
		    <c:if test="${not empty notfountId}">
		        <a href="/member/join.do">회원가입</a>
		    </c:if>
		</div>
		
        </form>
      </div>
    </div>
  </div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>