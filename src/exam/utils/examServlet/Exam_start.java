package exam.utils.examServlet;

import java.io.IOException;
import java.sql.*;
import java.text.*;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exam.utils.DbUtil;

/**
 * Servlet implementation class Exam_start
 */
@WebServlet("/Exam_start")
public class Exam_start extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Exam_start() {
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
		String time = (String) session.getAttribute("time");
		int time_b=15;
		if(time !="" || time !=null) {
			try {
				int t2=new Integer(time);
					time_b = t2;
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		int minutes = 0;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");// 设置日期格式
		String nowDate = simpleDateFormat.format(new Date());// new Date()为获取当前系统时间

		String Exam_id = request.getParameter("id");
		String etime = "";

		String sql0 = "select * from exam where id='" + Exam_id + "'";
		try {
			ResultSet rs = DbUtil.executeQuery(sql0);
			while (rs.next()) {
				etime = rs.getString("etime");
				etime = etime.substring(0, etime.length() - 5);
			}
			DbUtil.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			long from = simpleDateFormat.parse(nowDate).getTime();
			long to = simpleDateFormat.parse(etime).getTime();
			minutes = (int) ((to - from) / (1000 * 60));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if (minutes > time_b || minutes < 0) {
			session.setAttribute("error_message", "开启考试失败（开启时间过早，或时间已经过去！）");
			response.sendRedirect("teacher/exam_modify.jsp?id="+Exam_id+"");
		} else {
			try {
				String exam_sqlUpdate = "UPDATE exam SET eactive='1' WHERE id=" + Exam_id + "";
				int result = DbUtil.executeUpdate(exam_sqlUpdate);
				if (result > 0) {
					response.sendRedirect("teacher/exam_before.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
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
