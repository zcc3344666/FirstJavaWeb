package exam.file;

import java.io.File;

public class DeleteFile {
	 public static boolean deleteFile(String oldpath) {
		 boolean flag = false;
		 File oldPath = new File(oldpath);
         if (oldPath.isDirectory()) {
//          System.out.println(oldPath + "是文件夹--");
          File[] files = oldPath.listFiles();
          for (File file : files) {
            deleteFile(file.toString());
            flag = true;
          }
         }else{
           oldPath.delete();
           flag = true;
         }
         return flag;
       }

//	public static void main(String[] args) {
//		boolean rs = DeleteFile.deleteFile("D:/xxxx/");
//		if (rs) {
//			System.out.println("删除成功！");
//		} else {
//			System.out.println("删除失败！");
//		}
//	}
}