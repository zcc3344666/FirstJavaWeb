<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="admin_head.jsp"%>
<br>
<%
	String b_i_time = (String) session.getAttribute("b_i_time");
	String back_interval_time = "1";
	if (b_i_time != "" && b_i_time != null) {
		back_interval_time = b_i_time;
	}
	String count = (String) session.getAttribute("page_size");
	String page_Size = "10";
	if (count != "" && count != null) {
		page_Size = count;
	}
	String top = (String) session.getAttribute("top_size");
	String top_Size = "1048576";
	if (top != "" && top != null) {
		top_Size = top;
	}
	String bottom = (String) session.getAttribute("bottom_size");
	String bottom_Size = "512";
	if (bottom != "" && bottom != null) {
		bottom_Size = bottom;
	}
	String time = (String) session.getAttribute("time");
	String times = "15";
	if (time != "" && time != null) {
		times = time;
	}
%>
<div style="position: relative; margin-left: 16%;">
	<strong>修改系统配置</strong> <br>
	<div class="container" style="position: relative; margin-left: 4%">
		<form action="../Admin_os" method="post">
			<div class="row">
				<label class="col-sm-2 control-label">后台任务间隔时间：</label>
				<div class="col-sm-3">
					<input name="back_interval_time" type="text" class="form-control"
						value="<%=back_interval_time%>" />
				</div>
				<label>指定扫描考试信息的间隔时间，单位为 分钟。</label><br /> <br />
			</div>
			<div class="row">
				<label class="col-sm-2 control-label">分页查询记录条数：</label>
				<div class="col-sm-3">
					<input name="counts" type="text" class="form-control"
						value="<%=page_Size%>" />
				</div>
				<label>指定分页查询时每页显示记录数的默认值（查询页面可以更改）。</label><br /> <br />
			</div>
			<div class="row">
				<label class="col-sm-2 control-label">手动开启考试时间阈值：</label>
				<div class="col-sm-3">
					<input name="time2" type="text" class="form-control" 
					value="<%=times%>"/>
				</div>
				<label>指定手工开启考试时允许的最大提前量，单位为 分钟。</label><br /> <br />
			</div>
			<div class="row" style="display: none;">
				<label class="col-sm-2 control-label">上传文件字节数下限：</label>
				<div class="col-sm-3">
					<input name="bottom" type="text" class="form-control"
						value="<%=bottom_Size%>" />
				</div>
				<label>指定上传文件的长度下限（字节），低于此值发出警告。</label><br /> <br />
			</div>
			<div class="row">
				<label class="col-sm-2 control-label">上传文件字节数上限：</label>
				<div class="col-sm-3">
					<input name="top" type="text" class="form-control"
						value="<%=top_Size%>" />
				</div>
				<label>指定上传文件的长度上限（字节），高于此值发出警告。</label><br /> <br />
			</div>
			<div class="row">
				<div class="col-sm-offset-2 col-sm-3">
					<input id="yorns" name="yorn" type="checkbox" class="from-control" />
					<label style="font-size: 18px;">教师可以清理和删除考试</label>
				</div>
				<br /> <br />
			</div>
			<div class="row">
				<div class="col-sm-offset-2 col-sm-3">
					<input class="btn btn-primary" name="submit" type="submit"
						value="修改" />
				</div>
			</div>
		</form>
	</div>
</div>
<%
	String yOn = (String) session.getAttribute("cleanAnddelete_exam");
	if (yOn != "" && yOn != null) {
		if (yOn.equals("yes_exam")) {
%>
<script type="text/javascript">
	$('#yorns').attr("checked", true);
</script>
<%
	} else {
%>
<script type="text/javascript">
	$('#yorns').attr("checked", false);
</script>
<%
	}
	}
%>