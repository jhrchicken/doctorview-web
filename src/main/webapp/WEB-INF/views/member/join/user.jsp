<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ include file="../../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-join-user.css" />
<script>
// 	폼값 검증
	function validateForm(form) {
		if (form.id.value == '') {
			alert("아이디를 입력하세요.");
			form.id.focus();
			return false;
		}
	    if (form.idCheck.value !== "check") {
	        alert("아이디 중복체크를 진행하세요.");
	        form.idCheckBtn.focus();
	        return false;
	    }
		if (form.password.value == '') {
			alert("비밀번호를 입력하세요.");
			form.password.focus();
			return false;
		}
		if (form.password.value != form.passwordCheck.value) {
	        alert("비밀번호가 일치하지 않습니다.");
	        form.passwordCheck.focus();
	        return false;
	    } 
		var password_pattern =  /^[a-zA-Z0-9]{8,20}$/;
		if (!password_pattern.test(form.password.value)) {
		    alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
		    form.password.focus();
		    return false;
		}
		if (form.password.value == form.id.value) {
		    alert("비밀번호와 아이디는 일치할 수 없습니다.");
		    form.password.focus();
		    return false;
		}
		
		if (form.name.value == '') {
			alert("이름을 입력하세요.");
			form.name.focus();
			return false;
		}
		if (form.nickname.value == '') {
			alert("닉네임을 입력하세요.");
			form.name.focus();
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
		if (form.email1.value == '') {
			alert("이메일을 입력하세요.");
			form.email1.focus();
			return false;
		}
		if (form.email2.value == '') {
			alert("이메일을 입력하세요.");
			form.email2.focus();
			return false;
		}
		if (form.address.value == '') {
			alert("주소를 입력하세요.");
			form.address.focus();
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
		
	    if (!form.terms1.checked) {
	        alert("약관에 동의해야 합니다.");
	        return false;
	    }
	    if (!form.terms2.checked) {
	        alert("약관에 동의해야 합니다.");
	        return false;
	    }
		return true;
	}
	
	$(function() {
		// 아이디 중복 확인
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
		        url: "../../member/join/checkId.do", 
		        data: { join_id: join_id },
		        success: function(responseData) {
		            if (responseData === "0") {
		                $("#idCheckResult").css("color", "green").text("사용가능한 아이디");
		                $('input[name="idCheck"]').val("check");
		            } else {
		                $("#idCheckResult").css("color", "red").text("사용불가한 아이디");
		                $('input[name="idCheck"]').val("unCheck");
		            }
		        },
		        error: function(errData) {
		            alert("실패: " + errData.status + " - " + errData.statusText);
		        }
		    });
		});
		
		// 닉네임 생성
		$("#randomNickname").click(function() {
		    $.ajax({
		        url: "../../member/join/getNick.do",
		        success: function(responseData) {
		            $('input[name="nickname"]').val(responseData);
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
        <h2>일반 회원가입</h2>
        
        <form name="joinFrm" method="post" action="../../member/join/user.do" onsubmit="return validateForm(this);">
          <div class="agree_wrap">
            <div class="agree">
              <p class="agree_title">개인정보 수집 및 이용 동의</p>     
              <div class="agree_box">
                <p>'닥터뷰'(이하 "회사")는 회원가입 절차에서 필요한 최소한의 개인정보를 수집하고 있습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 사용하며, 사용 목적 외 다른 용도로는 절대 사용하지 않습니다.<br>
                <br>
                1. 수집하는 개인정보 항목<br>
                • 필수 항목: 이름, 이메일 주소, 비밀번호, 연락처(휴대전화번호)<br>
                • 선택 항목: 프로필 사진, 성별, 생년월일<br>
                <br>
                2. 개인정보의 수집 및 이용 목적<br>
                • 회원 가입 의사 확인, 이용자 식별 및 본인 인증<br>
                • 고객 관리 및 서비스 이용에 관한 문의 처리<br>
                • 맞춤형 콘텐츠 제공 및 서비스 개선<br>
                • 법적 의무 준수 및 분쟁 해결<br>
                <br>
                3. 개인정보의 보유 및 이용 기간<br>
                • 회원 탈퇴 시 즉시 파기 (단, 관련 법령에 따라 보존이 필요한 경우에는 해당 기간 동안 보관)<br>
                <br>
                4. 동의 거부 시 불이익 안내<br>
                회원가입 시 필수 항목에 대한 동의를 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.<br>
                <br>
                5. 개인정보 제공 동의<br>
                회사는 수집된 개인정보를 상기 목적 범위 내에서만 사용하며, 회원님의 동의 없이 제3자에게 제공하지 않습니다.<br>
                <br>
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
                <p>'닥터뷰'(이하 "회사")는 서비스 향상을 위해 개인정보 처리 업무를 외부 전문업체에 위탁할 수 있습니다. 회사는 위탁 계약 시 개인정보 보호법 등 관련 법령에 따라 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.<br>
                <br>
                1. 개인정보 처리 위탁 사항<br>
                회사는 다음과 같은 업무를 위탁하며, 위탁 받은 업체는 해당 업무를 수행하기 위해 필요한 범위 내에서만 개인정보를 처리합니다.<br>
                <br>
                • 위탁 업무 내용: 데이터 보관 및 관리, 결제 처리, 고객 문의 대응<br>
                • 위탁 업체: (해당 시 위탁업체의 이름을 명시)<br>
                <br>
                2. 개인정보의 위탁 목적<br>
                • 회원의 원활한 서비스 제공을 위한 데이터 보관 및 유지<br>
                • 결제 서비스 및 고객 지원 서비스 제공<br>
                • 시스템 운영 및 유지보수<br>
                <br>
                3. 위탁업체의 개인정보 처리 보유 및 이용 기간<br>
                • 회원 탈퇴 시 또는 위탁 계약 종료 시 즉시 파기<br>
                • 법령에 의해 보존이 필요한 경우 해당 법령에 따른 보존 기간 동안 보관<br>
                <br>
                4. 동의 거부 시 불이익 안내<br>
                회원님께서는 개인정보 위탁에 대한 동의를 거부할 수 있으나, 이 경우 일부 서비스 이용에 제한이 있을 수 있습니다.<br>
                <br>
                본인은 위 내용을 충분히 이해하였으며, 이에 동의합니다.</p>
              </div>
              <label class="checkbox_wrap">
                <input id="terms2" name="terms2" type="checkbox" value="yes" />
                <label for="terms2">개인정보 위탁에 동의합니다. <span class="must">(필수)</span></label>
              </label>
            </div>
          </div>

          <form>
            <p>*필수 입력사항</p>
            <table class="regist">
              <tr>
                <td class="left">아이디</td>
                <td class="id">
                  <input type="text" name="id" value="" maxlength="15" placeholder="아이디* (영문/숫자, 6~15자)" />
                  <button class="id_check" type="button" name="idCheckBtn" id="idCheckBtn"><span class="blind">중복 확인</span></button>
                  <span id="idCheckResult" class="notice_ok"></span>
            	  <input type="hidden" name="idCheck" value="unCheck" />
                </td>
              </tr>
              <tr class="pass">
                <td rowspan="2" class="left">비밀번호</td>
                <td><input type="password" name="password" value="" maxlength="20" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)" /></td>
              </tr>
              <tr>
                <td>
                  <input type="password" name="passwordCheck" value="" maxlength="20" placeholder="비밀번호 확인*">
                </td>
              </tr>
              <tr>
                <td class="left">이름</td>
                <td><input type="text" name="name" value="" placeholder="이름*" /></td>
              </tr>
              <tr>
                <td class="left">닉네임</td>
                <td class="nick">
                  <input type="text" name="nickname" value="" placeholder="닉네임*" />
                  <button class="random" type="button" name="randomNickname" id="randomNickname"><span class="blind">랜덤 추천</span></button>
                </td>
              </tr>
              <tr>
                <td class="left">전화번호</td>
                <td class="mobile">
                  <input type="tel" name="tel1" maxlength="3" value="" placeholder="010" /> -
				  <input type="tel" name="tel2" maxlength="4" value="" placeholder="0000" /> -
				  <input type="tel" name="tel3" maxlength="4" value="" placeholder="0000" />
                </td>
              </tr>
              <tr>
                <td class="left">이메일</td>
                <td class="mail">
	              <input type="text" name="email1" value="" placeholder="이메일*" /> @ 
	              <input type="text" name="email2" id="email2" value="" placeholder="naver.com" />
				  <select id="emailDomainSelect">
			        <option value="">직접 입력</option>
			        <option value="naver.com">naver.com</option>
			        <option value="gmail.com">gmail.com</option>
			        <option value="daum.net">daum.net</option>
			        <option value="hanmail.net">hanmail.net</option>
			      </select>
                </td>
              </tr>
              <script>
				    document.getElementById("emailDomainSelect").addEventListener("change", function() {
				        var email2 = document.getElementById("email2");
				        var selectedValue = this.value;
				
				        if (selectedValue === "") {
				            email2.value = "";
				            email2.readOnly = false;
				            email2.placeholder = "직접 입력";
				        } else {
				            email2.value = selectedValue;
				            email2.readOnly = true;
				        }
				    }); 
			  </script>
              <tr>
                <td class="left">주소</td>
                <td><input type="text" name="address" value="" placeholder="주소* ex) 서울특별시" /></td>
              </tr>
              <tr>
                <td class="left">주민등록번호</td>
                <td class="resi">
                  <input type="text" name="rrn1" value="" maxlength="6" placeholder="주민등록번호*" /> - 
                  <input type="text" name="rrn2" value="" maxlength="1" />
                </td>
              </tr>
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