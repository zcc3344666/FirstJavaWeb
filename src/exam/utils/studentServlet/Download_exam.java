package exam.utils.studentServlet;

import java.io.IOException;
import java.sql.ResultSet;

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
import exam.utils.DbUtil;


/**
 * Servlet implementation class Download_exam
 */
@WebServlet("/Download_exam")
public class Download_exam extends HttpServlet {
	private static final long serialVersionUID = 1L;
ServletConfig config = null;
	
    public Download_exam() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;Charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String activeExamId = (String) session.getAttribute("examId_upload");

		String sql0 = "select * from exam where id='" + activeExamId + "'";
		String epaper = null;
		try {
			ResultSet rs = DbUtil.executeQuery(sql0);
			int count = 0;
			while (rs.next()) {
				epaper = rs.getString("epaper");
				count++;
			}

			if (count > 0) {
				if(epaper==null||epaper.length()==0)
				{
					return;
				}
				// 新建一个SmartUpload对象
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
					su.downloadFile(Exam.address +"/teacher/"+"exam-"+activeExamId + "/" + epaper);
				} catch (SmartUploadException e) {
					e.printStackTrace();
				}
			}
			DbUtil.close();
		} catch (Exception e) {

		}
	}
}