package exam.utils.examServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exam.file.DeleteFile;
import exam.file.Exam;
import exam.utils.DbUtil;

/**
 * Servlet implementation class Admin_clean
 */
@WebServlet("/Admin_clean")
public class Admin_clean extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_clean() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Exam_id = request.getParameter("id");
		boolean flag = DeleteFile.deleteFile(Exam.address +"/student/"+"exam-"+Exam_id);
		boolean flag1=DeleteFile.deleteFile(Exam.address +"/teacher/"+"exam-"+Exam_id);
		if (flag) {
			try {
				String exam_sqlUpdate = "UPDATE exam SET ecleared='1' WHERE id=" + Exam_id + "";
				int result = DbUtil.executeUpdate(exam_sqlUpdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("administrator/admin_clean.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
