<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="teacher_head.jsp"%>
<div class="container">
	<%
	String st_sql = "SELECT * FROM exam WHERE eactive<>'0'";
	ResultSet rs2 = DbUtil.executeQuery(st_sql);
	int startExam=0;
	String Exam_startname = "";
	String Exam_startid="";
	try {
		while (rs2.next()) {
			startExam++;
			Exam_startname = rs2.getString("ename");
			Exam_startid=rs2.getString("id");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	if(startExam > 0){
	String students = "SELECT * FROM student WHERE eid = '" + Exam_startid + "'";
	ResultSet rs3=DbUtil.executeQuery(students);
	int counts=0;
	try{
		while(rs3.next()){
			counts++;
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	String start_students = "SELECT * FROM student WHERE eid = '" + Exam_startid + "'and ipaddress is null";
	ResultSet rs4=DbUtil.executeQuery(start_students);
	int start_counts=0;
	try{
		while(rs4.next()){
			start_counts++;
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

	<div
		style="background: #3C3C3C; padding-top: 20px; padding-bottom: 20px;">
		<h4 style="color: white;">
			（<%=Exam_startname%>）进行情况：
		</h4>
		<label style="color: white; margin-left: 20px;">参加考试学生总人数：' <%=counts %>
			'
		</label> <br /> <label style="color: white; margin-left: 20px;">已登录学生数量：'
			<%=counts - start_counts %> '，未登录学生数量：' <%=start_counts%> '
		</label> <br /> <label style="color: white; margin-left: 20px;">已登录学生中，已提交答案学生数量：，未提交答案学生数量：</label>
		<br />
	</div>

	<%
		} else {
	%>
	<div style="margin-left: 20%; margin-top: 20%;">
		<h3>错误信息：</h3>
		<label style="color: red; margin-left: 20px;">没有进行中的考试！</label>
	</div>
	<%}%>
</div>