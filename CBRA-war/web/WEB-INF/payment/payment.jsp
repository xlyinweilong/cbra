<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${not forceLanguage}">
    <c:choose>
        <c:when test="${fundCollection.eventLanguage=='CHINESE'}">
            <fmt:setLocale value="zh_CN" scope="session" />
            <fmt:setBundle basename="message" scope="session" var="bundle"/>
            <%
                Cookie cookie = new Cookie("COOKIE_LANG", "zh");
                cookie.setPath("/");
                response.addCookie(cookie);
            %>
        </c:when>
        <c:when test="${fundCollection.eventLanguage=='ENGLISH'}">
            <fmt:setLocale value="en_US" scope="session" />
            <fmt:setBundle basename="message" scope="session" var="bundle"/>
            <%
                Cookie enCookie = new Cookie("COOKIE_LANG", "en");
                enCookie.setPath("/");
                response.addCookie(enCookie);
            %>
        </c:when>
        <c:otherwise>
        </c:otherwise>
    </c:choose>
</c:if>
<%-- 
    Document   : payment 
    Created on : Apr 1, 2011, 9:37:14 PM
--%> 
<%@page  import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDPAYMENT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_CONTACTS);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp">
    <jsp:param name="PAGE_HEADER_TITLE" value="${pageTitle}" />
</jsp:include>
<c:choose>
    <c:when test="${fundCollection.type=='EVENT'}">
        <c:choose>
            <c:when test="${fundCollection.status=='DELETED'}">
                <div class="TheEndMessage">
                    <fmt:message key="COLLECT_EVENT_EDIT_LABEL_此活动已删除" bundle="${bundle}"/>
                </div>
            </c:when>
            <c:otherwise>
                <jsp:include page="/WEB-INF/payment/z_payment_event.jsp">
                    <jsp:param name="fromPage" value="PAYMENT" />
                </jsp:include>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/payment/z_payment_service_product_member.jsp">
            <jsp:param name="fromPage" value="PAYMENT" />
        </jsp:include>
    </c:otherwise>
</c:choose>
<%@include file="/WEB-INF/payment/z_payment_tip_dialog.jsp" %>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<%@include file="/WEB-INF/public/z_footer_close.html" %>


