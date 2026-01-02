<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ include file="../../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-join-hosp.css" />
<script>
	// 폼값 검증
   function validateForm(form) {
	   const fieldsToValidate = [
	        { field: form.id, message: "아이디를 입력하세요." },
	        { field: form.password, message: "비밀번호를 입력하세요." },
	        { field: form.passwordCheck, message: "비밀번호 확인을 입력하세요." },
	        { field: form.name, message: "병원명을 입력하세요." },
	        { field: form.tel1, message: "전화번호를 입력하세요." },
	        { field: form.tel2, message: "전화번호를 입력하세요." },
	        { field: form.tel3, message: "전화번호를 입력하세요." },
	        { field: form.address, message: "주소를 입력하세요." },
	        { field: form.department, message: "진료과목을 입력하세요." },
	        { field: form.taxid1, message: "사업자 번호를 입력하세요." },
	        { field: form.taxid2, message: "사업자 번호를 입력하세요." },
	        { field: form.taxid3, message: "사업자 번호를 입력하세요." },
	        { field: form.starttime, message: "진료 시작 시간을 입력하세요." },
	        { field: form.endtime, message: "진료 종료 시간을 입력하세요." },
	        { field: form.startbreak, message: "휴게 시작 시간을 입력하세요." },
	        { field: form.endbreak, message: "휴게 종료 시간을 입력하세요." },
	        { field: form.deadline, message: "접수 마감 시간을 입력하세요." }
	    ];
	
	    // 일반 필드 검증
	    for (let i = 0; i < fieldsToValidate.length; i++) {
	        const { field, message } = fieldsToValidate[i];
	        if (field.value.trim() === '') {
	            alert(message);
	            field.focus();
	            return false;
	        }
	    }
	    
	 	// 의사정보 검증
	    const arrayFields = [
	        { field: form.doctornamez, message: "의료진 이름을 입력하세요." },
	        { field: form.majorz, message: "전공을 입력하세요." },
	        { field: form.careerz, message: "경력을 입력하세요." },
	        { field: form.hoursz, message: "진료 시간을 입력하세요." }
	    ];

	    for (let i = 0; i < arrayFields.length; i++) {
	        const { field, message } = arrayFields[i];
	        for (let j = 0; j < field.length; j++) {
	            if (field[j].value.trim() === '') {
	                alert(message);
	                field[j].focus();
	                return false;
	            }
	        }
	    }

	    // 아이디 중복 체크 여부
	    if (form.idCheck.value !== "check") {
	        alert("아이디 중복체크를 진행하세요.");
	        form.idCheckBtn.focus();
	        return false;
	    }
	
	    // 비밀번호 확인
	    if (form.password.value !== form.passwordCheck.value) {
	        alert("비밀번호가 일치하지 않습니다.");
	        form.passwordCheck.focus();
	        return false;
	    }
	
	    // 비밀번호 패턴 체크
	    const passwordPattern = /^[a-zA-Z0-9]{8,20}$/;
	    if (!passwordPattern.test(form.password.value)) {
	        alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
	        form.password.focus();
	        return false;
	    }
	
	    // 비밀번호와 아이디 일치 체크
	    if (form.password.value === form.id.value) {
	        alert("비밀번호와 아이디는 일치할 수 없습니다.");
	        form.password.focus();
	        return false;
	    }
	
	    // 요일 체크 여부
	    const weeksCheckboxes = form.querySelectorAll('input[name="weeks"]');
	    const isWeekChecked = Array.from(weeksCheckboxes).some(checkbox => checkbox.checked);
	    if (!isWeekChecked) {
	        alert("요일 중 하나를 반드시 선택하세요.");
	        return false;
	    }
	
	    // 약관 동의 여부 확인
	    if (!form.terms1.checked) {
	        alert("약관1에 동의해야 합니다.");
	        return false;
	    }
	
	    if (!form.terms2.checked) {
	        alert("약관2에 동의해야 합니다.");
	        return false;
	    }
	
	    return true;
	}
   
   // 아이디 중복 확인
   $(function() {
       $.ajaxSetup({
           url: "../../member/join/checkId.do",
           dataType: "text",
       });

       $("#idCheckBtn").click(function() {
            var join_id = $('input[name="id"]').val();

		    if (join_id.length < 6) {
		    	alert("6자 이상으로 입력해주세요.");
		    	$('input[name="id"]').focus();
		    	return false;
		    }
		    
		    var id_pattern = /^[a-zA-Z0-9]+$/;
		    if (!id_pattern.test(join_id)) {
		        alert("아이디는 영문자와 숫자만 포함되어야 합니다.");
		        $('input[name="id"]').focus();
		        return false;
		    }
            

           $.ajax({
               data: { join_id: join_id },
               success: function(responseData) {
                   if (responseData == "0") {
                       $("#idCheckResult").css("color","green").html("사용가능한 아이디");
                       $('input[name="idCheck"]').val("check");
                   } else {
                       $("#idCheckResult").css("color","red").html("사용할 수 없는 아이디");
                       $('input[name="idCheck"]').val("unCheck");
                   }
               },
               error: function(errData) {
                   alert("실패: " + errData.status + " - " + errData.statusText);
               }
           });
       });
   });
