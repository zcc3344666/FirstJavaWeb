<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="student_head.jsp"%>
<div class="container">

	<div style="float: left;">

		<h3>试卷下载</h3>
		<br />
		<%
			String hasPaper = (String) session.getAttribute("hasPaper");
			if (hasPaper != null && hasPaper != "" && hasPaper.equals("1")) {
		%>
		<a class="btn" href="../Download_exam"><i
			class="glyphicon glyphicon-download"></i>下载查看</a>
		<%
			} else {
		%>
		<p class="exam-info">本次考试没有电子试卷。</p>
		<%
			}
		%>
		</div>

		<div style="float: right;">
			<h3>答案上传</h3>
			<br />
			<p>请按照考试要求将答案文件打包，再次进行上传。同名文件多次上传将会覆盖。</p>
			<form class="form-inline" action="../Upload_answer"
				enctype="multipart/form-data" method="post">
				<input type="file" name="answer" /> <input type="submit"
					class="btn btn-primary" value="上传" />
			</form>
			<h5><%=session.getAttribute("uploadErr")%></h5>
	<%session.setAttribute("uploadErr", ""); %>
		</div>
	</div>
	<div id="div_139434026" class="exam-notify"></div>