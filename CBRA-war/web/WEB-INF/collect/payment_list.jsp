<%-- 
    Document   : collect_detail
    Created on : Apr 10, 2011, 8:01:46 PM
    Author     : HUXIAOFENG
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--Set menu highlight --%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>

    <div class="BlueBoxContent826">
        <%--Sub menu --%>
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="PAYLIST"/>
            </jsp:include> 
        </div>

        <c:choose>
            <c:when test="${empty allSubOrders}">
                <h3 class="nolist"><fmt:message key="GLOBAL_MSG_BLANK_LIST" bundle="${bundle}"/></h3>
            </c:when>
            <c:otherwise>
                <div id="detail_payment_list" class="FloatLeft" style="padding-right:50px;">
                    <%--Download link--%>
                    <div class="PaymentListHeader">
                        <div class="FloatRight">
                            <a href="javascript:void(0);" onclick="Collect.downloadOrderList(${allSubOrders.size()},'${fundCollection.webId}');return false;">
                                <c:choose>
                                    <c:when test="${fundCollection.type=='EVENT'}">
                                        <fmt:message key="COLLECT_DETAIL_LINK_下载订单列表" bundle="${bundle}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="COLLECT_DETAIL_LINK_下载付款人名单" bundle="${bundle}"/>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <span id="order_list_down_msg" style="color: red;display: none" ></span>
                        </div> 
                        <div class="clear"></div>
                    </div>
                    <input type="hidden" id="collect_detatl_button" value="<fmt:message key='COLLECT_DETAIL_BUTTON_取消' bundle="${bundle}"/>" />

                           <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table ">
                        <thead>   
                            <tr>
                                <td><fmt:message key='COLLECT_DETAIL_LABEL_收款' bundle='${bundle}'/></td>
