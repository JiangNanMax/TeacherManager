package Service;

import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.net.*;
import DatabaseUtil.DBUtil;

public class AdminUpdate extends HttpServlet {
	
	public AdminUpdate() {
		super();
	}
	
	public void destroy() {
		super.destroy();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tea_id = request.getParameter("tea_id");
		String d1name = request.getParameter("d1name");
		String teacher_name = request.getParameter("teacher_name");
		String teacher_title = request.getParameter("teacher_title");
		String teacher_tel = request.getParameter("teacher_tel");
		String teacher_address = request.getParameter("teacher_address");
		String teacher_email = request.getParameter("teacher_email");
		
		/*
		System.out.println(tea_id);
		System.out.println(d1name);
		System.out.println(teacher_name);
		System.out.println(teacher_title);
		System.out.println(teacher_tel);
		System.out.println(teacher_address);
		System.out.println(teacher_email);
		*/
		
		
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
		
		sql = "update teacher set teacher_name=" + "\"" + teacher_name + "\"," + "teacher_dept_id=" + "\"" + dept_id + "\"," + "teacher_title=" + "\"" + teacher_title + "\"," + "teacher_tel=" + "\"" + teacher_tel + "\"," + "teacher_address=" + "\"" + teacher_address + "\"," + "teacher_email=" + "\"" + teacher_email + "\"" + " where teacher_id=" + "\"" + tea_id + "\"";
		//System.out.println(sql);
		if (conn != null) {
			dbu.executeUpdate(sql);
		}
		
		dbu.close();
	}
}