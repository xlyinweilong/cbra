<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_header
    Created on : Nov 14, 2012, 5:17:01 PM
    Author     : Yin.Weilong
--%>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="cn.yoopay.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>签到系统</title> 
        <meta name="keywords" content="Yoopay Event China Management Registration Payment Eventbrite Amiando Paypal Wepay China UnionPay Alipay 活动 会议 发布 推广 票务 报名 收款 银联 支付宝 网银 国际 信用卡"/> 
        <meta name="description" content="友付 是会议及活动的线上报名、推广、票务、收款一站式平台。20,000多个会议及活动，在使用友付，包括大型国内及国际行业会议会展、企业内部培训、经销商、供应商会议，及各种社交、聚会、文体、培训、演出活动。Yoopay is China's first event online management platform for event publishing, promotion, registration, and ticketing. Event organizers can also collect payments online in advance easily with dual currencies (RMB/USD) and dual languages (Chinese/English) via China Union Pay, Alipay, Visa, Mastercard, and Paypal. More than 20,000 domestic and international events, including conferences, exihibitions, forums, corporate and social events are using Yoopay for their events in China."/> 
        <link rel="shortcut icon" href="/favicon.ico" /> 
        <link rel="stylesheet" type="text/css" href="/css/jquery.cleditor.css" />
        <%-- 在正式DEPLOY时，所有CSS和JAVASCRIPT文件，都需要设置BROWSWER SIDE CACHE，并且在登录前各页面做预加载。 --%>
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
        <link href="/css/style_checkin.css" rel="stylesheet" type="text/css" />
        <fmt:message key='GLOBAL_LANGUAGE_SPECIFIC_CSS' bundle='${bundle}'/>
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery.bgiframe.js"></script>
        <script type="text/javascript" src="/scripts/jquery.bt.min.js" ></script>
        <script type="text/javascript" src="/scripts/jquery.uitablefilter.js" ></script>
        <script type="text/javascript" src="/scripts/jquery.highlight-4.closure.js" ></script>
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
        <script type="text/javascript" src="/scripts/jquery.cleditor.js"></script>
        <script type="text/javascript" src="/kindeditor-4.1.2/kindeditor.js"></script>
        <script type="text/javascript" src="/scripts/jquery.datepicker.local.cn.js"></script>
    </head>

    <body>
        <div class="head">
            <div class="head_inner ">
                <div class="logo" style="cursor: pointer" onclick="document.location.href='/account/overview'"></div>
                <div class="HeaderRight"><a href="/checkin/logout/${fundCollection.webId}">退出</a></div>
            </div>
        </div>

        <div class="nav">
            <ul id="nbaglobal" class="globalnav" >
                <li <c:if test="${mainMenuSelection eq 'AUTO_CHECKIN'}">class="nowpage"</c:if>>
                    <a href="/checkin/auto_checkin/${fundCollection.webId}" >自动签到</a>
                </li>
                <li <c:if test="${mainMenuSelection eq 'SEARCH'}">class="nowpage"</c:if>>
                    <a href="/checkin/search/${fundCollection.webId}" >查询</a>
                </li>
            </ul>

            <div class="clear"></div>
        </div>
        <div class="content">