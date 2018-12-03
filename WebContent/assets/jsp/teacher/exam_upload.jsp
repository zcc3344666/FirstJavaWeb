<%@page import="exam.utils.*"%>
<%@page import="java.sql.*,java.util.Date,java.text.*,com.jspsmart.upload.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SmartUpload smart = new SmartUpload();//实例化上传组件1
	
	String examId = smart.getRequest().getParameter("id");
	
	smart.initialize(pageContext); //初始化上传操作2

	// 3.设置文件上传的 限制
	smart.setAllowedFilesList("doc,docx,txt");
	// 单个文件最大字节数
	smart.setMaxFileSize(3 * 1024 * 1024);
	// 文件总最大字节数
	smart.setTotalMaxFileSize(12 * 1024 * 1024);

	// 4.使用upload上传
	boolean flag = false;
	try {
		smart.upload();
		flag = true;
	} catch (Exception e) {
		out.print("文件形式不对，文件应为doc,docx,txt格式，大小不超过3MB");
		flag = false;
	}
	
	// 5.文件保存
	String filename="";
	if(flag)
	{
		//获取文件名
		Files files = smart.getFiles();
		File file = files.getFile(0);
		filename = file.getFileName();
		
		//设置上传文件保存路径
		String filePath = "D:/JavaWeb/ch8/WebContent/WEB-INF" + "/upload";
		java.io.File fileDir = new java.io.File(filePath);
		if (!fileDir.exists()) {
			fileDir.mkdir();
		}

		try {
			int count = smart.save(filePath);
			flag = true;
		} catch (Exception e) {
			out.print("上传失败");
			flag = false;
		}
	}
	
	//写入数据库
	if(flag)
	{
		int result = 0;

		String sql = "UPDATE exam SET epaper='"+filename+"',etype='"
				+"application/x-msdownload"+"' WHERE id='"+examId+"'";
		try {
			result = DbUtil.executeUpdate(sql);
			if(result>0)
			{
				out.print("1");
			}
			else{
				out.print("无修改");
			}
		} catch (Exception e) {
			out.print("写入数据库失败");
		}
		DbUtil.close();
	}
%>