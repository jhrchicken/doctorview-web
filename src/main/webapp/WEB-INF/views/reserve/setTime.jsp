<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 예약관리</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-setTime.css" />
<script src="/js/proceed.js"></script>
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
	           } else {
	               // 오늘 이전 날짜 또는 선택 불가능한 요일
	               column.classList.add("past");
	           }
	
	           // 오늘 날짜일 경우
	           if (day === nowDate.getDate() && toDay.getMonth() === nowDate.getMonth() && toDay.getFullYear() === nowDate.getFullYear()) {
	               column.onclick = function () { calendarChoiceDay(column); }; // 오늘 날짜도 선택 가능
	        	   column.classList.add("past"); 
	               calendarChoiceDay(column); // 오늘 날짜 자동 선택
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
	
		// hospReserveMap에 formattedDate(사용자가 선택한 날짜)에 해당하는 데이터가 있는지 판단
		if (hospReserveMap[formattedDate]) {
		    isReserved = true;
		    
		    var reservedTimes = hospReserveMap[formattedDate]; // 선택한 날짜에 해당하는 예약의 시간데이터 리스트
		    hoursList.forEach(function(item, index) {
		        var time = item.split(":"); 
		        var hour = parseInt(time[0], 10);  // 시간을 정수로 변환
		
		        // reservedTimes에 포함된 시간은 예약불가로 표시하고 선택 비활성화
		        var radioButtonHtml = reservedTimes.includes(item) 
// 		            ? "<li class='time_item block'><input id='" + item  + "' type='checkbox' name='posttimez' value='" + item +"' disabled/><label class='block' for='"+ item +"'>" + item + "</label></li>"
		            ? "<li class='time_item block'><input id='" + item  + "' type='checkbox' name='posttimez' value='" + item +"'/><label class='block' for='"+ item +"'>" + item + "</label></li>"
		            : "<li class='time_item'><input id='" + item  + "' type='checkbox' name='posttimez' value='" + item +"'/><label for='"+ item +"'>" + item + "</label></li>";
		        
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
		        
		        if (hour < 12) {
		            timeListHtmlAM += "<li class='time_item'><input id='" + item  + "' type='checkbox' name='posttimez' value='" + item +"'/><label for='"+ item +"'>" + item + "</label></li>";
		        } else {
		            timeListHtmlPM += "<li class='time_item'><input id='" + item  + "' type='checkbox' name='posttimez' value='" + item +"'/><label for='"+ item +"'>" + item + "</label></li>";
		        }
		    });
		}
		
	   document.querySelector(".time_list_am").innerHTML = timeListHtmlAM;
	   document.querySelector(".time_list_pm").innerHTML = timeListHtmlPM;
	}
</script>
	
</head>
<body>
<!-- 예약관리 성공 여부 -->
<c:if test="${not empty setTimeResult}">
    <script>
        alert("${setTimeResult}");
    </script>
</c:if>

<%@include file="../common/main_header.jsp" %>
<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>병원 예약관리</h2>
			
			<form name="setTimeFrm" method="post" action="/reserve/setTime.do">
				<!-- 병원명/아이디 전달 -->
				<input type="hidden" name="hosp_ref" value="${ hospitalInfo.id }" placeholder="" readonly/>
				<input type="hidden" name="hospname" value="${ hospitalInfo.name }" placeholder="" readonly/>
      				
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
							<p> 예약받을 시간과 받지않을 시간을 설정하세요.</p>
							<p class="warning"> * '예약 open' 버튼을 통해 예약기능을 open 하는 경우<br/>3개의 진료예약을 추가로 받을 수 있습니다.<br/>
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
		       			
		       			<div class="btn_wrap">
    						<button type="submit" name="action" value="close">예약 close</button>
    						<button type="submit" name="action" value="open">예약 open</button>
<!-- 			            	<button type="submit">예약 닫기</button> -->
<!-- 			            	<button type="submit">예약 열기</button> -->
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