<!--                                <td><fmt:message key='COLLECT_DETAIL_LABEL_手续费' bundle='${bundle}'/></td>
                                <td><fmt:message key='COLLECT_DETAIL_LABEL_净收入' bundle='${bundle}'/></td>-->
                        <td><fmt:message key='COLLECT_LIST_LABEL_DATE' bundle='${bundle}'/></td> 
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_姓名' bundle='${bundle}'/></td> 
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_公司' bundle='${bundle}'/></td> 
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_职务' bundle='${bundle}'/></td> 
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_手机' bundle='${bundle}'/></td>
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_邮箱' bundle='${bundle}'/></td>
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_渠道码' bundle='${bundle}'/></td>
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_付款方式' bundle='${bundle}'/></td>
                        <td><fmt:message key='PAYMENT_LIST_LABEL_操作' bundle='${bundle}'/></td>
                        </tr> 
                        </thead>
                        <tbody>
                        <c:forEach var="subOrder" items="${allSubOrders}" varStatus="status">
                            <c:set var="mainOrder" value="${subOrder.parentOrderCollection}"></c:set>
                            <c:set var="gatewayPayment" value="${mainOrder.lastGatewayPayment}"></c:set>
                            <c:set var="ticketList" value="${subOrder.fundPaymentTicketList}"/>
                            <c:set var="itemList" value="${subOrder.orderCollectionSubItemList}"/>
                            <c:set var="orderPayer" value="${mainOrder.payerInfo}"/>
                            <c:set var="orderOwner" value="${mainOrder.owner}"/>
                            <tr <c:if test="${status.index%2!=0}">class="white"</c:if>>
                            <td id="refundable_amount_${mainOrder.serialId}"><%--${gatewayPayment.totalAmount} ${gatewayPayment.currencySign}--%>
                            <fmt:formatNumber value="${subOrder.refundableAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${mainOrder.currencySign}" />
                            </td>
                            <%--                                    <td>
                                                                    <fmt:formatNumber value="${gatewayPayment.serviceFee}" type="currency"  pattern="¤#,##0.##" currencySymbol="${gatewayPayment.currencySign}" />
                                                                </td>--%>
                            <%--                                    <td>
                                                                    <fmt:formatNumber value="${gatewayPayment.toUserAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${gatewayPayment.currencySign}" />
                                                                </td>--%>

                            <td>
                            <fmt:formatDate value="${mainOrder.endDate}" pattern="yyyy.MM.dd HH:mm" type="date" dateStyle="long" />
                            </td>
                            <td>
                                ${orderPayer.name == null ? orderOwner.name : orderPayer.name}
                            </td>
                            <td>
                                ${orderPayer.company == null ? orderOwner.company : orderPayer.company}
                            </td>
                            <td>
                                ${orderPayer.position == null ? orderOwner.position : orderPayer.position}
                            </td>
                            <td>
                                ${orderPayer.mobilePhone == null ? orderOwner.mobilePhone : orderPayer.mobilePhone}
                            </td>
                            <td>
                                ${orderPayer.email == null ? orderOwner.email : orderPayer.email}
                            </td>
                            <td>
                                ${subOrder.referralCode}
                            </td>
                            <td>
                            <c:choose>
                                <c:when test="${gatewayPayment.gatewayType == 'ALIPAY'}">
                                    <fmt:message key="TRANSACTION_TEXT_METHOD_支付宝" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL'}">
                                    PayPal
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL_CREDITCARD'}">
                                    <fmt:message key="PAYMENT_DETAIL_LABEL_信用卡海外" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL_CREDITCARD_VISA'}">
                                    VISA
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL_CREDITCARD_MASTERCARD'}">
                                    MasterCard
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'CHINABANK_CREDITCARD'}">
                                    <fmt:message key="PAYMENT_DETAIL_LABEL_信用卡中国" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'CHINABANK'}">
                                    <fmt:message key="TRANSACTION_TEXT_METHOD_网银" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'BANK_TRANSFER'}">
                                    <fmt:message key="GLOBAL_银行转账" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'INTERNATIONAL_BANK_TRANSFER'}">
                                    <fmt:message key="GLOBAL_国外银行转账" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'BALANCE'}">
                                    <fmt:message key="GLOBAL_友付余额" bundle="${bundle}"/>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${gatewayPayment.gatewayType != 'BALANCE' && gatewayPayment.balanceAmount != '0.00'}">
                                /<fmt:message key="GLOBAL_友付余额" bundle="${bundle}"/>
                            </c:if>
                            </td>
                            <td>
                            <c:choose>
                                <c:when test="${subOrder.isFree() || subOrder.isRefundableAmountIsZore()}">
                                    <input id="refund_${mainOrder.serialId}"  type="button" value="<fmt:message key='COLLECT_DETAIL_BUTTON_取消' bundle="${bundle}"/>" class="account_input" onclick="Collect.canclePayment('${mainOrder.serialId}')">
                                </c:when>
                                <c:otherwise>
                                    <input id="refund_${mainOrder.serialId}"  type="button" value="<fmt:message key='COLLECT_DETAIL_BUTTON_退款' bundle="${bundle}"/>"onclick="Collect.refundDialog('${mainOrder.serialId}');" class="account_input">
                                </c:otherwise>
                            </c:choose>
                            </td>
                            </tr>
                            <%--列出此订单下的门票和备注信息以及使用的折扣码信息 --%>
                            <tr <c:if test="${status.index%2!=0}">class="white"</c:if>>
                            <td colspan="6">
                                <div class="PaymentList">
                                    <c:choose>
                                        <c:when test="${fundCollection.type == 'EVENT'}">
                                            <c:forEach var="ticket" items="${ticketList}" varStatus="ticketStatus">
                                                <dd>
                                                <li class="number">
                                                    <a href="/account/ticket_download/${ticket.id}" target="_blank">${ticket.barcode}</a>
                                                </li>
                                                <li>${ticket.fundCollectionPrice.name}</li>
                                                </dd>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="item" items="${itemList}" varStatus="itemStatus">
                                                <dd>
                                                <li class="number">
                                                    ${item.price.name}
                                                </li>
                                                <li>${item.quantity}</li>
                                                </dd>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>   
                            </td>
                            <td colspan="6"> 
                                ${mainOrder.remarks}<br/>
                            <c:if test="${not empty subOrder.fundCollectionDiscount}">
                                <c:set var="discount" value="${subOrder.fundCollectionDiscount}"/>
                                ${discount.name}<span>${discount.code}</span>&nbsp;-
                                <c:choose>
                                    <c:when test="${discount.type=='RATE'}">                                                            
                                        <fmt:formatNumber value="${discount.rate}" type="number"  pattern="#,##0.##"/>%
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${discount.amount}" type="number"  pattern="¤#,##0.##" currencySymbol="${item.paymentCurrencySign}"/>                                                  
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>  
                </div>
            </c:otherwise>
        </c:choose>
        <div class="clear"></div>           
    </div>            
</div>
<div id="refundDialog" style="display:none">
</div>
<div id="refundSuccessDialog" style="display:none">
    <div style="margin-top: 15px">
        <fmt:message key="COLLECT_DETAIL_退款成功" bundle="${bundle}"/><br/>
        <input class="collection_button FloatRight" type="button"  value="<fmt:message key='GLOBAL_关闭' bundle='${bundle}'/>" onclick="RefundSuccessDiv.close()" name="Submit">
    </div>
</div>
<div id="freePaymentCancleDialog" style="display:none">
    <div style="margin-top: 15px">
        <fmt:message key="COLLECT_DETAIL_将此人从名单中删除" bundle="${bundle}"/>
        <div class="sk-item-returned-pop "> <input class="collection_button FloatRight" type="button"  value="<fmt:message key='GLOBAL_确认' bundle='${bundle}'/>" name="Submit" id="free_payment_cancle_confirm">
            <a href="javascript:;" onclick="RefundPaymentCancleDiv.close();" class="FloatRight MarginR10"><fmt:message key='GLOBAL_取消' bundle="${bundle}"/></a>
        </div> </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    $(document).ready(
    function(){
        
    });   
</script>

<%@include file="/WEB-INF/public/z_footer_close.html" %> 
