package exam.utils.studentServlet;

import java.io.IOException;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

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
 * Servlet implementation class Upload_answer
 */
@WebServlet("/Upload_answer")
public class Upload_answer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 声明servletconfig对象，作为initialize()方法的参数
		private ServletConfig servletconfig;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Upload_answer() {
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
		@SuppressWarnings("unchecked")
		ArrayList<ArrayList<Object>> submitList = 
 				(ArrayList<ArrayList<Object>>)session.getAttribute("submitList");
 		
 		ArrayList<Object> colList= new ArrayList<Object>();//本次提交信息
		
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
		String fileName = "";
 		int fileSize;
 		if (flag) {
 			// 获取文件名
 			Files files = smart.getFiles();
 			File file = files.getFile(0);
 			fileName = file.getFileName();
 			fileSize = file.getSize();
 			
 			colList.add(fileName);
 			colList.add(fileSize);
 			
 			if(fileName==null||fileName.equals(""))
 			{
 				response.sendRedirect("student/check_submit.jsp");
 				return;
 			}
 			
 			// 设置上传文件保存路径
 			String sno = (String)session.getAttribute("sno");
 			String sname = (String)session.getAttribute("student");
 			String filePath = Exam.address+"/student/exam-"+examId;
 			java.io.File fileDir = new java.io.File(filePath);
 			if (!fileDir.exists()) {
 				fileDir.mkdirs();
 				//System.out.println("12");
 			}
 			//System.out.println(filePath);
 			try {
 				int count = smart.save(filePath);
 				flag = true;
 			} catch (Exception e) {
 				session.setAttribute("uploadErr","上传失败");
 				//System.out.println("1");
 				flag = false;
 				e.printStackTrace();
 			}
 		}

		// 写入数据库
 		if (flag) {
 			//DateFormat fmt= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 			Date date=new Date();
 			Timestamp timeStamp = new Timestamp(date.getTime());
 			colList.add(timeStamp);
 			int result = 0;
 			String studentId = (String)session.getAttribute("studentId");
 			String sql = "select * from submit where sid='"+
 							studentId+"'and eid='"+examId+"'";
 			
 			try {
 				ResultSet rs = DbUtil.executeQuery(sql);
 				int count = 0;
 				String subId="";
 				while (rs.next()) {
 					subId=rs.getString("id");
 					count++;
 				}
 				int count1 = 0;
 				if(count==0) {  //无数据，插入
 					String sql1 = "INSERT INTO submit(sid,eid,stime) VALUES ('" 
 							+ studentId + "','"
 							+ examId + "','" + timeStamp + "')";
 					try {
 						count1 = DbUtil.executeUpdate(sql1);
					} catch (Exception e) {
						session.setAttribute("uploadErr","插入数据库失败");
					}
 				}
 				else {    //数据存在，修改
 					String sql2 = "UPDATE submit SET stime='" +timeStamp+"' WHERE id='"+subId+"'";
 					try {
 						count1 = DbUtil.executeUpdate(sql2);
 					}  catch (Exception e) {
						session.setAttribute("uploadErr","修改数据库失败");
					}
 				}
				if (count1 > 0) { //存储下来显示。
					int k = -1;
					for (int i = 0; i < submitList.size(); i++) {
						if (submitList.get(i).get(0).toString().equals(fileName)) {
							k = i;
							
						}
					}
					if (k>=0) {
						submitList.set(k, colList);
					}else
					{
						submitList.add(colList);
						session.setAttribute("submitList", submitList);
					}
				} else {
					session.setAttribute("uploadErr", "插入数据库失败");
				}
 			} catch (Exception e) {
 				e.printStackTrace();
 			}
 			
 			DbUtil.close();
 		} 		
 		response.sendRedirect("student/check_submit.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
