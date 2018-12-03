<%@page import="exam.file.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="teacher_head.jsp"%>

<%
	String suploadErr = (String) session.getAttribute("suploadErr");
	if (suploadErr == null) {
		suploadErr = "";
	}

	String addstuErr = (String) session.getAttribute("addstuErr");
	if (addstuErr == null) {
		addstuErr = "";
	}
%>
<div class="container">
	<nav class="navbar navbar-default" role="navigation">
		<ul class="nav navbar-nav"
			style="margin-left: 40%; margin-right: 40%;">
			<li>完成学生名单的导入和修改后， <a class="btn"
				href="exam_modify.jsp?id=<%=(String) session.getAttribute("examId_upload")%>"><i
					class="glyphicon glyphicon-edit"></i>返回编辑</a></li>
		</ul>
	</nav>
	<div class="row" style="background: #CDCDCD;">
		<h4>添加单个学生</h4>
		<form action="../Add_student" method="post">
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sno" placeholder="学号*" />
			</div>
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sname"
					placeholder="姓名*" />
			</div>
			<div class="form-group col-sm-3">
				<input type='text' class="form-control" name="sclass"
					placeholder="班级*" />
			</div>
			<input type="hidden" name="eid" value="" />
			<div class="form-group col-sm-1">
				<input class="btn btn-primary" type="submit" value="添加" />
			</div>
			<div class="form-group col-sm-2">
				<small style="color:#FF0000"><%=addstuErr %></small>
			</div>
		</form>
	</div>
	<br />
</div>


<div class="container">
	<div style="float: left;">
		<form class="form-inline" action="../Page_size" method="post">
			分页大小 <input type="text" name="pageSize" value="<%=Exam.pageSize%>"
				class="input-small" /> <input type="submit" class="btn" value="设置" />
		</form>
	</div>
	<div style="float: right;">
		<form class="form-inline">
			<a title="第一页" <%if (Exam.pageNo == 1) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=1" class="btn" <%}%>>
				<i class="glyphicon glyphicon-fast-backward"></i>
			</a> <a title="前一页" <%if (Exam.pageNo == 1) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=<%=(Exam.pageNo - 1)%>" class="btn"
				<%}%>> <i
				class="glyphicon glyphicon-step-backward"></i>
			</a> <input type="text" name="pageNo"
				placeholder="<%=Exam.pageNo%>/<%=Exam.pageCount%>"
				class="input-small" readonly />
			<a title="后一页"
				<%if (Exam.pageNo == Exam.pageCount) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=<%=(1 + Exam.pageNo)%>" class="btn"
				<%}%>> <i
				class="glyphicon glyphicon-step-forward"></i>
			</a> <a title="最后一页"
				<%if (Exam.pageNo == Exam.pageCount) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=<%=Exam.pageCount%>" class="btn"
				<%}%>> <i
				class="glyphicon glyphicon-fast-forward"></i>
			</a>
		</form>
	</div>
</div>
<div class="container">
	<table class="table table-striped table-bordered">
		<thead>
			<tr>
				<th class="span4">学号</th>
				<th class="span4">姓名</th>
				<th class="span3">班级</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
				<%
					for(int i = (Exam.pageNo-1)*Exam.pageSize;
							i<Exam.rowList.size()&&i<Exam.pageNo*Exam.pageSize;i++)
					{%>
						<tr>
							<td><%=Exam.rowList.get(i).get(1).toString() %></td>
							<td><%=Exam.rowList.get(i).get(2).toString() %></td>
							<td><%=Exam.rowList.get(i).get(3).toString() %></td>
							<td><a href="../Delete_student?id=<%=Exam.rowList.get(i).get(0).toString() %>" onclick="return confirm('确定删除学生   <%=Exam.rowList.get(i).get(2).toString()%>   吗？');">
									<i class="glyphicon glyphicon-trash" title="删除"></i></a></td>
						</tr>
					<%}
				%>
		</tbody>
	</table>
	<div style="float: right;">
		<form class="form-inline">
			<a title="第一页" <%if (Exam.pageNo == 1) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=1" class="btn" <%}%>>
				<i class="glyphicon glyphicon-fast-backward"></i>
			</a> <a title="前一页" <%if (Exam.pageNo == 1) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=<%=(Exam.pageNo - 1)%>" class="btn"
				<%}%>> <i
				class="glyphicon glyphicon-step-backward"></i>
			</a> <input type="text" name="pageNo"
				placeholder="<%=Exam.pageNo%>/<%=Exam.pageCount%>"
				class="input-small" readonly />
			<a title="后一页"
				<%if (Exam.pageNo == Exam.pageCount) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=<%=(1 + Exam.pageNo)%>" class="btn"
				<%}%>> <i
				class="glyphicon glyphicon-step-forward"></i>
			</a> <a title="最后一页"
				<%if (Exam.pageNo == Exam.pageCount) {%>
				href="javascript: void(0)" class="btn disabled"
				<%} else {%>
				href="../Page_number?pageNo=<%=Exam.pageCount%>" class="btn"
				<%}%>> <i
				class="glyphicon glyphicon-fast-forward"></i>
			</a>
		</form>
	</div>
</div>
<div class="container">
	<form action="../Teacher_studentUpload" enctype="multipart/form-data"
		method="post">
		<h4>批量导入学生名单</h4>
		<div class="form-inline">
			<input type="hidden" name="eid" value="" /> <input type="file"
				name="students" class="form-control" /> <input type="submit"
				class="btn btn-primary form-button" value="导入" />
		</div>
		<h5 style="color: #FF0000"><%=suploadErr%></h5>
	</form>
</div>