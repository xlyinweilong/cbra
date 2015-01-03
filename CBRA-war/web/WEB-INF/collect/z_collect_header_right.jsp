<%-- 
    Document   : 收款详细信息Header子模版：统计信息
    Created on : Jan 6, 2012, 3:42:12 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="FloatRight bold">
    <span class="MarginR10"><fmt:message key="COLLECT_LIST_LABEL_COLLECTED" bundle="${bundle}"/>: 
        <c:choose>
            <c:when test="${fundCollection.paymentAmountUSD.intValue() == 0 && fundCollection.paymentAmountCNY.intValue() == 0}">
                <fmt:formatNumber value="${fundCollection.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
            </c:when>
            <c:otherwise>
                <c:if test="${fundCollection.paymentAmountCNY.intValue()>0}">
                    <fmt:formatNumber value="${fundCollection.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                </c:if>
                &nbsp;&nbsp;
                <c:if test="${fundCollection.paymentAmountUSD.intValue()>0}">
                    <fmt:formatNumber value="${fundCollection.paymentAmountUSD}" type="currency"  pattern="¤#,##0.##" currencySymbol="$" />
                </c:if>
            </c:otherwise>
        </c:choose>
    </span>
    <c:choose>
        <c:when test="${fundCollection.type=='EVENT'}">
            <fmt:message key="COLLECT_DETAIL_TEXT_门票售出" bundle="${bundle}"/>：${totalTicketCount}
        </c:when>
        <c:otherwise>
            <fmt:message key="COLLECT_DETAIL_LABEL_已付款人" bundle="${bundle}"/>：${fundCollection.paidCountCNY +fundCollection.paidCountUSD} <fmt:message key="COLLECT_DETAIL_LABEL_人" bundle="${bundle}"/>
        </c:otherwise>
    </c:choose>

    &nbsp;&nbsp; <fmt:message key="PAYMENT_DETAIL_TEXT_浏览次数" bundle="${bundle}"/>：${fundCollection.visitCount}
</div>
<div class="clear"></div>

