<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DatabaseUtil.DBUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>首页</title>
    
    <link rel="stylesheet" type="text/css" href="bootstrap/style.css">
    <link rel="stylesheet" type="text/css" href="bootstrap/bootstrap.min.css">
    
    <link rel="stylesheet" href="css/public.css">
    <link rel="stylesheet" href="css/index.css">
    
    <script src="bootstrap/jquery.min(1).js"></script>
    <script src="bootstrap/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="bootstrap/bootbox.min.js"></script>
    
</head>
<body>
<div class="header_wrap">
    <div id="header" class="auto">
        <div class="logo">校内教师名录</div>
		<%
			boolean is_login = false;
			Cookie[] cookies = request.getCookies();
			String name_in_cookie = new String("");
			for(Cookie i : cookies) {
				if((i.getName( )).compareTo("adminName") == 0 ){
					is_login = true;
					name_in_cookie = i.getValue( );
					break ;
		        	}
			}
			//System.out.println(is_login);
			if(is_login == false) {
		%>
		        <div class="login">
		            <a href="AdminLogin.jsp">管理员登录</a>
		        </div>
        <%} else { %>
        			<div class="nav">
	                <a class="hover" >首页</a>
	                <a href="AdminMain.jsp">管理页</a>
	                <div id="my_username">
	                    <a id="adminname" href="AdminInfo.jsp"><% out.print(name_in_cookie); %></a>
	                    <a style="width: 5px;cursor:auto;text-decoration: none;">|&nbsp;</a>
	                    <a id="logout" href="AdminLogout.jsp">退出</a>
	                </div>
	            </div>
        <%} %>
    </div>
</div>
<div class="place-holder"></div>


<div class="box">
    <div class="content">
        <!--搜索输入框及查询、重置按钮-->
        <div class="container content_width">
            <div class="person_search">
                <div class="search_input">
                    <div class="input-group mb-3">
                        <span>姓名：</span>
                        <input id="Ktext" type="text" class="form-control" placeholder="请输入姓名">
                    </div>
                </div>
                <div class="search_input">
                    <button class="btn btn-primary search_btn" type="button" id="search_btn">查询</button>
                    <button class="btn btn-primary search_btn" type="button" id="back_btn">重置</button>
                </div>
            </div>
            <div class="line"></div>
        </div>
        <!--表格列表-->
        <table id="tb" class="table">
            <thead>
	            <tr>
	                <th>学院名</th>
	                <th>系名</th>
	                <th>教师姓名</th>
	                <th>职称</th>
	                <th>办公电话号码</th>
	                <th>办公地址</th>
	                <th>电子邮件</th>
	            </tr>
            </thead>
            <tbody id="show_tbody">
        		<%
				DBUtil dbu = new DBUtil();
	        		Connection conn = null;
	        		ResultSet rs = null;
	        		conn = dbu.getConnection();
	        		String sql = "select d2.dept_name as d2name,d1.dept_name as d1name,t.teacher_name,t.teacher_title,t.teacher_tel,t.teacher_address,t.teacher_email from teacher t join department d1 on t.teacher_dept_id=d1.dept_id join department d2 on d1.father_id=d2.dept_id";
	        		if(conn != null) {
	        			rs = dbu.executeQuery(sql);
	        		}
	        		try {
	        			if(rs != null) {
	        				while(rs.next()) {
	        	%>
	        		<tr>
	                <td><% out.print(rs.getString("d2name")); %></td>
	                <td><% out.print(rs.getString("d1name")); %></td>
	                <td><% out.print(rs.getString("teacher_name")); %></td>
	                <td><% out.print(rs.getString("teacher_title")); %></td>
	                <td><% out.print(rs.getString("teacher_tel")); %></td>
	                <td><% out.print(rs.getString("teacher_address")); %></td>
	                <td><% out.print(rs.getString("teacher_email")); %></td>
	            	</tr>
	        	<%
	        				}
	        			}
	        		} catch(Exception e) {
	        			e.printStackTrace();
	        		}
	        		dbu.close();
	      	%>
	            
            </tbody>
        </table>
    </div>
</div>


<div id="footer" class="auto">
    <div class="bottom">
        <a href="index.jsp">校内教师名录</a>
    </div>
    <div class="copyright">Powered by JiangNanMax ©2019</div>
</div>

<script src="bootstrap/mejs.js"></script>

</body>
</html>