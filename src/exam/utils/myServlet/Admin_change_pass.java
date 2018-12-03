package exam.utils.myServlet;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.sun.java.swing.plaf.windows.resources.windows;

import exam.utils.*;

/**
 * Servlet implementation class Admin_change_pass
 */
@WebServlet("/Admin_change_pass")
public class Admin_change_pass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Admin_change_pass() {
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
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		String ad_user = request.getParameter("admin_name");
		String ad_old_pwd = Password.createPassword(request.getParameter("oldpass"));
		String ad_new_pwd = request.getParameter("newpass1");
		String ad_new_pwd2 = request.getParameter("newpass2");

		if (ad_old_pwd == "" || ad_new_pwd == "" || ad_new_pwd2 == "") {
			response.sendRedirect("administrator/admin_head.jsp?_error=1");
		} else {
			if (!ad_new_pwd2.equals(ad_new_pwd)) {
				response.sendRedirect("administrator/admin_head.jsp?ad_error=2");
			} else {
				String sqlSearch = "SELECT * FROM admin WHERE aname='" + ad_user + "'and apass='" + ad_old_pwd + "'";
				int result = 0;
				int count = 0;
				ResultSet rs = null;
				rs = DbUtil.executeQuery(sqlSearch);
				try {
					while (rs.next()) {
						count += 1;
					}
					if (count == 1) {
						String sqlUpdate = "UPDATE admin SET apass='" + Password.createPassword(ad_new_pwd) + "' WHERE aname='" + ad_user
								+ "'";
						result = DbUtil.executeUpdate(sqlUpdate);
						DbUtil.close();
						if (result > 0) {
							response.sendRedirect("index.jsp?ad_succ=1");
						}
					} else {
						response.sendRedirect("administrator/admin_head.jsp?ad_error=3");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}

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
