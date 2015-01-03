<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	/**
	 * Copyright (c) 2010 Changchun Boan (BOAN) Co. Ltd.
	 * All right reserved.
	 */
	/**
	 * @author XXX
	 * @version 1.0
	 * @audit  
	 */
	/**
	 * Modified Person：
	 * Modified Time：
	 * Modified Explain：
	 */
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "0");
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>信息提示页</title>
	<link rel="stylesheet" href="${pageContent.request.contextPath}/admin/css/style.css" type="text/css" />
	<link rel="stylesheet" href="${pageContent.request.contextPath}/admin/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
	<link rel="stylesheet" href="${pageContent.request.contextPath}/admin/js/validate/tip-green/tip-green.css" type="text/css" />
	<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/validate/jquery.poshytip.js"></script>
	<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/validate/jquery.validate.js"></script>
	<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/common/common.js"></script>
    <script type="text/javascript">
		try{
			//$(".tip").fadeOut(200);
			alert("${message.content}");
			parent.window.location.href="${message.targetUrl}";
			<s:if test="message.reflashTreeFrameUrl != null">
				$(window.top.frames["treeFrame"]).attr("src","${message.reflashTreeFrameUrl}");
				$(window.top.frames["treeFrame"]).reload();
			</s:if>
		}catch(e){};
	</script>
  </head>
  <body>
	<div class="rightinfo">
	 	<div class="tip">
			<div class="tiptop"><span>提示信息</span><a></a></div>
			<div class="tipinfo">
				<span><img src="/images/ticon.png" /></span>
			<div class="tipright">
				<p>是否确认对信息的修改 ？</p>
				<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
			</div>
		</div>
		<div class="tipbtn">
			<input name="" type="button"  class="sure" value="确定" />
		</div>
	</div>
  </body>
</html>

