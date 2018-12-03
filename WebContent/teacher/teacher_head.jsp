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
<link rel="stylesheet"
	href="../assets/css/bootstrap-datetimepicker.min.css">
<script src="../assets/js/bootstrap-datetimepicker.min.js"></script>
<script src="../assets/js/bootstrap-datetimepicker.zh-CN.js"></script>
<link rel="stylesheet" href="../assets/css/main.css">
</head>
<body>
	<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand">上机考试管理系统</a>
		</div>
		<div>
			<ul class="nav navbar-nav" style="float: left;">
				<li><a href="teacher_main.jsp">首页</a></li>
				<li><a href="exam_before.jsp">考前操作</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 考中管理 <b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a href="middle_condition.jsp">考试概况</a></li>
						<li><a href="middle_student_message.jsp">学生信息</a></li>
						<li><a href="middle_cancel_ip.jsp">解除锁定</a></li>
						<li><a href="middle_inform.jsp">通知管理</a></li>
					</ul></li>

				<li><a href="exam_after.jsp">考后操作</a></li>
			</ul>
			<ul class="nav navbar-nav" style="float: right;">
				<li><a style="font-size: 20px;">欢迎,<%=session.getAttribute("teacher") %></a></li>
				<li><a href="#" data-toggle="modal" data-target="#changeModal">修改口令</a></li>
				<li><a href="../index.jsp">退出</a></li>
			</ul>
		</div>
	</div>
	
	<div class="modal fade" id="changeModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改口令</h4>
				</div>
				<form action="../Teacher_change_pass" method="post">
					<div style="margin-left: 35%; margin-right: 35%; margin-top: 50px;">
						<input type="hidden" value="<%=session.getAttribute("teacher")%>"
							name="teacher_name" /> <input type="password" name="oldpass"
							placeholder="原口令" style="width: 100%" /> <br /> <br /> <input
							type="password" name="newpass1" placeholder="新口令"
							style="width: 100%" /> <br /> <br /> <input type="password"
							name="newpass2" placeholder="重新输入新口令" style="width: 100%" /> <br />
						<br />
						<div>
							<input data-dismiss="modal" type="button" value="取消"
								style="width: 45%; float: left;"> <input type="submit"
								value="修改" style="width: 45%; float: right;" />
						</div>
					</div>
				</form>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>
	
	</nav>
	<nav class="navbar" role="navigation"
		style="margin-left: 10%;margin-right: 10%;">
		<h3>上机考试管理</h3>
	</nav>
	
	<%
	String flag = request.getParameter("te_error");
		try {
			if (flag != null) {
				switch (flag) {
				case "1":
					out.print("输入有空值，修改失败！");
					break;
				case "2":
					out.print("两次新密码输入不一致，修改失败！");
					break;
				case "3":
					out.print("原密码有误，修改失败！");
					break;
				default:
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>