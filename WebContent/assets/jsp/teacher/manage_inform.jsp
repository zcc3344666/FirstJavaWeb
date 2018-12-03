<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String examId = (String) session.getAttribute("examId_upload");
    String s_inform=request.getParameter("inform");
    if(s_inform!=null && s_inform.length() > 0){
    	String sqlInsert = "INSERT INTO inform(ts_inform,eid) VALUES ('"+s_inform+"','"+examId+"')";
    	DbUtil.executeUpdate(sqlInsert);
    }
    String id=request.getParameter("id");
    if(id !=null && id .length() > 0){
    	String sqlDelete = "DELETE FROM inform WHERE id='" + id + "'";
    	DbUtil.executeUpdate(sqlDelete);
    }
    response.sendRedirect("../../../teacher/middle_inform.jsp");
    %>