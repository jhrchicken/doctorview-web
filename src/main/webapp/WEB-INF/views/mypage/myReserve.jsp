<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>닥터뷰</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<%@ include file="../common/head.jsp" %>
		<link rel="stylesheet" href="/css/my-reserve.css" />
		<script src="/js/my-reserve.js"></script>
	</head>
	
	<body>
		<%@include file="../common/main_header.jsp" %>
		<main id="container">
			<div class="content">
				<h2>예약 내역</h2>
				<section class="reserve_history">
					<div class="tab">
						<ul>
							<li class="active"><a href="">전체</a></li>
							<li><a href="">완료된 예약</a></li>
							<li><a href="">취소된 예약</a></li>
						</ul>
					</div>
					
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="currentDate"/>
							
					<!-- 전체 -->
					<div class="tab_content">
					
						<!-- 예약이 있는지 확인 -->
						<c:set var="isNone" value="T" />
						<c:forEach items="${ reserveList }" var="row" varStatus="loop">
							<c:if test="${ userAuth eq 'ROLE_USER' and row.hide eq 'F' }">
								<c:set var="isNone" value="F" />
							</c:if>
						</c:forEach>
						<c:if test="${ userAuth eq 'ROLE_HOSP' and reserveList != null }">
					        <c:set var="isNone" value="F" />
					    </c:if>

						<c:choose>
							<c:when test="${ isNone eq 'T' }">
								<c:if test="${ userAuth eq 'ROLE_USER'}">
									<p class="none">예약된 병원이 없어요<br/>병원을 예약하고 방문해보세요</p>
								</c:if>
								<c:if test="${ userAuth eq 'ROLE_HOSP'}">
									<p class="none">예약된 손님이 없어요
								</c:if>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ reserveList }" var="row" varStatus="loop">
									
									<!-- user 회원 화면-->
									<c:if test="${ userAuth eq 'ROLE_USER' }">
										<c:if test="${ row.hide eq 'F' }">
											<form name="cancelReservationForm_${row.app_id}">
												<input type="hidden" name="app_id" value="${ row.app_id }" />
											</form>
											<form name="hideReservationForm_${row.app_id}">
												<input type="hidden" name="app_id" value="${ row.app_id }" />
											</form>
											
											<!-- 예약정보 -->
											<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
											<div class="reserve">
												<div class="info">
													<div class="top">
														<h2>${ row.hospname }</h2>
														<div class="btn_wrap">
															<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
																<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
															</c:if>
															<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
																<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
																<c:if test="${ row.hosp_review eq 'F' }">
																	<a class="review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeHospReviewModal"
																		onclick="openHospReviewWriteModal(${row.api_idx}, ${ row.app_id })" class="modal_link">
																		<span>병원 리뷰 작성</span>
																	</a>
																</c:if>
																<c:if test="${ row.doc_review eq 'F' }">
																	<a class="review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeDoctorReviewModal"
																		onclick="openDoctorReviewWriteModal(${row.doc_idx}, ${ row.app_id })" class="modal_link">
																		<span>의사 리뷰 작성</span>
																	</a>
																</c:if>
															</c:if>
															<c:if test="${ row.cancel eq 'T' }">
																<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
															</c:if>
															<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
														</div>
													</div>
													<div class="bottom">
														<dl>
															<dt>예약일</dt>
															<dd>${ row.postdate } ${ row.posttime }</dd>
															<dt>담당의</dt>
															<dd>${ row.doctorname }</dd>
														</dl>
														<dl>
															<dt>예약자 이름</dt>
															<dd>${ row.username }</dd>
															<dt>전화번호</dt>
															<dd>${ row.tel }</dd>
														</dl>
														<dl>
															<dt>주민등록번호</dt>
															<dd>${ row.rrn }</dd>
															<dt>주소</dt>
															<dd>${ row.address }</dd>
														</dl>
														<dl>
															<dt>메모</dt>
															<dd class="memo_dd">
																<div class="memo">
																	<c:if test="${ empty row.user_memo }">
																		<span>-</span>
									        						</c:if>
																	<c:if test="${ not empty row.user_memo }">
																		<span>${ row.user_memo }</span>
									        						</c:if>
																	<div class="memo_btn">
																		<button type="button" data-bs-toggle="modal" data-bs-target="#memoModal"
																			onclick="openMemoModal(${ row.app_id }, '${ row.user_memo }')">
																			<span>메모변경</span>
																		</button>
																	</div>
																</div>
															</dd>
														</dl>
													</div>
												</div>
											</div>
										</c:if>
									</c:if>
								
									<!-- hosp 회원 화면  -->
									<c:if test="${ userAuth eq 'ROLE_HOSP' }">
										<!-- 예약정보 -->
										<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
										<div class="reserve">
											<div class="info">
												<div class="top">
													<h2>${ row.hospname }</h2>
													<div class="btn_wrap">
														<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
															<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
														</c:if>
														<c:if test="${ row.cancel eq 'T' }">
															<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
														</c:if>
													</div>
												</div>
												<div class="bottom">
													<dl>
														<dt>예약일</dt>
														<dd>${ row.postdate } ${ row.posttime }</dd>
														<dt>담당의</dt>
														<dd>${ row.doctorname }</dd>
													</dl>
													<dl>
														<dt>예약자 이름</dt>
														<dd>${ row.username }</dd>
														<dt>전화번호</dt>
														<dd>${ row.tel }</dd>
													</dl>
													<dl>
														<dt>주민등록번호</dt>
														<dd>${ row.rrn }</dd>
														<dt>주소</dt>
														<dd>${ row.address }</dd>
													</dl>
													<dl>
														<dt>메모</dt>
														<dd class="memo_dd">
															<div class="memo">
																<c:if test="${ empty row.hosp_memo }">
																	<span>-</span>
								        						</c:if>
																<c:if test="${ not empty row.hosp_memo }">
																	<span>${ row.hosp_memo }</span>
								        						</c:if>
																<div class="memo_btn">
																	<button type="button" data-bs-toggle="modal" data-bs-target="#memoModal"
																		onclick="openMemoModal(${ row.app_id }, '${ row.hosp_memo }')">
																		<span>메모변경</span>
																	</button>
																</div>
															</div>
														</dd>
													</dl>
												</div>
											</div>
										</div>
									</c:if>
										
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					
					<!-- 완료된 예약 -->
					<div class="tab_content">
						<!-- 완료된 예약이 있는지 확인 -->
						<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
						<c:set var="isNone" value="T" />
						<c:forEach items="${ reserveList }" var="row" varStatus="loop">
							<c:if test="${ userAuth eq 'ROLE_USER' and row.hide eq 'F' and reserveDate lt currentDate and row.cancel eq 'F' }">
								<c:set var="isNone" value="F" />
							</c:if>
							<c:if test="${ userAuth eq 'ROLE_HOSP' and reserveDate lt currentDate and row.cancel eq 'F' }">
								<c:set var="isNone" value="F" />
							</c:if>
						</c:forEach>
					
						<c:choose>
							<c:when test="${ isNone eq 'T' }">
								<p class="none">완료된 예약이 없어요</p>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ reserveList }" var="row" varStatus="loop">
									<!-- user 회원 화면-->
									<c:if test="${ userAuth eq 'ROLE_USER' }">
										<c:if test="${ row.hide eq 'F' }">
											<form name="cancelReservationForm_${row.app_id}">
												<input type="hidden" name="app_id" value="${ row.app_id }" />
											</form>
											<form name="hideReservationForm_${row.app_id}">
												<input type="hidden" name="app_id" value="${ row.app_id }" />
											</form>
											
											<!-- 예약정보 -->
											<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
				            				<c:if test="${reserveDate lt currentDate and row.cancel eq 'F'}">
												<div class="reserve">
													<div class="info">
														<div class="top">
															<h2>${ row.hospname }</h2>
															<div class="btn_wrap">
																<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
																	<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
																</c:if>
																<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
																	<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
																	<c:if test="${ row.hosp_review eq 'F' }">
																		<a class="review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeHospReviewModal"
																			onclick="openHospReviewWriteModal(${row.api_idx}, ${ row.app_id })" class="modal_link">
																			<span>병원 리뷰 작성</span>
																		</a>
																	</c:if>
																	<c:if test="${ row.doc_review eq 'F' }">
																		<a class="review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeDoctorReviewModal"
																			onclick="openDoctorReviewWriteModal(${row.doc_idx}, ${ row.app_id })" class="modal_link">
																			<span>의사 리뷰 작성</span>
																		</a>
																	</c:if>
																</c:if>
																<c:if test="${ row.cancel eq 'T' }">
																	<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
																</c:if>
																<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
															</div>
														</div>
														<div class="bottom">
															<dl>
																<dt>예약일</dt>
																<dd>${ row.postdate } ${ row.posttime }</dd>
																<dt>담당의</dt>
																<dd>${ row.doctorname }</dd>
															</dl>
															<dl>
																<dt>예약자 이름</dt>
																<dd>${ row.username }</dd>
																<dt>전화번호</dt>
																<dd>${ row.tel }</dd>
															</dl>
															<dl>
																<dt>주민등록번호</dt>
																<dd>${ row.rrn }</dd>
																<dt>주소</dt>
																<dd>${ row.address }</dd>
															</dl>
															<dl>
																<dt>메모</dt>
																<dd class="memo_dd">
																	<div class="memo">
																		<c:if test="${ empty row.user_memo }">
																			<span>-</span>
										        						</c:if>
																		<c:if test="${ not empty row.user_memo }">
																			<span>${ row.user_memo }</span>
										        						</c:if>
																		<div class="memo_btn">
																			<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">
																				<span>메모변경</span>
																			</button>
																		</div>
																	</div>
																</dd>
															</dl>
														</div>
													</div>
												</div>
											</c:if>
										</c:if>
									</c:if>
								
									<!-- hosp 회원 화면-->
									<c:if test="${ userAuth eq 'ROLE_HOSP' }">
										<c:if test="${ row.hide eq 'F' }">
											<!-- 예약정보 -->
											<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
				            				<c:if test="${reserveDate lt currentDate and row.cancel eq 'F'}">
												<div class="reserve">
													<div class="info">
														<div class="top">
															<h2>${ row.hospname }</h2>
															<div class="btn_wrap">
																<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
																	<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
																</c:if>
																<c:if test="${ row.cancel eq 'T' }">
																	<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
																</c:if>
															</div>
														</div>
														<div class="bottom">
															<dl>
																<dt>예약일</dt>
																<dd>${ row.postdate } ${ row.posttime }</dd>
																<dt>담당의</dt>
																<dd>${ row.doctorname }</dd>
															</dl>
															<dl>
																<dt>예약자 이름</dt>
																<dd>${ row.username }</dd>
																<dt>전화번호</dt>
																<dd>${ row.tel }</dd>
															</dl>
															<dl>
																<dt>주민등록번호</dt>
																<dd>${ row.rrn }</dd>
																<dt>주소</dt>
																<dd>${ row.address }</dd>
															</dl>
															<dl>
																<dt>메모</dt>
																<dd class="memo_dd">
																	<div class="memo">
																		<c:if test="${ empty row.hosp_memo }">
																			<span>-</span>
										        						</c:if>
																		<c:if test="${ not empty row.hosp_memo }">
																			<span>${ row.hosp_memo }</span>
										        						</c:if>
																		<div class="memo_btn">
																			<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">
																				<span>메모변경</span>
																			</button>
																		</div>
																	</div>
																</dd>
															</dl>
														</div>
													</div>
												</div>
											</c:if>
										</c:if>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>

					<!-- 취소된 예약 -->
					<div class="tab_content">
						<!-- 취소된 예약이 있는지 확인 -->
						<c:set var="isNone" value="T" />
						<c:forEach items="${ reserveList }" var="row" varStatus="loop">
							<c:if test="${ userAuth eq 'ROLE_USER' and row.hide eq 'F' and row.cancel eq 'T' }">
								<c:set var="isNone" value="F" />
							</c:if>
							<c:if test="${ userAuth eq 'ROLE_HOSP' and row.cancel eq 'T' }">
						        <c:set var="isNone" value="F" />
						    </c:if>
						</c:forEach>

						<c:choose>
							<c:when test="${ isNone eq 'T' }">
								<p class="none">취소된 예약이 없어요</p>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ reserveList }" var="row" varStatus="loop">
									<!-- user 회원 화면-->
									<c:if test="${ userAuth eq 'ROLE_USER' }">
										<c:if test="${ row.hide eq 'F' }">
											<form name="cancelReservationForm_${row.app_id}">
												<input type="hidden" name="app_id" value="${ row.app_id }" />
											</form>
											<form name="hideReservationForm_${row.app_id}">
												<input type="hidden" name="app_id" value="${ row.app_id }" />
											</form>
											
											<!-- 예약정보 -->
				            				<c:if test="${row.cancel eq 'T'}">
												<div class="reserve">
													<div class="info">
														<div class="top">
															<h2>${ row.hospname }</h2>
															<div class="btn_wrap">
																<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
																	<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
																</c:if>
																<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
																	<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
																	<c:if test="${ row.hosp_review eq 'F' }">
																		<a class="review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeHospReviewModal"
																			onclick="openHospReviewWriteModal(${row.api_idx}, ${ row.app_id })" class="modal_link">
																			<span>병원 리뷰 작성</span>
																		</a>
																	</c:if>
																	<c:if test="${ row.doc_review eq 'F' }">
																		<a class="review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeDoctorReviewModal"
																			onclick="openDoctorReviewWriteModal(${row.doc_idx}, ${ row.app_id })" class="modal_link">
																			<span>의사 리뷰 작성</span>
																		</a>
																	</c:if>
																</c:if>
																<c:if test="${ row.cancel eq 'T' }">
																	<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
																</c:if>
																<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
															</div>
														</div>
														<div class="bottom">
															<dl>
																<dt>예약일</dt>
																<dd>${ row.postdate } ${ row.posttime }</dd>
																<dt>담당의</dt>
																<dd>${ row.doctorname }</dd>
															</dl>
															<dl>
																<dt>예약자 이름</dt>
																<dd>${ row.username }</dd>
																<dt>전화번호</dt>
																<dd>${ row.tel }</dd>
															</dl>
															<dl>
																<dt>주민등록번호</dt>
																<dd>${ row.rrn }</dd>
																<dt>주소</dt>
																<dd>${ row.address }</dd>
															</dl>
															<dl>
																<dt>메모</dt>
																<dd class="memo_dd">
																	<div class="memo">
																		<c:if test="${ empty row.user_memo }">
																			<span>-</span>
										        						</c:if>
																		<c:if test="${ not empty row.user_memo }">
																			<span>${ row.user_memo }</span>
										        						</c:if>
																		<div class="memo_btn">
																			<button type="button" data-bs-toggle="modal" data-bs-target="#memoModal"
																				onclick="openMemoModal(${ row.app_id }, '${ row.user_memo }')">
																				<span>메모변경</span>
																			</button>
																		</div>
																	</div>
																</dd>
															</dl>
														</div>
													</div>
												</div>
											</c:if>
										</c:if>
									</c:if>
								
									<!-- hosp 회원 화면-->
									<c:if test="${ userAuth eq 'ROLE_HOSP' }">
										<c:if test="${ row.hide eq 'F' }">
											<!-- 예약정보 -->
				            				<c:if test="${row.cancel eq 'T'}">
												<div class="reserve">
													<div class="info">
														<div class="top">
															<h2>${ row.hospname }</h2>
															<div class="btn_wrap">
																<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
																	<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
																</c:if>
																<c:if test="${ row.cancel eq 'T' }">
																	<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
																</c:if>
															</div>
														</div>
														<div class="bottom">
															<dl>
																<dt>예약일</dt>
																<dd>${ row.postdate } ${ row.posttime }</dd>
																<dt>담당의</dt>
																<dd>${ row.doctorname }</dd>
															</dl>
															<dl>
																<dt>예약자 이름</dt>
																<dd>${ row.username }</dd>
																<dt>전화번호</dt>
																<dd>${ row.tel }</dd>
															</dl>
															<dl>
																<dt>주민등록번호</dt>
																<dd>${ row.rrn }</dd>
																<dt>주소</dt>
																<dd>${ row.address }</dd>
															</dl>
															<dl>
																<dt>메모</dt>
																<dd class="memo_dd">
																	<div class="memo">
																		<c:if test="${ empty row.hosp_memo }">
																			<span>-</span>
										        						</c:if>
																		<c:if test="${ not empty row.hosp_memo }">
																			<span>${ row.hosp_memo }</span>
										        						</c:if>
																		<div class="memo_btn">
																			<button type="button" data-bs-toggle="modal" data-bs-target="#memoModal"
																				onclick="openMemoModal(${ row.app_id }, '${ row.hosp_memo }')">
																				<span>메모변경</span>
																			</button>
																		</div>
																	</div>
																</dd>
															</dl>
														</div>
													</div>
												</div>
											</c:if>
										</c:if>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</section>
			</div>
		</main>
		<%@include file="../common/main_footer.jsp" %>
		
		
		<!-- == 메모 모달창 == -->
		<form id="memoForm" method="post" action="../mypage/editMemo.do" onsubmit="return validateMemoForm(this);">
			<input type="hidden" id="memo_app_id" name="app_id" value="">
			<div class="modal" id="memoModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">메모</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<div class="modal-body">
							<c:if test="${ userAuth eq 'ROLE_USER' }">
								<textarea class="form-control" id="memo_content" name="user_memo" style="height: 100px;"></textarea>
							</c:if>
							<c:if test="${ userAuth eq 'ROLE_HOSP' }">
								<textarea class="form-control" id="memo_content" name="hosp_memo" style="height: 100px;"></textarea>
							</c:if>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">작성하기</button>
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		  
		<!-- == 병원 리뷰 작성 모달창 == -->
		<form method="post" action="../hospital/writeReview.do" onsubmit="return validateReviewForm(this);">
		    <input type="hidden" id="hosp_review_write_api_idx" name="api_ref" value="" />
		    <input type="hidden" id="hosp_app_id" name="app_id" value="">
		    <input type="hidden" id="hosp_review_write_hashtags" name="hashtags" />
		    <input type="hidden" id="hosp_review_write_score" name="score" value="" />
		    <div class="modal" id="writeHospReviewModal">
		        <div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h4 class="modal-title">&nbsp;</h4>
		                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		                </div>
		                <div class="modal-body">
		                    <!-- 해시태그 선택 -->
		                    <div class="form-group">
		                        <label>해시태그 선택:</label>
		                        <div id="hosp-hashtag-list">
		                            <!-- 해시태그 목록 -->
		                            <button type="button" class="btn btn-secondary">친절해요</button>
		                            <button type="button" class="btn btn-secondary">전문적이예요</button>
		                            <button type="button" class="btn btn-secondary">청결해요</button>
		                            <button type="button" class="btn btn-secondary">신속해요</button>
		                        </div>
		                    </div>
		                    <!-- 별 점수 선택 -->
		                    <div class="form-group">
		                        <label>점수 선택:</label>
		                        <div id="hosp-star-rating" style="cursor: pointer;">
		                            <!-- 별 아이콘 -->
		                            <img src="/images/star_empty.svg" class="hosp_star" data-value="1" />
		                            <img src="/images/star_empty.svg" class="hosp_star" data-value="2" />
		                            <img src="/images/star_empty.svg" class="hosp_star" data-value="3" />
		                            <img src="/images/star_empty.svg" class="hosp_star" data-value="4" />
		                            <img src="/images/star_empty.svg" class="hosp_star" data-value="5" />
		                        </div>
		                    </div>
		                    <!-- 폼 입력 -->
		                    <textarea class="form-control" name="doctor" style="height: 20px;" placeholder="담당 의사를 입력해주세요"></textarea>
		                    <textarea class="form-control" name="treat" style="height: 20px;" placeholder="치료 내용을 입력해주세요"></textarea>
		                    <textarea class="form-control" name="cost" style="height: 20px;" placeholder="비용을 입력해주세요"></textarea>
		                    <textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
		                </div>
		                <div class="modal-footer">
		                    <button type="submit" class="btn btn-primary">작성하기</button>
		                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		                </div>
		            </div>
		        </div>
		    </div>
		</form>
		
		<!-- == 의사 리뷰 작성 모달창 == -->
		<form method="post" action="../doctor/writeReview.do" onsubmit="return validateReviewForm(this);">
		   <input type="hidden" id="doc_review_write_doc_ref" name="doc_ref" value="" />
		   <input type="hidden" id="doc_app_id" name="app_id" value="">
		   <input type="hidden" id="doc_review_write_hashtags" name="hashtags" />
		    <input type="hidden" id="doc_review_write_score" name="score" value="" />
		   <div class="modal" id="writeDoctorReviewModal" >
		      <div class="modal-dialog">
		         <div class="modal-content">
		            <!-- Modal Header -->
		            <div class="modal-header">
		               <h4 class="modal-title">&nbsp;</h4>
		               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <!-- Modal Body -->
		            <div class="modal-body">
		               <!-- 해시태그 선택 -->
		                    <div class="form-group">
		                        <label>해시태그 선택:</label>
		                        <div id="doc-hashtag-list">
		                            <!-- 해시태그 목록 -->
		                            <button type="button" class="btn btn-secondary">친절해요</button>
		                            <button type="button" class="btn btn-secondary">전문적이예요</button>
		                            <button type="button" class="btn btn-secondary">청결해요</button>
		                            <button type="button" class="btn btn-secondary">신속해요</button>
		                        </div>
		                    </div>
		                    <!-- 별 점수 선택 -->
		                    <div class="form-group">
		                        <label>점수 선택:</label>
		                        <div id="doc-star-rating" style="cursor: pointer;">
		                            <!-- 별 아이콘 -->
		                            <img src="/images/star_empty.svg" class="doc_star" data-value="1" />
		                            <img src="/images/star_empty.svg" class="doc_star" data-value="2" />
		                            <img src="/images/star_empty.svg" class="doc_star" data-value="3" />
		                            <img src="/images/star_empty.svg" class="doc_star" data-value="4" />
		                            <img src="/images/star_empty.svg" class="doc_star" data-value="5" />
		                        </div>
		                    </div>
		               <textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
		            </div>
		            <!-- Modal Footer -->
		            <div class="modal-footer">
		               <button type="submit" class="btn btn-primary">작성하기</button>
		               <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		            </div>
		         </div>
		      </div>
		   </div>
		</form>
	</body>
</html>