package exam.utils;

import java.sql.*;

public class DbUtil {
	/**
	 * 声名连接数据库信息，例如数据库URL、用户名及密码等
	 */
	private static final String URL = "jdbc:mysql://localhost:3306/exam_project?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
	private static final String USER = "root";
	private static final String PASSWORD = "root";
	/**
	 * 声明JDBC的相关对象
	 */
	protected static Statement s = null;
	protected static ResultSet rs = null;
	protected static Connection conn = null;

	/**
	 * 创建数据库连接
	 * 
	 * @return conn
	 */
	public static synchronized Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;
	}

	/**
	 * 执行INSERT、UPDATE、DELETE语句
	 * 
	 * @param sql
	 *            SQL语句，字符串类型
	 * @return 执行结果，int类型
	 */
	public static int executeUpdate(String sql) {
		int result = 0;
		try {
			s = getConnection().createStatement();
			result = s.executeUpdate(sql);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 执行SELECT语句
	 * 
	 * @param sql
	 *            SQL语句，字符串类型
	 * @return ResultSet结果集
	 */
	public static ResultSet executeQuery(String sql) {
		try {
			s = getConnection().createStatement();
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return rs;
	}

	/**
	 * 执行动态SQL语句
	 * 
	 * @param sql
	 *            含有参数的动态SQL语句
	 * @return 返回PreparedStatement对象
	 */
	public static PreparedStatement executePreparedStatement(String sql) {
		PreparedStatement ps = null;
		try {
			ps = getConnection().prepareStatement(sql);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return ps;
	}

	/**
	 * 事务回滚
	 */
	public static void rollback() {
		try {
			getConnection().rollback();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	/**
	 * 关闭数据库连接对象
	 */
	public static void close() {
		try {
			if (rs != null)
				rs.close();
			if (s != null)
				s.close();
			if (conn != null)
				conn.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
