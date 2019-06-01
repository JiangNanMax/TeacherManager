package Service;

import java.sql.*;
import DatabaseUtil.DBUtil;

public class test {

	public static void main(String[] args) {
		DBUtil dbu = new DBUtil();
		Connection conn = null;
		ResultSet rs = null;
		conn = dbu.getConnection();
		String sql = "select d2.dept_name as d2name,d1.dept_name as d1name,t.teacher_name,t.teacher_title,t.teacher_tel,t.teacher_address,t.teacher_email from teacher t join department d1 on t.teacher_dept_id=d1.dept_id join department d2 on d1.father_id=d2.dept_id";
		//System.out.println(sql);
		if(conn != null) {
			rs = dbu.executeQuery(sql);
		}
		try {
			if(rs != null) {
				while(rs.next()) {
					System.out.print(rs.getString("d2name"));
					System.out.print(" ");
					System.out.print(rs.getString("d1name"));
					System.out.print(" ");
					System.out.print(rs.getString("teacher_name"));
					System.out.print(" ");
					System.out.print(rs.getString("teacher_title"));
					System.out.print(" ");
					System.out.print(rs.getString("teacher_tel"));
					System.out.print(" ");
					System.out.print(rs.getString("teacher_address"));
					System.out.print(" ");
					System.out.print(rs.getString("teacher_email"));
					System.out.println();
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		dbu.close();
	}

}
