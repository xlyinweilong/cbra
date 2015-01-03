<%-- 
    Document   : z_payment_tip_dialog
    Created on : Jul 13, 2012, 2:25:08 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="paymentTipDialog" style="display:none;text-align: center">
    <div>
        <fmt:message key="PAYMENT_DETAIL_LABEL_请您在新打开的页面进行支付，支付完成前请不要关闭该窗口" bundle="${bundle}"/>
    </div>
    <div style="margin-top: 20px;font-size: 12px">
        <c:choose>
            <c:when test="${not empty scriptVarName}">
                <input type="button" onclick="${scriptVarName}.redirectToResult(true);" class="collection_button" value="<fmt:message key='PAYMENT_BUTTON_已完成支付' bundle='${bundle}'/>"/>
                <input type="button" onclick="${scriptVarName}.redirectToResult(false);" class="collection_button" value="<fmt:message key='PAYMENT_BUTTON_支付遇到问题' bundle='${bundle}'/>"/></c:when>
            <c:otherwise>
                <input type="button" onclick="FundPayment.redirectToResult(true);" class="collection_button" value="<fmt:message key='PAYMENT_BUTTON_已完成支付' bundle='${bundle}'/>"/>
                <input type="button" onclick="FundPayment.redirectToResult(false);" class="collection_button" value="<fmt:message key='PAYMENT_BUTTON_支付遇到问题' bundle='${bundle}'/>"/>
            </c:otherwise>
        </c:choose>

    </div>
</div>
