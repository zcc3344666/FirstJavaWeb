<%@page import="exam.utils.*"%>
<%@page import="java.sql.*,java.util.Date,java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//设置请求报文的字符编码为utf-8
	request.setCharacterEncoding("utf-8");
	//获取表单输入域的值
	String ename = request.getParameter("ename");
	String etime = request.getParameter("etime");
	String examId = request.getParameter("id");
	String[] start = request.getParameterValues("eautostart");
	String eautostart = "0";
	//遍历hobbies数组，将其转化为一个字符串
	if (start != null) {
		for (int i = 0; i < start.length; i++) {
			eautostart = "1";
		}
	}
	if (ename == "" || etime == "") {
		out.print("存在空值，修改失败！");
	} else {
		try {
			DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = fmt.parse(etime);
			Timestamp timeStamp = new Timestamp(date.getTime());
			int result = Sql_teacher.updateExam(ename, timeStamp, examId, eautostart);
			if (result > 0) {
				out.print(1);
			}
		} catch (Exception e) {
			out.print("修改失败");
			e.printStackTrace();
		}
	}
%>
