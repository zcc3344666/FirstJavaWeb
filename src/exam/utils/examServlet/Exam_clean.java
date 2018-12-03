package exam.utils.examServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.file.DeleteFile;
import exam.file.Exam;
import exam.utils.DbUtil;

/**
 * Servlet implementation class Exam_clean
 */
@WebServlet("/Exam_clean")
public class Exam_clean extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Exam_clean() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String Exam_id = request.getParameter("id");
		boolean flag = DeleteFile.deleteFile(Exam.address +"/student/"+"exam-"+Exam_id);
		boolean flag1=DeleteFile.deleteFile(Exam.address +"/teacher/"+"exam-"+Exam_id);
		if (flag) {
			session.setAttribute("file_message", "清档成功!");
			try {
				String exam_sqlUpdate = "UPDATE exam SET ecleared='1' WHERE id=" + Exam_id + "";
				int result = DbUtil.executeUpdate(exam_sqlUpdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			session.setAttribute("file_message", "清档失败!");
		}
		response.sendRedirect("teacher/exam_after.jsp");
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
