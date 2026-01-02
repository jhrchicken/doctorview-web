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
		<!--  병원 목록 -->
		<div class="hosp_wrap">
			<div class="hosp_list">
				<c:choose>
					<c:when test="${ empty hospList }">
						<div>
							<p class="none">검색 결과가 없습니다</p>
						</div>
					</c:when>
					<c:otherwise>
						<ul class="hosp">
							<c:forEach items="${ hospList }" var="row" varStatus="loop">
								<li onclick="location.href='./hospital/viewHosp.do?api_idx=${ row.api_idx }'">
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
															<c:if test="${ hashrow.hosp_ref == row.id }">
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
		</div>
	</body>
</html>