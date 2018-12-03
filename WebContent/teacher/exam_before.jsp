<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="teacher_head.jsp"%>
<div>
	<div class="container">
		<div class="row" style="background: #CDCDCD;">
			<label>添加考试</label>
			<form id="add_exam_form" action="" method="post">
				<div class="form-group col-sm-3">
					<input type='text' class="form-control" name="ename"
						placeholder="考试名称" />
				</div>
				<div class='col-sm-3'>
					<div class="form-group">
						<div class='controls input-group date' id='datetimepicker'
							data-link-field="etime">
							<input type='text' class="form-control" readonly="readonly"
								placeholder="考试时间" /> <span class="input-group-addon"><span
								class="glyphicon glyphicon-remove"></span></span> <span
								class="input-group-addon"><span
								class="glyphicon glyphicon-calendar"></span></span>
						</div>

					</div>
				</div>
				<input type="hidden" id="etime" name="etime" />
				<div class="form-group col-sm-3">
					<input type="checkbox" name="eautostart" value="true"
						class="form -control" /><label style="font-size: 18px;">自动开始</label>
					<input class="btn btn-primary" type="button" value="添加"
						id="btn_log" onClick="addExam()" />
				</div>
			</form>
		</div>
		<br />
		<div class="row">
			<div id="exam_father"><%@include
					file="../assets/jsp/teacher/all_exam_before.jsp"%></div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#datetimepicker').datetimepicker({
			format : "yyyy-mm-dd hh:ii",
			autoclose : true,
			minuteStep : 5,
			minView : 0,
			todayBtn : true,
			startDate : new Date(),
			pickerPosition : 'bottom-left',
			language : 'zh-CN'
		});
	});

	function showExam() {
		$("#exam_father").load("../assets/jsp/teacher/all_exam.jsp");
	}
	function addExam() {
		$.ajax({
			cache : false,
			type : "POST",
			url : "../assets/jsp/teacher/add_exam.jsp", // 把表单数据发送到add_exam.jsp
			data : $('#add_exam_form').serialize(), // 要发送的是add_exam_form表单中的数据
			async : false,
			error : function(request) {
				alert("发送请求失败！");
			},
			success : function(data) {
				if (data == 1) {
					$("#exam_father").load(
							"../assets/jsp/teacher/all_exam_before.jsp");
				} else {
					alert(data);
				}
			}
		});
	}
</script>
