package Service;

import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.net.*;
import DatabaseUtil.DBUtil;

import java.io.PrintWriter;
import org.json.JSONArray;
import org.json.JSONObject;

public class son_dept extends HttpServlet {
	public son_dept() {
		super();
	}
	
	public void destroy() {
		super.destroy();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        String father_dept = request.getParameter("father_dept");
        
        
         try { 
        	 	DBUtil dbu = new DBUtil();
     		Connection conn = null;
     		ResultSet rs = null;
     		conn = dbu.getConnection();
     		String sql = "select * from department where dept_name=" + "\"" +father_dept+ "\"";
     		rs = dbu.executeQuery(sql);
            JSONArray jsonarray = new JSONArray();  
            JSONObject jsonobj = new JSONObject(); 
            
            String father_id = "";
            while(rs.next()) {
            		father_id = rs.getString("dept_id");
            }
            
            sql = "select * from department where father_id=" + father_id;
     		rs = dbu.executeQuery(sql);
            int i = 0;
            while(rs.next()) {
            		String tmp = String.valueOf(i);
                jsonobj.put(tmp, rs.getString("dept_name"));   
                i++;
            }
            jsonarray.put(jsonobj);
            
            out = response.getWriter();
            
            out.println(jsonarray);
            
            dbu.close(); 
            
            	
         }catch (Exception e) { 
              out.print("get data error!"); 
              e.printStackTrace(); 
         }
         
      }
	
	
}
