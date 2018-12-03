package exam.utils.myServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Admin_os
 */
@WebServlet("/Admin_os")
public class Admin_os extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_os() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String back_interval_time = request.getParameter("back_interval_time");
		String counts = request.getParameter("counts");
		String bottom = request.getParameter("bottom");
		String top = request.getParameter("top");
		String timess= request.getParameter("time2");
		
		String[] yOn = request.getParameterValues("yorn");
		String yesNo = "";
		// 遍历hobbies数组，将其转化为一个字符串
		if (yOn != null) {
			for (int i = 0; i < yOn.length; i++) {
				yesNo ="sss";
			}
		}
		
		if ((back_interval_time != "" && back_interval_time != null) &&(counts !="" && counts !=null)&&(bottom != "" && bottom != null)&&(top != "" && top !=null)&&(timess != "" && timess !=null)) {
			try {
				float b_i_time = new Float(back_interval_time);
				int count = new Integer(counts);
				int bt=new Integer(bottom);
				int tp=new Integer(top);
				int ti=new Integer(timess);
				if (b_i_time > 0 && count > 0 && bt >0 && tp >0 && tp>bt && ti > 0) {
					session.setAttribute("b_i_time", back_interval_time);
					session.setAttribute("page_size", counts);
					session.setAttribute("bottom_size", bottom);
					session.setAttribute("top_size", top);
					session.setAttribute("time", timess);
					if(yesNo != "") {
						session.setAttribute("cleanAnddelete_exam", "yes_exam");
					}else {
						session.setAttribute("cleanAnddelete_exam", "no_exam");
					}
				} else {
					response.sendRedirect("administrator/admin_os.jsp");
					return;
				}
			} catch (NumberFormatException e) {
				response.sendRedirect("administrator/admin_os.jsp");
				return;
			}
		}
		
		response.sendRedirect("administrator/admin_os.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
