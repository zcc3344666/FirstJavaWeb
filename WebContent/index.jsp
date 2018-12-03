<%@page import="exam.utils.*"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page language="java" contentType="text/html; chars2et=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; chars2et=UTF-8">
<title>上机考试管理系统</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/login.css">
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<style>
body {
	padding-top: 60px;
	height: 100%;
	width: 100%;
	background-image: url("assets/img/bac.png");
	background-size: cover;
}
</style>
</head>
<body>
	<ul id="loginTab" class="nav nav-tabs" style="font-size: 21px;">
		<li class="active"><a href="#student" data-toggle="tab">学生登录</a></li>
		<li><a href="#teacher" data-toggle="tab">教师登录</a></li>
		<li><a href="#admin" data-toggle="tab">管理员登录</a></li>
	</ul>
	<br>
	<br>
	<div id="loginTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="student" class="container">
			<nav class="navbar navbar-default" role="navigation"
				style="margin-left: 10%;margin-right: 10%">
			<div>
				<ul class="nav navbar-nav">
					<li><h4  id="st_warning">没有进行中的考试，不能登录！</h4></li>
				</ul>
			</div>
			</nav>
			<div class="row">
				<div class="col-md-offset-4 col-md-4">
					<form class="form-horizontal" action="Student_check" method="post">
						<span class="heading">学生登录</span>
						<div class="form-group">
							<input type="text" class="form-control" name="st_no"
								placeholder="学　号">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="st_name"
								placeholder="姓　名">
						</div>
						<div class="form-group">
							<div class="main-checkbox">
								<input type="checkbox" value="None" id="checkbox1" name="check" />
								<label for="checkbox1"></label>
							</div>
							<span class="text">Remember me</span>
							<button id="st_btn" type="submit" class="btn btn-default">登录</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="teacher" class="container">
			<div class="row">
				<div class="col-md-offset-4 col-md-4">
					<form class="form-horizontal" action="Teacher_check" method="post">
						<span class="heading">教师登录</span>
						<div class="form-group">
							<input type="text" class="form-control" name="te_name"
								placeholder="用  户  名">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="te_pwd"
								placeholder="密　码">
						</div>
						<div class="form-group">
							<div class="main-checkbox">
								<input type="checkbox" value="None" id="checkbox1" name="check" />
								<label for="checkbox1"></label>
							</div>
							<span class="text">Remember me</span>
							<button type="submit" class="btn btn-default">登录</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="admin" class="container">
			<div class="row">
				<div class="col-md-offset-4 col-md-4">
					<form class="form-horizontal" action="Admin_check" method="post">
						<span class="heading">管理员登录</span>
						<div class="form-group">
							<input type="text" class="form-control" name="ad_name"
								placeholder="用  户  名">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="ad_pwd"
								placeholder="密　码">
						</div>
						<div class="form-group">
							<div class="main-checkbox">
								<input type="checkbox" value="None" id="checkbox1" name="check" />
								<label for="checkbox1"></label>
							</div>
							<span class="text">Remember me</span>
							<button type="submit" class="btn btn-default">登录</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%
	ArrayList<ArrayList<Object>> submit=new ArrayList<ArrayList<Object>>();
	session.setAttribute("submitList", submit);
	String st_sql = "SELECT * FROM exam WHERE eactive<>'0'";
	ResultSet rs2=DbUtil.executeQuery(st_sql);
	try {
		int ad_count=0;
		String Exam_startname="";
		while(rs2.next()) {
			Exam_startname=rs2.getString("ename");
			ad_count++;
		}
		if(ad_count>0){%>
		<script type="text/javascript">
		$('#st_warning').text("考试(<%=Exam_startname %>)正在进行中,可以登录进行考试。");
		$('#st_btn').attr("disabled", false);
		</script>
			<%
		}else{%>
		<script type="text/javascript">
		$('#st_warning').text("没有进行中的考试，不能登陆！");
		$('#st_btn').attr("disabled", true);
		</script>
			<%
			
		}
		}catch(Exception e){
			e.printStackTrace();
		}
	
		String flag = request.getParameter("succ");
		String flags = request.getParameter("errNo");
		try {
			if (flag != null && flag.equals("1"))
				out.print("<script>alert('密码修改成功，请重新登录！');</script>");
			if (flags != null){
				switch(flags){
				case "1":out.print("<script>alert('用户名或密码有误，请重新输入！');</script>"); break;
				case "2":out.print("<script>alert('学号或姓名有误，请重新输入！');</script>"); break;
				case "3":out.print("<script>alert('该学生已绑定其他计算机，可请求老师解绑！');</script>"); break;
				default : break;
				}
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	%>
</body>
</html>