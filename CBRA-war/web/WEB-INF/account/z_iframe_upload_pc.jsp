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
                if (${postResult.success}) {
                    var type = "${postResult.singleSuccessMsg}";
                    $("#reg_" + type + "_div", parent.document).parent("div").css("height", "250px");
                    $("#reg_" + type + "_div", parent.document).hide();
                    $("#reg_" + type + "_img", parent.document).attr("src", "${postResult.redirectUrl}");
                    $("#reg_" + type + "_img", parent.document).show();
                    $("#reg_" + type + "_result", parent.document).css("color", "");
                    $("#reg_" + type + "_result", parent.document).html("${postResult.object}");
                    setTimeout(function () {
                        $("#reg_" + type + "_result", parent.document).html("");
                    }, 3000);
                    $("#" + type + "_hidden", parent.document).val("${postResult.redirectUrl}");
                } else {
                    var type = "${postResult.singleErrorMsg}";
                    $("#reg_" + type + "_result", parent.document).css("color", "red");
                    $("#reg_" + type + "_result", parent.document).html("${postResult.object}");
                    setTimeout(function () {
                        $("#reg_" + type + "_result", parent.document).html("");
                        $("#reg_" + type + "_result", parent.document).css("color", "");
                    }, 3000);
                }
            } catch (e) {
            }
            ;
        </script>
    </head>
    <body>
    </body>
</html>