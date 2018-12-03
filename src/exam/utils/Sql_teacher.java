package exam.utils;

import java.sql.*;

public class Sql_teacher {
	public static int addexam(String ename, Timestamp timeStamp, String teacherId, String eautostart) {
		int id = 0;

		String sql0 = "INSERT INTO exam(ename,etime,ecreator,eautostart) VALUES ('" + ename + "','" + timeStamp + "','"
				+ teacherId + "','" + eautostart + "')";
		try {
			int count = 0;
			count = DbUtil.executeUpdate(sql0);
			if (count == 0) {
				return 0;
			} else {
				String sql = "SELECT id FROM exam";
				try {
					ResultSet rs = DbUtil.executeQuery(sql);
					while (rs.next()) {
						id = rs.getInt("id");
					}
				} catch (Exception e) {
					System.out.println("错误");
					id=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			id=0;
		}
		DbUtil.close();
		return id;
	}

	public static int updateExam(String ename, Timestamp timeStamp, String examId, String eautostart) {
		int result = 0;

		String sql = "UPDATE exam SET ename='"+ename+"',etime='"+timeStamp+"',eautostart='"
				+eautostart+"' WHERE id='"+examId+"'";
		try {
			
			// 执行SQL语句
			result = DbUtil.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		DbUtil.close();
		return result;
	}

	public static String getTname(int id) {
		String tname = "";
		String sql0 = "select tname from teacher where id='" + id + "'";
		try {
			ResultSet rs = DbUtil.executeQuery(sql0);
			while (rs.next()) {
				tname = rs.getString("tname");
			}
			DbUtil.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tname;
	}
}
