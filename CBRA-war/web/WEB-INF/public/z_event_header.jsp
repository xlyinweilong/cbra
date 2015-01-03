<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="cn.yoopay.*"%>

<div class="headEvent">
    <div class="headEventImg">
        <c:choose>
            <c:when test="${sessionScope.user != null && pageViewLoginAllowed}">
                <a href="/account/overview" class="headEventImgLogo"></a>
            </c:when>
            <c:otherwise>
                <a href="/public/index" class="headEventImgLogo"></a>
            </c:otherwise>
        </c:choose>
        <span class="FloatLeft MarginL60"><fmt:message key="PULIC_Z_EVENT_FOOTER_TEXT_LEFT" bundle="${bundle}"/></span>
        <%--<a href="/payment/${fundCollection.webId}" class="headEventImgLink">https://yoopay.cn/pay/${fundCollection.webId}</a>--%>
        <c:if test="${empty apiPaymentPage}">
            <c:choose>
                <c:when test="${fundCollection != null && fundCollection.eventLanguage != 'AUTODETECT' }">
                    <div class="FloatRight ColorGreen"> &nbsp;&nbsp;<a href="javascript:language.doSetChinese('FORCE')">中文</a> | <a href="javascript:language.doSetEnglish('FORCE')">English</a></div>
                </c:when>
                <c:otherwise>
                    <div class="FloatRight ColorGreen"> &nbsp;&nbsp;<a href="javascript:language.doSetChinese()">中文</a> | <a href="javascript:language.doSetEnglish()">English</a></div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>  
</div>
<div class="home_content">
    <c:if test="${empty apiPaymentPage}">
        <%@include file="/WEB-INF/public/z_weibo_share.jsp" %>
    </c:if>