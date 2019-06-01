<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>退出登录</title>
</head>
<body>
<%
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
%>
	<center>
		<h4>&nbsp;&nbsp;&nbsp;退出登录成功！</h4>
		<a href="index.jsp">点击回到首页</a>
	</center>
</body>
</html>