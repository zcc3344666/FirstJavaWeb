<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
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
<link rel="stylesheet" href="../assets/css/main.css">
<script type="text/javascript">
function HideWarning() {
	$('#ad_warning').hide();
}
	
</script>
</head>
<body>
	<div class="navbar navbar-default" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand">上机考试管理系统</a>
			</div>
			<div>
				<ul class="nav navbar-nav" style="float: left;">
					<li><a href="admin_main.jsp">首页</a></li>
					<li><a href="admin_manage_teacher.jsp">教师管理</a></li>
					<li><a href="admin_clean.jsp">考试清理</a></li>
					<li><a href="admin_os.jsp">系统配置</a></li>
				</ul>
				<ul class="nav navbar-nav" style="float: right;">
					<li><a style="font-size: 20px;">欢迎,<%=session.getAttribute("admin")%></a></li>
					<li><a href="#" data-toggle="modal" data-target="#changeModal">修改口令</a></li>

					<li><a href="../index.jsp">退出</a></li>
				</ul>
			</div>
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
				<form action="../Admin_change_pass" method="post">
					<div style="margin-left: 35%; margin-right: 35%; margin-top: 50px;">
						<input type="hidden" value="<%=session.getAttribute("admin")%>"
							name="admin_name" /> <input type="password" name="oldpass"
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

	<nav class="navbar navbar-default" role="navigation"
		style="margin-left: 10%;margin-right: 10%">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand">系统管理</a>
		</div>
		<div id="ad_warning">
			<ul class="nav navbar-nav">
				<li><a>没有设置管理员，系统默认管理员不安全，请尽快处理！</a></li>
			</ul>
		</div>
	</div>
	</nav>
	<%
	String flag = request.getParameter("ad_error");
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
		
		String ad_sql = "SELECT * FROM admin";
		ResultSet rs=DbUtil.executeQuery(ad_sql);
		try {
			int ad_count=0;
			while(rs.next()) {
				ad_count++;
			}
			if(ad_count>1){%>
			<script type="text/javascript">
			$('#ad_warning').hide();
			</script>
				<%
			}else{%>
			<script type="text/javascript">
			$('#ad_warning').show();
			</script>
				<%
				
			}
			}catch(Exception e){
			}
	%>
</body>
</html>