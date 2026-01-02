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
<link rel="stylesheet" href="/css/my-heart-hospital.css" />
</head>

<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<!-- 서브 헤더 -->
		<div class="sub_header">
			<div class="sub_content">
				<div class="sub_loc">
					<ul>
						<li class="active"><a href="/mypage/myHosp.do">찜한 병원</a></li>
						<li><a href="/mypage/myDoctor.do">찜한 의사</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="content">
			<h2>찜한 병원</h2>
			<!--  병원 목록 -->
			<div class="hosp_wrap">
				<div class="hosp_list">
					<c:choose>
						<c:when test="${ empty hospList }">
							<div>
								<p class="none">찜한 병원이 없어요<br/>마음에 드는 병원을 찜해보세요</p>
							</div>
						</c:when>
						<c:otherwise>
							<ul class="hosp">
								<c:forEach items="${ hospList }" var="row" varStatus="loop">
									<li onclick="location.href='../hospital/viewHosp.do?api_idx=${ row.api_idx }'">
										<!-- 병원 사진 -->
										<div class="hosp_photo">
											<c:if test="${ row.photo == null }">
												<img src="/images/hospital.png" alt="">
											</c:if>
											<c:if test="${ row.photo != null }">
												<img src="/uploads/${ row.photo }" alt="">
											</c:if>
										</div>
										<!-- 병원 정보 -->
										<div class="hosp_info">
											<div class="hosp_name">
												<p>${ row.name }</p>
												<c:if test="${ row.enter == 'T' }">
													<span class="hosp_mark"></span>
												</c:if>
											</div>
											<div class="hosp_dept">
												<p>${ row.department }</p>
											</div>
											<div class="hosp_tel">
												<p class="sub_tit">전화</p>
												<div class="divider"></div>
												<p>${ row.tel }</p>
											</div>
											<div class="hosp_addr">
												<p class="sub_tit">주소</p>
												<div class="divider"></div>
												<p>${ row.address }</p>
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
											<!-- 해시태그 -->
											<c:if test="${ row.enter == 'T' }">
												<c:if test="${ not empty hashtagList }">
													<div class="hosp_hashtag">
														<ul>
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.hosp_ref != null and hashrow.hosp_ref == row.id }">
																	<li class="tag">
																		<p># ${ hashrow.tag }
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</c:if>
											</c:if>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
				
				<!-- 페이지네이션 -->
				<c:if test="${ not empty hospList }">
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