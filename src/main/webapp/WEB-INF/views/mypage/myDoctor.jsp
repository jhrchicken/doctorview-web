<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-heart-doctor.css" />
</head>

<body>
<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<!-- 서브 헤더 -->
		<div class="sub_header">
			<div class="sub_content">
				<div class="sub_loc">
					<ul>
						<li><a href="/mypage/myHosp.do">찜한 병원</a></li>
						<li class="active"><a href="/mypage/myDoctor.do">찜한 의사</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="content">
			<h2>찜한 의사</h2>
			<!-- 의사 목록 -->
			<div class="doc_wrap">
				<div class="doc_list">
					<c:choose>
						<c:when test="${ empty doctorList }">
							<div>
								<p class="none">찜한 의사가 없어요<br/>마음에 드는 의사를 찜해보세요</p>
							</div>
						</c:when>
						<c:otherwise>
							<ul class="doctor">
								<c:forEach items="${ doctorList }" var="row" varStatus="loop">
									<li onclick="location.href='../doctor/viewDoctor.do?doc_idx=${ row.doc_idx }'">
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
				
				<!-- 페이지네이션 -->
				<c:if test="${ not empty doctorList }">
					<div class="pagination">
						<div class="pagination_inner">
							${ pagingImg }
						</div>
					</div>
				</c:if>
				
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>