package exam.utils.teacherStudent;

import java.io.IOException;

import java.sql.ResultSet;
import java.util.ArrayList;

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
import exam.utils.ExcelUtil;


/**
 * Servlet implementation class Teacher_student
 */
@WebServlet("/Teacher_studentUpload")
public class Teacher_studentUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServletConfig servletconfig;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Teacher_studentUpload() {
        super();
        // TODO Auto-generated constructor stub
    }
 // 初始化servletconfig对象
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
		HttpSession session = request.getSession();
		String examId = (String) session.getAttribute("examId_upload");

		SmartUpload smart = new SmartUpload();// 实例化上传组件1

		// 2.初始化SmartUpolad对象
		try {
			smart.initialize(servletconfig, request, response);
		} catch (ServletException e1) {
			// e1.printStackTrace();
			session.setAttribute("suploadErr", "上传失败");
			
			response.sendRedirect("TeacherStudentServlet?id="+examId);
			return;
		}

		// 3.设置文件上传的 限制
		smart.setAllowedFilesList("xlsx");
		// 单个文件最大字节数
		smart.setMaxFileSize(3 * 1024 * 1024);
		// 文件总最大字节数
		smart.setTotalMaxFileSize(12 * 1024 * 1024);

		// 4.使用upload上传
		try {
			smart.upload();
		} catch (Exception e) {
			session.setAttribute("suploadErr", "文件形式不对，文件应为xlsx格式，大小不超过3MB");
			
			response.sendRedirect("TeacherStudentServlet?id="+examId);
			return;
		}

		// 5.文件保存
		String filename = "";
		// 获取文件名
		Files files = smart.getFiles();
		File file = files.getFile(0);
		filename = file.getFileName();

		if(filename==null||filename.equals(""))
		{
			session.setAttribute("suploadErr", "");
			response.sendRedirect("TeacherStudentServlet?id="+examId);
			return;
		}
		
		// 设置上传文件保存路径
		String filePath = Exam.address;
		java.io.File fileDir = new java.io.File(filePath);
		if (!fileDir.exists()) {
			fileDir.mkdir();
		}

		try {
			int count = smart.save(filePath);
		} catch (Exception e) {
			session.setAttribute("suploadErr", "上传失败");
			
			response.sendRedirect("TeacherStudentServlet?id="+examId);
			return;
		}

		java.io.File file0 = new java.io.File(Exam.address+"/"+filename);
		ArrayList<ArrayList<Object>> result = ExcelUtil.readExcel(file0);
		if (result == null) {
			session.setAttribute("suploadErr", file.getFilePathName());
			
			response.sendRedirect("TeacherStudentServlet?id="+examId);
			return;
		}
		int num=0;
		if (result.get(0).get(0).toString().equals("班级") && result.get(0).get(1).toString().equals("学号")
				&& result.get(0).get(2).toString().equals("姓名")) {
			for (int i = 1; i < result.size(); i++) {
				String sql = "select * from student where sno='"
						+ result.get(i).get(1).toString() 
						+ "'and eid='"+examId+"'";
				try {
					ResultSet rs = DbUtil.executeQuery(sql);
					int count = 0;
					while (rs.next()) {
						count++;
					}
					if (count==0) {
						String sql0 = "INSERT INTO student(sno,sname,sclass,eid) VALUES ('" + result.get(i).get(1).toString()
								+ "','" + result.get(i).get(2).toString() + "','" + result.get(i).get(0).toString() + "','"
								+ examId + "')";
						try {
							num += DbUtil.executeUpdate(sql0);
						} catch (Exception e) {
							e.printStackTrace();
						}
						DbUtil.close();
					}
				} catch (Exception e) {
					session.setAttribute("suploadErr", "上传失败");
					
					response.sendRedirect("TeacherStudentServlet?id="+examId);
					return;
				}
			}
		}
		session.setAttribute("suploadErr", "导入"+num+"个");
		response.sendRedirect("TeacherStudentServlet?id="+examId);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
