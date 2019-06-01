package Service;

import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.net.*;
import DatabaseUtil.DBUtil;

public class AdminLoginCheck extends HttpServlet {
	public AdminLoginCheck () {
		super();
	}
	public void destroy() {
		super.destroy();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String adminName = request.getParameter("adminName");
		String adminPassword = request.getParameter("adminPassword");
		//System.out.println(adminName);
		//System.out.println(adminPassword);
		
		DBUtil dbu = new DBUtil();
		Connection conn = null;
		ResultSet rs = null;
		boolean if_pass = false;
		conn = dbu.getConnection();
		String sql = "select * from user where username=" + "\"" + adminName + "\"" + "and password=" + "\"" + adminPassword + "\"";
		
		if (conn != null) {
			rs = dbu.executeQuery(sql);
		}
		try {
			if (rs != null) {
				if_pass = rs.next();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		dbu.close();
		
		if (if_pass) {
			//System.out.println("登录成功！");
			Cookie name = new Cookie("adminName", adminName);
			name.setMaxAge(60*60*12);
			name.setPath("/"); //加上这句话，jsp才能拿到cookie，for what???
			response.addCookie(name);
			response.sendRedirect("../AdminMain.jsp");
		} else {
			//System.out.println("登录失败！");
			response.sendRedirect("../LoginFail.jsp");
		}
	}
}
