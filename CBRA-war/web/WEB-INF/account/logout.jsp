<%-- 
    Document   : logout
    Created on : Mar 31, 2011, 9:02:46 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("/public/index");
%>
