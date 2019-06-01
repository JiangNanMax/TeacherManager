package Service;

import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.net.*;
import DatabaseUtil.DBUtil;

public class AdminDel  extends HttpServlet {
	public AdminDel() {
		super();
	}
	
	public void destroy() {
		super.destroy();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tea_id = request.getParameter("tea_id");
		DBUtil dbu = new DBUtil();
		Connection conn = null;
		conn = dbu.getConnection();
		String sql = "delete from teacher where teacher_id=" + "\"" + tea_id + "\"";
		if (conn != null) {
			dbu.executeUpdate(sql);
		}
		dbu.close();
	}
}
