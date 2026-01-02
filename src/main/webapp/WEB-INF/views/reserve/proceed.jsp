<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script src="/js/proceed.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-proceed.css" />
<script>
	var toDay = new Date(); // 오늘 날짜 (내 컴퓨터 로컬 기준)
	var nowDate = new Date();  // 실제 오늘날짜 고정값
	     
	var weeks = [${weeks}]; // 병원의 근무요일 데이터
	
	function buildCalendar() {
	   let doMonth = new Date(toDay.getFullYear(), toDay.getMonth(), 1); // 이번 달의 첫 번째 날
	   let lastDate = new Date(toDay.getFullYear(), toDay.getMonth() + 1, 0); // 이번 달의 마지막 날
	
	   let tbCalendar = document.querySelector(".scriptCalendar > tbody"); // 캘린더 테이블 본문
	   document.getElementById("calYear").innerText = toDay.getFullYear(); // 년도 표시
	   document.getElementById("calMonth").innerText = autoLeftPad((toDay.getMonth() + 1), 2); // 월 표시
	
	   // 이전 캘린더 데이터를 삭제
	   while (tbCalendar.rows.length > 0) {
	       tbCalendar.deleteRow(tbCalendar.rows.length - 1);
	   }
	
	   let row = tbCalendar.insertRow(); // 첫 번째 행
	   let dom = 1; // 요일 카운터
	   let daysLength = (Math.ceil((doMonth.getDay() + lastDate.getDate()) / 7) * 7) - doMonth.getDay(); // 캘린더에 표시할 총 일 수
	   let nearestFutureDay = null; // 가장 가까운 요일
	
	   for (let day = 1 - doMonth.getDay(); daysLength >= day; day++) {
	       let column = row.insertCell();
	
	       // 현재 달의 유효한 날
	       if (Math.sign(day) == 1 && lastDate.getDate() >= day) {
	           column.innerText = autoLeftPad(day, 2); // 날짜 표시
	
	           let currentDate = new Date(toDay.getFullYear(), toDay.getMonth(), day); // 현재 날짜
	
	           let dayOfWeek = new Date(toDay.getFullYear(), toDay.getMonth(), day).getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
	           let korWeekday = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"][dayOfWeek];
	
	           // 오늘 이후 날짜일 경우 && 선택 가능한 요일인지 확인
	           if (currentDate >= nowDate && weeks.includes(korWeekday)) {
	               column.onclick = function () { calendarChoiceDay(this); };
	               
	               // 오늘 이후 날짜 배경 색상
	               column.classList.add("future")
	               
	                // 근무하는 가장 가까운 날을 찾음
	                if (!nearestFutureDay && currentDate >= nowDate) {
	                    nearestFutureDay = column;
	                }
	           } else {
	               // 오늘 이전 날짜 또는 선택 불가능한 요일
	               column.classList.add("past");
	           }
      
	           // 오늘 날짜일 경우, 병원이 근무하는 요일인지 확인
	            if (day === nowDate.getDate() && toDay.getMonth() === nowDate.getMonth() && toDay.getFullYear() === nowDate.getFullYear()) {
	                if (weeks.includes(korWeekday)) {
	                    // 오늘이 병원이 근무하는 요일이면 기본으로 선택됨
	                    column.onclick = function () { calendarChoiceDay(column); };
	                    column.classList.add("future");
	                    calendarChoiceDay(column); // 오늘 날짜 자동 선택
	                    
	                    // 근무하는 가장 가까운 날을 찾음
	                    if (!nearestFutureDay && currentDate >= nowDate) {
	                        nearestFutureDay = column;
	                    }
	                    
	                } else {
	                    column.classList.add("past"); // 오늘이 근무하지 않는 요일이면 선택 불가
	                }
	            }
   
	           
	       } else {
	           // 이전, 다음 달 날짜 처리
	           let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
	           column.innerText = autoLeftPad(exceptDay.getDate(), 2);
	           column.classList.add("prevnext")
	       }
	
	       // 일요일
	       if (dom % 7 == 1) {
	    	   column.classList.add("sunday");
	       }
	
	       // 토요일
	       if (dom % 7 == 0) {
	    	   column.classList.add("saturday");
	           row = tbCalendar.insertRow(); // 주가 끝날 때마다 새 행 추가
	       }
	
	       dom++;
	   }   
	   
	   // 오늘이 근무하지 않는 요일이라면, 가장 가까운 근무일을 자동 선택
	    if (!weeks.includes(new Date().toLocaleString('ko-KR', { weekday: 'long' }))) {
	        if (nearestFutureDay) {
	            calendarChoiceDay(nearestFutureDay); // 가장 가까운 근무일을 선택
	        }
	    }
	}
	
	   	
	function setUnavailableTime(formattedDate) {
	    var hoursList = JSON.parse('${hoursList}'); // 병원 진료시간 데이터
	    var hospReserveMap = JSON.parse('${hospReserveMap}'); // 병원 예약목록 날짜:시간 Map 데이터

	    var isReserved = false;  // 예약목록 존재여부 판단 변수
	    var isReservedTime = false; // 해당하는 날짜의 예약 가능시간 판단 변수

	    document.querySelector(".time_list_am").innerHTML = '';  
	    document.querySelector(".time_list_pm").innerHTML = '';  
	    var timeListHtmlAM = '';  
	    var timeListHtmlPM = '';  

	    // 현재 시간 가져오기
	    var currentTime = new Date();
	    var currentHours = currentTime.getHours();
	    var currentMinutes = currentTime.getMinutes();
	    var currentTimeString = autoLeftPad(currentHours, 2) + ':' + autoLeftPad(currentMinutes, 2);

	    // 선택한 날짜와 오늘 날짜가 같은지 비교
	    var selectedDate = new Date(formattedDate);
	    var isToday = selectedDate.toDateString() === currentTime.toDateString();

	    // hospReserveMap에 formattedDate(사용자가 선택한 날짜)에 해당하는 데이터가 있는지 판단
	    if (hospReserveMap[formattedDate]) {
	        isReserved = true;

	        var reservedTimes = hospReserveMap[formattedDate]; // 선택한 날짜에 해당하는 예약의 시간데이터 리스트
	        hoursList.forEach(function(item, index) {
	            var time = item.split(":"); 
	            var hour = parseInt(time[0], 10);  // 시간을 정수로 변환

	            // 오늘 날짜일 경우: 과거 시간 비활성화
	            var isPastTime = isToday && (item < currentTimeString);

	            // reservedTimes에 포함된 시간은 예약불가로 표시하고 선택 비활성화
	            var radioButtonHtml = reservedTimes.includes(item) || isPastTime
	                ? "<li class='time_item'><input id='" + item  + "' type='radio' name='posttime' value='" + item +"' disabled/><label class='block' for='"+ item +"'>" + item + "</label></li>"
	                : "<li class='time_item'><input id='" + item  + "' type='radio' name='posttime' value='" + item +"'/><label for='"+ item +"'>" + item + "</label></li>";

	            if (hour < 12) {
	                timeListHtmlAM += radioButtonHtml;
	            } else {
	                timeListHtmlPM += radioButtonHtml;
	            }
	        });
	    } else {
	        // 예약이 없으면 모든 hoursList 시간 출력
	        hoursList.forEach(function(item, index) {
	            var time = item.split(":");
	            var hour = parseInt(time[0], 10);

	            // 오늘 날짜일 경우: 과거 시간 비활성화
	            var isPastTime = isToday && (item < currentTimeString);

	            var radioButtonHtml = isPastTime
	                ? "<li class='time_item'><input id='" + item  + "' type='radio' name='posttime' value='" + item +"' disabled/><label class='block' for='"+ item +"'>" + item + "</label></li>"
	                : "<li class='time_item'><input id='" + item  + "' type='radio' name='posttime' value='" + item +"'/><label for='"+ item +"'>" + item + "</label></li>";

	            if (hour < 12) {
	                timeListHtmlAM += radioButtonHtml;
	            } else {
	                timeListHtmlPM += radioButtonHtml;
	            }
	        });
	    }

	    document.querySelector(".time_list_am").innerHTML = timeListHtmlAM;
	    document.querySelector(".time_list_pm").innerHTML = timeListHtmlPM;
	}

