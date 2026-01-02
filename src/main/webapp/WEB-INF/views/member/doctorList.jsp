<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
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
			<h2>의사 목록</h2>
			
			<div class="add_doctor">
				<button type="button" onclick="location.href='/doctor/writeDoctor.do'">의사 등록하기</button>
			</div>
			
			<div class="my_doctor">
				<c:choose>
					<c:when test="${ empty doctorDTO }">
						<div>
							<p>등록된 의사가 없습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
						<ul class="doctor">
							<c:forEach items="${ doctorDTO }" var="row" varStatus="loop">
								<!-- 의사 정보 -->
								<li>
									<form name="deleteDoctorForm_${row.doc_idx}">
										<input type="hidden" name="doc_idx" value="${ row.doc_idx }" />
									</form>
									<span class="img">
										<!-- ****************** DB 업데이트 후 결과 확인 필요 *****************  -->
										<c:if test="${ row.photo == null }">
											<img src="/images/doctor.png" alt="" />
										</c:if>
										<c:if test="${ row.photo != null }">
											<img src="/uploads/${ row.photo }" alt="" />
										</c:if>
									</span>
									<div class="info">
										<div class="info_top">
											<h3>${ row.name }</h3>
											<div class="detail">
												<div class="details">
													<p class="blue">전공</p>
													<p>${ row.major }</p>
												</div>
												<div class="details">
													<p class="blue">경력</p>
													<p>${ row.career }</p>
												</div>
												<div class="details">
													<p class="blue">근무시간</p>
													<p>${ row.hours }</p>
												</div>
											</div>
										</div>
										
										<a href="/doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span class="blind">의사 바로가기</span></a>
									</div>
									
									<!-- 하단 메뉴(버튼) -->
									<div class="board_btn">
										<button type="button" onclick="location.href='/doctor/editDoctor.do?doc_idx=${ row.doc_idx }';">수정</button>
										<button type="button" onclick="deleteDoctor(${ row.doc_idx });">삭제</button>
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