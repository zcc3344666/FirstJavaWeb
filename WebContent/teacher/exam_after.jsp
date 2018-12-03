<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="teacher_head.jsp"%>
<div class="container">
<h4 style="color: #EAC100;">答卷与提交记录默认导出到该计算机D盘下exam_result文件夹下，且文件保留最最后一次打包</h4>
	<div id="exam_after">
		<%@include file="../assets/jsp/teacher/all_exam_after.jsp"%></div>
</div>
<%
String file_message=(String)session.getAttribute("file_message");
System.out.print(file_message);
session.setAttribute("file_message", "");
if(file_message != null && file_message.length() > 0){
	out.print("<script>alert('"+file_message+"');</script>");
}
%>