<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="table table-striped table-bordered">
	<tr>
		<th>用户名</th>
		<th>全名</th>
		<th>是否管理员</th>
		<th>操作</th>
	</tr>
	<%
		//查询所有的用户信息
		String sqlSearch = "SELECT * FROM teacher";

		try {
			ResultSet rs1 = DbUtil.executeQuery(sqlSearch);
			//编历查询结果
			while (rs1.next()) {
				String adminYN = "否";
	%>
	<tr>
		<td><%=rs1.getString("tname")%></td>
		<td><%=rs1.getString("tfullname")%></td>
		<%
			try {
						if (rs1.getString("tadmin").equals("1")) {
							adminYN = "是";
						}
					} catch (Exception e) {
					}
		%>
		<td><%=adminYN%></td>
		<td><a
			href="../assets/jsp/administrator/delete_teacher.jsp?name=<%=rs1.getString("tname")%>"
			onclick="return confirm('确定删除用户    <%=rs1.getString("tname")%>   吗？');">删除</a>&nbsp;<a
			href='#' data-toggle='modal' data-target='#tModal'
			data-whatever='<%=rs1.getString("tname") %>'
			data-whatever1='<%=rs1.getInt("id")%>'>修改</a></td>
	</tr>
	<%
		}
			DbUtil.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</table>