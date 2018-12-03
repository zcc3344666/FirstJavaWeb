<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上机考试管理系统</title>
<link rel="stylesheet" href="../assets/css/bootstrap.min.css">
<script src="../assets/js/jquery.min.js"></script>
<script src="../assets/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="../assets/jsp/student/status.jsp"%>
	<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand">上机考试管理系统</a>
		</div>
		<div>
			<ul class="nav navbar-nav" style="float: left;">
				<li><a href="student_main.jsp">首页</a></li>
				<li><a href="check_submit.jsp">查看提交</a></li>
			</ul>
			<ul class="nav navbar-nav" style="float: right;">
				<li><a style="font-size: 20px;">欢迎,<%=session.getAttribute("student")%></a></li>
			</ul>
		</div>
	</div>
	</nav>
</body>
</html>