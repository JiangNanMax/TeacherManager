<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>管理员登录</title>
    <link rel="stylesheet" href="css/public.css">
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
<div class="header_wrap">
    <div id="header" class="auto">
        <div class="logo">校内教师名录</div>
        <div class="nav">
	        <a href="index.jsp">首页</a>
	    </div>
    </div>
</div>
<div class="place-holder"></div>
<div id="register" class="auto">
    <h2>欢迎登录!</h2>
    <form method="post" action="Service/AdminLoginCheck" >
        <label>用户名：<input name="adminName" type="text"></label>
        <label>密码：<input name="adminPassword" type="password"></label>
        <div style="clear:both;"></div>
        <input type="submit" class="btn" value="登录">
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