</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>병원 예약</h2>
			<c:set var="selectdate" value="${param.postdate}" />
			
			<!-- form -->
			<form name="proceedFrm" method="post" 
				action="/reserve/proceed.do" onsubmit="return proceedValidateForm(this);">

				<!-- 병원 정보 -->
				<div class="hosp_info">
					<span class="img">
						<img src="/images/hospital.png" alt="" style="width: 100%; height: 100%;" />
					</span>
					<div class="info">
						<div class="info_top">
			        		<h3>${ hospitalInfo.name }</h3>
							<!-- 병원명/아이디 전달 -->
							<input type="hidden" name="hosp_ref" value="${ hospitalInfo.id }" placeholder="" readonly/>
							<input type="hidden" name="hospname" value="${ hospitalInfo.name }" placeholder="" readonly/>
						</div>
						<div class="detail">
						  	<div class="details">
						    	<p class="blue">전화</p>
						    	<p>${ hospitalInfo.tel }</p>
							</div>
							<div class="details">
						  		<p class="blue">주소</p>
						  		<p>${ hospitalInfo.address }</p>
							</div>
							<div class="details">
							  	<p class="blue">진료과목</p>
							  	<p>${ hospitalInfo.department }</p>
					        </div>
			      		</div>
			   		</div>
				</div>
      
				<!-- 의사정보 -->
				<div class="proceed">
					<div class="doctor">
						<div class="swiper">
							<div class="swiper-wrapper">
							<c:forEach items="${ doctorInfo }" var="row" varStatus="loop">
								<div class="swiper-slide li">
									<label>
										<!-- 의사 선택 radio -->
										<input id="${ row.name }"  type="radio" name="doctorname" value="${ row.name }" />
										<label class="doc_check" for="${ row.name }">${ row.name } 의사<p>${ row.major }</p></label>
									</label>
									<div class="doc">							
										<div class="doc_wrap">
											<span class="doc_img">
												<img src="/images/doctor.png" alt="" />
											</span>
								       		<input type="hidden" name="doc_idx" value="${ row.doc_idx }" />
								          	<input type="hidden" name="doctorname_${ row.name }" value="${ row.name }" />
										</div>
										<div class="doc_content">
											<div class="doc_title">
												<h3>${ row.name }</h3>
												<p>${ row.major }</p>
											</div>
											<div class="doc_detail">
												<p class="blue">경력</p>
										        <p>${ row.career }</p>
										    </div>
									        <div class="doc_detail">
												<p class="blue">진료 요일</p>
												<p>${ row.hours }</p>
											</div>
								    	</div>
									</div>
					  			</div>
							</c:forEach>	
							</div>
						</div>
					</div>
				</div>
				

