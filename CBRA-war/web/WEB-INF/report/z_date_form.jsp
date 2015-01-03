<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_date_form
    Created on : May 18, 2011, 1:45:19 PM
    Author     : chenjianlin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
    if (request.getAttribute("endDate") == null && request.getAttribute("startDate") == null) {
        request.setAttribute("startDate", new Date());
        request.setAttribute("endDate", new Date());
    }
    if (request.getAttribute("startDate") != null && request.getAttribute("endDate") == null) {
        request.setAttribute("endDate", request.getAttribute("startDate"));
    }
    if (request.getAttribute("startDate") == null && request.getAttribute("endDate") != null) {
        request.setAttribute("startDate", request.getAttribute("endDate"));
    }
%>

<!DOCTYPE html>
<link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
<form action="${param.action}" method="post">
    <div class="search bold" ><span>${param.title}</span>
        <input type="hidden" name="a" value="${param.a}"/>
        <input type="text" class="Input200" id="startDate"name="start" value="<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>"/>   到 <input type="text" id="endDate"name="end" class="Input200" value="<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>"/> 
        <input type="submit" value="确定" class="button"/></div>
</form>
<form id="search_form" action="${param.action}" method="POST">
    <input type="hidden" id="page_num" name="page" value="1"/>
    <input type="hidden" id="a" name="a" value="${param.a}"/>
    <input type="hidden" id="start" name="start" value="<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>"/>
    <input type="hidden" id="end" name="end" value="<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>"/>
</form>

<script>
    $( "#startDate" ).datepicker();
    $( "#startDate" ).datepicker("option", "dateFormat", "yy-mm-dd");
    $( "#endDate" ).datepicker();
    $( "#endDate" ).datepicker("option", "dateFormat", "yy-mm-dd");
    $( "#startDate" ).val($('#start').val());
    $( "#endDate" ).val($('#end').val());
</script>