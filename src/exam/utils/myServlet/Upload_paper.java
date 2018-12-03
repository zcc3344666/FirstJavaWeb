package exam.utils.myServlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jspsmart.upload.File;
import com.jspsmart.upload.Files;
import com.jspsmart.upload.SmartUpload;

import exam.file.Exam;
import exam.utils.DbUtil;

/**
 * Servlet implementation class Upload_paper
 */
@WebServlet("/Upload_paper")
public class Upload_paper extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 声明servletconfig对象，作为initialize()方法的参数
		private ServletConfig servletconfig;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Upload_paper() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) throws ServletException {
		this.servletconfig = config;
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;Charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session=request.getSession();
		
		SmartUpload smart = new SmartUpload();// 实例化上传组件1
		String examId = (String)session.getAttribute("examId_upload");
		String fileSize_Max=(String) session.getAttribute("top_size");
		int fs_Max=1048576;
		if(fileSize_Max !="" || fileSize_Max !=null) {
			try {
				int top=new Integer(fileSize_Max);
					fs_Max = top;
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		// 2.初始化SmartUpolad对象
		try {
			smart.initialize(servletconfig, request, response);
		} catch (ServletException e1) {
			// e1.printStackTrace();
			session.setAttribute("uploadErr","上传失败");
			return;
		}

		// 3.设置文件上传的 限制
		smart.setAllowedFilesList("doc,docx,txt");
		// 单个文件最大字节数
		smart.setMaxFileSize(fs_Max);
		// 文件总最大字节数
		smart.setTotalMaxFileSize(12 * 1024 * 1024);

		// 4.使用upload上传
		boolean flag = false;
		try {
			smart.upload();
			flag = true;
		} catch (Exception e) {
			session.setAttribute("uploadErr","文件形式不对，文件应为doc,docx,txt格式，且大小不能超过"+(float)fs_Max/1024/1024+" MB");
			flag = false;
		}

		// 5.文件保存
		String filename = "";
		if (flag) {
			// 获取文件名
			Files files = smart.getFiles();
			File file = files.getFile(0);
			filename = file.getFileName();
			
			if(filename==null||filename.equals(""))
			{
				response.sendRedirect("teacher/exam_modify.jsp?id="+examId);
				return;
			}
			// 设置上传文件保存路径
			String filePath = Exam.address + "/teacher/" + "exam-" + examId;
			java.io.File fileDir = new java.io.File(filePath);
			if (!fileDir.exists()) {
				fileDir.mkdirs();
			}

			try {
				int count = smart.save(filePath);
				flag = true;
			} catch (Exception e) {
				session.setAttribute("uploadErr","上传失败");
				flag = false;
			}
			
		}

		// 写入数据库
		if (flag) {
			int result = 0;
			String sql = "UPDATE exam SET epaper='" + filename + "',etype='" + "application/x-msdownload"
					+ "' WHERE id='" + examId + "'";
			/*String sql = "UPDATE exam SET epaper='" + filename + "',etype='" + "application/x-msdownload"
					+ "' WHERE id='" + examId + "'";*/
			try {
				result = DbUtil.executeUpdate(sql);
				if (result > 0) {
					session.setAttribute("uploadErr","");
				} else {
					session.setAttribute("uploadErr","无修改"+examId);
				}
			} catch (Exception e) {
				session.setAttribute("uploadErr","写入数据库失败");
			}
			DbUtil.close();
		}
		response.sendRedirect("teacher/exam_modify.jsp?id="+examId);
		//request.getRequestDispatcher("teacher_exam_modify.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
