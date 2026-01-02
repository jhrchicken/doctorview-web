document.addEventListener("DOMContentLoaded", function() {
    buildCalendar();
    
    document.getElementById("btnPrevCalendar").addEventListener("click", function(event) {
        prevCalendar();
    });
    
    document.getElementById("nextNextCalendar").addEventListener("click", function(event) {
        nextCalendar();
    });
});
	
// 이전달 버튼 클릭 동작(지난 월 출력)
function prevCalendar() {
    this.toDay = new Date(toDay.getFullYear(), toDay.getMonth() - 1, toDay.getDate());
    buildCalendar();    
}

// 다음달 버튼 클릭 동작
function nextCalendar() {
    this.toDay = new Date(toDay.getFullYear(), toDay.getMonth() + 1, toDay.getDate());
    buildCalendar();   
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

    const year = document.getElementById("calYear").innerText;
    const month = document.getElementById("calMonth").innerText;
    const day = column.innerText.trim(); // 공백 제거
    
    const formattedDate = year + "-" + month + "-" +  day;
    
    // 선택한 날짜를 input에 설정
    document.getElementById("selectedDate").value = formattedDate;
    
    setUnavailableTime(formattedDate);
}


// 일 표시 형식 설정
function autoLeftPad(num, digit) {
    if(String(num).length < digit) {
        num = new Array(digit - String(num).length + 1).join("0") + num;
    }
    return num;
}

// proceed 폼값 검증
function proceedValidateForm(form) {
	// 의사 선택 검증
    const doctorname = form.doctorname;  
    let doctorChecked = false;
    if (doctorname.length) {
        for (let i = 0; i < doctorname.length; i++) {
            if (doctorname[i].checked) {
                doctorChecked = true;
                break;
            }
        }
    } else {
        doctorChecked = doctorname.checked;
    }
    if (!doctorChecked) {
        alert("진료받을 의사를 선택하세요.");
        return false;
    }
	 
	// 시간 선택 검증
	const posttime = form.posttime;  
	let timeChecked = false;
	for (let i = 0; i < posttime.length; i++) {
	    if (posttime[i].checked) {
	    	timeChecked = true;
	        break;
	    }
	}
	if (!timeChecked) {
		alert("진료받을 시간을 선택하세요.");
		return false;
	}
	
	// 예약자 정보 검증
	if (form.username.value == '') {
		alert("방문자 이름을 입력하세요.");
		form.username.focus();
		return false;
	}
	if (form.tel1.value == '') {
		alert("전화번호를 입력하세요.");
		form.tel1.focus();
		return false;
	}
	if (form.tel2.value == '') {
		alert("전화번호를 입력하세요.");
		form.tel2.focus();
		return false;
	}
	if (form.tel3.value == '') {
		alert("전화번호를 입력하세요.");
		form.tel3.focus();
		return false;
	}
	if (form.rrn1.value == '') {
		alert("주민등록번호를 입력하세요.");
		form.rrn1.focus();
		return false;
	}
	if (form.rrn2.value == '') {
		alert("주민등록번호를 입력하세요.");
		form.rrn2.focus();
		return false;
	}

	return true;

}

