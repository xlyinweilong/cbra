<%@ page language="java" pageEncoding="UTF-8"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	response.setCharacterEncoding( "utf-8" );
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="<%=path %>/background/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=path %>/background/js/jquery.js"></script>
<script type="text/javascript">
$(function(){	
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
</script>
</head>
<body style="background:url(<%=path %>/background/images/topbg.gif) repeat-x;">
    <div class="topleft">
    	<a href="javascript:void(0);" target="_parent"><img src="<%=path %>/background/images/logo.png" title="系统首页"/></a>
    </div>
    <!-- 
    <ul class="nav">
	    <li><a href="default.html" target="rightFrame" class="selected"><img src="images/icon01.png" title="工作台" /><h2>工作台</h2></a></li>
	    <li><a href="imgtable.html" target="rightFrame"><img src="images/icon02.png" title="模型管理" /><h2>模型管理</h2></a></li>
	    <li><a href="imglist.html"  target="rightFrame"><img src="images/icon03.png" title="模块设计" /><h2>模块设计</h2></a></li>
	    <li><a href="tools.html"  target="rightFrame"><img src="images/icon04.png" title="常用工具" /><h2>常用工具</h2></a></li>
	    <li><a href="computer.html" target="rightFrame"><img src="images/icon05.png" title="文件管理" /><h2>文件管理</h2></a></li>
	    <li><a href="tab.html"  target="rightFrame"><img src="images/icon06.png" title="系统设置" /><h2>系统设置</h2></a></li>
    </ul>
     -->
    <div class="topright">    
	    <ul>
	    	<!-- 
		    <li><span><img src="<%=path %>/admin/images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
                    <li><a href="#">您的城市：</a></li>
	    	 -->
		    <li><a href="/admin/right" target="rightFrame">平台首页</a></li>
		    <li><a href="/admin/main?a=logout" target="_parent">退出</a></li>
	    </ul>
	    <div class="user">
		    <span>欢迎您，${admin.name}</span>
		    <!-- 
		    <i>消息</i>
		    <b>5</b>
		     -->
	    </div>    
    </div>
</body>
</html>
