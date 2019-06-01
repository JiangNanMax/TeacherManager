package DatabaseUtil;

import java.sql.*;

public class DBUtil {
	public String DBDRIVER = "com.mysql.jdbc.Driver";
	public String DBURL = "jdbc:mysql://localhost:3306/addresslist";
	public String DBUSER = "root";
	public String DBPASSWORD = "15359882050";
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	
	public DBUtil() {
		try {
			Class.forName(DBDRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("驱动加载失败！");
		}
	}
	
	public Connection getConnection() {
		try {
			conn = DriverManager.getConnection(DBURL,DBUSER,DBPASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("数据库连接失败！");
		}
		return conn;
	}
	
	public ResultSet executeQuery(String sql) {
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (rs == null ) {
			System.out.println("查询失败！");
		}
		return rs;
	}
	
	public int executeUpdate(String sql) {
		int ans = 0;
		try {
			stmt = conn.createStatement();
			ans = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("更新失败！");
			ans = 0;
		}
		return ans;
	}
	
	public void close() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
