package Service;

import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.net.*;
import DatabaseUtil.DBUtil;

public class AdminChangePW extends HttpServlet{
	public AdminChangePW() {
		super();
	}
	public void destroy() {
		super.destroy();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String adminName = request.getParameter("adminName");
		String adminPassword = request.getParameter("adminPassword");
		String adminNewPassword = request.getParameter("adminNewPassword");
		String adminConfirmPassword = request.getParameter("adminConfirmPassword");
		
		if(adminNewPassword.compareTo(adminConfirmPassword) != 0) {
			response.sendRedirect("../ChangeFailDisaccord.jsp");
		}
		else {
			DBUtil dbu = new DBUtil();
			Connection conn = null;
			ResultSet rs = null;
			conn = dbu.getConnection();
			String sql = "select count(*) as rowCount from user where username=" + "\"" + adminName + "\"" + "and password=" + "\"" + adminPassword + "\"";
			if(conn != null) {
				rs = dbu.executeQuery(sql);
			}
			try {
				//System.out.println(rs);
				rs.next();
				int rowCount = rs.getInt("rowCount");
				//System.out.println(rowCount);
				if(rowCount != 1) {
					response.sendRedirect("../ChangeFailWaPassword.jsp");
				}
				else {
					sql = "update user set password=" + "\"" + adminNewPassword + "\"" + " where username=" + "\"" + adminName + "\""  + " and password=" + "\"" + adminPassword +  "\";";
					//System.out.println(sql);
					int ans = dbu.executeUpdate(sql);
					if(ans == 1) {
						Cookie[] cookies = request.getCookies();
						for(int i = 0; i < cookies.length; i++) {
							String name = cookies[i].getName();
							if(name.equals("adminName")) {
								cookies[i].setMaxAge(0); 
								cookies[i].setPath("/");
								response.addCookie(cookies[i]);
								//System.out.println("找到了");
								break;
							}
						}
						response.sendRedirect("../ChangeSuccess.jsp");
					}
					else {
						response.sendRedirect("../ChangeFail.jsp");
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			dbu.close();
		}
	}
}