<!-- 진료과목 추후 추가 -->
<!--       <div class="list_search"> -->
<!--         <form class="searchForm" name="searchForm"> -->
<!--           <div class="search_depart"> -->
<!--             <select name="searchSelect" class="searchField"> -->
<!--               <option value="depart">-- 진료과목 선택 --</option> -->
<!--               <option value="in">내과</option> -->
<!--               <option value="out">외과</option> -->
<!--               <option value="ear">이비인후과</option> -->
<!--               <option value="plastic">성형외과</option> -->
<!--             </select> -->
<!--             <input type="submit" class="search_btn" value=""> -->
<!--           </div> -->
<!--         </form> -->
<!--       </div> -->
      
	      		<!-- 예약 폼 -->
				<div class="reservation">
					<!-- 캘린더 -->
		          	<div class="calendar">
						<div class="calendar_top">
						   <button type="button" class="prev_btn" id="btnPrevCalendar">
						      <img src="/images/paging2.svg" alt="" style="width: 30px; height: 30px;" />
						   </button>
						   <div class="date">
						      <p id="calYear">YYYY</p>
						      <p>/</p>
						      <p id="calMonth">MM</p>
						   </div>
						   <button type="button" class="next_btn" id="nextNextCalendar">
						      <img src="/images/paging3.svg" alt="" style="width: 30px; height: 30px;" />
						   </button>
						</div>
					
						<table class="scriptCalendar">
						    <thead>
						        <tr>
						            <td>일</td>
						            <td>월</td>
						            <td>화</td>
						            <td>수</td>
						            <td>목</td>
						            <td>금</td>
						            <td>토</td>
						        </tr>
						    </thead>
						    <tbody>
						    	<!-- js로 달력출력 -->
								<!-- 선택한 예약 날짜 전달 input -->
								<input type="hidden" id="selectedDate" name="postdate" value="">
						    </tbody>
						</table>
					</div>
					
					<div class="reserv_right">
						<div class="time_select">
				        	<div class="am">
				              	<!-- 12:00 이전만 출력 -->
				            	<div class="time_title">오전</div>
			              		<ul class="time_list_am">
			              		</ul>
			            	</div>
			            	<div>
				              	<!-- 12:00 이후만 출력 -->
			              		<div class="time_title">오후</div>
		             			<ul class="time_list_pm">
			              		</ul>
		           			</div>
		       			</div>
		       			
		       			<!-- 예약자 정보 -->
		       			<div class="user_info">
				        	<h3>예약자 정보</h3>
				        	<p>실제 방문하시는 분의 정보를 입력해주세요.</p>
			            	<div class="reserv_wrap">
			              		<table>
					                <tr>
					                	<td class="left">이름</td>
					                  	<td>
						                  	<input type="text" name="username" value="${ userInfo.name }" placeholder="방문자의 이름을 입력해주세요.">
						                  	<input type="hidden" name="user_ref" value="${ userInfo.id }">
					                  	</td>
					                </tr>
			                		<tr>
				                  		<td class="left">전화번호</td>
										<td class="mobile">
											<input type="tel" name="tel1" maxlength="3" value="${ tel1 }" placeholder="010" /> -
											<input type="tel" name="tel2" maxlength="4" value="${ tel2 }" placeholder="0000" /> -
											<input type="tel" name="tel3" maxlength="4" value="${ tel3 }" placeholder="0000" />
										</td>
				                	</tr>
									<tr>
									    <td class="left">주민등록<br/>번호</td>
									    <td class="resi">
									            <input type="text" name="rrn1" value="${ birthRrn }" maxlength="6" placeholder="주민등록번호*" /> - 
									            <input type="text" name="rrn2" value="${ genderRrn }" maxlength="1" />
<!-- 									            <span class="masking">******</span> -->
									            <span class="masking">●●●●●●</span>
									    </td>
									</tr>
					                <tr>
					                	<td class="left">주소</td>
					                  	<td><input type="text" name="address" value="${ userInfo.address }" placeholder="방문자의 주소를 입력해주세요."></td>
					                </tr>
			              		</table>
			            	</div>
			            
			            	<div class="btn_wrap">
				            	<button type="button" onclick="resetForm()">새로 작성하기</button> 
				            	<button type="submit">예약하기</button>
				            	<!-- 새로작성하기 -->
								<script>
									function resetForm() {
									    const inputs = document.querySelectorAll('.reserv_wrap input[type="text"]'); // 예약자 정보 input 요소 선택
									    
									    inputs.forEach(input => {
									        input.value = ''; // 빈 문자열로 설정
									    });
									}
								</script>
				            </div>
				            
				        </div>
					</div>
	   			</div>
      		</form>
   		</div>
	</div>
</main>
<%@ include file="../common/main_footer.jsp" %>
</body>
</html>