<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<%-- 设置语言要在输出任何response之前 --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<title>筑誉建筑联合会</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Yoopay Event China Management Registration Payment Eventbrite Amiando Paypal Wepay China UnionPay Alipay 活动 会议 发布 推广 票务 报名 收款 银联 支付宝 网银 国际 信用卡"/> 
<meta name="description" content="友付 是会议及活动的线上报名、推广、票务、收款一站式平台。20,000多个会议及活动，在使用友付，包括大型国内及国际行业会议会展、企业内部培训、经销商、供应商会议，及各种社交、聚会、文体、培训、演出活动。Yoopay is China's first event online management platform for event publishing, promotion, registration, and ticketing. Event organizers can also collect payments online in advance easily with dual currencies (RMB/USD) and dual languages (Chinese/English) via China Union Pay, Alipay, Visa, Mastercard, and Paypal. More than 20,000 domestic and international events, including conferences, exihibitions, forums, corporate and social events are using Yoopay for their events in China."/> 
<link rel="shortcut icon" href="/favicon.ico" /> 
<link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
<link href="/css/master.css" rel="stylesheet" type="text/css"><!--top-->
<script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
<script type="text/javascript" src="/js/base.js"></script><!--导航 -->

