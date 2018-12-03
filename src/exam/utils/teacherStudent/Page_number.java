package exam.utils.teacherStudent;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exam.file.Exam;

/**
 * Servlet implementation class Page_number
 */
@WebServlet("/Page_number")
public class Page_number extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ServletConfig config = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Page_number() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig config) throws ServletException {
		this.config = config;
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
		try {
			String ps = request.getParameter("pageNo");
			// System.out.println(ps);
			int pageNo = new Integer(ps);
			Exam.pageNo = pageNo;
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.sendRedirect("teacher/exam_student.jsp");
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
