<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_header
    Created on : Aug 1, 2012, 5:00:01 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="cn.yoopay.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>友付Report系统</title> 

        <link rel="shortcut icon" href="/favicon.ico" /> 

        <link rel="stylesheet" type="text/css" href="/css/jquery.cleditor.css" />
        <link rel="stylesheet" type="text/css" href="/css/jquery.cleditor.css" />
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
        <link href="/css/style_admin.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery.bgiframe.js"></script>
        <script type="text/javascript" src="/scripts/jquery.bt.min.js" ></script>
        <script type="text/javascript" src="/scripts/jquery.cleditor.js"></script>
        <script type="text/javascript" src="/scripts/jquery.datepicker.local.cn.js"></script>
    </head>

    <body>
        <div class="head">
            <div class="head_inner ">
                <div class="logo" style="cursor: pointer" onclick="document.location.href='/account/overview'"></div>
                <div class="HeaderRight"><a href="/report/repassword">账户管理</a><span>|</span><a href="/report/logout">退出</a></div>
            </div>
        </div>

        <div class="nav">
            <ul id="nbaglobal" class="globalnav" >
                <c:if test="${reportAccountPermit.statsReportPermit}">
                    <li <c:if test="${mainMenuSelection eq 'STATS_REPORT'}">class="nowpage"</c:if>>
                        <a href="/report/sta" >综合统计报表</a>
                    </li>
                </c:if>
                <c:if test="${reportAccountPermit.regReportPermit}">
                    <li <c:if test="${mainMenuSelection eq 'REG_REPORT'}">class="nowpage"</c:if>>
                        <a href="/report/reg" >注册</a>
                    </li>
                </c:if>
                <c:if test="${reportAccountPermit.collectReportPermit}">
                    <li <c:if test="${mainMenuSelection eq 'COLLECT_REPORT'}">class="nowpage"</c:if>>
                        <a href="/report/collect" >收款</a>
                    </li>
                </c:if>
                <c:if test="${reportAccountPermit.salesReportPermit}">
                    <li <c:if test="${mainMenuSelection eq 'SALES_REPORT'}">class="nowpage"</c:if>>
                        <a href="/report/sales_report" >销售统计报表</a>
                    </li>
                </c:if>
                <c:if test="${reportAccountPermit.collectionPaymentQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'COLLECT_PAYMENT'}">class="nowpage"</c:if>>
                        <a href="/report/collect_payment" >收款到账报表</a>
                    </li>
                </c:if>
            </ul>

            <div class="clear"></div>
        </div>

        <div class="sub_nav">
            <div class="sub_nav_inner">
                <c:if test="${mainMenuSelection eq 'WITHDRAW'}">
                    <span  style="padding-left:320px" <c:if test="${subMenuSelection eq 'WITHDRAW_UN_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/report/un_processed_withdraw" >未处理提款请求查询</a></span>
                    <span>|</span>
                    <span <c:if test="${subMenuSelection eq 'WITHDRAW_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/report/processed_withdraw">已处理提款请求查询</a></span>
                </c:if>
                <c:if test="${mainMenuSelection eq 'SEAL'}">
                    <span style="padding-left:460px" <c:if test="${subMenuSelection eq 'SEAL_UN_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/report/un_processed_seal_list">未处理实名认证查询</a></span>
                    <span>|</span>
                    <span <c:if test="${subMenuSelection eq 'SEAL_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/report/processed_seal_list">已处理实名认证查询</a></span>
                </c:if>

            </div>
        </div>
        <div class="content">