</script>
</head>
<body>
<%@ include file="../../common/main_header.jsp" %>
	
<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
        <h2>병원 회원가입</h2>
        <form name="joinFrm" method="post" action="../../member/join/hosp.do" onsubmit="return validateForm(this);">
          <div class="agree_wrap">
            <div class="agree">
              <p class="agree_title">개인정보 수집 및 이용 동의</p>     
              <div class="agree_box">
                <p>'닥터뷰'(이하 "회사")는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다.<br />
                <br />
                1. 수집하는 개인정보 항목<br />
                • 필수 항목: 이름, 이메일 주소, 비밀번호, 연락처(휴대전화번호)<br />
                • 선택 항목: 프로필 사진, 성별, 생년월일<br />
                <br />
                2. 개인정보의 수집 및 이용 목적<br />
                • 회원 가입 의사 확인, 이용자 식별 및 본인 인증<br />
                • 고객 관리 및 서비스 이용에 관한 문의 처리<br />
                • 맞춤형 콘텐츠 제공 및 서비스 개선<br />
                • 법적 의무 준수 및 분쟁 해결<br />
                <br />
                3. 개인정보의 보유 및 이용 기간<br />
                • 회원 탈퇴 시 즉시 파기 (단, 관련 법령에 따라 보존이 필요한 경우에는 해당 기간 동안 보관)<br />
                <br />
                4. 동의 거부 시 불이익 안내<br />
                회원가입 시 필수 항목에 대한 동의를 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.<br />
                <br />
                5. 개인정보 제공 동의<br />
                회사는 수집된 개인정보를 상기 목적 범위 내에서만 사용하며, 회원님의 동의 없이 제3자에게 제공하지 않습니다.<br />
                <br />
                본인은 위 내용을 충분히 이해하였으며, 이에 동의합니다.</p>
              </div>
              <label class="checkbox_wrap">
                <input id="terms1" name="terms1" type="checkbox" value="yes" />
                <label for="terms1">개인정보 수집 및 이용에 동의합니다. <span class="must">(필수)</span></label>
              </label>
            </div>
            <div class="agree">
              <p class="agree_title">개인정보 처리 위탁에 대한 동의</p>     
              <div class="agree_box">
                <p>'닥터뷰'(이하 "회사")는 서비스 향상을 위해 개인정보 처리 업무를 외부 전문업체에 위탁할 수 있습니다. 회사는 위탁 계약 시 개인정보 보호법 등 관련 법령에 따라 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.<br />
                <br />
                1. 개인정보 처리 위탁 사항<br />
                회사는 다음과 같은 업무를 위탁하며, 위탁 받은 업체는 해당 업무를 수행하기 위해 필요한 범위 내에서만 개인정보를 처리합니다.<br />
                <br />
                • 위탁 업무 내용: 데이터 보관 및 관리, 결제 처리, 고객 문의 대응<br />
                • 위탁 업체: (해당 시 위탁업체의 이름을 명시)<br />
                <br />
                2. 개인정보의 위탁 목적<br />
                • 회원의 원활한 서비스 제공을 위한 데이터 보관 및 유지<br />
                • 결제 서비스 및 고객 지원 서비스 제공<br />
                • 시스템 운영 및 유지보수<br />
                <br />
                3. 위탁업체의 개인정보 처리 보유 및 이용 기간<br />
                • 회원 탈퇴 시 또는 위탁 계약 종료 시 즉시 파기<br />
                • 법령에 의해 보존이 필요한 경우 해당 법령에 따른 보존 기간 동안 보관<br />
                <br />
                4. 동의 거부 시 불이익 안내<br />
                회원님께서는 개인정보 위탁에 대한 동의를 거부할 수 있으나, 이 경우 일부 서비스 이용에 제한이 있을 수 있습니다.<br />
                <br />
                본인은 위 내용을 충분히 이해하였으며, 이에 동의합니다.</p>
              </div>
              <label class="checkbox_wrap">
                <input id="terms2" name="terms2" type="checkbox" value="yes" />
                <label for="terms2">개인정보 위탁에 동의합니다. <span class="must">(필수)</span></label>
              </label>
            </div>
          </div>


          <p>*필수 입력사항</p>
          <table class="regist">
            <tr>
              <td class="left">아이디</td>
              <td class="id">
                <input type="text" name="id" value="" maxlength="15" placeholder="아이디* (영문+숫자, 6~15자)" />
                <button id="idCheckBtn" name="idCheckBtn" class="id_check" type="button"><span class="blind">중복 확인</span></button>
                <span id="idCheckResult" class="notice_ok"></span> 
                <input type="hidden" name="idCheck" value="unCheck" />
              </td>
            </tr>
            <!-- 비밀번호 폼 시작 -->
            <tr class="pass">
              <td rowspan="2" class="left">비밀번호</td>
              <td><input type="password" name="password" value="" maxlength="20" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)" /></td>
            </tr>
            <tr>
              <td>
                <input type="password" name="passwordCheck" value="" maxlength="20" placeholder="비밀번호 확인*" />
              </td>
            </tr>
            <!-- 비밀번호 폼 끝 -->
            <tr>
              <td class="left">이름</td>
              <td><input type="text" name="name" value="" placeholder="병원명*" /></td>
            </tr>
            <tr>
              <td class="left">전화번호</td>
              <td class="mobile">
				<input type="tel" name="tel1" maxlength="3" value="" placeholder="031" /> -
				<input type="tel" name="tel2" maxlength="4" value="" placeholder="전화번호*" /> -
				<input type="tel" name="tel3" maxlength="4" value="" />
              </td>
            </tr>
            <tr>
              <td class="left">주소</td>
              <td><input type="text" name="address" value="" placeholder="주소*" /></td>
            </tr>
            <tr>
              <td class="left">진료과목</td>
              <td>
                <input type="text" name="department" value="" placeholder="진료과목*" />
            </tr>
            <tr>
              <td class="left">사업자 번호</td>
              <td class="regi">
				<input type="text" name="taxid1" value="" maxlength="3" placeholder="사업자번호*" /> -
				<input type="text" name="taxid2" value="" maxlength="2" placeholder="사업자번호*" /> -
				<input type="text" name="taxid3" value="" maxlength="5" placeholder="사업자번호*" />
           	  </td>
            </tr>
            <!-- 영업시간 폼 시작 -->
            <tr class="time">
              <td rowspan="4" class="left">진료시간</td>
              <td>
                 요일:  
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
                  		<input id="thursday" type="checkbox" name="weeks" value="목요일" />
                  		<label for="thursday">목</label>
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
	    <option value="">시작 시간 선택</option>
	</select>
     ~ 
    <select class="searchField" id="endtime" name="endtime">
	    <option value="">종료 시간 선택</option>
	</select>
  </td>
