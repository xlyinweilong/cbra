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
    <link rel="stylesheet" href="${pageContent.request.contextPath}/css/style.css" type="text/css" />
	<link rel="stylesheet" href="${pageContent.request.contextPath}/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
	<link rel="stylesheet" href="${pageContent.request.contextPath}/js/validate/tip-green/tip-green.css" type="text/css" />
	<script type="text/javascript" src="${pageContent.request.contextPath}/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContent.request.contextPath}/js/validate/jquery.poshytip.js"></script>
	<script type="text/javascript" src="${pageContent.request.contextPath}/js/validate/jquery.validate.js"></script>
	<script type="text/javascript" src="${pageContent.request.contextPath}/js/common/common.js"></script>
  </head>
  <body>
  </body>
</html>
<script type="text/javascript">
	alert('${message.content}');
</script>
