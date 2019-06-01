package Service;

import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.net.*;
import DatabaseUtil.DBUtil;

public class AdminAdd extends HttpServlet {
	
	public AdminAdd() {
		super();
	}
	
	public void destroy() {
		super.destroy();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String d1name = request.getParameter("d1name");
		String teacher_name = request.getParameter("teacher_name");
		String teacher_title = request.getParameter("teacher_title");
		String teacher_tel = request.getParameter("teacher_tel");
		String teacher_address = request.getParameter("teacher_address");
		String teacher_email = request.getParameter("teacher_email");
		
		/*
		System.out.println(d1name);
		System.out.println(teacher_name);
		System.out.println(teacher_title);
		System.out.println(teacher_tel);
		System.out.println(teacher_address);
		System.out.println(teacher_email);
		*/
		
		//select dept_id from department where dept_name="计算机科学技术系";
		//insert into teacher(teacher_name,teacher_dept_id,teacher_title,teacher_tel,teacher_address,teacher_eamil) values("江南",2,"助教","18918020032","五舍304","jiangnanmax@gmail.com");
		DBUtil dbu = new DBUtil();
		Connection conn = null;
		ResultSet rs = null;
		conn = dbu.getConnection();
		String sql = "select dept_id from department where dept_name=" + "\"" + d1name + "\"";
		String dept_id = "";
		if (conn != null) {
			rs = dbu.executeQuery(sql);
		}
		try {
			while(rs.next()) {
				dept_id = rs.getString("dept_id");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		//System.out.println(dept_id);
		sql = "insert into teacher(teacher_name,teacher_dept_id,teacher_title,teacher_tel,teacher_address,teacher_email) values(" + "\"" + teacher_name + "\"," + dept_id + ",\"" + teacher_title + "\"," + "\"" + teacher_tel + "\"," + "\"" + teacher_address + "\"," + "\"" + teacher_email + "\")";
		//System.out.println(sql);
		if (conn != null) {
			dbu.executeUpdate(sql);
		}
		dbu.close();
	}
}
