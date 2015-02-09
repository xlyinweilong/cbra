<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
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
        <script type="text/javascript" src="${pageContent.request.contextPath}/background/js/jquery.js"></script>
        <script type="text/javascript">
            try {
                alert("${postResult.singleSuccessMsg}");
            } catch (e) {
            }
            ;
        </script>
    </head>
    <body>
    </body>
</html>

