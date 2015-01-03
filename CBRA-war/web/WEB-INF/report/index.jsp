<%-- 
    Document   : index
    Created on : Jul 11, 2012, 1:07:14 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/report/z_header.jsp"%>

<div id="admin">
    <div style="background: none; padding:100px; text-align: center">
        <h1>
            欢迎您的登录！</h1></div>
</div>

<jsp:include page="/WEB-INF/report/z_footer.jsp"/>
