<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${ alertFlag eq 'alert01' }">
		<script>
			alert("관리자로 로그인 해야합니다.");
			location.href = "index.do";
		</script>	
	</c:when>
	<c:when test="${ alertFlag eq 'alert02' }">
		<script>
			alert("로그아웃 되었습니다.");
			location.href = "index.do";
		</script>	
	</c:when>
	<c:otherwise>
		<script>
			alert("관리자모드 첫화면으로 이동합니다.");
			location.href = "index.do";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>