<%@page import="exam.utils.Password"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="exam.utils.*,java.sql.*,java.util.Date,java.text.*"%>
<%
int minutes = 0;

SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");// 设置日期格式
String nowDate = simpleDateFormat.format(new Date());// new Date()为获取当前系统时间

String etime = "";
String etime2 = "";
String etime3= "";
String sql0 = "select * from exam where id='77'";
try {
	ResultSet rs = DbUtil.executeQuery(sql0);
	while (rs.next()) {
		etime = rs.getString("etime");
		etime = etime.substring(0, etime.length() - 5);
		etime3=simpleDateFormat.parse(etime).toString();
	}
	DbUtil.close();
} catch (Exception e) {
	e.printStackTrace();
}
try {
	long from = simpleDateFormat.parse(nowDate).getTime();
	long to = simpleDateFormat.parse(etime).getTime();
	minutes = (int) ((to - from) / (1000 * 60));
	out.print(to);
	out.print("<br/>");
	out.print(from);
	out.print("<br/>");
	out.print(to - from);
	out.print("<br/>");
} catch (ParseException e1) {
	// TODO Auto-generated catch block
	e1.printStackTrace();
}
if (minutes > 15 || minutes < 0) {
	out.print(minutes);
}else{
	out.print("正确");
}

%>
<div><h4><%=etime %></h4></div><h4><%=etime2 %></h4><br/><h4><%=etime3 %></h4><br/><h4><%=nowDate %></h4>