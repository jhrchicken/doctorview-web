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
		<h5 class="card-title fw-semibold mb-4">예약 관리</h5>
		<div class="card">
    	<table class="table table-bordered">
    		<tr class="text-center" id="boardTr">
    			<th>No</th>
    			<th>병원명</th>
    			<th>의사 이름</th>
    			<th>회원 이름</th>
    			<th>전화번호</th>
    			<th>주민번호</th>
    			<th>날짜</th>
    			<th>예약 상태</th>
    			<th></th>
			</tr>	
<c:choose>
	<c:when test="${ not empty reserveList }">
		<c:forEach items="${ reserveList }" var="row" varStatus="loop">
			<tr <c:if test="${ row.cancel eq 'T' }">class="table-dark"</c:if>>
				<td>${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
				<td>${ row.hospname }</td>
				<td>${ row.doctorname }</td>
				<td>${ row.username }</td>
				<td>${ row.tel }</td>
				<td>${ row.rrn }</td>
				<td>${ row.postdate }</td>
				<td>${ row.cancel eq 'T' ? '예약취소' : '예약' }</td>
				<td>
					<%-- <button type="button" class="btn btn-warning" onclick="location.href='board_edit.do?boardname=${param.boardname}&board_idx=${row.board_idx}';">수정</button> --%>
					<button type="button" class="btn btn-danger" onclick="reserveChange('${row.app_id}','${ row.cancel }');">예약변경</button>
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
let reserveChange = function(app_id, cancel){
	if(confirm('변경할까요?')){
		location.href='reserve_change.do?app_id='+app_id+'&cancel='+cancel ;
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