package exam.utils.teacherStudent;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.utils.DbUtil;
import exam.utils.Password;

/**
 * Servlet implementation class Cancel_ip
 */
@WebServlet("/Cancel_ip")
public class Cancel_ip extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cancel_ip() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;Charset=utf-8");
		request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		try {
			// 执行解锁
			String sql_cancel = "UPDATE student SET ipaddress=null WHERE id='" + id + "'";
			int result = DbUtil.executeUpdate(sql_cancel);
			DbUtil.close();
			if (result > 0) {
				response.sendRedirect("teacher/middle_cancel_ip.jsp");
			}
		} catch (Exception e) {
			response.sendRedirect("teacher/middle_cancel_ip.jsp");
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
