<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	float back_interval_time=60;
	String b_i_time=(String)session.getAttribute("b_i_time");
	if (b_i_time != "" && b_i_time != null) {
		try {
			back_interval_time = Float.parseFloat(b_i_time)*60;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	%>
	<meta http-equiv="refresh" content="<%=back_interval_time %>"/>
<%@ include file="admin_head.jsp"%>
<br>
<div style="position: relative; margin-left: 13%; margin-right: 13%;">
	<%@include file="../assets/jsp/administrator/all_exam.jsp" %>
</div>