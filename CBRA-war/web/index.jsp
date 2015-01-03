<%-- 
    Document   : index
    Created on : Apr 14, 2011, 6:35:39 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/public/index");
    requestDispatcher.forward(request, response);
%>