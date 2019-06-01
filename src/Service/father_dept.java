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

public class father_dept extends HttpServlet {

	public father_dept() {
		super();
	}
	
	public void destroy() {
		super.destroy();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        
         try { 
             
        	 	DBUtil dbu = new DBUtil();
     		Connection conn = null;
     		ResultSet rs = null;
     		conn = dbu.getConnection();
     		String sql = "select * from department where father_id=0";
     		rs = dbu.executeQuery(sql);
            JSONArray jsonarray = new JSONArray();  
            JSONObject jsonobj = new JSONObject(); 
            
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
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
          
}
