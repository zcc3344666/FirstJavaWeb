<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="teacher_head.jsp"%>

<%
	//设置请求报文的字符编码为utf-8
	request.setCharacterEncoding("utf-8");
	//获取表单输入域的值
	String examId = request.getParameter("id");
	
	String students = "SELECT * FROM student WHERE eid = '" + examId + "'";
	ResultSet rs3=DbUtil.executeQuery(students);
	int counts=0;
	try{
		while(rs3.next()){
			counts++;
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	session.setAttribute("examId_upload", examId);
	String uploadErr = (String) session.getAttribute("uploadErr");
	if (uploadErr == null) {
		uploadErr = "";
	}

	session.setAttribute("addstuErr", "");//提前把添加学生提示清空
	session.setAttribute("suploadErr", "");
	
	String ename = "", etime = "", eautostart = "", epaper = "";

	String sql0 = "select * from exam where id='" + examId + "'";
	try {
		ResultSet rs = DbUtil.executeQuery(sql0);
		int count = 0;
		while (rs.next()) {
			ename = rs.getString("ename");
			etime = rs.getString("etime");
			etime = etime.substring(0, etime.length() - 5) + " ";

			if (rs.getInt("eautostart") == 1) {
				eautostart = "checked";
			}
			epaper = rs.getString("epaper");
			count++;
		}

		if (count == 0) {
			response.sendRedirect("exam_before.jsp");
		} else {

		}
		DbUtil.close();
	} catch (Exception e) {
		response.sendRedirect("exam_before.jsp");
	}
%>

<div class="container">
	<div class="row" style="background: #CDCDCD;">
		<h4>编辑考试信息</h4>
		<form id="teacher_exam_update" action="" method="post">
			<input type="hidden" name="id" value="<%=examId%>" />
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="ename"
					placeholder="考试名称" value="<%=ename%>" />
			</div>
			<div class='col-sm-3'>
				<div class="form-group">
					<div class='input-group date' id='datetimepicker' data-link-field="etime">
						<input type='text' class="form-control" name="etimes"
							value="<%=etime%>" readonly="readonly" placeholder="考试时间" /> <span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-remove"></span>
						</span> <span class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
			</div>
			<input type="hidden" id="etime" name="etime" />
			<div class="form-group col-sm-3">
				<input type="checkbox" name="eautostart" class="form -control"
					value="true" <%=eautostart%> /><label style="font-size: 18px;">自动开始</label>
				<input class="btn btn-primary" type="button" value="修改" id="btn_log"
					onClick="updateExam();" />
			</div>
		</form>
	</div>
	<br />
</div>

<div class="container">
	<div class="row" style="background: #CDCDCD;">
		<h4>上传试卷</h4>
		<form action="../Upload_paper" id="teacher_exam_upload"
			enctype="multipart/form-data" method="post">

			<%
				if (epaper != null && !epaper.equals("")) {
			%>

			<p style="background: black; color: white;">
				已经上传过试卷，再次上传将导致原有试卷不可访问！ <a class="btn" href="../Download_paper"><i
					class="glyphicon glyphicon-download-alt"></i>下载查看</a>
			</p>
			<div class="form-inline">
				<input type="file" name="paper" class="form-control" /> <input
					type="submit" class="btn btn-warning" name="upload" value="更新"
					class="form-button" />
			</div>
			<%
				} else {
			%>
			<div class="form-inline">
				<input type="file" name="paper" class="form-control" /> <input
					type="submit" class="btn btn-warning" name="upload" value="上传"
					class="form-button" />
			</div>
			<%
				}
			%>
			<h5><%=uploadErr%></h5>
		</form>
	</div>
	<br />
</div>
<div class="container">
	<div class="row" style="background: #CDCDCD;">
		<form class="form-inline" action="../TeacherStudentServlet"
			method="post">
			<h4>导入学生名单</h4>
			<p>目前设定参加此次考试的学生人数：<%=counts %></p>
			<input type="hidden" name="id" value="<%=examId%>" /> <input
				type="submit" class="btn btn-primary" value="继续导入" />
		</form>
	</div>
	<br />
</div>
<div class="container">
	<div class="row" style="background: #CDCDCD;">
		<form class="form-inline" action="../Exam_start"
			method="post">
			<h4>开启考试</h4>
			<input type="hidden" name="id" value="<%=examId%>" />
			
			<%
			String sql_Examstart = "SELECT * FROM exam WHERE eactive<>'0'";
			int count = 0;
			String Exam_startname="";
			try {
				ResultSet rs_exam = DbUtil.executeQuery(sql_Examstart);
				//编历查询结果
				while (rs_exam.next()) {
					Exam_startname=rs_exam.getString("ename");
					count++;
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			if(count > 0){
				%>
				<h4 style="color: yellow;">考试(<%=Exam_startname %>)正在进行中，本系统不允许同时进行多场考试！</h4>
				<%
			}else{%>
			<h4 style="color: red;"><%=session.getAttribute("error_message") %></h4>
			<%
			session.setAttribute("error_message", "");
				if (epaper != null && !epaper.equals("")) {
			%>
			<button type="submit" class="btn btn-success btn-large">
				<i class="glyphicon glyphicon-off"></i> 开启
			</button>
			<%
				}
				else{
					%>
					<h4 style="color: yellow;">尚未上传试卷</h4>
					<button type="submit" class="btn btn-warning btn-large">
						<i class="glyphicon glyphicon-off"></i> 开启
					</button>
					<%	
				}
			}
			%>
		</form>
	</div>
</div>
<script type="text/javascript">
	$("#datetimepicker").datetimepicker({
		format : "yyyy-mm-dd hh:ii",
		autoclose : true,
		minuteStep : 5,
		minView : 0,
		todayBtn: true,
		startDate : new Date(),
		pickerPosition : 'bottom-left',
		language : 'zh-CN'
	});
	function updateExam() {
		$.ajax({
			cache : false,
			type : "POST",
			url : "../assets/jsp/teacher/exam_update.jsp",
			data : $('#teacher_exam_update').serialize(),
			async : false,
			error : function(request) {
				alert("发送请求失败！");
			},
			success : function(data) {
				if (data == 1) {
					alert("修改成功！");
				} else {
					alert(data);
				}
			}
		});
	}

	function uploadExam() {
		$.ajax({
			cache : false,
			type : "POST",
			url : "../assets/jsp/teacher/teacher_exam_upload.jsp",
			data : $('#teacher_exam_upload').serialize(),
			async : false,
			error : function(request) {
				alert("发送请求失败！");
			},
			success : function(data) {
				if (data == 1) {
					alert("上传成功");
				} else {
					alert(data);
				}
			}
		});
	}
</script>
