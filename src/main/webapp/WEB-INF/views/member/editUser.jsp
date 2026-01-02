<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/edit-user.css" />
<script>
// 	폼값 검증
function validateForm(form) {
	if (form.password.value == '') {
		alert("비밀번호를 입력하세요.");
		form.password.focus();
		return false;
	}
	var password_pattern =  /^[a-zA-Z0-9]{8,20}$/;
	if (!password_pattern.test(form.password.value)) {
	    alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
	    form.password.focus();
	    return false;
	}
	if (form.passwordCheck.value == '') {
		alert("비밀번호가 일치하지않습니다.");
		form.passwordCheck.focus();
		return false;
	}
	
	return true;
}

// 회원탈퇴 confirm
function withdrawMemberConfirm(id) {
    if (confirm("정말 탈퇴하시겠습니까?")) {
    	var form = document.editForm;
    	form.method = "post";
        form.action = "/member/withdraw.do";
        form.submit();
    }
}


$(function() {
	// 닉네임 생성
	$("#randomNickname").click(function() {
	    $.ajax({
	        url: "/member/join/getNick.do",
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
        <h2>회원정보 변경</h2>
        
	    <c:if test="${ not empty editUserFaild }">
	  		<p>${ editUserFaild }</p>
	    </c:if>
        
        <form name="editForm" method="post" action="../../member/editUser.do" onsubmit="return validateForm(this);">
          <p>*필수 입력사항</p>
          <table class="regist">
            <tr>
              <td class="left">아이디</td>
              <td class="id">
			  	<input type="text" name="id" value="${ loginUserInfo.id }" maxlength="15" readonly/>
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
              <td><input type="text" name="name" value="${ loginUserInfo.name }" placeholder="이름*" /></td>
            </tr>
            <tr>
              <td class="left">닉네임</td>
              <td class="nick">
                <input type="text" name="nickname" value="${ loginUserInfo.nickname }" placeholder="닉네임*" />
                <button class="random" type="button" name="randomNickname" id="randomNickname"><span class="blind">랜덤 추천</span></button>
              </td>
            </tr>
            <tr>
              <td class="left">전화번호</td>
              <td class="mobile">
               	<input type="tel" name="tel1" maxlength="3" value="${ tel[0] }" placeholder="010"/> -
				<input type="tel" name="tel2" maxlength="4" value="${ tel[1] }" placeholder="0000"/> -
				<input type="tel" name="tel3" maxlength="4" value="${ tel[2] }" placeholder="0000"/>
              </td>
            </tr>
            <tr>
              <td class="left">이메일</td>
              <td class="mail">
                <input type="text" name="email1" value="${ email[0] }" placeholder="이메일*"> @
                <input type="text" name="email2" id="email2" value="${ email[1] }" placeholder="naver.com"/>
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
              <td>
                <input type="text" name="address" value="${ loginUserInfo.address }" placeholder="주소* ex) 서울특별시">
              </td>
            </tr>
            
          </table>    
          <div class="btn_wrap">
            <input type="submit" value="수정하기" />
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