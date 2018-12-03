package exam.utils.teacherStudent;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.utils.DbUtil;

/**
 * Servlet implementation class Delete_student
 */
@WebServlet("/Delete_student")
public class Delete_student extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Delete_student() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;Charset=utf-8");
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		session.setAttribute("addstuErr", "");

		String id = request.getParameter("id");
		String examId = (String) session.getAttribute("examId_upload");
		try {
			String sql = "DELETE FROM student WHERE id='" + id + "'and eid='" + examId + "'";
			// 执行删除
			DbUtil.executeUpdate(sql);
		} catch (Exception e) {
			// TODO: handle exception
		}

		DbUtil.close();
		if (request.getHeader("Referer").toString().equals("http://localhost:8080/ProjectTest/teacher/middle_student_message.jsp")) {
			response.sendRedirect("teacher/middle_student_message.jsp");
		} else {
		response.sendRedirect("TeacherStudentServlet?id=" + examId);
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
