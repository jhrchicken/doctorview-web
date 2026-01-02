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
		<%@include file="../common/head.jsp" %>
		<link rel="stylesheet" href="/css/doc-view.css" />
		<script src="/js/doctor-view.js"></script>
	</head>
	
	<body>
		<%@include file="../common/main_header.jsp" %>
		<main id="container">
			<div class="content">
				<div class="doc_wrap">
					<!-- 의사 프로필 -->
					<form name="deleteDoctorForm">
						<input type="hidden" name="doc_idx" value="${ doctorDTO.doc_idx }" />
					</form>
					<div class="doc_profile">
						<!-- 의사 사진 -->
						<c:if test="${ doctorDTO.photo == null }">
							<span class="doc_photo">
								<img src="/images/doctor.png" alt="" />
							</span>
						</c:if>
						<c:if test="${ doctorDTO.photo != null }">
							<span class="doc_photo">
								<img src="/uploads/${ row.photo }" />
							</span>
						</c:if>
						<!-- 의사 정보 -->
						<div class="doc_info">
							<div class="doc_name">
								<p>${ doctorDTO.name }</p>
							</div>
							<a class="doc_hosp" href="/hospital/viewHosp.do?api_idx=${ doctorDTO.api_ref }">
								${ doctorDTO.hospname }
								<img src="/images/open_in_new.svg" style="width: 20px; height: 20px;" />
							</a>
							<div class="doc_major">
								<p class="sub_tit">전공</p>
								<div class="divider"></div>
								<p>${ doctorDTO.major }</p>
							</div>
							<div class="doc_career">
								<p class="sub_tit">경력</p>
								<div class="divider"></div>
								<p>${ doctorDTO.career }</p>
							</div>
							<div class="doc_hours">
								<p class="sub_tit">근무시간</p>
								<div class="divider"></div>
								<p>${ doctorDTO.hours }</p>
							</div>

							<!-- 찜 버튼 / 의사 수정 삭제 버튼 -->
							<div class="info_right">
								<!-- 의사 수정 버튼 -->
								<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' and doctorDTO.hosp_ref == sessionScope.loginMember.id }">
									<a class="edit_doc_btn" href="../doctor/editDoctor.do?doc_idx=${ param.doc_idx }">
										<span>수정하기</span>
									</a>
								</c:if>
								<!-- 의사 삭제 버튼 -->
								<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' and doctorDTO.hosp_ref == sessionScope.loginMember.id }">
									<a class="delete_doc_btn" href="javascript:void(0);" onclick="deleteDoctor(${ param.doc_idx });">
										<span>삭제하기</span>
									</a>
								</c:if>
								<!-- 찜 버튼 -->
								<c:if test="${ doclikecheck == 0 }">
									<a class="save_btn" href="../doctor/clickDocLike.do?doc_idx=${ param.doc_idx }">
										<span>
											<img src="/images/mark.svg" alt="">
											${ doctorDTO.likecount }
										</span>
									</a>
								</c:if>
								<c:if test="${ doclikecheck == 1 }">
									<a class="save_btn" href="../doctor/clickDocLike.do?doc_idx=${ param.doc_idx }">
										<span>
											<img src="/images/mark_full.svg" alt="">
											${ doctorDTO.likecount }
										</span>
									</a>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				
				<div class="review_wrap">
					<div class="review_list">
						<form name="deleteReviewForm" method="post">
							<input type="hidden" name="doc_ref" value="" />
							<input type="hidden" name="review_idx" value="" />
						</form>
						<form name="deleteReplyForm" method="post">
							<input type="hidden" name="doc_ref" value="" />
							<input type="hidden" name="review_idx" value="" />
						</form>
						
						<!-- 리뷰 요약 -->
						<div class="review_summary">
							<p class="total_count">총 <span>${ doctorDTO.reviewcount }</span>건의 리뷰가 있어요</p>
							<p class="avg_score">${ doctorDTO.score }</p>
							<div class="avg_star">
								<c:choose>
									<c:when test="${ doctorDTO.score != 0 }">
										<div class="star">
											<c:forEach var="i" begin="0" end="${doctorDTO.score - 1}">
												<img src="/images/star.png" alt="" />
											</c:forEach>
											<c:forEach var="i" begin="${doctorDTO.score}" end="4">
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
						<c:if test="${ not empty reviewsList }">
							<ul class="review">
								<c:forEach items="${ reviewsList }" var="row" varStatus="loop">
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
												<!-- 해시태그 -->
												<c:if test="${ not empty hashtagList }">
													<div class="review_hashtag">
														<ul>
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.dreview_ref == row.review_idx }">
																	<li class="tag">
																		<p># ${ hashrow.tag }</p>
																	</li>
																	<c:if test="${!loop.last && hashtagList[loop.index + 1].dreview_ref == row.review_idx}">
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
														<a class="comm_like_btn" href="../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }">
															<span>
																<img src="/images/review_like_btn.svg" style="width: 20px; height: 20px;" />
																${ row.likecount }
															</span>
														</a>
													</c:if>
													<c:if test="${ row.likecheck == 1 }">
														<p>이 리뷰가 도움이 돼요!</p>
														<a class="comm_like_btn" href="../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }">
															<span>
																<img src="/images/review_like_btn_filled.svg" style="width: 20px; height: 20px;" />
																${ row.likecount }
															</span>
														</a>
													</c:if>
													<!-- 답변 작성 버튼 -->
													<c:if test="${ doctorDTO.hosp_ref == sessionScope.loginMember.id }">
														<a class="reply_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
															onclick="openReplyWriteModal(${ row.doc_ref }, ${ row.review_idx });">
															<span>답변 작성하기</span>
														</a>
													</c:if>
													<div class="crud_btn">
														<!-- 리뷰 수정 버튼 -->
														<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
															<a class="edit_review_btn" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#editReviewModal"
																onclick="openReviewEditModal(${ row.doc_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }')">
																<span>수정하기</span>
															</a>
														</c:if>
														<!-- 리뷰 삭제 버튼 -->
														<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
															<a class="delete_review_btn" href="javascript:void(0);" onclick="deleteReview(${ row.doc_ref }, ${ row.review_idx });">
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
										<c:forEach items="${ reviewsList }" var="replyRow">
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
																	onclick="openReplyEditModal(${ replyRow.doc_ref }, ${ replyRow.review_idx }, '${ replyRow.content }')">
																	<span>수정하기</span>
																</a>
																<!-- 답변 삭제 버튼 -->
																<a class="delete_reply_btn" href="javascript:void(0);" onclick="deleteReply(${ replyRow.doc_ref }, ${ replyRow.review_idx });">
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
		</main>
		<%@include file="../common/main_footer.jsp" %>
		
		<!-- == 리뷰 수정 모달창 == -->
		<form method="post" action="../doctor/editReview.do" onsubmit="return validateReviewForm(this);">
			<input type="hidden" id="review_edit_doc_ref" name="doc_ref" value="" />
			<input type="hidden" id="review_edit_hashtags" name="hashtags" />
		    <input type="hidden" id="review_edit_score" name="score" value="" />
		   	<div class="modal" id="editReviewModal" >
		    	<div class="modal-dialog">
		    		<div class="modal-content">
		    			<div class="modal-header">
		    				<h4 class="modal-title">&nbsp;</h4>
		    				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		    			</div>
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
		    				<!-- 내용 입력 -->
		    				<textarea class="form-control" id="review_edit_content" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
		    			</div>
		    			<div class="modal-footer">
		    				<button type="submit" class="btn btn-primary">수정하기</button>
		    				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		<!-- == 답변 작성 모달창 == -->
		<form method="post" action="../doctor/writeReply.do" onsubmit="return validateReplyForm(this);">
		   <input type="hidden" id="reply_write_doc_ref" name="doc_ref" value="" />
		   <input type="hidden" id="reply_write_review_idx" name="review_idx" value="" />
		   <div class="modal" id="writeReplyModal" >
		      <div class="modal-dialog">
		         <div class="modal-content">
		            <div class="modal-header">
		               <h4 class="modal-title">&nbsp;</h4>
		               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <div class="modal-body">
		               <textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력하세요"></textarea>
		            </div>
		            <div class="modal-footer">
		               <button type="submit" class="btn btn-primary">작성하기</button>
		               <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		            </div>
		         </div>
		      </div>
		   </div>
		</form>
		
		<!-- == 답변 수정 모달창 == -->
		<form method="post" action="../doctor/editReply.do" onsubmit="return validateReplyForm(this);">
		   <input type="hidden" id="reply_edit_doc_ref" name="doc_ref" value="" />
		   <div class="modal" id="editReplyModal" >
		      <div class="modal-dialog">
		         <div class="modal-content">
		            <div class="modal-header">
		               <h4 class="modal-title">의사 답변 수정</h4>
		               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <div class="modal-body">
		               <input type="hidden" id="reply_edit_review_idx" name="review_idx" value="">
		               <textarea class="form-control" id="reply_edit_content" name="content" style="height: 100px;"></textarea>
		            </div>
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