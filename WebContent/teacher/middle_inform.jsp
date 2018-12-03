<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="teacher_head.jsp"%>
<div class="container">
	<%
String st_sql = "SELECT * FROM exam WHERE eactive<>'0'";
	ResultSet rs2 = DbUtil.executeQuery(st_sql);
	int startExam=0;
	try {
		while (rs2.next()) {
			startExam++;
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	if(startExam > 0) {%>
	<div class="row" style="background: #CDCDCD;">
		<h4>新增通知消息</h4>
		<form action="../assets/jsp/teacher/manage_inform.jsp">
			<div class="form-group col-sm-3">
				<textarea class="form-control" name="inform" placeholder="通知消息内容"></textarea>
			</div>
			<div class="form-group col-sm-1">
				<input class="btn btn-primary" type="submit" value="添加" />
			</div>
		</form>
	</div>
	<div>
		<h4>已有通知消息</h4>
		<%@ include file="../assets/jsp/teacher/all_inform.jsp"%>
	</div>
	<%}else{%>
	<div style="margin-left: 20%; margin-top: 20%;">
		<h3>错误信息：</h3>
		<label style="color: red; margin-left: 20px;">没有进行中的考试！</label>
	</div>
	<%}%>
</div>