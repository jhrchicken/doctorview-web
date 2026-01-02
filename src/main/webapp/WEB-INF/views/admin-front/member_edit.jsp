<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="./inc/common_head.jsp" %>
<body>
  <!--  Body Wrapper -->
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    <!-- Sidebar Start -->
    <aside class="left-sidebar">
      <!-- Sidebar scroll-->
      <div>
      	<!-- 관리자 글로벌 로고 -->
        <%@ include file="./inc/global_logo.jsp" %>        
        <!-- 좌측메뉴 인클루드-->
        <%@ include file="./inc/left_menu.jsp" %>
      </div>
      <!-- End Sidebar scroll-->
    </aside>
    <!--  Sidebar End -->
    <!--  Main wrapper -->
    <div class="body-wrapper">
      <!-- 관리자 상단 헤더 알림 영역 -->
      <%@ include file="./inc/header_alert.jsp" %>
      <div class="container-fluid">
<!-- ############ 컨텐츠는 여기부터 Start ########## -->
<form name="frm" method="post" action="member_edit.do">
<input type="hidden" name="auth" value="${ memberDTO.auth }" />
<div class="card">
	<div class="card-body">
		<h5 class="card-title fw-semibold mb-4">일반회원수정</h5>
		<div class="card">
    	<table class="table table-bordered">
    		<tr class="text-center">
    			<th>아이디</th>
    			<td><input type="text" name="id" value="${ memberDTO.id }" readonly class="form-control" /></td>
			</tr>         		
    		<tr class="text-center">
    			<th>패스워드</th>
    			<td><input type="password" name="password" value="${ memberDTO.password }" class="form-control" /></td>
			</tr>         		
    		<tr class="text-center">
    			<th>이름</th>
    			<td><input type="text" name="name" value="${ memberDTO.name }" class="form-control" /></td>
			</tr>         		
    		<tr class="text-center">
    			<th>닉네임</th>
    			<td><input type="text" name="nickname" value="${ memberDTO.nickname }" class="form-control" /></td>
			</tr>         		
    		<tr class="text-center">
    			<th>전화번호</th>
    			<td>
    			<div class="row">
	    			<div class="col">    			
	    				<input type="text" name="tel1" value="${ tel[0] }" class="form-control" />
	    			</div>
					<div class="col">    				
	    				<input type="text" name="tel2" value="${ tel[1] }" class="form-control" />
	    			</div>
					<div class="col">    				
	    				<input type="text" name="tel3" value="${ tel[2] }" class="form-control" />
	    			</div>
    			</div>
    			</td>
			</tr>         		
    		<tr class="text-center">
    			<th>이메일</th>
    			<td>
    			<div class="row">
	    			<div class="col">    			
	    				<input type="text" name="email1" value="${ email[0] }" class="form-control" />
	    			</div>
					<div class="col">    				
	    				<input type="text" name="email2" value="${ email[1] }" class="form-control" />
	    			</div>
    			</div>
    			</td>
			</tr>  
			<tr class="text-center">
    			<th>주소</th>
    			<td><input type="text" name="address" value="${ memberDTO.address }" class="form-control" /></td>
			</tr>      
			<tr class="text-center">
    			<th>주민등록번호</th>
    			<td>
    			<div class="row">
	    			<div class="col">    			
	    				<input type="text" name="rrn1" value="${ rrn1 }" class="form-control" />
	    			</div>
					<div class="col">    				
	    				<input type="text" name="rrn2" value="${ rrn2 }" class="form-control" />
	    			</div>
    			</div>
    			</td>
			</tr>   		
			</table>
    	</div>
	</div>
	<div class="btn_wrap">
		<button type="submit" class="btn btn-primary">전송</button>
		<button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
	</div>
</div>
</form>	
<script>
let deleteMember = function(user_id){
	if(confirm('삭제할까요?')){
		location.href='member_delete.do?id='+user_id ;
	}
}
</script>
<!-- ############ 컨텐츠는 여기가 End ########## -->
      </div>
    </div>
  </div>
  <!-- 공통 스크립트 -->
  <%@ include file="./inc/common_script.jsp" %>
</body>
</html>