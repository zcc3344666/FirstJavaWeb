<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String examId = (String) session.getAttribute("examId_upload");
	String s_number = request.getParameter("sno");
	String s_name = request.getParameter("sname");
	String s_class = request.getParameter("sclass");
	String sqlSearch = "SELECT * FROM student WHERE  eid = '" + examId + "'";
	if (s_number != null && s_number.length() > 0) {
		sqlSearch += "and sno='" + s_number + "'";
	}
	if (s_name != null && s_name.length() > 0) {
		sqlSearch += "and sname='" + s_name + "'";
	}
	if (s_class != null && s_class.length() > 0) {
		sqlSearch += "and sclass='" + s_class + "'";
	}

	int count = 0;
	StringBuffer sb = new StringBuffer();//StringBuffer是线程安全的，StringBuilder不是线程安全的
	try {
		sb.delete(0, sb.length());
		sb.append("<table class='table table-striped table-bordered'>");
		sb.append("<tr><th>");
		sb.append("学号");
		sb.append("</th><th>");
		sb.append("姓名");
		sb.append("</th><th>");
		sb.append("班级");
		sb.append("</th><th>");
		sb.append("操作");
		sb.append("</th></tr>");
		ResultSet rs1 = DbUtil.executeQuery(sqlSearch);
		//编历查询结果
		while (rs1.next()) {
			count++;
			sb.append("<tr><td>");
			sb.append(rs1.getString("sno"));
			sb.append("</td><td>");
			sb.append(rs1.getString("sname"));
			sb.append("</td><td>");
			sb.append(rs1.getString("sclass"));
			sb.append("</td><td>");
			sb.append("<a href=javascript:if(confirm('确认删除学号为（" + rs1.getString("sno")
					+ "）的学生吗?')){window.location.href='../Delete_student?id=" + rs1.getString("id")
					+ "';}><i class='glyphicon glyphicon-trash' title='删除'></i></a>");
			sb.append("</td></tr>");

		}
		DbUtil.close();
		sb.append("</table>");
		if (count == 0) {
			sb.delete(0, sb.length());
			sb.append("查询出错，查询无果！");
			sb.append("<br/>");
			sb.append("请检查输入内容是否正确！");
		}
	} catch (SQLException e) {
		sb.delete(0, sb.length());
		sb.append("查询出错，查询无果！");
		sb.append("<br/>");
		sb.append("请检查输入内容是否正确！");
	}
	//将查询结果存入session名为search的属性中
	session.setAttribute("search_student", sb);
	//跳转至userAdmin.jsp页面
	response.sendRedirect("../../../teacher/middle_student_message.jsp");
%>
