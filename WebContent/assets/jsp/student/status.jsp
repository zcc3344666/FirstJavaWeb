<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="exam.utils.*,java.sql.*"%>
<!DOCTYPE html>
<%
	session.setAttribute("hasPaper", "0");
	String sql0 = "select * from exam where eactive<>'0'";
	try {
		ResultSet rs = DbUtil.executeQuery(sql0);
		int count = 0;
		String examName="";
		String epaper = null;
		while (rs.next()) {
			epaper = rs.getString("epaper");
			count++;
		}
		
		if (count > 0) {
			if(epaper==null||epaper.length()==0)
			{
				session.setAttribute("hasPaper", "0");
			}
			else
			{
				session.setAttribute("hasPaper", "1");
			}
		}
		DbUtil.close();
	} catch (Exception e) {
		session.setAttribute("studentErr", "查询数据库失败");
	}
%>
