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
<form name="frm" method="post" action="board_edit.do">
<div class="card">
	<div class="card-body">
		<h5 class="card-title fw-semibold mb-4">게시판관리</h5>
		<div class="card">
		<input type="hidden" name="boardname" value="${ param.boardname }" />
		<input type="hidden" name="board_idx" value="${ param.board_idx }" />
    	<table class="table table-bordered">
    		<tr class="text-center">
    			<th>제목</th>
    			<td><input type="text" name="title" value="${ boardDTO.title }" class="form-control"  /></td>    			
			</tr>	
    		<tr class="text-center">
    			<th>내용</th>
    			<td><textarea name="content" cols="30" rows="10"  class="form-control">${ boardDTO.content }</textarea></td>    			
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
let deletePost = function(board_idx){
	if(confirm('삭제할까요?')){
		location.href='board_delete.do?boardname=${param.boardname}&board_idx='+board_idx ;
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