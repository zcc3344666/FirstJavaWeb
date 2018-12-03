<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="teacher_head.jsp"%>
<%
	String addstuErr = (String) session.getAttribute("addstuErr");
	if (addstuErr == null) {
		addstuErr = "";
	}
	session.setAttribute("addstuErr", null);
%>
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
		<h4>添加单个学生</h4>
		<form action="../Add_student" method="post">
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sno" placeholder="学号*" />
			</div>
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sname"
					placeholder="姓名*" />
			</div>
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sclass"
					placeholder="班级*" />
			</div>
			<input type="hidden" name="eid" value="" />
			<div class="form-group col-sm-1">
				<input class="btn btn-primary" type="submit" value="添加" />
			</div>
			<div class="form-group col-sm-2">
				<small style="color: #FF0000"><%=addstuErr%></small>
			</div>
		</form>
	</div>
	<br />
	<div class="row" style="background: #CDCDCD;">
		<h4>查找学生信息(默认查找所有考生)</h4>
		<form action="../assets/jsp/teacher/student_middle_message.jsp"
			method="post">
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
	<%
		try {
				StringBuffer sb = new StringBuffer();
				sb = (StringBuffer) session.getAttribute("search_student");
				if (sb.toString() != null && sb.toString().length() > 0) {
					out.print(sb.toString());
				}
			} catch (Exception e) {

			}
	%>
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