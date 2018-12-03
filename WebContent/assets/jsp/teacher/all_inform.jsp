<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <table class="table table-striped table-bordered"><tr>
    <th>通知消息</th>
    <th>清除</th>
    </tr>
    <%
    String examId = (String) session.getAttribute("examId_upload");
		//查询所有的用户信息
		String sqlSearch = "SELECT * FROM inform WHERE eid = '" + examId + "'";

		try {
			ResultSet rs1 = DbUtil.executeQuery(sqlSearch);
			//编历查询结果
			while (rs1.next()) {
	%>
	<tr>
		<td><%=rs1.getString("ts_inform")%></td>
		<td><a
			href="../assets/jsp/teacher/manage_inform.jsp?id=<%=rs1.getString("id") %>"
			onclick="return confirm('确定删除该条通知消息吗？');">删除</a>&nbsp;</td>
	</tr>
	<%
		}
			DbUtil.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
    </table>