<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 출석체크</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-attend.css" />


<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        buildCalendar();
        
        document.getElementById("btnPrevCalendar").addEventListener("click", function(event) {
            prevCalendar();
        });
        
        document.getElementById("nextNextCalendar").addEventListener("click", function(event) {
            nextCalendar();
        });
        
     	// 출석하기 버튼 눌렀을 때 alert 추가
        const attendForm = document.forms["attend"];
        if (attendForm) {
            attendForm.addEventListener("submit", function(event) {
                event.preventDefault(); // 폼 제출을 잠시 멈추고
                alert("10p 지급 완료!");
                this.submit(); // 폼 제출
            });
        }
    });

    var toDay = new Date(); // @param 전역 변수, 오늘 날짜 / 내 컴퓨터 로컬을 기준으로 toDay에 Date 객체를 넣어줌
    var nowDate = new Date();  // @param 전역 변수, 실제 오늘날짜 고정값
    
    // @brief   이전달 버튼 클릭시
    function prevCalendar() {
        this.toDay = new Date(toDay.getFullYear(), toDay.getMonth() - 1, toDay.getDate());
        buildCalendar();    // @param 전월 캘린더 출력 요청
    }

    // @brief   다음달 버튼 클릭시
    function nextCalendar() {
        this.toDay = new Date(toDay.getFullYear(), toDay.getMonth() + 1, toDay.getDate());
        buildCalendar();    // @param 명월 캘린더 출력 요청
    }

     /*
     @brief   캘린더 오픈
     @details 날짜 값을 받아 캘린더 폼을 생성하고, 날짜값을 채워넣는다.
     */
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

    	            // 오늘 날짜일 경우
    	            if (day === nowDate.getDate() && toDay.getMonth() === nowDate.getMonth() && toDay.getFullYear() === nowDate.getFullYear()) {
    	                column.onclick = function () { calendarChoiceDay(this); };
    	                // 오늘 날짜 자동 선택
    	                calendarChoiceDay(column);
    	            } else if (day < nowDate.getDate()) {
    	            	column.classList.add("past");
    	            }
    	        } else {
    	            // 이전 또는 다음 달 날짜 처리
    	            let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
    	            column.innerText = autoLeftPad(exceptDay.getDate(), 2);
    	            column.style.color = "#A9A9A9"; // 이전/다음 달 날짜 회색 표시
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

    	 // 날짜 선택 함수 (기본적으로 오늘 선택)
    	function calendarChoiceDay(column) {
    	    if (document.getElementsByClassName("choiceDay")[0]) {
    	        // 이전에 선택된 날짜가 있을 경우 초기화
    	        document.getElementsByClassName("choiceDay")[0];  
    	        document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
    	    }
    	    // 선택한 날짜 강조
    	    column.classList.add("choiceDay");
    	}

    /**
     * @brief   숫자 두자릿수( 00 ) 변경
     * @details 자릿수가 한자리인 ( 1, 2, 3등 )의 값을 10, 11, 12등과 같은 두자리수 형식으로 맞추기위해 0을 붙인다.
     * @param   num     앞에 0을 붙일 숫자 값
     * @param   digit   글자의 자릿수를 지정 ( 2자릿수인 경우 00, 3자릿수인 경우 000 … )
     */
    function autoLeftPad(num, digit) {
        if(String(num).length < digit) {
            num = new Array(digit - String(num).length + 1).join("0") + num;
        }
        return num;
    }
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="list_title">
				<h2>출석체크</h2>
				<p>매일 출석하고 포인트를 받아가세요.</p>
			</div>
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
			        	<!-- 스크립트로 내용 채워넣음 -->
			        </tbody>
			    </table>
			    
		    </div>
				
		    <form name="attend" method="post" action="/mypage/attend.do">
				<div class="btn_wrap">
	                <input type="hidden" name="attendDate" id="attendDate" value="${ todayDate }" />
					<c:if test="${ memberDTO.attend != todayDate }">
						<button type="submit" id="attendButton">출석체크</button>
					</c:if>
					<c:if test="${ memberDTO.attend == todayDate }">
						<button class="attend_complete" type="button" disabled>출석 완료</button>
					</c:if>
				</div>   
            </form>
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>
