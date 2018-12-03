package exam.utils.teacherStudent;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.file.Exam;

/**
 * Servlet implementation class Page_size
 */
@WebServlet("/Page_size")
public class Page_size extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ServletConfig config = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Page_size() {
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

		HttpSession session = request.getSession();
		String p_size = (String) session.getAttribute("page_size");
		if (p_size != "" && p_size != null) {
			try {
				int pageSize = new Integer(p_size);
				if (pageSize > 0) {
					Exam.pageSize = pageSize;
				} else {
					response.sendRedirect("teacher/exam_student.jsp");
					return;
				}
			} catch (NumberFormatException e) {
				response.sendRedirect("teacher/exam_student.jsp");
				return;
			}
		}

		try {
			String ps = request.getParameter("pageSize");
			// System.out.println(ps);
			int pageSize = new Integer(ps);
			if (pageSize > 0) {
				Exam.pageSize = pageSize;
			} else {
				response.sendRedirect("teacher/exam_student.jsp");
				return;
			}
		} catch (Exception e) {
			response.sendRedirect("teacher/exam_student.jsp");
			return;
		}

		Exam.pageNo = 1;
		Exam.pageCount = Exam.rowList.size() / Exam.pageSize;
		if (Exam.rowList.size() % Exam.pageSize > 0 || Exam.pageCount == 0) {
			Exam.pageCount++;
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
