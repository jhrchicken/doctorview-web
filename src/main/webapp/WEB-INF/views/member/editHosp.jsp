<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/edit-hosp.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// 	폼값 검증
function validateForm(form) {
	if (form.password.value == '') {
		alert("비밀번호를 입력하세요.");
		form.password.focus();
		return false;
	}
// 	var password_pattern =  /^[a-zA-Z0-9]{8,20}$/;
// 	if (!password_pattern.test(form.password.value)) {
// 	    alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
// 	    form.password.focus();
// 	    return false;
// 	}
	if (form.passwordCheck.value == '') {
		alert("비밀번호가 일치하지않습니다.");
		form.passwordCheck.focus();
		return false;
	}
	return true;
}

//회원탈퇴 confirm
function withdrawMemberConfirm(id) {
    if (confirm("정말로 탈퇴하시겠습니까?")) {
    	var form = document.editForm;
    	form.method = "post";
        form.action = "/member/withdraw.do";
        form.submit();
    }
}
</script>

</head>
<body>

<!-- 회원정보 수정 성공 여부 -->
<c:if test="${not empty editUserResult}">
    <script>
        alert("${editUserResult}");
    </script>
</c:if>


<%@ include file="../common/main_header.jsp" %>
	
<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
      	<h2>병원정보 수정</h2>
		<form name="editForm" method="post" enctype="multipart/form-data"
				action="../../member/editHosp.do" onsubmit="return validateForm(this);">
				
			<!-- member -->
			<p>*필수 입력사항</p>
			<table class="regist">
				<tr>
					<td class="left">아이디</td>
					<td class="id">
						<input type="text" name="id" value="${ loginUserInfo.id }" maxlength="15" readonly/>
			         	<input type="hidden" name="hosp_ref" value="${ hoursInfo.hosp_ref }" />
					</td>
				</tr>
				<tr class="pass">
					<td rowspan="2" class="left">비밀번호</td>
					<td><input type="password" name="password" maxlength="20" value="" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)"/></td>
				</tr>
				<tr>
					<td><input type="password" name="passwordCheck" maxlength="20" value="" placeholder="비밀번호 확인*"/></td>
				</tr>
				<tr>
					<td class="left">이름</td>
					<td><input type="text" name="name" value="${ loginUserInfo.name }" placeholder="이름*"/></td>
				</tr>
				<tr>
					<td class="left">전화번호</td>
					<td class="mobile">
						<input type="tel" name="tel1" maxlength="3" value="${ tel[0] }" placeholder="010"/> -
						<input type="tel" name="tel2" maxlength="4" value="${ tel[1] }" placeholder="전화번호*" /> -
						<input type="tel" name="tel3" maxlength="4" value="${ tel[2] }" />
					</td>
				</tr>
				<tr>
					<td class="left">주소</td>
					<td><input type="text" name="address" value="${ loginUserInfo.address }" placeholder="주소*"/></td>
				</tr>
				<tr>
					<td class="left">진료과목</td>
					<td><input type="text" name="department" value="${ loginUserInfo.department }" placeholder="진료과목*" /></td>
				</tr>
				<tr>
					<td class="left">사업자 번호</td>
					<td class="regi">
						<input type="text" name="taxid1" value="${ taxid[0] }" placeholder="사업자번호*" readonly/> -
						<input type="text" name="taxid2" value="${ taxid[1]  }" placeholder="사업자번호*" readonly/> -
						<input type="text" name="taxid3" value="${ taxid[2]  }" placeholder="사업자번호*" readonly/>
					</td>
				</tr>
			
				<!-- hours -->
				<!-- 영업시간 폼 시작 -->
			    <tr class="time">
			    	<td rowspan="4" class="left">영업시간</td>
			     	<td>
			       		요일:  
						<c:if test="${not empty weeks}">
						    <script>
						        $(document).ready(function() {
						            var weeks = ["${fn:join(weeks, '","')}" ];
						            
						            if (weeks.includes("월요일")) {
						                $('#monday').prop('checked', true);
						            }
						            if (weeks.includes("화요일")) {
						                $('#tuesday').prop('checked', true);
						            }
						            if (weeks.includes("수요일")) {
						                $('#wednesday').prop('checked', true);
						            }
						            if (weeks.includes("목요일")) {
						                $('#tdursday').prop('checked', true);
						            }
						            if (weeks.includes("금요일")) {
						                $('#friday').prop('checked', true);
						            }
						            if (weeks.includes("토요일")) {
						                $('#saturday').prop('checked', true);
						            }
						            if (weeks.includes("일요일")) {
						                $('#sunday').prop('checked', true);
						            }
						        });
						    </script>
						</c:if>

						<label class="checkbox_wrap">
				         	<input id="monday" type="checkbox" name="weeks" value="월요일" />
				         	<label for="monday">월</label>
						</label>
				      	<label class="checkbox_wrap">
					        <input id="tuesday" type="checkbox" name="weeks" value="화요일" />
					        <label for="tuesday">화</label>
				      	</label>
				        <label class="checkbox_wrap">
					      	<input id="wednesday" type="checkbox" name="weeks" value="수요일" />
					      	<label for="wednesday">수</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="tdursday" type="checkbox" name="weeks" value="목요일" />
				        	<label for="tdursday">목</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="friday" type="checkbox" name="weeks" value="금요일" />
				        	<label for="friday">금</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="saturday" type="checkbox" name="weeks" value="토요일" />
				        	<label for="saturday">토</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="sunday" type="checkbox" name="weeks" value="일요일" />
				        	<label for="sunday">일</label>
				      	</label>
				     </td>
   				</tr>

				<!-- 시간 선택 input 태그에서 select 태그로 변경됨 -->
				<tr class="time">
				  <td>
				    진료 시간
				    <select class="searchField" id="starttime" name="starttime">
					    <option value="${ starttime }">${ starttime }</option>
					</select>
				     ~ 
				    <select class="searchField" id="endtime" name="endtime">
					    <option value="${ endtime }">${ endtime }</option>
					    <option value="">종료 시간 선택</option>
					</select>
				  </td>
				</tr>
				<tr class="time">
				  <td>
				    휴게 시간
				    <select class="searchField" id="startbreak" name="startbreak">
					    <option value="${ startbreak }">${ startbreak }</option>
					    
					</select>
				     ~ 
				    <select class="searchField" id="endbreak" name="endbreak">
					    <option value="${ endbreak }">${ endbreak }</option>
					    <option value="">종료 시간 선택</option>
					</select>
				  </td>
				</tr>
				<tr class="time">
				  <td>
				    접수 마감
				    <select class="searchField" id="deadline" name="deadline">
					    <option value="${ deadline }">${ deadline }</option>
					</select>
				  </td>
				</tr>
				
				<script>
				    const timeSelectIds = ['starttime', 'endtime', 'startbreak', 'endbreak', 'deadline'];
				
				    // 30분 단위로 선택 가능
				    timeSelectIds.forEach(id => {
				        const selectElement = document.getElementById(id);
				        
				        for (let hour = 0; hour < 24; hour++) {
				            for (let minute = 0; minute < 60; minute += 30) {
				                const value = String(hour).padStart(2, '0') + ':' + String(minute).padStart(2, '0');
				                const option = document.createElement('option');
				                option.value = value;
				                option.textContent = value;
				                selectElement.appendChild(option);
				            }
				        }
				    });
				    
				    
				 	// 시간 비교 함수
				    function compareTimes(start, end) {
				        const startTime = document.getElementById(start).value;
				        const endTime = document.getElementById(end).value;
				
				        if (startTime && endTime && startTime >= endTime) {
				            alert('종료 시간은 시작 시간보다 늦어야 합니다.');
				            document.getElementById(end).value = '';
				        }
				    }
				
				    // 이벤트 리스너 추가
				    document.getElementById('starttime').addEventListener('change', () => {
				        compareTimes('starttime', 'endtime');
				    });
				
				    document.getElementById('endtime').addEventListener('change', () => {
				        compareTimes('starttime', 'endtime');
				    });
				
				    document.getElementById('startbreak').addEventListener('change', () => {
				        compareTimes('startbreak', 'endbreak');
				    });
				
				    document.getElementById('endbreak').addEventListener('change', () => {
				        compareTimes('startbreak', 'endbreak');
				    });
				    
				</script>
				
				
				
				
				
				
				
				
				
				
				
				
				
		    
			    <!-- 추가사항 -->
			    <!-- ********* 병원 이미지 추가 필요 ********* -->
			    <tr>
			    	<td class="left">사진</td>
			    	<td>
			    		<div class="image">
			    			<c:if test="${ hospDatilInfo.photo == null || hospDatilInfo.photo == '' }">
				    			<!-- 병원.. 병원 기본 이미지 이거 맞나..?? -->
							    <img src="/images/hospital.png" alt="" />
							</c:if>
							<c:if test="${ hospDatilInfo.photo != null && hospDatilInfo.photo != '' }">
							    <img src="/uploads/${ hospDatilInfo.photo }"  />
							</c:if>
				    		<input type="file" name="file" value="${ hospDatilInfo.photo }" />
				    		<input type="hidden" name="photo" value="${ hospDatilInfo.photo }" />
			    		</div>
			    	</td>
			    </tr>
			    <tr>
			    	<td class="left">소개</td>
			    	<td><input type="text" name="introduce" value="${ hospDatilInfo.introduce }" /></td>
			    </tr>
			    <tr>
			    	<td class="left">오시는 길</td>
			    	<td><input type="text" name="traffic" value="${ hospDatilInfo.traffic }" placeholder="ex ) 00역에서 도보 10분" /></td>
			    </tr>
			    <tr>
			    	<!-- radio 버튼으로 변경됨 -->
			    	<td class="left">주차</td>
			    	<td>
					    <label>
					        <input id="parking_t" type="radio" name="parking" value="T" ${ hospDatilInfo.parking == 'T' ? 'checked' : '' } />
					        <label class="doc_check" for="parking_t">가능</label>
					    </label>
					    <label class="extra">
					        <input id="parking_f" type="radio" name="parking" value="F" ${ hospDatilInfo.parking == 'F' ? 'checked' : '' } />
					        <label class="doc_check" for="parking_f">불가능</label>
					    </label>
					</td>
			    </tr>
			    <tr>
			    	<!-- radio 버튼으로 변경됨 -->
			    	<td class="left">PCR 검사</td>
					<td>
					    <label>
					        <input id="pcr_t" type="radio" name="pcr" value="T" ${ hospDatilInfo.pcr == 'T' ? 'checked' : '' } />
					        <label class="doc_check" for="pcr_t">가능</label>
					    </label>
					    <label class="extra">
					        <input id="pcr_f" type="radio" name="pcr" value="F" ${ hospDatilInfo.pcr == 'F' ? 'checked' : '' } />
					        <label class="doc_check" for="pcr_f">불가능</label>
					    </label>
					</td>
			    </tr>
			    <tr>
			    	<!-- radio 버튼으로 변경됨 -->
			    	<td class="left">입원</td>
			    	<td>
					    <label>
					        <input id="hospitalize_t" type="radio" name="hospitalize" value="T" ${ hospDatilInfo.hospitalize == 'T' ? 'checked' : '' } />
					        <label class="doc_check" for="hospitalize_t">가능</label>
					    </label>
					    <label class="extra">
					        <input id="hospitalize_f" type="radio" name="hospitalize" value="F" ${ hospDatilInfo.hospitalize == 'F' ? 'checked' : '' } />
					        <label class="doc_check" for="hospitalize_f">불가능</label>
					    </label>
					</td>
			    </tr>
			    <tr>
			    	<!-- radio 버튼으로 변경됨 -->
			    	<td class="left">예약 방문</td>
			    	<td>
					    <label>
					        <input id="system_t" type="radio" name="system" value="T" ${ hospDatilInfo.system == 'T' ? 'checked' : '' } />
					        <label class="doc_check" for="system_t">가능</label>
					    </label>
					    <label class="extra">
					        <input id="system_f" type="radio" name="system" value="F" ${ hospDatilInfo.system == 'F' ? 'checked' : '' } />
					        <label class="doc_check" for="system_f">불가능</label>
					    </label>
					</td>
			    </tr>
			    <!-- 의료진 추가 -->
			    <tr>
			    	<td class="left">의사</td>
		      		<!-- 의료진 관리 - 수정 페이지로 이동 --> 
			      	<td class="doctors">
			      		<a href="/member/doctorInfo.do">의사 등록 및 수정하기</a>
		      		</td>
			    </tr>
			</table>
			<div class="btn_wrap">
				<input type="submit" value="수정완료" />
				<input type="button" onclick="withdrawMemberConfirm('${ loginUserInfo.id }');" value="회원탈퇴" />
			</div>
		</form>
  	  </div>
    </div>
  </div>
</main>	

<%@ include file="../common/main_footer.jsp" %>	
</body>
</html>