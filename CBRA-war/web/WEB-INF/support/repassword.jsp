<%-- 
    Document   : repassword
    Created on : Jul 11, 2012, 4:57:44 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>
<div>
    <span style="color: red">${postResult.singleErrorMsg}</span>
    <span>${postResult.singleSuccessMsg}</span>
    <form action="/support/repassword" method="POST">
        <input type="hidden" name="a" value="repassword"/>
        <span>原密码：</span><input type="password" name="oldpassword"/><br>
        <span>新密码：</span><input type="password" name="newpassword"/><br/>
        <span>重复密码：</span><input type="password" name="repeatpassword"/><br/>
        <input type="submit" value="确定"/>
    </form>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
