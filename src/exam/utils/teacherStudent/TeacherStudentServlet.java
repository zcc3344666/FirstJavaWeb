package exam.utils.teacherStudent;

import java.io.IOException;

import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.file.Exam;
import exam.utils.DbUtil;

/**
 * Servlet implementation class TeacherStudentServlet
 */
@WebServlet("/TeacherStudentServlet")
public class TeacherStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TeacherStudentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession();
		ArrayList<ArrayList<Object>> rowList = new ArrayList<ArrayList<Object>>();
		ArrayList<Object> colList;

		String examId = (String) session.getAttribute("examId_upload");
		String sql0 = "select * from student where eid="+examId;

		try {
			ResultSet rs = DbUtil.executeQuery(sql0);
			while (rs.next()) {
				colList = new ArrayList<Object>();
				colList.add(rs.getString("id"));
				colList.add(rs.getString("sno"));
				colList.add(rs.getString("sname"));
				colList.add(rs.getString("sclass"));
				rowList.add(colList);
			}
			DbUtil.close();
			Exam.rowList = rowList;
			response.sendRedirect("Page_size");
		} catch (Exception e) {
			request.getRequestDispatcher("teacher/exam_modify.jsp").forward(request, response);
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
