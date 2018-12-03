package exam.utils.teacherStudent;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.utils.DbUtil;

/**
 * Servlet implementation class Add_student
 */
@WebServlet("/Add_student")
public class Add_student extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Add_student() {
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

		HttpSession session = request.getSession();
		session.setAttribute("addstuErr", "");

		String sno = request.getParameter("sno");
		String sname = request.getParameter("sname");
		String sclass = request.getParameter("sclass");
		String examId = (String) session.getAttribute("examId_upload");

		if (sno == null || sno.length() <= 0 || sname == null || sname.length() <= 0 || sclass == null || sclass.length() <= 0) {
			session.setAttribute("addstuErr", "学生信息不能为空");
			if (request.getHeader("Referer").toString().equals("http://localhost:8080/ProjectTest/teacher/middle_student_message.jsp")) {
				response.sendRedirect("teacher/middle_student_message.jsp");
			} else {
				response.sendRedirect("TeacherStudentServlet?id=" + examId);
			}
			return;
		}

		String sql = "select * from student where sno='" + sno + "'and eid='" + examId + "'";
		try {
			ResultSet rs = DbUtil.executeQuery(sql);
			int count = 0;
			while (rs.next()) {
				count++;
			}
			if (count == 0) {
				String sql0 = "INSERT INTO student(sno,sname,sclass,eId) VALUES ('" + sno + "','" + sname + "','"
						+ sclass + "','" + examId + "')";
				try {
					int counts = 0;
					counts = DbUtil.executeUpdate(sql0);
					if (counts == 0) {
						session.setAttribute("addstuErr", "添加失败");
					} else {
						session.setAttribute("addstuErr", "添加成功");
					}
				} catch (Exception e) {
					session.setAttribute("addstuErr", "添加失败");
					e.printStackTrace();
				}
			} else {
				session.setAttribute("addstuErr", "学号重复");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("addstuErr", "添加失败");
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
