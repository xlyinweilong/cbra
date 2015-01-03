<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_menu
    Created on : Jul 11, 2012, 1:07:14 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
</head>
<style type="text/css" >
    body{text-align: center;padding:0px;margin:0px;}
    .nolist{ padding:10px;font-size:16px;text-align:center;color:#A75C25;}
    table{ border-collapse:collapse; text-align: center; }
    .content{margin-top: 30px}
    .vPagging{ margin-top: 30px}
    .vPagging a { border: #eee 1px solid; margin:2px; line-height:21px; background-color:#fff; padding: 2px 5px; color:#036cb4; text-decoration:none; font-weight:100; font-size:12px}
    .vPagging a:hover {border:#036cb4 1px solid; color:#fff; background-color:#036cb4; font-weight:100;}
    .vPagging a.curp{border:#036cb4 1px solid;}
    .admin-nav{background: none repeat scroll 0 0 #DEF1FE;height: 30px;line-height:30px;}
    .admin-nav span{display: block;height: 30px;line-height:30px;}
    .admin-nav span a:link,.admin-nav span a:visited{color:#686868;text-decoration:none ;}
    .admin-nav span a:hover,.admin-nav span a:active{color:#686868;text-decoration:underline;}
    .exit{text-align: right;margin:10px 40px 10px 0px;}
    .exit a:link,.exit a:visited{color:#57913C;text-decoration: none;}
    .exit a:hover,.exit a:active{color:#57913C;text-decoration: underline;}
</style>
<div class="admin-nav">
    <span>
        <c:if test="${reportAccountPermit.statsReportPermit}">
            <a href="/report/sta" >综合统计报表</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${reportAccountPermit.salesReportPermit}">
            <a href="/report/sales_report" >销售统计报表</a>&nbsp;|&nbsp;
        </c:if>
        <a href="/report/repassword">账户管理</a>
    </span>
</div>
<div class="exit">
    &nbsp;&nbsp;&nbsp;<a href="/report/logout">退出</a>
</div>
<div class="clear"></div>