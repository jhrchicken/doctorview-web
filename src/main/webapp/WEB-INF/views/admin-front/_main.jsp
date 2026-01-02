<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 관리자 모드</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/admin-main.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">

      <div class="manage">
        
        <div class="wrap">
          <h2>회원 관리</h2>
          <ul class="link">
            <li>
              <p>회원 목록</p>
              <a href="#">바로<br />가기</a>
            </li>
            <li>
              <p>회원 승인</p>
              <a href="#">바로<br />가기</a>
            </li>
          </ul>
        </div>

        <div class="wrap">
          <h2>게시판 관리</h2>
          <ul class="link">
            <li>
              <p>게시물 관리</p>
              <a href="#">바로<br />가기</a>
            </li>
          </ul>
        </div>

      </div>

    </div>
  </div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>