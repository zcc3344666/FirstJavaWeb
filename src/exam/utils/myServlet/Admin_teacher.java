package exam.utils.myServlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.utils.*;

/**
 * Servlet implementation class Admin_teacher
 */
@WebServlet("/Admin_teacher")
public class Admin_teacher extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Admin_teacher() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 设置请求报文的字符编码为utf-8
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		// 获取表单输入域的值
		String te_id = request.getParameter("teacher_id");
		int id = 0;
		try {
			id = Integer.parseInt(te_id);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		String te_user = request.getParameter("teacher_name");

		String te_pwd = Password.createPassword(request.getParameter("newpass"));
		String te_truename = request.getParameter("teacher_truename");
		String[] hobbies = request.getParameterValues("yorn");
		String hobby = "";
		// 遍历hobbies数组，将其转化为一个字符串
		if (hobbies != null) {
			for (int i = 0; i < hobbies.length; i++) {
				hobby += hobbies[i];
			}
		}

		if (te_pwd == "" || te_truename == "") {
			response.sendRedirect("administrator/admin_manage_teacher.jsp?errNo=1");
		} else {
			String te_sql = "SELECT * FROM teacher where tname='" + te_user + "'";
			ResultSet rs = DbUtil.executeQuery(te_sql);
			try {
				String ss = "";
				if (rs.next()) {
					ss = rs.getString("tadmin");
				}
				if (ss.equals("1")) {
					String ad_sql = "SELECT * FROM admin where aname='" + te_user + "'";
					rs = DbUtil.executeQuery(ad_sql);
					try {
						int ad_id = 0;
						if (rs.next()) {
							ad_id = rs.getInt("id");
						}

						if (hobby != "") {
							String te_sqlUpdate = "UPDATE teacher SET tpass='" + te_pwd + "',tfullname='" + te_truename
									+ "',tadmin='1' WHERE id=" + id + "";
							String ad_sqlUpdate = "UPDATE admin SET apass='" + te_pwd + "',afullname='" + te_truename
									+ "' WHERE id=" + ad_id + "";
							int result = DbUtil.executeUpdate(te_sqlUpdate);
							result = DbUtil.executeUpdate(ad_sqlUpdate);
							if (result > 0) {
								// 跳转至userAdmin.jsp页面
								response.sendRedirect("administrator/admin_manage_teacher.jsp?errNo=0");
							}
						} else {
							if (te_user.equals(session.getAttribute("admin"))) {
								response.sendRedirect("administrator/admin_manage_teacher.jsp?errNo=4");
							} else {
								String te_sqlUpdate = "UPDATE teacher SET tpass='" + te_pwd + "',tfullname='"
										+ te_truename + "',tadmin='0' WHERE id=" + id + "";
								String ad_sqlDelete = "DELETE FROM admin WHERE id=" + ad_id + "";
								int result = DbUtil.executeUpdate(te_sqlUpdate);
								result = DbUtil.executeUpdate(ad_sqlDelete);
								if (result > 0) {
									// 跳转至userAdmin.jsp页面
									response.sendRedirect("administrator/admin_manage_teacher.jsp?errNo=0");
								}

							}
						}
					} catch (Exception e) {
						// TODO: handle exception
					}

				} else {
					if (hobby != "") {
						String te_sqlUpdate = "UPDATE teacher SET tpass='" + te_pwd + "',tfullname='" + te_truename
								+ "',tadmin='1' WHERE id=" + id + "";
						String ad_sqlInsert = "INSERT INTO admin(aname,apass,afullname) VALUES ('" + te_user + "','"
								+ te_pwd + "','" + te_truename + "')";

						int result = DbUtil.executeUpdate(te_sqlUpdate);
						result = DbUtil.executeUpdate(ad_sqlInsert);
						if (result > 0) {
							// 跳转至userAdmin.jsp页面
							response.sendRedirect("administrator/admin_manage_teacher.jsp?errNo=0");
						}
					} else {
						String te_sqlUpdate = "UPDATE teacher SET tpass='" + te_pwd + "',tfullname='" + te_truename
								+ "',tadmin='0' WHERE id=" + id + "";
						int result = DbUtil.executeUpdate(te_sqlUpdate);
						if (result > 0) {
							// 跳转至userAdmin.jsp页面
							response.sendRedirect("administrator/admin_manage_teacher.jsp?errNo=0");
						}
					}
				}

			} catch (Exception e) {
				// TODO: handle exception
			}

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
