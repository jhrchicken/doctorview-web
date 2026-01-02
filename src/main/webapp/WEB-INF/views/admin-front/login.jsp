<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="./inc/common_head.jsp" %>

<body> 
  <!--  Body Wrapper -->
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    <div
      class="position-relative overflow-hidden radial-gradient min-vh-100 d-flex align-items-center justify-content-center">
      <div class="d-flex align-items-center justify-content-center w-100">
        <div class="row justify-content-center w-100">
          <div class="col-md-8 col-lg-6 col-xxl-3">
            <div class="card mb-0">
              <div class="card-body">
                <a href="../main/index.do" class="text-nowrap logo-img text-center d-block py-3 w-100">
                  <img src="../assets/images/logos/doctor_logo.png">
                </a>
                <c:choose>
                	<c:when test="${ not empty loginFailed }">
                		<p class="text-center text-danger">${ loginFailed }</p>	
                	</c:when>
                	<c:otherwise>
                		<p class="text-center">닥터뷰 관리자만 로그인할 수 있습니다.</p>
                	</c:otherwise>
                </c:choose>
<script>
function checkForm(f){
	if(!f.id.value){
		alert('아이디를 입력하세요');
		f.id.focus();
		return false; 
	}
	if(!f.password.value){
		alert('비밀번호를 입력하세요');
		f.password.focus();
		return false; 
	}
	f.action = "/admin/login.do";
}
</script>                
<form name="loginForm" method="post" onsubmit="return checkForm(this);">
                  <div class="mb-3">
<label for="exampleInputEmail1" class="form-label">아이디</label>
<input type="text" class="form-control" id="exampleInputEmail1" 
	aria-describedby="emailHelp" name="id">
                  </div>
                  <div class="mb-4">
<label for="exampleInputPassword1" class="form-label">비밀번호</label>
<input type="password" class="form-control" id="exampleInputPassword1"
	name="password">
                  </div>
                  <div class="d-flex align-items-center justify-content-between mb-4">
                    <div class="form-check">
                      <%-- 쿠키 : ${adminSaveId } --%>                      
                      <input class="form-check-input primary" 
                      	type="checkbox"	value="1" name="saveId"
                      	<c:if test="${ not empty adminSaveId }">checked</c:if>>
                      <label class="form-check-label text-dark" for="flexCheckChecked">
                        아이디 저장하기
                      </label>
                    </div>
                    <!-- <a class="text-primary fw-bold" href="./index.html">Forgot Password ?</a> -->
                  </div>
                  
<input type="submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 
	rounded-2" value="LogIn">
<!-- <button type="submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 
	rounded-2">LogIn[로그인]</button>	 -->
	
                  <div class="d-flex align-items-center justify-content-center">
                    <p class="fs-4 mb-0 fw-bold"></p>
                    <a class="text-primary fw-bold ms-2" href="../">홈페이지 바로가기</a>
                  </div>
</form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="../assets/libs/jquery/dist/jquery.min.js"></script>
  <script src="../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>