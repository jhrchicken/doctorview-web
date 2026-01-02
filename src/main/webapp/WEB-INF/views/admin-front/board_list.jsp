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
<div class="card">
	<div class="card-body">
		<h5 class="card-title fw-semibold mb-4">게시판 관리</h5>
		<div class="card">
    	<table class="table table-bordered">
    		<tr class="text-center" id="boardTr">
    			<th>No</th>
    			<th>제목</th>
    			<th>작성자</th>
    			<th>작성일</th>
    			<th>좋아요</th>
    			<th>댓글</th>
    			<th></th>
			</tr>	
<c:choose>
	<c:when test="${ not empty postsList }">
		<c:forEach items="${ postsList }" var="row" varStatus="loop">
			<tr>
				<td>${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
				<td>${ row.title }</td>
				<td>${ row.nickname }</td>
				<td>${ row.postdate }</td>
				<td>${ row.likecount }</td>
				<td>${ row.commentcount }</td>
				<td class="table_btn_wrap">
					<button type="button" class="btn btn-warning" onclick="location.href='board_edit.do?boardname=${param.boardname}&board_idx=${row.board_idx}';">수정</button>
					<button type="button" class="btn btn-danger" onclick="deletePost('${row.board_idx}');">삭제</button>
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="10">작성된 게시물이 없습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>              		
			</table>
    	</div>
	</div>
	<div class="pagination">
		<div class="pagination_inner">
			${ pagingImg }
		</div>
	</div>	
</div>
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