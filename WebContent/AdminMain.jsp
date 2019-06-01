<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DatabaseUtil.DBUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>管理页</title>
    
    <link rel="stylesheet" type="text/css" href="bootstrap/style.css">
    <link rel="stylesheet" type="text/css" href="bootstrap/bootstrap.min.css">
    
    <link rel="stylesheet" href="css/public.css">
    <link rel="stylesheet" href="css/index.css">
    
    <script src="bootstrap/jquery.min(1).js"></script>
    <script src="bootstrap/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="bootstrap/bootbox.min.js"></script>
    
    <script>
        $(document).ready(function () {
            $.ajax({
                type: "get",
                url: "Service/father_dept",
                data: {},
                dataType: "json",
                success: function (data) {
                    //$("#select_1").html("<option value=''>请选择省份</option>");
	                	//console.log(data[0].length);
	                	var len = 0;
	                	for(key in data[0]) {
	                		len++;
	                	}
	                	//$("#select_1").append("<option selected='selected'>" + data[0][0] + "</option>");
	                	$("#select_1").html("<option>--- 请选择学院 ---</option>");
	                	for(var i=0;i<len;i++) {
	                		$("#select_1").append("<option>" + data[0][i] + "</option>");
	                	}
	                	//$("#select_1").append("<option selected='selected'>" + data[0][len-1] + "</option>");
                }
            });
            
            //console.log($("#select_1").val());
            
            $("#select_1").change(function () {
            		//console.log($("#select_1").val());
            		var father_dept = $("#select_1").val();
            		$("#select_2").empty();
            		$.ajax({
                    type: "Post",
                    url: "Service/son_dept",
                    data: {"father_dept": father_dept},
                    dataType: "json",
                    success: function (data) {
                        //$("#select_1").html("<option value=''>请选择省份</option>");
    	                		//console.log(data[0].length);
        	                	var len = 0;
        	                	for(key in data[0]) {
        	                		len++;
        	                	}
        	                	
        	                	console.log(data);
        	                	
        	                	for(var i=0;i<len;i++) {
        	                		$("#select_2").append("<option>" + data[0][i] + "</option>");
        	                	}
                    }
                });
            });
            
            
            
        });
    </script>
    
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
            <a class="hover">管理页</a>
            <div id="my_username">
                <a id="adminname" href="AdminInfo.jsp"><% out.print(name_in_cookie); %></a>
                <a style="width: 5px;cursor:auto;text-decoration: none;">|&nbsp;</a>
                <a id="logout" href="AdminLogout.jsp">退出</a>
            </div>
        </div>
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
        
        <div class="export">
            <button id="new_add" type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#renyuan">
                <img src="bootstrap/add_two.png">
                <span>添加</span>
            </button>
            <div class="modal fade" id="renyuan" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-lg modal_position">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">添加</h4>
                            <button type="button" class="close" data-dismiss="modal">×</button>
                        </div>
                        <div class="modal-body">
                            <table id="xztb" class="table">
                                <!--新修改弹窗的样式-->
                                <tbody>
                                    <tr>
                                        <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;">*</font>教师姓名</label></td>
                                        <td><input class="teacherName" type="text" placeholder="请输入姓名"></td>
                                        <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;">*</font>职称</label></td>
                                        <td><input class="teacherTitle" type="text" placeholder="请输入职称"></td>
                                    </tr>
                                    <tr>
                                        <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;">*</font>办公电话号码</label></td>
                                        <td><input class="phoneNum" type="text" placeholder="请输入电话号码"></td>
                                        <td class="tb_bg"><label for="">办公地址</label></td>
                                        <td><input class="Address" type="text" placeholder="请输入办公地址"></td>
                                    </tr>
                                    <tr>
                                        <td class="tb_bg"><label for="">电子邮件</label></td>
                                        <td><input class="Email" type="text" placeholder="请输入电子邮件"></td>
                                    </tr>
                                    <tr>
                                        <td class="tb_bg"><label for="">所属学院</label></td>
                                        <td>
                                            <select id="select_1" class="form-control select_down" style="font-size: 13px; color: #666;">
                                                
                                            </select>
                                        </td>
                                        <td class="tb_bg"><label for="">所属系别</label></td>
                                        <td>
                                            <select id="select_2" class="form-control select_down" style="font-size: 13px; color: #666;">
                                                
                                            </select>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                            <button id="add_btn" type="button" class="btn btn-secondary">确定</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
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
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="show_tbody">
        		<%
				DBUtil dbu = new DBUtil();
	        		Connection conn = null;
	        		ResultSet rs = null;
	        		conn = dbu.getConnection();
	        		String sql = "select d2.dept_name as d2name,d1.dept_name as d1name,t.teacher_id,t.teacher_name,t.teacher_title,t.teacher_tel,t.teacher_address,t.teacher_email from teacher t join department d1 on t.teacher_dept_id=d1.dept_id join department d2 on d1.father_id=d2.dept_id";
	        		if(conn != null) {
	        			rs = dbu.executeQuery(sql);
	        		}
	        		try {
	        			if(rs != null) {
	        				while(rs.next()) {
	        	%>
	        		<tr tea_id=<% out.print(rs.getString("teacher_id")); %> tea_name=<% out.print(rs.getString("teacher_name")); %>>
	        			<td><% out.print(rs.getString("d2name")); %></td>
	                <td><% out.print(rs.getString("d1name")); %></td>
	                <td><% out.print(rs.getString("teacher_name")); %></td>
	                <td><% out.print(rs.getString("teacher_title")); %></td>
	                <td><% out.print(rs.getString("teacher_tel")); %></td>
	                <td><% out.print(rs.getString("teacher_address")); %></td>
	                <td><% out.print(rs.getString("teacher_email")); %></td>
	                <td>
	                    <a href="#" class="edit" style="cursor:pointer;">编辑</a>
	                    <a href="#" class="del" style="cursor:pointer;">删除</a>
	                </td>
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