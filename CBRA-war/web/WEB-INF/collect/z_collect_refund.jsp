<%-- 
    Document   : z_yplink_dialog
    Created on : Jul 4, 2011, 5:25:35 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="width:336px; margin:0 auto" class="TextAlignLeft"> 
    <div class="noticeMessage" id="refundMessageDiv" style="display:none">
        <div class="wrongMessage" id="refundMessage"></div>
    </div>
    <div title="ajaxReturnSuccess" style="display:none">${postResult.success}</div>
    <div title="ajaxReturnError" style="display:none">${postResult.singleErrorMsg}</div>
    <div title="isRefundableAmountZero" style="display:none">${isRefundableAmountZero}</div>
    <div title="afterProcessingRefundableAmount" style="display:none">${afterProcessingRefundableAmount}</div>
    <form id="refund">

        <input type="hidden" name="a" value="refund">
        <input id="refund_paymentId" type="hidden" name="paymentId" value="${payment.serialId}">
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"><fmt:message key='COLLECT_DETAIL_PAYMENT_LIST_POP_退款给' bundle="${bundle}"/></label>
            ${payment.owner.name}(${payment.owner.email})
        </div>
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"><fmt:message key='TRANSACTION_LABEL_友付序列号' bundle="${bundle}"/></label>
            ${serialId}
        </div>
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"><fmt:message key='COLLECT_DETAIL_PAYMENT_LIST_POP_原金额' bundle="${bundle}"/></label>
            <fmt:formatNumber value="${payment.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${payment.currencySign}" />
        </div>
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"><fmt:message key='COLLECT_DETAIL_PAYMENT_LIST_POP_退款金额' bundle="${bundle}"/></label>
            <input class="Input40" type="text" id="refundAmount" name="refundAmount" value="${refundableAmount}"> <fmt:message key='COLLECT_DETAIL_PAYMENT_LIST_POP_最多可退' bundle="${bundle}"/>
            <span id="max_refund_amount">
                <c:choose>
                    <c:when test="${payment.currencyType=='CNY'}">
                        <fmt:message key='COLLECT_DETAIL_元' bundle="${bundle}"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key='COLLECT_DETAIL_美元' bundle="${bundle}"/>
                    </c:otherwise>
                </c:choose>
            </span>


        </div>
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"><fmt:message key='COLLECT_DETAIL_LABEL_留言' bundle="${bundle}"/></label>
            <input class="pop_input" type="text" name="refundMessage" >
        </div>
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"><input type="checkbox" name="paymentOrderInvalid" value="true"></label>
            <fmt:message key='COLLECT_DETAIL_LABEL_设置此定单和相关门票为无效' bundle="${bundle}"/>
        </div>
        <div class="sk-item-returned-pop">
            <label class="sk-label-returned-pop"></label>
            <input class="collection_button FloatRight" type="button"  value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="Collect.refund(${refundableAmount})" name="Submit">
            <a href="javascript:;" onclick="RefundDiv.close();" class="FloatRight MarginR10"><fmt:message key='GLOBAL_取消' bundle="${bundle}"/></a>
        </div>
    </form>
</div>