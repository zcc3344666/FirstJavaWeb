<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="admin_head.jsp"%>
<script>
	$(function() {
		$('#tModal').on('shown.bs.modal', function(event) {
			var btn = $(event.relatedTarget)
			var modal = $(this)
			modal.find('#teacher_id').val(btn.data('whatever1'));
			modal.find('#name').val(btn.data('whatever'));
		})
	});
</script>
<div style="position: relative; margin-left: 16%; margin-right: 16%;">
	<form action="../assets/jsp/administrator/add_teacher.jsp">
		
			<div class="row" style="background: #CDCDCD;">
				<strong>添加教师</strong> <br>
				<div class="form-group col-sm-3">
					<input name="username" type="text" class="form-control"
						placeholder="用户名" />
				</div>
				<div class="form-group col-sm-3">
					<input name="password" type="password" class="form-control"
						placeholder="初始口令" />
				</div>
				<div class="form-group col-sm-3">
					<input name="truename" type="text" class="form-control"
						placeholder="真实姓名" />
				</div>
				<div class="form-group col-sm-3">
					<input name="yorn" type="checkbox" class="from-control"
						name="eautostart" /> <label style="font-size: 18px;">管理员</label>
						<input
						class="btn btn-primary" name="submit" type="submit" value="添加" />
				</div>
			</div>
	</form>
	<br>
	<div><%@ include
			file="../assets/jsp/administrator/all_teacher.jsp"%></div>
</div>
<%
	String flag1 = request.getParameter("errNo");
	try {
		if (flag1 != null) {
			switch (flag1) {
			case "0":
				out.print("<script>alert('修改成功！');</script>");
				break;
			case "1":
				out.print("<script>alert('用户名、密码、真实姓名均不能为空，请重新输入！');</script>");
				break;
			case "2":
				out.print("<script>alert('用户名已存在，请重新输入！');</script>");
				break;
			case "3":
				out.print("<script>alert('此用户名管理员已存在，请重新输入！');</script>");
				break;
			case "4":
				out.print("<script>alert('此为当前登陆用户，不可更改管理员属性！');</script>");
				break;
			default:
				break;
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<div class="modal fade" id="tModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">修改信息</h4>
			</div>
			<form action="../Admin_teacher" method="post">
				<div style="margin-left: 35%; margin-right: 35%; margin-top: 50px;">
					<input type="hidden" id="teacher_id" name="teacher_id" /> <input
						id="name" type="text" name="teacher_name" placeholder="用户名"
						style="width: 100%" readonly="readonly" /> <br /> <br /> <input
						type="password" name="newpass" placeholder="口令"
						style="width: 100%" /> <br /> <br /> <input type="text"
						name="teacher_truename" placeholder="真实姓名" style="width: 100%" />
					<br /> <br /> <input name="yorn" type="checkbox" value="管理员" />管理员<br />
					<br />
					<div>
						<input data-dismiss="modal" type="button" value="取消"
							style="width: 45%; float: left;"> <input type="submit"
							value="修改" style="width: 45%; float: right;" />
					</div>
				</div>
			</form>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>