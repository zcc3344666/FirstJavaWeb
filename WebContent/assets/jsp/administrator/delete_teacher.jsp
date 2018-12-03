<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%
	//获取查询字符串中参数name的值
	String name = request.getParameter("name");
	String sql0 = "SELECT * FROM teacher WHERE tname='" + name + "' and tadmin='1'";
	int count = 0;
	try {
		ResultSet rs = DbUtil.executeQuery(sql0);

		while (rs.next()) {
			count++;
		}
	} catch (Exception e) {

	}
	if (count > 0) {
		if (!name.equals(session.getAttribute("admin"))) {
			String sql1 = "DELETE FROM admin WHERE aname='" + name + "'";
			DbUtil.executeUpdate(sql1);
			//定义SQL语句
			String sql = "DELETE FROM teacher WHERE tname='" + name + "'";
			//执行删除
			DbUtil.executeUpdate(sql);

			response.sendRedirect("../../../administrator/admin_manage_teacher.jsp");
		}
		else {
			response.sendRedirect("../../../administrator/admin_manage_teacher.jsp?errNo=4");
		}
	}else{
		//定义SQL语句
		String sql = "DELETE FROM teacher WHERE tname='" + name + "'";
		//执行删除
		DbUtil.executeUpdate(sql);
		
		response.sendRedirect("../../../administrator/admin_manage_teacher.jsp");
	}
	
%>