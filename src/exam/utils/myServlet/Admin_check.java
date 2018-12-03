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
 * Servlet implementation class Admin_check
 */
@WebServlet("/Admin_check")
public class Admin_check extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Admin_check() {
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
		String ad_user = request.getParameter("ad_name");
		String ad_pwd = Password.createPassword(request.getParameter("ad_pwd"));

		String ad_sqlSearch = "SELECT * FROM admin WHERE aname='" + ad_user + "'and apass='" + ad_pwd + "'";
		HttpSession session = request.getSession();

		int ad_result = 0;
		ResultSet ad_rs = null;
		ad_rs = DbUtil.executeQuery(ad_sqlSearch);
		try {
			while (ad_rs.next()) {
				ad_result += 1;
			}
			DbUtil.close();
			if (ad_result == 1) {
				session.setAttribute("admin", ad_user);
				response.sendRedirect("administrator/admin_main.jsp");
			} else {
				response.sendRedirect("index.jsp?errNo=1");
			}
		} catch (SQLException e) {
			e.printStackTrace();
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
