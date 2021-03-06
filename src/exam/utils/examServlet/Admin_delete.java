package exam.utils.examServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exam.utils.DbUtil;

/**
 * Servlet implementation class Admin_delete
 */
@WebServlet("/Admin_delete")
public class Admin_delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_delete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Exam_id = request.getParameter("id");
		try {
				String exam_sqlUpdate = "DELETE FROM exam WHERE id=" + Exam_id + "";
				int result = DbUtil.executeUpdate(exam_sqlUpdate);
				if (result > 0) {
					response.sendRedirect("administrator/admin_clean.jsp");
				} 
		} catch (Exception e) {
			e.printStackTrace();
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
