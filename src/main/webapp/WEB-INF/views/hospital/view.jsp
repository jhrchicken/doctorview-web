<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>닥터뷰</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
		<%@include file="../common/head.jsp" %>
		<link rel="stylesheet" href="/css/hosp-view.css" />
		<script src="/js/hospital-view.js"></script>
	</head>
	
	<body>
		<%@include file="../common/main_header.jsp" %>
		
		<main id="container">
			<div class="content">
				<div class="hosp_wrap">
					<!-- 병원 프로필 -->
					<div class="hosp_profile">
						<!-- 병원 사진 -->
						<div class="hosp_photo">
							<c:if test="${ hospitalDTO.photo == null }">
								<span class="hosp_photo">
									<img src="/images/hospital.png" alt="">
								</span>
							</c:if>
							<c:if test="${ hospitalDTO.photo != null }">
								<span class="hosp_photo">
									<img src="/uploads/${ hospitalDTO.photo }" alt="">
								</span>
							</c:if>
						</div>
						<!-- 병원 정보 -->
						<div class="hosp_info">
							<div class="hosp_name">
								<p>${ hospitalDTO.name }</p>
								<c:if test="${ hospitalDTO.enter == 'T' }">
									<span class="hosp_mark"></span>
								</c:if>
							</div>
							<div class="hosp_dept">
								<p>${ hospitalDTO.department }</p>
							</div>
							<div class="hosp_tel">
								<p class="sub_tit">전화</p>
								<div class="divider"></div>
								<p>${ hospitalDTO.tel }</p>
							</div>
							<div class="hosp_addr">
								<p class="sub_tit">주소</p>
								<div class="divider"></div>
								<p>${ hospitalDTO.address }</p>
							</div>
							<div class="hosp_detail">
								<c:if test="${ hospitalDTO.parking }">
									<div class="hosp_park">
										<p class="sub_tit">주차</p>
										<div class="divider"></div>
										<c:if test="${ hospitalDTO.parking == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.parking == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
								</c:if>
								<c:if test="${ hospitalDTO.system }">
									<div class="hosp_res">
										<p class="sub_tit">예약</p>
										<div class="divider"></div>
										<c:if test="${ hospitalDTO.system == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.system == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
								</c:if>
								<c:if test="${ hospitalDTO.hospitalize }">
									<div class="hosp_hosp">
										<p class="sub_tit">입원</p>
										<div class="divider"></div>
										<c:if test="${ hospitalDTO.hospitalize == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.hospitalize == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
								</c:if>
								<c:if test="${ hospitalDTO.pcr }">
									<div class="hosp_pcr">
										<p class="sub_tit">PCR 검사</p>
										<div class="divider"></div>
										<c:if test="${ hospitalDTO.pcr == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.pcr == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
								</c:if>
							</div>
							<!-- 찜 버튼 -->
							<div class="info_right">
								<c:if test="${ hosplikecheck == 0 }">
									<a class="save_btn" href="../hospital/clickHospLike.do?api_idx=${ param.api_idx }">
										<span>
											<img src="/images/mark.svg" alt="">
											${ hospitalDTO.likecount }
										</span>
									</a>
								</c:if>
								<c:if test="${ hosplikecheck == 1 }">
									<a class="save_btn" href="../hospital/clickHospLike.do?api_idx=${ param.api_idx }">
										<span>
											<img src="/images/mark_full.svg" alt="">
											${ hospitalDTO.likecount }
										</span>
									</a>
								</c:if>
							</div>
							<!-- 해시태그 -->
							<c:if test="${ hospitalDTO.enter == 'T' }">
								<c:if test="${ not empty hashtagList }">
									<div class="hosp_hashtag">
										<ul>
											<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
												<c:if test="${ hashrow.hosp_ref == hospitalDTO.id }">
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
					</div>
					
					<!-- 예약 / 채팅 버튼 -->
					<div class="btn_wrap">
						<!-- 예약 버튼 -->
						<c:if test="${ hospitalDTO.enter == 'T' && sessionScope.userName != null && sessionScope.userAuth != 'ROLE_HOSP' }">
							<a class="reserve_btn" href="/reserve/proceed.do?api_idx=${ param.api_idx }">
								<span>예약하기</span>
							</a>
						</c:if>
						<!-- 채팅 버튼 -->
						<c:if test="${ hospitalDTO.enter == 'T' && sessionScope.userName != null && sessionScope.userAuth != 'ROLE_HOSP' }">
						    <a class="chat_btn" href="javascript:void(0);" onclick="openChatRoom('${ sessionScope.userName }', '${ hospitalDTO.name }');">
								<span>채팅하기</span>
							</a>
						</c:if>
					</div>
					
					<!-- 의사 정보 -->
					<div class="doctor_info">
						<c:choose> 
							<c:when test="${ empty doctorList }">
								<div class="doctor_none">
									<p>의료진 정보가 존재하지 않습니다.</p>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ doctorList }" var="row" varStatus="loop">
							    	<div class="doctor">
							            <a href="../doctor/viewDoctor.do?doc_idx=${ row.doc_idx }">
							                <div class="doc_wrap">
							                    <div class="doc_img">
							                        <c:if test="${ row.photo == null }">
							                            <img src="/images/doctor.png" alt="" />
							                        </c:if>
							                        <c:if test="${ row.photo != null }">
							                            <img src="/uploads/${ row.photo }" />
							                        </c:if>
							                    </div>
							                    <div class="doc_content">
							                        <div class="doc_title">
							                            <h3>${ row.name }</h3>
							                            <p class="etc">${ row.major }</p>
							                        </div>
							                        <div class="doc_detail">
							                            <p class="blue">경력</p>
							                            <p class="etc">${ row.career }</p>
							                        </div>
							                        <div class="doc_detail">
							                            <p class="blue">진료 요일</p>
							                            <p class="etc">${ row.hours }</p>
							                        </div>
							                    </div>
							                </div>
							            </a>
							    	</div>
						        </c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
		
					<!-- 시간 정보 -->
					<div class="time_info">
						<c:forEach items="${ hourList }" var="row" varStatus="loop"> 
								<c:if test="${ row.starttime != '00:00' }">
									<div class="time">
										<p class="day">${ row.week }</p>
										<div class="time_detail">
											<p class="blue">영업시간</p>
											<p class="etc">${ row.starttime }-${ row.endtime }</p>
										</div>
										<c:if test="${ row.startbreak != '00:00' }">
											<div class="time_detail">
												<p class="blue">휴게시간</p>
												<p class="etc">${ row.startbreak }-${ row.endbreak }</p>
											</div>
										</c:if>
										<div class="time_detail">
											<p class="blue">접수마감</p>
											<p class="etc">${ row.deadline }</p>
										</div>
									</div>
								</c:if>
						</c:forEach>	
					</div>
					
					<div class="review_wrap">
						<div class="review_list">
							<form name="deleteReviewForm" method="post">
							    <input type="hidden" name="api_ref" value="" />
							    <input type="hidden" name="review_idx" value="" />
							</form>
							<form name="deleteReplyForm" method="post">
							    <input type="hidden" name="api_ref" value="" />
							    <input type="hidden" name="review_idx" value="" />
							</form>
						
							<!-- 리뷰 요약 -->
							<div class="review_summary">
								<p class="total_count">총 <span>${ hospitalDTO.reviewcount }</span>건의 리뷰가 있어요</p>
								<p class="avg_score">${ hospitalDTO.score }</p>
								<div class="avg_star">
									<c:choose>
										<c:when test="${ hospitalDTO.score != 0 }">
											<div class="star">
												<c:forEach var="i" begin="0" end="${hospitalDTO.score - 1}">
													<img src="/images/star.png" alt="" />
												</c:forEach>
												<c:forEach var="i" begin="${hospitalDTO.score}" end="4">
													<img src="/images/star_empty.png" alt="" />
												</c:forEach>
											</div>
										</c:when>
										<c:otherwise>
											<div class="star">
												<c:forEach var="i" begin="0" end="4">
													<img src="/images/star_empty.png" alt="" />
												</c:forEach>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							
							<!-- 리뷰 -->
							<c:if test="${ not empty reviewList }">
								<ul class="review">
									<c:forEach items="${ reviewList }" var="row" varStatus="loop">
										<c:if test="${ row.original_idx == row.review_idx }">
											<li>
												<!-- 작성자 아이콘 -->
												<div class="review_icon">
													<img src="/images/face2.png"/>
												</div>
												<!-- 리뷰 정보 -->
												<div class="review_info">
													<!-- 닉네임 -->
													<div class="review_nickname">
														<p>${ row.nickname }</p>
													</div>
													<!-- 날짜 및 수정 여부 -->
													<div class="info_right">
														<div class="review_date">
															<p>${ row.postdate }</p>
															<c:if test="${ row.rewrite == 'T' }">
																<p class="dot">・</p>
																<p class="edit">수정됨</p>
															</c:if>
														</div>
													</div>
													<!-- 별점 -->
													<div class="review_score">
														<div class="star">
															<c:forEach var="i" begin="0" end="${row.score - 1}">
																<img src="/images/star.png" alt="" />
															</c:forEach>
															<c:forEach var="i" begin="${row.score}" end="4">
																<img src="/images/star_empty.png" alt="" />
															</c:forEach>
														</div>
														<p>${ row.score }</p>
													</div>
													<!-- 추가 정보 -->
													<div class="review_extra">
														<c:if test="${ row.doctor != null }">
															<div class="extra_content">
																<p class="sub_tit">담당의</p>
																<p>${ row.doctor }</p>
															</div>
														</c:if>
														<c:if test="${ row.treat != null }">
															<c:if test="${ row.doctor != null }">
																<div class="divider"></div>
															</c:if>
															<div class="extra_content">
																<p class="sub_tit">치료내용</p>
																<p>${ row.treat }</p>			
															</div>
														</c:if>
														<c:if test="${ row.cost != null }">
															<c:if test="${ row.doctor != null or row.treat != null }">
																<div class="divider"></div>
															</c:if>
															<div class="extra_content">
																<p class="sub_tit">비용</p>
																<p>${ row.cost }원</p>					
															</div>
														</c:if>
													</div>
													<!-- 해시태그 -->
													<c:if test="${ not empty hashtagList }">
														<div class="review_hashtag">
															<ul>
																<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																	<c:if test="${ hashrow.hreview_ref == row.review_idx }">
																		<li class="tag">
																			<p># ${ hashrow.tag }</p>
																		</li>
																		<c:if test="${!loop.last && hashtagList[loop.index + 1].hreview_ref == row.review_idx}">
																			<div class="divider"></div>
																		</c:if>
																	</c:if>
																</c:forEach>
															</ul>
														</div>
													</c:if>
													<!-- 내용 -->
													<div class="review_content">
														<p>${ row.content }</p>
													</div>
													<!-- 버튼 -->
													<div class="button_wrap">
														<!-- 좋아요 버튼 -->
														<c:if test="${ row.likecheck == 0 }">
															<p>이 리뷰가 도움이 돼요!</p>
															<a class="comm_like_btn" href="../hospital/clickReviewLike.do?api_ref=${ row.api_ref }&review_idx=${ row.review_idx }">
																<span>
																	<img src="/images/review_like_btn.svg" style="width: 20px; height: 20px;" />
																	${ row.likecount }
																</span>
															</a>
														</c:if>
														<c:if test="${ row.likecheck == 1 }">
															<p>이 리뷰가 도움이 돼요!</p>
															<a class="comm_like_btn" href="../hospital/clickReviewLike.do?api_ref=${ row.api_ref }&review_idx=${ row.review_idx }">
																<span>
																	<img src="/images/review_like_btn_filled.svg" style="width: 20px; height: 20px;" />
																	${ row.likecount }
																</span>
															</a>
														</c:if>
														<!-- 답변 작성 버튼 -->
														<c:if test="${ hospitalDTO.id == sessionScope.loginMember.id }">
															<a class="reply_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
																onclick="openReplyWriteModal(${ row.api_ref }, ${ row.review_idx });">
																<span>답변 작성하기</span>
															</a>
														</c:if>
														<div class="crud_btn">
															<!-- 리뷰 수정 버튼 -->
															<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
																<a class="edit_review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#editReviewModal"
																	onclick="openReviewEditModal(${ row.api_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }', '${ row.cost }', '${ row.treat }', '${ row.doctor }')">
																	<span>수정하기</span>
																</a>
															</c:if>
															<!-- 리뷰 삭제 버튼 -->
															<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
																<a class="delete_review_btn" href="javascript:void(0);" onclick="deleteReview(${ row.api_ref }, ${ row.review_idx });">
																	<span>삭제하기</span>
																</a>
															</c:if>
														</div>
													</div>
												</div>
											</li>
										</c:if>
										
										<!-- 리뷰에 대한 답변 출력 -->
										<ul class="reply">
											<c:forEach items="${ reviewList }" var="replyRow">
												<c:if test="${ replyRow.original_idx == row.review_idx and replyRow.review_idx != replyRow.original_idx }">
													<li>
														<!-- 화살표 -->
														<div class="reply_arrow">
															<img src="/images/sub_arrow_right.svg"/>
														</div>
														<!-- 작성자 아이콘 -->
														<div class="reply_icon">
															<img src="/images/face1.png"/>
														</div>
														<!-- 답변 정보 -->
														<div class="reply_info">
															<!-- 닉네임 -->
															<div class="reply_nickname">
																<p>${ replyRow.nickname }</p>
																<span class="hosp_mark"></span>
															</div>
															<!-- 날짜 및 수정 여부 -->
															<div class="info_right">
																<div class="reply_date">
																	<p>${ replyRow.postdate }</p>
																	<c:if test="${ replyRow.rewrite == 'T' }">
																		<p class="dot">・</p>
																		<p class="edit">수정됨</p>
																	</c:if>
																</div>
															</div>
															<!-- 내용 -->
															<div class="reply_content">
																<p>${ replyRow.content }</p>
															</div>
															<!-- 버튼 -->
															<c:if test="${ replyRow.writer_ref.equals(sessionScope.userId) }">
																<div class="button_wrap">
																	<!-- 답변 수정 버튼 -->
																	<a class="edit_reply_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#editReplyModal"
																		onclick="openReplyEditModal(${ replyRow.api_ref }, ${ replyRow.review_idx }, '${ replyRow.content }')">
																		<span>수정하기</span>
																	</a>
																	<!-- 답변 삭제 버튼 -->
																	<a class="delete_reply_btn" href="javascript:void(0);" onclick="deleteReply(${ replyRow.api_ref }, ${ replyRow.review_idx });">
																		<span>삭제하기</span>
																	</a>
																</div>
															</c:if>
														</div>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</c:forEach>
								</ul>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</main>
		
		<%@include file="../common/main_footer.jsp" %>

	
		<!-- == 리뷰 수정 모달창 == -->
		<form method="post" action="../hospital/editReview.do" onsubmit="return validateReviewForm(this);">
			<input type="hidden" id="review_edit_api_ref" name="api_ref" value="" />
			<input type="hidden" name="hashtags" id="review_edit_hashtags" />
		    <input type="hidden" id="review_edit_score" name="score" value="" />
			<div class="modal" id="editReviewModal">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">&nbsp;</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<input type="hidden" id="review_edit_review_idx" name="review_idx" value="">
							<!-- 해시태그 선택 영역 -->
							<div class="form-group">
								<label>해시태그 선택:</label>
								<div id="hashtag-list">
									<!-- 해시태그 목록 -->
									<button type="button" class="btn btn-secondary">친절해요</button>
									<button type="button" class="btn btn-secondary">전문적이예요</button>
									<button type="button" class="btn btn-secondary">청결해요</button>
									<button type="button" class="btn btn-secondary">신속해요</button>
								</div>
							</div>
							<!-- 별 점수 선택 영역 -->
							<div class="form-group">
								<label>점수 선택:</label>
								<div id="star-rating" style="cursor: pointer;">
									<!-- 별 아이콘 -->
									<img src="/images/star_empty.svg" class="star" data-value="1" />
									<img src="/images/star_empty.svg" class="star" data-value="2" />
									<img src="/images/star_empty.svg" class="star" data-value="3" />
									<img src="/images/star_empty.svg" class="star" data-value="4" />
									<img src="/images/star_empty.svg" class="star" data-value="5" />
								</div>
							</div>
							<!-- 댓글 내용 -->
		                    <textarea class="form-control" id="review_edit_doctor"  name="doctor" style="height: 20px;" placeholder="담당 의사를 입력해주세요"></textarea>
		                    <textarea class="form-control" id="review_edit_treat" name="treat" style="height: 20px;" placeholder="치료 내용을 입력해주세요"></textarea>
		                    <textarea class="form-control" id="review_edit_cost" name="cost" style="height: 20px;" placeholder="비용을 입력해주세요"></textarea>
							<textarea class="form-control" id="review_edit_content" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
						</div>
						<!-- Modal Footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">수정하기</button>
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		<!-- == 답변 작성 모달창 == -->
		<form method="post" action="../hospital/writeReply.do" onsubmit="return validateReplyForm(this);">
			<input type="hidden" id="reply_write_api_ref" name="api_ref" value="" />
			<input type="hidden" id="reply_write_review_idx" name="review_idx" value="" />
			<div class="modal" id="writeReplyModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">&nbsp;</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력하세요"></textarea>
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
		
		<!-- ==  답변 수정 모달창 == -->
		<form method="post" action="../hospital/editReply.do" onsubmit="return validateReplyForm(this);">
			<input type="hidden" id="reply_edit_api_ref" name="api_ref" value="" />
			<div class="modal" id="editReplyModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">&nbsp;</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<input type="hidden" id="reply_edit_review_idx" name="review_idx" value="">
							<textarea class="form-control" id="reply_edit_content" name="content" style="height: 100px;"></textarea>
						</div>
						<!-- Modal Footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">수정하기</button>
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</body>   

</html>