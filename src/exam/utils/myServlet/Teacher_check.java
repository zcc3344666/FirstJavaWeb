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
 * Servlet implementation class Teacher_check
 */
@WebServlet("/Teacher_check")
public class Teacher_check extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Teacher_check() {
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
		String te_user = request.getParameter("te_name");
		String te_pwd = Password.createPassword(request.getParameter("te_pwd"));
		String id="";
		
		String te_sqlSearch = "SELECT * FROM teacher WHERE tname='" + te_user + "'and tpass='" + te_pwd + "'";
		HttpSession session = request.getSession();

		int te_result = 0;
		ResultSet te_rs = null;
		te_rs = DbUtil.executeQuery(te_sqlSearch);
		try {
			while (te_rs.next()) {
				id=te_rs.getString("id");
				te_result += 1;
			}
			DbUtil.close();
			if (te_result == 1) {
				session.setAttribute("teacher", te_user);
				session.setAttribute("teacherId", id);
				response.sendRedirect("teacher/teacher_main.jsp");
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
