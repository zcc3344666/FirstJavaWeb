<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="table table-striped table-bordered">
	<tr>
		<th>考试名称</th>
		<th>考试时间</th>
		<th>创建人</th>
		<th>上传试卷</th>
		<th>自动开始</th>
		<th>进行中</th>
		<th>已结束</th>
		<th>已归档</th>
		<th>已清理</th>
		<th>&nbsp;</th>
	</tr>
	<%
		String yOn = (String) session.getAttribute("cleanAnddelete_exam");
		String sTeacher = (String) session.getAttribute("teacher");
		String sqlTeacher = "SElECT * FROM teacher WHERE tname=" + sTeacher + "";
		String tid = "";
		try {
			ResultSet rs1 = DbUtil.executeQuery(sqlTeacher);
			while (rs1.next()) {
				tid = rs1.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//查询所有有关该老师的考试信息
		String sqlSearch = "SELECT * FROM exam WHERE ecreator=" + tid + "";

		try {
			ResultSet rs1 = DbUtil.executeQuery(sqlSearch);
			//编历查询结果
			while (rs1.next()) {
				String datatime = rs1.getString("etime");
				String newDate = datatime.substring(0, datatime.length() - 2);
	%>
	<tr>
		<td><%=rs1.getString("ename")%></td>
		<td><%=newDate%></td>
		<td><%=Sql_teacher.getTname(rs1.getInt("ecreator"))%></td>
		<td>
			<%
				if (rs1.getString("epaper") != null && !rs1.getString("epaper").equals("")) {
							out.print("<i class='glyphicon glyphicon-ok'></i>");
						}
			%>
		</td>
		<td>
			<%
				if (rs1.getInt("eautostart") != 0) {
							out.print("<i class='glyphicon glyphicon-ok'></i>");
						}
			%>
		</td>
		<td>
			<%
				if (rs1.getInt("eactive") != 0) {
							out.print("<i class='glyphicon glyphicon-ok'></i>");
						}
			%>
		</td>
		<td>
			<%
				if (rs1.getInt("efinish") != 0) {
							out.print("<i class='glyphicon glyphicon-ok'></i>");
						}
			%>
		</td>
		<td>
			<%
				if (rs1.getInt("earchived") != 0) {
							out.print("<i class='glyphicon glyphicon-ok'></i>");
						}
			%>
		</td>
		<td>
			<%
				if (rs1.getInt("ecleared") != 0) {
							out.print("<i class='glyphicon glyphicon-ok'></i>");
						}
			%>
		</td>
		<td>
			<%
				if (rs1.getInt("eactive") != 0) {
			%>
			<button class="btn-primary"
				onclick="javascript:window.location.href='../Exam_stop?id=<%=rs1.getInt("id")%>'">
				<span class="glyphicon glyphicon-off"></span> 停止考试
			</button> <%
 	} else if (rs1.getInt("eactive") == 0 && rs1.getInt("efinish") != 0
 					&& rs1.getInt("earchived") == 0) {
 %>
			<button class="btn"
				onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
				title="打包下载答卷">
				<span class="glyphicon glyphicon-download-alt"></span>
			</button>

			<button class="btn"
				onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
				title="导出提交记录">
				<span class="glyphicon glyphicon-book"></span>
			</button> <%
 	} else if (yOn != "" && yOn != null) {
 				if (yOn.equals("yes_exam")) {

 					if (rs1.getInt("efinish") != 0 && rs1.getInt("earchived") != 0
 							&& rs1.getInt("ecleared") == 0) {
 %>
			<button class="btn"
				onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
				title="打包下载答卷">
				<span class="glyphicon glyphicon-download-alt"></span>
			</button>

			<button class="btn"
				onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
				title="导出提交记录">
				<span class="glyphicon glyphicon-book"></span>
			</button>

			<button class="btn"
				onclick="javascript:window.location.href='../Exam_clean?id=<%=rs1.getInt("id")%>'">
				<span class="glyphicon glyphicon-remove-circle"></span> 清理
			</button> <%
 	} else if (rs1.getInt("efinish") != 0 && rs1.getInt("earchived") != 0
 							&& rs1.getInt("ecleared") != 0) {
 %>
			<button class="btn"
				onclick="javascript:window.location.href='../Exam_delete?id=<%=rs1.getInt("id")%>'">
				<span class="glyphicon glyphicon-trash"></span> 删除
			</button> <%
 	}
 				} else if (rs1.getInt("efinish") != 0 && rs1.getInt("earchived") != 0
 						&& rs1.getInt("ecleared") == 0) {
 %>
			<button class="btn"
				onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
				title="打包下载答卷">
				<span class="glyphicon glyphicon-download-alt"></span>
			</button>

			<button class="btn"
				onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
				title="导出提交记录">
				<span class="glyphicon glyphicon-book"></span>
			</button> <%
 	}
 			}else if(yOn == null){
 				if(rs1.getInt("efinish") != 0 && rs1.getInt("earchived") != 0
 						&& rs1.getInt("ecleared") == 0){
 					%>
 					<button class="btn"
 						onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
 						title="打包下载答卷">
 						<span class="glyphicon glyphicon-download-alt"></span>
 					</button>

 					<button class="btn"
 						onclick="javascript:window.location.href='../Exam_file?id=<%=rs1.getInt("id")%>'"
 						title="导出提交记录">
 						<span class="glyphicon glyphicon-book"></span>
 					</button> <%
 				}
 			}
 %>
		</td>
	</tr>
	<%
		}
			DbUtil.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</table>