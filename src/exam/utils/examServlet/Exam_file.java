package exam.utils.examServlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import exam.file.Exam;
import exam.file.FileToZip;
import exam.utils.DbUtil;

/**
 * Servlet implementation class Exam_file
 */
@WebServlet("/Exam_file")
public class Exam_file extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ServletConfig config = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Exam_file() {
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
		HttpSession session = request.getSession();

		String Exam_id = request.getParameter("id");
		boolean flag = FileToZip.fileToZip(Exam.address+"/student/exam-"+Exam_id, "D:/exam_result","students_answers"+Exam_id);
		SmartUpload su = new SmartUpload();
		// 初始化
		su.initialize(config, request, response);
		/*
		 * 设定contentDisposition为null以禁止浏览器自动打开文件，保证点击链接后是下载文件。若不设定，则下载的文件扩展名为doc时，
		 * 浏览器将自动用Word打开它；当扩展名为pdf时，浏览器将用PDF阅读器打开。
		 */
		su.setContentDisposition(null);
		// 下载文件
		try {
			su.downloadFile("D:/exam_result/students_answers"+Exam_id+".zip");
		} catch (SmartUploadException e) {
			e.printStackTrace();
		}
		if (flag) {
			session.setAttribute("file_message", "考生答卷打包成功!");
			try {
				String sql = "DELETE FROM student WHERE eid='" + Exam_id + "'";
				String sql_submit= "DELETE FROM submit WHERE eid='" + Exam_id + "'";
				// 执行删除
				DbUtil.executeUpdate(sql);
				DbUtil.executeUpdate(sql_submit);
				String exam_sqlUpdate = "UPDATE exam SET earchived='1' WHERE id=" + Exam_id + "";
				int result = DbUtil.executeUpdate(exam_sqlUpdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			session.setAttribute("file_message", "考生答卷打包失败!");
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
