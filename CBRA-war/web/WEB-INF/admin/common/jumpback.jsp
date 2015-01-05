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
        <link rel="stylesheet" href="${pageContent.request.contextPath}/background/css/style.css" type="text/css" />
        <link rel="stylesheet" href="${pageContent.request.contextPath}/background/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
        <link rel="stylesheet" href="${pageContent.request.contextPath}/background/js/validate/tip-green/tip-green.css" type="text/css" />
        <script type="text/javascript" src="${pageContent.request.contextPath}/background/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContent.request.contextPath}/background/js/validate/jquery.poshytip.js"></script>
        <script type="text/javascript" src="${pageContent.request.contextPath}/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="${pageContent.request.contextPath}/background/js/common/common.js"></script>
        <script type="text/javascript">
            try {
                alert("${postResult.singleSuccessMsg}");
            <c:if test = "${reflashTreeFrameUrl != null}" >
                parent.parent.treeFrame.location.href = "${reflashTreeFrameUrl}";
            </c:if>
                parent.window.location.href = "${postResult.redirectUrl}";
            } catch (e) {
            }
            ;
        </script>
    </head>
    <body>
    </body>
</html>

