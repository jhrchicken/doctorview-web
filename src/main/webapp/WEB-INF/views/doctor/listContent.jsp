<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>닥터뷰</title>
	</head>
	
	<body>
		<input type="hidden" id="count" value="${ count }">
		<!-- 의사 목록 -->
		<div class="doc_wrap">
			<div class="doc_list">
				<c:choose>
					<c:when test="${ empty doctorList }">
						<div>
							<p class="none">검색 결과가 없습니다</p>
						</div>
					</c:when>
					<c:otherwise>
						<ul class="doctor">
							<c:forEach items="${ doctorList }" var="row" varStatus="loop">
								<li onclick="location.href='./doctor/viewDoctor.do?doc_idx=${ row.doc_idx }'">
									<!-- 의사 사진 -->
									<div class="doc_photo">
										<c:if test="${ row.photo == null }">
											<img src="/images/doctor.png" alt="">
										</c:if>
										<c:if test="${ row.photo != null }">
											<img src="/uploads/${ row.photo }" alt="">
										</c:if>
									</div>
									<!-- 의사 정보 -->
									<div class="doc_info">
										<div class="doc_name">
											<p>${ row.name }</p>
										</div>
										<div class="doc_hosp">
											<p>${ row.hospname }</p>
										</div>
										<div class="doc_major">
											<p class="sub_tit">전공</p>
											<div class="divider"></div>
											<p>${ row.major }</p>
										</div>
										<div class="doc_career">
											<p class="sub_tit">경력</p>
											<div class="divider"></div>
											<p>${ row.career }</p>
										</div>
										<div class="doc_hours">
											<p class="sub_tit">근무시간</p>
											<div class="divider"></div>
											<p>${ row.hours }</p>
										</div>
										<!-- 찜과 리뷰 -->
										<div class="info_right">
											<div class="like">
												<img src="/images/mark_full.svg" alt="">
												<p>${ row.likecount }</p>
											</div>
											<div class="review">
												<img src="/images/star.svg" alt="">
												<p>${ row.score }</p>
												<p class="count">(${ row.reviewcount })</p>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</body>
</html>