<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>管理员信息</title>
    <link rel="stylesheet" href="css/public.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
<%
	boolean is_login = false;
	String name_in_cookie = new String("");
	Cookie[] cookies = request.getCookies();
	for(Cookie i : cookies) {
		if((i.getName( )).compareTo("adminName") == 0 ){
			is_login = true;
			name_in_cookie = i.getValue( );
			break ;
        	}
	}
	if(is_login == false) {
%>
<script>
	window.location.href="Error.jsp";
</script>
<%} %>

<div class="header_wrap">
    <div id="header" class="auto">
        <div class="logo">校内教师名录</div>
        
        		<div class="nav">
                <a href="index.jsp">首页</a>
                <a href="AdminMain.jsp" >管理页</a>
            </div>
            
			<div class="username">
				<a href="AdminLogout.jsp">退出</a>
				<a style="cursor:auto;text-decoration: none;">&nbsp;|&nbsp;</a>
				<a href="AdminInfo.jsp"><% out.print(name_in_cookie); %></a>
			</div>
    </div>
</div>
<div class="place-holder"></div>

<div id="register" class="auto">
    <h2>管理员信息</h2>
    <form method="post" action="Service/AdminChangePW" >
    		<label>用户名：<input name="adminName" type="text" readonly="value" <% out.print("value=\"" + name_in_cookie + "\""); %>></label>
        <label>旧密码：<input name="adminPassword" type="password"></label>
        <label>新密码：<input name="adminNewPassword" type="password"></label>
        <label>确认密码：<input name="adminConfirmPassword" type="password"></label>
        <div style="clear:both;"></div>
        <input type="submit" class="btn" value="修改">
    </form>
</div>

<div id="footer" class="auto">
    <div class="bottom">
        <a href="index.jsp">校内教师名录</a>
    </div>
    <div class="copyright">Powered by JiangNanMax ©2019</div>
</div>
</body>
</html>