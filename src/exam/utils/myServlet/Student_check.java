package exam.utils.myServlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.ObjectUtils.Null;

import exam.utils.*;

/**
 * Servlet implementation class Student_check
 */
@WebServlet("/Student_check")
public class Student_check extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Student_check() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String st_sql = "SELECT * FROM exam WHERE eactive<>'0'";
		ResultSet rss=DbUtil.executeQuery(st_sql);
		String Exam_startid="";
		try {
			while(rss.next()) {
				Exam_startid=rss.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String st_no = request.getParameter("st_no");
		String st_name = request.getParameter("st_name");
		String id="";

		String st_sqlSearch = "SELECT * FROM student WHERE sno='" + st_no + "'and sname='" + st_name + "'and eid = '" + Exam_startid + "'";
		HttpSession session = request.getSession();

		int st_result = 0;
		ResultSet st_rs = null;
		st_rs = DbUtil.executeQuery(st_sqlSearch);
		try {
			while (st_rs.next()) {
				id=st_rs.getString("id");
				st_result += 1;
			}
			if (st_result >= 1) {
				String st_sqlSearch1 = "SELECT * FROM student WHERE sno='" + st_no + "'and sname='" + st_name + "'and eid = '" + Exam_startid + "'and ipaddress is null";
				int st_result1 = 0;
				ResultSet st_rs1 = DbUtil.executeQuery(st_sqlSearch1);
				try {
					while (st_rs1.next()) {
						st_result1 += 1;
					}
					if (st_result1 >= 1) {
						
						try {
							// 执行加锁
							String sql_block = "UPDATE student SET ipaddress='"+request.getRemoteAddr()+"' WHERE sno='" + st_no + "'";
							int result = DbUtil.executeUpdate(sql_block);
							if (result > 0) {
								session.setAttribute("student", st_name);
								session.setAttribute("sno", st_no);
								session.setAttribute("studentId", id);
								session.setAttribute("studentErr", "");
								response.sendRedirect("student/student_main.jsp");
							}
						} catch (Exception e) {
							e.printStackTrace();
						}				
					}else {
						String st_sqlSearch2 = "SELECT * FROM student WHERE sno='" + st_no + "'and sname='" + st_name + "'and eid = '" + Exam_startid + "'and ipaddress='"+request.getRemoteAddr()+"'";
						int st_result2 = 0;
						ResultSet st_rs2 = DbUtil.executeQuery(st_sqlSearch2);
						try {
							while(st_rs2.next()) {
								st_result2+=1;
							}
							DbUtil.close();
							if (st_result2 >= 1) {
								session.setAttribute("student", st_name);
								session.setAttribute("sno", st_no);
								session.setAttribute("studentId", id);
								session.setAttribute("studentErr", "");
								response.sendRedirect("student/student_main.jsp");
							}else {
								response.sendRedirect("index.jsp?errNo=3");
							}
						}catch (Exception e) {
							e.printStackTrace();
						}					
					}
				}catch (Exception e) {
					e.printStackTrace();
				}
				DbUtil.close();
			} else {
				response.sendRedirect("index.jsp?errNo=2");
			}
		} catch (SQLException e) {
			e.printStackTrace();
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
