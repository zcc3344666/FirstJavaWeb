<%@page import="exam.utils.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//设置请求报文的字符编码为utf-8
		request.setCharacterEncoding("utf-8");
		//获取表单输入域的值
		String username = request.getParameter("username");
		String password = Password.createPassword(request.getParameter("password"));
		String truename = request.getParameter("truename");
		String[] hobbies = request.getParameterValues("yorn");
		String hobby = "";
		//遍历hobbies数组，将其转化为一个字符串
		if (hobbies != null) {
			for (int i = 0; i < hobbies.length; i++) {
				hobby += hobbies[i];
			}
		}
		if (username == "" || password == "" || truename == "") {
			response.sendRedirect("../../../administrator/admin_manage_teacher.jsp?errNo=1");
		} else {
			String sql0 = "select * from teacher where tname='" + username + "'";
			try {
				ResultSet rs = DbUtil.executeQuery(sql0);
				int count = 0;
				while (rs.next()) {
					count++;
				}

				if (count > 0) {
					response.sendRedirect("../../../administrator/admin_manage_teacher.jsp?errNo=2");
				} else {
					//编写SQL语句
					int result = 0;
					int result1 = 0;
					if (hobby != "") {

						sql0 = "select * from admin where aname='" + username + "'";
						try {
							rs = DbUtil.executeQuery(sql0);
							count = 0;
							while (rs.next()) {
								count++;
							}

							if (count > 0) {
								response.sendRedirect("../../../administrator/admin_manage_teacher.jsp?errNo=3");
							} else {
								String sql = "INSERT INTO teacher(tname,tpass,tfullname,tadmin) VALUES (?,?,?,?)";
								String sql1 = "INSERT INTO admin(aname,apass,afullname) VALUES (?,?,?)";

								//为动态SQL的参数赋值
								try {
									PreparedStatement ps = DbUtil.executePreparedStatement(sql);
									ps.setString(1, username);
									ps.setString(2, password);
									ps.setString(3, truename);
									ps.setString(4, "1");
									result = ps.executeUpdate();
									ps.close();

									PreparedStatement ps1 = DbUtil.executePreparedStatement(sql1);
									ps1.setString(1, username);
									ps1.setString(2, password);
									ps1.setString(3, truename);
									//执行SQL语句

									result1 = ps1.executeUpdate();

									ps1.close();
								} catch (SQLException e) {
									e.printStackTrace();
								}
							}
						} catch (Exception e) {
						}
					} else {
						String sql = "INSERT INTO teacher(tname,tpass,tfullname,tadmin) VALUES (?,?,?,?)";
						//为动态SQL的参数赋值
						try {
							PreparedStatement ps = DbUtil.executePreparedStatement(sql);
							ps.setString(1, username);
							ps.setString(2, password);
							ps.setString(3, truename);
							ps.setString(4, "0");
							//执行SQL语句
							result = ps.executeUpdate();
							ps.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}

					//如果执行成功，查询数据库
					if (result > 0) {
						//跳转至admin_manage_teacher.jsp页面
						response.sendRedirect("../../../administrator/admin_manage_teacher.jsp");
					}
				}

			} catch (Exception e) {

			}
		}
	%>
</body>
</html>