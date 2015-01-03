<%-- 
    Document   : z_gateway_select
    Created on : Apr 21, 2011, 7:28:02 PM
    Author     : WangShuai
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.Config"%>
<div class="selects select" style="color:#000;">
    <c:if test="${not empty fundCollection}">
        <c:set var="allowPayGates" value="${fundCollection.allowPayGateType}"></c:set>
    </c:if>
    <span input="gateway_type" id="gateway_type_select_span" >
        <c:choose>
            <c:when test="${gateway_type_init==null}"><fmt:message key="PAYMENT_DETAIL_LABEL_信用卡Visa" bundle="${bundle}"/></c:when>
            <c:otherwise><fmt:message key="${gateway_type_init}" bundle="${bundle}"/></c:otherwise>
        </c:choose>
    </span>
    <ul style="display: none;" id="payment_type">
        <li tvalue="BALANCE" id="balance_enough_container" style="display: none">
            <c:choose>
                <c:when test="${fundCollection.currencyType=='USD'}">
                    <fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元XXX美元' bundle='${bundle}'></fmt:message>
                </c:when>
                <c:otherwise>
                    <fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元' bundle='${bundle}'></fmt:message>
                </c:otherwise>
            </c:choose>
        </li>
        <c:if test="${(empty allowPayGates) || fn:containsIgnoreCase(allowPayGates, 'CHINABANK')}">
            <li tvalue="CHINABANK"><fmt:message key="PAYMENT_DETAIL_LABEL_网银在线" bundle="${bundle}"/></li>
        </c:if>
        <%-- 
        <c:if test="${empty allowPayGates || fn:containsIgnoreCase(allowPayGates, 'ALIPAY')}">
            <li tvalue="ALIPAY"><fmt:message key="PAYMENT_DETAIL_LABEL_支付宝" bundle="${bundle}"/></li>
        </c:if>--%>
        <c:if test="${(empty allowPayGates) || fn:containsIgnoreCase(allowPayGates, 'PAYPAL_CREDITCARD_VISA')}">
            <li tvalue="PAYPAL_CREDITCARD_VISA">Visa</li>
        </c:if>
        <c:if test="${(empty allowPayGates) || fn:containsIgnoreCase(allowPayGates, 'PAYPAL_CREDITCARD_MASTERCARD')}">
            <li tvalue="PAYPAL_CREDITCARD_MASTERCARD">MasterCard</li>
        </c:if>
        <c:if test="${(empty allowPayGates) || fn:containsIgnoreCase(allowPayGates, 'PAYPAL')}">
            <li tvalue="PAYPAL">Paypal</li>
        </c:if>
        <c:if test="${(empty allowPayGates) || fn:containsIgnoreCase(allowPayGates, 'BANK_TRANSFER')}">
            <li tvalue="BANK_TRANSFER"><fmt:message key="GLOBAL_银行转账" bundle="${bundle}"/></li>
        </c:if>
        <c:if test="${(empty allowPayGates) || fn:containsIgnoreCase(allowPayGates, 'BANK_TRANSFER')}">
            <li tvalue="INTERNATIONAL_BANK_TRANSFER"><fmt:message key="GLOBAL_国外银行转账" bundle="${bundle}"/></li>
        </c:if>
    </ul>
</div>
<div style="display:none; float: left;" id="buyer_email_input_div">
    <input class="selects select InputPaygateGateway" id="buyer_email" name="buyer_email" value=""/>
</div> 
<div class=" select" style="color:#000;display: none" id="chinabank_credit_select" >
    <span input="gateway_type" id="chinabank_credit_span">
        <fmt:message key="PAYMENT_DETAIL_LABEL_请选择" bundle="${bundle}"/>
    </span>
    <ul style="display:none" id="chinabank_credit_ul">
        <li tvalue="308"><fmt:message key="PAYMENT_GATEWAY_BANK_招商银行" bundle="${bundle}"/></li>
        <li tvalue="102"><fmt:message key="PAYMENT_GATEWAY_BANK_工商银行" bundle="${bundle}"/></li>
        <li tvalue="105"><fmt:message key="PAYMENT_GATEWAY_BANK_建设银行" bundle="${bundle}"/></li>
        <li tvalue="104"><fmt:message key="PAYMENT_GATEWAY_BANK_中国银行" bundle="${bundle}"/></li>
        <li tvalue="306"><fmt:message key="PAYMENT_GATEWAY_BANK_广发银行" bundle="${bundle}"/></li>
    </ul>
</div>
<div style="display: none" id="chinabank_tip_not_ie">
    <span class="hidden_input_container">
        <div style="margin: auto">
            <fmt:message key='CHINABANK_TIP_NOT_ID_网银只支持IE' bundle='${bundle}'/><br class="clear"/>
            <p class="MarginTop10 TextAlignRight">
                <input type="button" class="collection_button" onclick="GatewayPayment.chinabankTipNotIeClose()" value="<fmt:message key='CHINABANK_TIP_NOT_ID_BUTTON' bundle='${bundle}'/>"/>
            </p>
        </div>
    </span>
</div>
