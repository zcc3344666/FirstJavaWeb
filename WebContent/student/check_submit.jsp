<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ include file="student_head.jsp"%>

<div style="position: relative; margin-left: 15%;">
	<h2>上机考试中...</h2>
	<table class="table table-striped table-bordered">
		<tr>
			<th>本次考试通知消息</th>
		</tr>
		<%
			//查询所有的用户信息
			String sqlSearch = "SELECT * FROM inform";

			try {
				ResultSet rs1 = DbUtil.executeQuery(sqlSearch);
				//编历查询结果
				while (rs1.next()) {
		%>
		<tr>
			<td><%=rs1.getString("ts_inform")%></td>
		</tr>
		<%
			}
				DbUtil.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
	</table>
</div>
<div class="table-c"
	style="position: relative; margin-left: 16%; margin-right: 16%;">
	<strong>已上传文件列表</strong>
	<table class="table table-striped table-bordered">
		<thead>
			<tr>
				<th class="span4">文件名</th>
				<th class="span4">文件大小</th>
				<th class="span4">上传时间</th>
			</tr>
		</thead>
		<tbody>
			<%
				try {
					@SuppressWarnings("unchecked")
					ArrayList<ArrayList<Object>> submitList = (ArrayList<ArrayList<Object>>) session
							.getAttribute("submitList");
					for (int i = 0; i < submitList.size(); i++) {
						Timestamp t = (Timestamp) submitList.get(i).get(2);
						String str = t.toString();
			%>
			<tr>
				<td><%=submitList.get(i).get(0).toString()%></td>
				<td><%=submitList.get(i).get(1).toString()%></td>
				<td><%=str%></td>
			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</tbody>
	</table>
</div>
<br>
<br>
<div style="position: relative; margin-left: 16%;">
	<h4>答案上传</h4>
	<form class="form-inline" action="../Upload_answer"
		enctype="multipart/form-data" method="post">
		<input type="file" name="answer" class="form-control" /> <input
			type="submit" class="btn btn-primary" value="上传" class="form-button" />
	</form>
	<h5><%=session.getAttribute("uploadErr")%></h5>
	<%
		session.setAttribute("uploadErr", "");
	%>
</div>