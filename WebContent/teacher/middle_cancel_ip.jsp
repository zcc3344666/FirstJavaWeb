<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="teacher_head.jsp"%>
<div class="container">
	<%
		String st_sql = "SELECT * FROM exam WHERE eactive<>'0'";
		ResultSet rs2 = DbUtil.executeQuery(st_sql);
		int startExam = 0;
		try {
			while (rs2.next()) {
				startExam++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (startExam > 0) {
	%>
	<div class="row" style="background: #CDCDCD;">
		<h4>按学生信息查找已登录信息</h4>
		<form action="../assets/jsp/teacher/search_middle_student.jsp">
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sno" placeholder="学号" />
			</div>
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sname"
					placeholder="姓名" />
			</div>
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sclass"
					placeholder="班级" />
			</div>
			<input type="hidden" name="eid" value="" />
			<div class="form-group col-sm-1">
				<input class="btn btn-primary" type="submit" value="查找" />
			</div>
			<div class="form-group col-sm-2">
				<small style="color: #FF0000"></small>
			</div>
		</form>
	</div>
	<br />
	<div class="row" style="background: #CDCDCD;">
		<h4>按ip地址查找已登录信息</h4>
		<form action="../assets/jsp/teacher/search_middle_student.jsp">
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sip"
					placeholder="ip地址" />
			</div>
			<input type="hidden" name="eid" value="" />
			<div class="form-group col-sm-1">
				<input class="btn btn-primary" type="submit" value="查找" />
			</div>
			<div class="form-group col-sm-2">
				<small style="color: #FF0000"></small>
			</div>
		</form>
	</div>
	<br />
	<h4>查找结果</h4>
	<table class='table table-striped table-bordered'>
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>班级</th>
			<th>IP地址</th>
			<th>&nbsp;</th>
		</tr>
		<tbody>
			<%
				try {
						StringBuffer sb = new StringBuffer();
						sb = (StringBuffer) session.getAttribute("search_student1");
						if (sb.toString() != null && sb.toString().length() > 0) {
							out.print(sb.toString());
						}
					} catch (Exception e) {

					}
			%>
		</tbody>
	</table>
	<%
		} else {
	%>
	<div style="margin-left: 20%; margin-top: 20%;">
		<h3>错误信息：</h3>
		<label style="color: red; margin-left: 20px;">没有进行中的考试！</label>
	</div>
	<%
		}
	%>
</div>