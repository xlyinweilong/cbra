<%-- 
    Document   : z_header_widget
    Created on : Feb 6, 2012, 2:38:57 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="background:none">
    <head>    
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>
            <fmt:message key="GLOBAL_HEADER_TITLE" bundle="${bundle}"/>
        </title> 
        <meta name="keywords" content="友付 yoopay yoopay.cn 收款 活动 团体 捐款 转款 支付宝 银联 网银 贝宝 易宝 快钱 财付通 china event group donation payment unionpay alipay paypal visa mastercard american express amex yeepay 99bll tenpay "/> 
        <meta name="description" content="友付帮助用户轻松完成各种收款及转款需求，如：活动收款、团体收款、朋友转款、募捐；支持网银、支付宝、信用卡等多种支付方式和币种，并提供款项纪录和管理功能；"/> 
        <link rel="shortcut icon" href="/favicon.ico" /> 

        <%-- 在正式DEPLOY时，所有CSS和JAVASCRIPT文件，都需要设置BROWSWER SIDE CACHE，并且在登录前各页面做预加载。 --%>
        <link href="/css/style.css" rel="stylesheet" type="text/css" />
        <c:choose>
            <c:when test="${not empty sizeWidth && sizeWidth == 'small'}">
                <link href="/css/style_widget540.css" rel="stylesheet" type="text/css" />
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
       
        <c:choose>
            <c:when test="${not empty eventPaymentPage}">
                <c:choose>
                    <c:when test="${empty fundCollection.eventStyle}"><link href="/css/white.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_WHITE'}"><link href="/css/white.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_BLACK'}"><link href="/css/black.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_BLUE'}"><link href="/css/blue.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_GREEN'}"><link href="/css/green.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_PURPLE'}"><link href="/css/purple.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_SILVER'}"><link href="/css/silver.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:when test="${fundCollection.eventStyle=='CLASSIC_ORANGE'}"><link href="/css/orange.css" rel="stylesheet" type="text/css" /></c:when>
                    <c:otherwise><link href="${fundCollection.eventStyle}" rel="stylesheet" type="text/css" /></c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
            </c:otherwise>
        </c:choose>
       
        <fmt:message key='GLOBAL_LANGUAGE_SPECIFIC_CSS' bundle='${bundle}'/>
        <%--<link href="/css/style.min.css" rel="stylesheet" type="text/css" />--%>
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <script type="text/javascript" src="/scripts/yoopay.js"></script>

    </head>

    <body style="padding:0px;margin:0px;overflow: hidden; background: none">
