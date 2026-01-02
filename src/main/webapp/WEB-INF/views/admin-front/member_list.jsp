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
		<h5 class="card-title fw-semibold mb-4">회원 관리</h5>
		<div class="card">
    	<table class="table table-bordered">
    		<tr class="text-center" id="boardTr">
    			<th>No</th>
    			<th>아이디</th>
    			<th>이름</th>
    			<th>닉네임</th>
    			<th>전화번호</th>
    			<th>이메일</th>
    			<th>등급</th>
    			<th></th>
			</tr>
<c:choose>
	<c:when test="${ not empty memberList }">
		<c:forEach items="${ memberList }" var="row" varStatus="loop">
			<tr>
				<td>${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
				<td>${ row.id }</td>
				<td>${ row.name }</td>
				<td>${ row.nickname }</td>
				<td>${ row.tel }</td>
				<td>${ row.email }</td>
				<td>
					<c:choose>
						<c:when test="${ row.auth eq 'ROLE_ADMIN' }">
							관리자
						</c:when>	
						<c:when test="${ row.auth eq 'ROLE_USER' }">
							일반회원
						</c:when>
						<c:when test="${ row.auth eq 'ROLE_HOSP' }">
							병원회원
						</c:when>
					</c:choose>
				</td>
				<td class="table_btn_wrap">
					<c:choose>
						<c:when test="${ row.auth eq 'ROLE_USER' }">
							<button type="button" class="btn btn-warning" onclick="location.href='member_edit.do?id=${row.id}';">수정</button>
							<button type="button" class="btn btn-danger" onclick="deleteMember('${row.id}');">삭제</button>
						</c:when>
						<c:when test="${ row.auth eq 'ROLE_HOSP' }">
							<button type="button" class="btn btn-info" onclick="location.href='member_edit.do?id=${row.id}';">수정</button>
							<button type="button" class="btn btn-danger" onclick="deleteMember('${row.id}');">삭제</button>
						</c:when>
					</c:choose>
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