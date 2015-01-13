<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<%-- 设置语言要在输出任何response之前 --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>
            <c:choose>
                <c:when test="${empty param.PAGE_HEADER_TITLE}">
                    <fmt:message key="GLOBAL_HEADER_TITLE" bundle="${bundle}"/>
                </c:when>
                <c:otherwise>
                    ${param.PAGE_HEADER_TITLE}
                </c:otherwise>
            </c:choose>
        </title> 
        <meta name="keywords" content="Yoopay Event China Management Registration Payment Eventbrite Amiando Paypal Wepay China UnionPay Alipay 活动 会议 发布 推广 票务 报名 收款 银联 支付宝 网银 国际 信用卡"/> 
        <meta name="description" content="友付 是会议及活动的线上报名、推广、票务、收款一站式平台。20,000多个会议及活动，在使用友付，包括大型国内及国际行业会议会展、企业内部培训、经销商、供应商会议，及各种社交、聚会、文体、培训、演出活动。Yoopay is China's first event online management platform for event publishing, promotion, registration, and ticketing. Event organizers can also collect payments online in advance easily with dual currencies (RMB/USD) and dual languages (Chinese/English) via China Union Pay, Alipay, Visa, Mastercard, and Paypal. More than 20,000 domestic and international events, including conferences, exihibitions, forums, corporate and social events are using Yoopay for their events in China."/> 
        <link rel="shortcut icon" href="/favicon.ico" /> 
        <%-- 在正式DEPLOY时，所有CSS和JAVASCRIPT文件，都需要设置BROWSWER SIDE CACHE，并且在登录前各页面做预加载。 --%>
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>	
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <!--[if IE]><script src="/scripts/excanvas.compiled.js" type="text/javascript"></script><![endif]-->
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
    </head>
    <body>

