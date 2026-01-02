<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>닥터뷰 관리자모드</title>
  <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="../assets/css/styles.min.css" />
  <style>
  #boardTr{ background-color:silver;}
  
/*** 페이지네이션 ***/
body p {
	margin: 0;
}
body .table {
	margin-bottom: 0;
}
body .table td {
	text-align: center;
}
body .table td.table_btn_wrap {
	display: flex;
	gap: 0 10px;
	justify-content: center;
}
body .card {
	margin-bottom: 0;
}
body img {
	vertical-align: baseline;
}
body .pagination {
  margin-bottom: 30px;  
  justify-content: center;
}
body .pagination_inner {
  display: flex;
  text-align: center;
  gap: 0 20px;
}
body .pagination a {
  font-weight: 700;
  font-size: 18px;
  color: #bbb;
  display: block;
  width: 24px;
  height: 24px;
}
body .pagination a:hover {
  color: var(--point-color2);
}
body .pagination p {
  font-weight: 700;
  font-size: 18px;
  color: var(--point-color2);
  display: block;
  width: 24px;
  height: 24px;
}
/*** 수정 버튼 ***/
body .btn_wrap {
	display: flex;
	gap: 0 20px;
	justify-content: center;
	margin-bottom: 20px;
}


  </style>  
</head>