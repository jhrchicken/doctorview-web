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
		<h5 class="card-title fw-semibold mb-4">병원회원 승인관리</h5>
		<div class="card">
    	<table class="table table-bordered">
    		<tr class="text-center" id="boardTr">
    			<th>No</th>
    			<th>아이디</th>
    			<th>병원명</th>
    			<th>전화번호</th>
    			<th>승인여부</th>
    			<th></th>
			</tr>
<c:choose>
	<c:when test="${ not empty memberList }">
		<c:forEach items="${ memberList }" var="row" varStatus="loop">
			<tr <c:if test="${ row.enable eq 0 }">class="table-dark"</c:if>>
				<td>${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
				<td>${ row.id }</td>
				<td>${ row.name }</td>
				<td>${ row.tel }</td>
				<td>
					<c:choose>
						<c:when test="${ row.enable eq 0 }">
							승인안됨
						</c:when>	
						<c:when test="${ row.enable eq 1 }">
							승인됨
						</c:when>
					</c:choose>
				</td>
				<td class="table_btn_wrap">
				<c:if test="${ row.enable eq 0 }">
					<button type="button" class="btn btn-danger" onclick="enabledChange('${ row.id }','1');">승인</button>
					<button type="button" class="btn btn-primary" onclick="enabledChange('${ row.id }','delete');">거절</button>
				</c:if>
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="10">등록된 회원이 없습니다.</td>
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
let enabledChange = function(id, enabled){
	let msg = "";
	if(enabled==1){
		msg = "승인으로 변경할까요?";
	}
	else if(enabled=='delete'){
		msg = "선택한 병원회원을 삭제할까요?";
	}
	
	if(confirm(msg)){
		location.href='hospital_change.do?id='+id+'&enabled='+enabled ;
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