package exam.utils.myServlet;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.utils.*;

/**
 * Servlet implementation class Teacher_change_pass
 */
@WebServlet("/Teacher_change_pass")
public class Teacher_change_pass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Teacher_change_pass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		String te_user = request.getParameter("teacher_name");
		String te_old_pwd = Password.createPassword(request.getParameter("oldpass"));
		String te_new_pwd = request.getParameter("newpass1");
		String te_new_pwd2 = request.getParameter("newpass2");

		if (te_old_pwd == "" || te_new_pwd == "" || te_new_pwd2 == "") {
			response.sendRedirect("teacher/teacher_head.jsp?te_error=1");
		} else {
			if (!te_new_pwd2.equals(te_new_pwd)) {
				response.sendRedirect("teacher/teacher_head.jsp?te_error=2");
			} else {
				String sqlSearch = "SELECT * FROM teacher WHERE tname='" + te_user + "'and tpass='" + te_old_pwd + "'";
				int result = 0;
				int count = 0;
				ResultSet rs = null;
				rs = DbUtil.executeQuery(sqlSearch);
				try {
					while (rs.next()) {
						count += 1;
					}
					if (count == 1) {
						String sqlUpdate = "UPDATE teacher SET tpass='" + Password.createPassword(te_new_pwd) + "' WHERE tname='" + te_user
								+ "'";
						result = DbUtil.executeUpdate(sqlUpdate);
						DbUtil.close();
						if (result > 0) {
							response.sendRedirect("index.jsp?succ=1");
						}
					} else {
						response.sendRedirect("teacher/teacher_head.jsp?te_error=3");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}

			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
