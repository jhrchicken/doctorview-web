<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 예약관리</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-doctor-list.css" />
<script>
function deleteDoctor(doc_idx) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		var form = document.forms["deleteDoctorForm_" + doc_idx];
		form.method = "post";
		form.action = "/doctor/deleteDoctor.do";
		form.submit();
	}
}
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>예약 목록</h2>
			
			
			
			
<div class="my_doctor">
<c:choose>
	<c:when test="${ empty reserveInfo }">
		<div>
			<p>예약정보가 없습니다</p>
		</div>
	</c:when>
	<c:otherwise>
		<ul class="doctor">
			<c:forEach items="${ reserveInfo }" var="row" varStatus="loop">
				<!-- 의사 정보 -->
				<li>
					<form name="deleteDoctorForm_${row.app_id}">
						<input type="hidden" name="app_id" value="${ row.app_id }" />
					</form>
					<div class="info">
						<div class="info_top">
							<h3>${ row.hospname }</h3>
							<div class="detail">
								<div class="details">
									<p class="blue">예약 의사</p>
									<p>${ row.doctorname }</p>
								</div>
								<div class="details">
									<p class="blue">예약자</p>
									<p>${ row.username }</p>
								</div>
								<div class="details">
									<p class="blue">날짜</p>
									<p>${ row.postdate }</p>
								</div>
								<div class="details">
									<p class="blue">시간</p>
									<p>${ row.posttime }</p>
								</div>
							    <c:if test="${ not empty row.user_memo }">
								<div class="details">
									<p class="blue">메모</p>
									<p>${ row.user_memo }</p>
								</div>
        						</c:if>
							</div>
						</div>
					</div>
					
					<!-- 하단 메뉴(버튼) -->
					<div class="board_btn">
						<button type="button" onclick="location.href='/doctor/editDoctor.do?doc_idx=${ row.app_id }';">메모추가</button>
						<button type="button" onclick="deleteDoctor(${ row.app_id });">삭제</button>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:otherwise>
</c:choose>
</div>
			
			
			
			
			
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>