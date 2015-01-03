<%-- 
    Document   : waiting_approval_result
    Created on : Aug 28, 2012, 4:26:34 PM
    Author     : Yin.Weilong
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${gatewayPaymentSource == 'SOURCE_WIDGET'}">
        <c:if test="${empty bundle}">
            <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
            <fmt:setBundle basename="message" scope="session" var="bundle"/>
        </c:if>
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
                <link href="/css/style.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                </c:when>
                <c:otherwise><jsp:include page="/WEB-INF/public/z_header.jsp"/></c:otherwise>
                </c:choose>
                <c:set var="useraccount" value="${orderCollectionSub.parentOrderCollection.owner}"></c:set>
                <c:set var="fundCollection" value="${orderCollectionSub.fundCollection}"></c:set>
                <div class="BlueBox" <c:if test="${gatewayPaymentSource == 'SOURCE_WIDGET'}">style="width: 540px;margin:0 auto;"</c:if>>
                    <div class="BlueBoxTitle">
                        <span class="FloatLeft"><fmt:message key="PAYMENT_DETAIL_TEXT_收款链接" bundle="${bundle}"/>：<a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</a></span>
                        <span class="FloatRight">
                            <fmt:message key="PAYMENT_DETAIL_TEXT_收款序列号" bundle="${bundle}"/>：${fundCollection.serialId}
                        </span>
                        <div class="clear"></div>
                    </div>
                    <div class="successMessage">
                        <div class="sucess_title">
                            <fmt:message key="PAYMENT_RESULT_TEXT_您的报名请求已提交，请等候主办方审批" bundle="${bundle}"/>
                        </div>
                    </div>
                    <div class="BlueBox_Gray">
                        <div class="BlueBoxContent826">
                            <div class="FloatLeft BlueBoxLeft">
                                <div class="Calendar">
                                    <p class="Month"><fmt:formatDate value="${fundCollection.eventBeginDate}" type="date" pattern="${eventMonthDayParseStyle}"/></p>
                                    <p class="Day">${eventWeekday}</p>
                                </div> 
                                <div>
                                    <c:if test="${fundCollection.ownerUser.sealVerified && fundCollection.ownerUser.accountType=='COMPANY'}">
                                        <a href="/company/${fundCollection.ownerUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                                    </c:if>
                                    <c:if test="${fundCollection.ownerUser.sealVerified && fundCollection.ownerUser.accountType=='USER'}">
                                        <a href="/user/${fundCollection.ownerUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                                    </c:if>
                                </div>
                            </div>
                            <div class="FloatLeft BlueBoxContent">
                                <div>
                                    <fmt:message key="COLLECT_EDIT_TEXT_活动时间" bundle="${bundle}"/>：
                                    ${eventDateDesc} 
                                </div>
                                <div>
                                    <label class="sk-label3 "><fmt:message key="COLLECT_EDIT_TEXT_活动地点" bundle="${bundle}"/>：</label>
                                    <c:choose>
                                        <c:when test="${not empty fundCollection.eventLocation}">
                                            ${fundCollection.eventLocation}
                                            <c:if test="${fundCollection.getEventMapUrl()!=null}">
                                                <a href="${fundCollection.getEventMapUrl()}" class="MarginL7" target="_blank"><fmt:message key="COLLECT_EDIT_TEXT_查看地图" bundle="${bundle}"/></a> 
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            &nbsp;
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <fmt:message key="COLLECT_EVENT_EDIT_TEXT_主办方" bundle="${bundle}"/>
                                    ：${fundCollection.ownerUser.getDisplayName()}（${fundCollection.ownerUser.email}）
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div> 
                <c:choose>
                    <c:when test="${gatewayPaymentSource == 'SOURCE_WIDGET'}">
                        <%@include file="/WEB-INF/payment/z_payment_tip_dialog.jsp" %>
                        <jsp:include page="/WEB-INF/public/z_footer_widget.jsp"/>
                    </c:when>
                    <c:otherwise><jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> </c:otherwise>
                </c:choose>
