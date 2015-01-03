<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : 历史记录
    Created on : Apr 10, 2011, 8:18:10 PM
    Author     : HUXIAOFENG
--%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.TRANSACTION);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.TRANSACTION_LIST);
%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<c:if test="${postResult.success}">
    <h3 class="nolist">
        ${postResult.singleSuccessMsg}
    </h3>
</c:if>

<c:if test="${!empty postResult.singleErrorMsg}">
    <h3 class="nolist">
        ${postResult.singleErrorMsg}
    </h3>
</c:if>
<c:if test="${transactionList != null}">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
        <thead>
            <tr>
                <td width="8%"><fmt:message key="TRANSACTION_LABEL_时间" bundle="${bundle}"/></td>
        <td width="13%"><fmt:message key="TRANSACTION_LABEL_友付序列号" bundle="${bundle}"/></td> 
        <td width="10%"><fmt:message key="TRANSACTION_LABEL_金额" bundle="${bundle}"/></td>
        <td width="10%"><fmt:message key='COLLECT_DETAIL_LABEL_手续费' bundle='${bundle}'/></td>
        <td width="10%"><fmt:message key='COLLECT_DETAIL_LABEL_净收入' bundle='${bundle}'/></td>
        <td width="10%"><fmt:message key="TRANSACTION_LABEL_款项" bundle="${bundle}"/></td>
        <td width="15%"><fmt:message key="TRANSACTION_LABEL_支付方式" bundle="${bundle}"/></td> 
        <td width="30%"><fmt:message key="TRANSACTION_LABEL_事由" bundle="${bundle}"/></td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="transaction" items="${transactionList}" varStatus="status">
            <c:set var="fundCollection" value="${transaction.fundCollection}"></c:set>
            <c:set var="mainOrder" value="${transaction.orderMain}"></c:set>
            <c:set var="gatewayPayment" value="${mainOrder.lastGatewayPayment}"></c:set>
            <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
            <td><fmt:formatDate value="${transaction.createDate}" type="date" pattern="yyyy.MM.dd"/></td>
            <td>
            <c:choose>
                <c:when test="${transaction.transactionType == 'COLLECTION_PAYMENT' || transaction.transactionType == 'PAYMENT_TO_COLLECTION'}">

                    <c:choose>
                        <c:when test="${user.id == fundCollection.ownerUser.id}">
                            <a href="/collect/preview/${transaction.fundCollection.webId}">${transaction.serialId}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/pay/${transaction.fundCollection.webId}">${transaction.serialId}</a>
                        </c:otherwise>
                    </c:choose>

                </c:when>
                <c:otherwise>
                    ${transaction.serialId}
                </c:otherwise>
            </c:choose>
            </td>
            <td>
            <c:choose>
                <c:when test="${transaction.transactionType == 'WITHDRAW' || transaction.transactionType == 'REFUND'|| transaction.transactionType == 'API_BE_REFUND' || transaction.transactionType == 'API_REFUND' || transaction.transactionType == 'BE_REFUND' ||transaction.transactionType == 'DRAW_REFUND' || transaction.transactionType == 'REFUND_SERVICE_FEE'|| transaction.transactionType == 'API_REFUND_SERVICE_FEE' || transaction.transactionType == 'REFUND_INVOICE_FEE' || transaction.transactionType == 'API_REFUND_INVOICE_FEE' || transaction.transactionType == 'DATA_CONVERT_OUT' || transaction.transactionType == 'INVOICE_SERVICE_FEE' || transaction.transactionType == 'SHORT_MESSAGE_PROMOTION_SERVICE_FEE' || transaction.transactionType == 'EMAIL_PROMOTION_SERVICE_FEE'}">
                    <fmt:formatNumber value="${transaction.amount}" type="currency"  pattern="￥#,##0.##"/>
                </c:when>
                <c:otherwise>
                    <fmt:formatNumber value="${gatewayPayment.getCNYTotalAmount()}" type="currency"  pattern="￥#,##0.##"/>
                </c:otherwise>
            </c:choose>
            </td>
            <td>
            <c:choose>
                <c:when test="${(transaction.transactionType == 'COLLECTION_PAYMENT' || transaction.transactionType == 'TRANSFER_IN'  || transaction.transactionType == 'API_CHARGE') && gatewayPayment != null}">
                    <fmt:formatNumber value="${gatewayPayment.getCNYServiceFeeAddCNYInvoiceFee()}" type="currency"  pattern="￥#,##0.##"/>
                </c:when>
                <c:otherwise>&nbsp;</c:otherwise>
            </c:choose>
            </td>
            <td>
            <c:choose>
                <c:when test="${(transaction.transactionType == 'COLLECTION_PAYMENT' || transaction.transactionType == 'TRANSFER_IN'  || transaction.transactionType == 'API_CHARGE') && gatewayPayment != null}">
                    <fmt:formatNumber value="${gatewayPayment.toUserCNYAmount}" type="currency"  pattern="￥#,##0.##"/>
                </c:when>
                <c:otherwise>&nbsp;</c:otherwise>
            </c:choose>
            </td>

            <td>
            <c:choose>
                <c:when test="${transaction.transactionType == 'COLLECTION_PAYMENT'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_收款" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'PAYMENT_TO_COLLECTION'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_付款" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'API_CHARGE'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_付款API" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'ADDFUND'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_充值" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'YOOPAY_SERVICE'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_购买友付服务" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'TRANSFER_OUT'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_转出" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'TRANSFER_IN'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_转入" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'TRANSFER_BOUNCE'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_退款" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'WITHDRAW'}">
                    <fmt:message key="TRANSACTION_TEXT_TYPE_提款" bundle="${bundle}"/>
                </c:when> 
                <c:when test="${transaction.transactionType == 'REFUND' || transaction.transactionType == 'API_REFUND' }">
                    <fmt:message key="TRANSACTION_MSG_退款" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'BE_REFUND' || transaction.transactionType == 'API_BE_REFUND'}">
                    <fmt:message key="TRANSACTION_MSG_收款人退款" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'DRAW_REFUND'}">
                    <fmt:message key="TRANSACTION_MSG_提取退款" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'REFUND_SERVICE_FEE' || transaction.transactionType == 'API_REFUND_SERVICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_退还手续费" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'REFUND_INVOICE_FEE' || transaction.transactionType == 'API_REFUND_INVOICE_FEE'}}">
                    <fmt:message key="TRANSACTION_MSG_退还发票手续费" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'INVOICE_SERVICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_发票服务费" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'SHORT_MESSAGE_PROMOTION_SERVICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_短信推广服务费" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'EMAIL_PROMOTION_SERVICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_邮件推广服务费" bundle="${bundle}"/>
                </c:when>
            </c:choose>
            </td>
            <td>
            <c:choose>
                <c:when test="${gatewayPayment != null && (transaction.transactionType == 'COLLECTION_PAYMENT' || transaction.transactionType == 'PAYMENT_TO_COLLECTION' || transaction.transactionType == 'ADDFUND' || transaction.transactionType == 'YOOPAY_SERVICE'|| transaction.transactionType == 'API_CHARGE' ) }">
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
                        (<fmt:formatNumber value="${gatewayPayment.getCNYGatewayAmount()}" type="currency"  pattern="￥#,##0.##"/>)
                        +<fmt:message key="GLOBAL_友付余额" bundle="${bundle}"/>(<fmt:formatNumber value="${gatewayPayment.getCNYBalanceAmount()}" type="currency"  pattern="￥#,##0.##"/>)
                    </c:if>
                </c:when>
                <c:otherwise>&nbsp;</c:otherwise>
            </c:choose>
            </td>
            <td>
            <c:choose>
                <c:when test="${transaction.status == 'TRANSACTION_PENDING'}">
                    [<fmt:message key="TRANSACTION_TEXT_STATUS_待审核" bundle="${bundle}"/>]
                </c:when>
                <c:when test="${transaction.status == 'TRANSACTION_CANCELED'}">
                    [<fmt:message key="TRANSACTION_TEXT_STATUS_已取消" bundle="${bundle}"/>]
                </c:when>
                <c:otherwise></c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${fundCollection!=null }">
                    <c:if test="${transaction.transactionType == 'COLLECTION_PAYMENT'}">
                        <fmt:message key="TRANSACTION_TEXT_MEMO_ACTION_收到" bundle="${bundle}"/> ${mainOrder.owner.getDisplayName()}
                    </c:if>
                    <c:if test="${transaction.transactionType == 'PAYMENT_TO_COLLECTION'}">
                        <fmt:message key="TRANSACTION_TEXT_MEMO_ACTION_付给" bundle="${bundle}"/> ${transaction.fundCollection.ownerUser.getDisplayName()}
                    </c:if>
                    <c:if test="${transaction.transactionType == 'INVOICE_SERVICE_FEE' && transaction.amount>0}">
                        ${mainOrder.owner.getDisplayName()}
                    </c:if>
                    <c:choose>
                        <c:when test="${user.id == fundCollection.ownerUser.id}">
                            <a href="/collect/preview/${transaction.fundCollection.webId}">${fundCollection.title}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/pay/${transaction.fundCollection.webId}">${fundCollection.title}</a>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${transaction.transactionType == 'API_CHARGE'}">
                    <fmt:message key="YPSERVICE_API_付款人信息" bundle="${bundle}"/>  ${mainOrder.customerName}(${mainOrder.customerEmail})
                </c:when>
                <c:when test="${transaction.transactionType == 'YOOPAY_SERVICE'}">
                    <fmt:message key="YP_SERVICE_NAME_${mainOrder.yoopayService.serviceName}" bundle="${bundle}"/>
                </c:when>
                <c:when test="${transaction.transactionType == 'WITHDRAW'&&transaction.amount>0}">
                    <fmt:message key="TRANSACTION_TEXT_MEMO_ACTION_提款到" bundle="${bundle}"/>  ${mainOrder.withdrawAccount.name}
                </c:when>

                <c:when test="${transaction.transactionType == 'REFUND' || transaction.transactionType == 'API_REFUND'}">
                    <fmt:message key="TRANSACTION_MSG_退给XXX" bundle="${bundle}">
                        <c:choose>
                            <c:when test="${mainOrder.targetUser.accountType=='COMPANY'}">
                                <fmt:param value="${mainOrder.targetUser.company}" />
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="${mainOrder.targetUser.name}" />
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty mainOrder.serialId}">
                                <fmt:param value="${mainOrder.serialId}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="&nbsp;"/> 
                            </c:otherwise>
                        </c:choose>
                    </fmt:message> 
                </c:when>
                <c:when test="${transaction.transactionType == 'DRAW_REFUND'}">
                    <fmt:message key="TRANSACTION_MSG_提取退款XXX" bundle="${bundle}">
                        <c:choose>
                            <c:when test="${not empty mainOrder.serialId}">
                                <fmt:param value="${mainOrder.serialId}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="&nbsp;"/> 
                            </c:otherwise>
                        </c:choose>
                    </fmt:message> 
                </c:when>
                <c:when test="${transaction.transactionType == 'BE_REFUND' || transaction.transactionType == 'API_BE_REFUND'}">
                    <fmt:message key="TRANSACTION_MSG_收到XXX" bundle="${bundle}">
                        <fmt:param value="${mainOrder.owner.name}"/>
                        <c:choose>
                            <c:when test="${not empty mainOrder.serialId}">
                                <fmt:param value="${mainOrder.serialId}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="&nbsp;"/> 
                            </c:otherwise>
                        </c:choose>
                    </fmt:message> 
                    <c:if test="${not empty mainOrder.remarks}">&nbsp;${mainOrder.remarks}</c:if>
                </c:when>
                <c:when test="${transaction.transactionType == 'REFUND_SERVICE_FEE' || transaction.transactionType == 'API_REFUND_SERVICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_退还手续费XXX" bundle="${bundle}">
                        <c:choose>
                            <c:when test="${not empty mainOrder.serialId}">
                                <fmt:param value="${mainOrder.serialId}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="&nbsp;"/> 
                            </c:otherwise>
                        </c:choose>
                    </fmt:message> 
                </c:when>
                <c:when test="${transaction.transactionType == 'REFUND_INVOICE_FEE' || transaction.transactionType == 'API_REFUND_INVOICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_退还发票手续费XXX" bundle="${bundle}">
                        <c:choose>
                            <c:when test="${not empty mainOrder.serialId}">
                                <fmt:param value="${mainOrder.serialId}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="&nbsp;"/> 
                            </c:otherwise>
                        </c:choose>
                    </fmt:message> 
                </c:when>
                <c:when test="${transaction.transactionType == 'SHORT_MESSAGE_PROMOTION_SERVICE_FEE'||transaction.transactionType == 'EMAIL_PROMOTION_SERVICE_FEE'}">
                    <fmt:message key="TRANSACTION_MSG_推广服务费XXX" bundle="${bundle}">
                        <c:choose>
                            <c:when test="${not empty mainOrder.serialId}">
                                <fmt:param value="${mainOrder.serialId}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:param value="&nbsp;"/> 
                            </c:otherwise>
                        </c:choose>
                    </fmt:message> 
                </c:when>
                <c:when test="${transaction.transactionType == 'DATA_CONVERT_OUT'}">
                    账户余额按2.6%扣除手续费，提款时无需再支付手续费
                </c:when>


                <c:otherwise>&nbsp;</c:otherwise>
            </c:choose>

            </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/WEB-INF/public/z_paging.jsp">
        <jsp:param name="baseUrl" value="/transaction/list" />
        <jsp:param name="totalCount" value="${transactionList.getTotalCount()}" />
        <jsp:param name="maxPerPage" value="${transactionList.getMaxPerPage()}" />
        <jsp:param name="pageIndex" value="${transactionList.getPageIndex()}" />
    </jsp:include>

</c:if>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