</tr>
<tr class="time">
  <td>
    휴게 시간
    <select class="searchField" id="startbreak" name="startbreak">
	    <option value="">시작 시간 선택</option>
	</select>
     ~ 
    <select class="searchField" id="endbreak" name="endbreak">
	    <option value="">종료 시간 선택</option>
	</select>
  </td>
</tr>
<tr class="time">
  <td class="deadline">
    접수 마감
    <select class="searchField" id="deadline" name="deadline">
	    <option value="">종료 시간 선택</option>
	</select>
  <p class="caution">*접수 마감시간이 오후 8시 이후이면 '야간 진료 가능'으로 표시됩니다.</p>
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



            
            
            <!-- 영업시간 폼 끝 -->
            <!-- 의료진 폼 시작 -->
            <tr class="doc">
              <td rowspan="4" class="left">의료진</td>
              <td id="doctorContainer">
              	<table class="doctor-info">
              		<tr>
              			<td class="left">이름 </td>
              			<td><input type="text" name="doctornamez" value="" placeholder="이름*" /></td>
              		</tr>
              		<tr>
              			<td class="left">전공 </td>
              			<td><input type="text" name="majorz" placeholder="전공*" /></td>
              		</tr>
              		<tr>
              			<td class="left">경력</td>
              			<td><input type="text" name="careerz" placeholder="경력*" /></td>
              		</tr>
              		<tr>
              			<td class="left">진료시간</td>
              			<td><input type="text" name="hoursz" value="" class="doc_time" placeholder="진료시간*" /></td>
              		</tr>
              	</table>
              	<div class="add">
					<button id="addDoctor" class="plus" type="button"><span class="blind">의료진 추가</span></button>
					<button id="deleteDoctor" class="delete" type="button"><span class="blind">의료진 삭제</span></button>
              	</div>
              </td>
            </tr>
            
            <script>
	         // 새로운 의료진 정보 추가
            document.getElementById("addDoctor").onclick = function() {
	            const newDoctorInfo = document.createElement("table");
	            newDoctorInfo.className = "doctor-info";
	            newDoctorInfo.innerHTML = `
	            	<tr>
      			<td class="left">이름: </td>
      			<td><input type="text" name="doctornamez" value="" placeholder="이름*" /></td>
       		</tr>
       		<tr>
       			<td class="left">전공: </td>
       			<td><input type="text" name="majorz" placeholder="전공*" /></td>
       		</tr>
       		<tr>
       			<td class="left">경력</td>
       			<td><input type="text" name="careerz" placeholder="경력*" /></td>
       		</tr>
       		<tr>
       			<td class="left">진료시간:</td>
       			<td><input type="text" name="hoursz" value="" class="doc_time" placeholder="진료시간*" /></td>
       		</tr>
	            `;
	            
	            const doctorContainer = document.getElementById("doctorContainer");
	            doctorContainer.appendChild(newDoctorInfo);
	            doctorContainer.appendChild(document.getElementById("addDoctor"));
	            doctorContainer.appendChild(document.getElementById("deleteDoctor"));
	          };
	          
	          // 의사 입력테이블 삭제
	          document.getElementById("deleteDoctor").onclick = function() {
	        	    const doctorContainer = document.getElementById("doctorContainer");
	        	    const addedDoctors = doctorContainer.querySelectorAll(".doctor-info");
	        	    
	        	    if (addedDoctors.length > 1) {
	        	        doctorContainer.removeChild(addedDoctors[addedDoctors.length - 1]);
	        	    }
	        	};
	        	
            </script>
            

            <!-- 의료진 폼 끝 -->
          </table>    

            
          <div class="btn_wrap">
            <input type="submit" value="완료" />
          </div>
        </form>
      </div>
    </div>
  </div>
</main>
	
<%@include file="../../common/main_footer.jsp" %>
</body>
</html>