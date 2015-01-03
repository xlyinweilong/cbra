
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
    Document   : collect_information
    Created on : Sep 25, 2012, 3:06:26 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/report/z_header.jsp"%>  

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
<h3 align="left">活动信息（${fundCollection.title}）：</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
    <tbody>
    <div class="admin-content">
        <c:choose>
            <c:when test="${not empty collectInformationMap}">                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                    <tr>
                        <td>主办方</td>
                        <td class="white">${collectInformationMap.event_host}</td>
                        <td>活动名称</td>
                        <td class="white" id="userEmail">${collectInformationMap.title}</td>
                    </tr>
                    <tr>
                        <td>售出票数</td>
                        <td class="white">${collectInformationMap.guests}</td>
                        <td>购买次数</td>
                        <td class="white">${collectInformationMap.orders}</td>
                    </tr>
                    <tr>
                        <td>人民币收入总额</td>
                        <td class="white">${collectInformationMap.cny_payment_total}</td>
                        <td>美元收入总额</td>
                        <td class="white">${collectInformationMap.usd_payment_total}</td>
                    </tr>
                </table>
                <a href="javascript:showPaymentList()">查看订票者名单</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:showTicketList()">查看参会者名单</a> 
                <div id="report_payment_list" style="display:none">
                    <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="history_table ">
                        <thead>   
                            <tr>
                                <td>已付金额</td>
                                <td>手续费</td>
                                <td>时间</td> 
                                <td>姓名</td> 
                                <td>公司</td> 
                                <td>职务</td> 
                                <td>手机</td>
                                <td>邮箱</td>
                                <td>渠道码</td>
                                <td>付款方式</td>
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
                            <td>
                            <fmt:formatNumber value="${gatewayPayment.toUserAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${mainOrder.currencySign}" />
                            </td>
                            <td>
                            <fmt:formatNumber value="${gatewayPayment.serviceFee}" type="currency"  pattern="¤#,##0.##" currencySymbol="${mainOrder.currencySign}" />
                            </td>
                            <td>
                            <fmt:formatDate value="${mainOrder.endDate}" pattern="yyyy.MM.dd HH:mm" type="date" dateStyle="long" />
                            </td>
                            <td>
                                ${orderPayer.name==null ?orderOwner.name : orderPayer.name}
                            </td>
                            <td>
                                ${orderPayer.company == null ? orderOwner.company : orderPayer.company}
                            </td>
                            <td>
                                ${orderPayer.position== null ? orderOwner.position : orderPayer.position}
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
                                    支付宝
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL'}">
                                    PayPal
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL_CREDITCARD'}">
                                    信用卡海外
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL_CREDITCARD_VISA'}">
                                    VISA
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'PAYPAL_CREDITCARD_MASTERCARD'}">
                                    MasterCard
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'CHINABANK_CREDITCARD'}">
                                    信用卡中国
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'CHINABANK'}">
                                    网银
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'BANK_TRANSFER'}">
                                    银行转账
                                </c:when>
                                <c:when test="${gatewayPayment.gatewayType == 'BALANCE'}">
                                    友付余额
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${gatewayPayment.gatewayType != 'BALANCE' && gatewayPayment.balanceAmount != '0.00'}">
                                (<fmt:formatNumber value="${gatewayPayment.getGatewayAmount()}" type="currency"  pattern="¤#,##0.##" currencySymbol="${mainOrder.currencySign}" />)
                                +友付余额(<fmt:formatNumber value="${gatewayPayment.getBalanceAmount()}" type="currency"  pattern="¤#,##0.##" currencySymbol="${mainOrder.currencySign}" />)
                            </c:if>
                            </td>
                            </tr>
                            <%--列出此订单下的门票和备注信息以及使用的折扣码信息 --%>
                            <tr <c:if test="${status.index%2!=0}">class="white"</c:if>>
                            <td colspan="5">
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
                            <td colspan="5"> 
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
                <div id="report_ticket_list" style="display:none">
                    <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="history_table ">
                        <thead>   
                            <tr>
                                <td>时间</td> 
                                <td>门票ID</td>
                                <td>门票种类</td>
                                <td>姓名</td> 
                                <td>公司</td> 
                                <td>职务</td> 
                                <td>手机</td>
                                <td>邮箱</td>
                                <td>渠道码</td>
                                <td>删除</td>
                        <c:forEach var="question" items="${registerQuestions}">
                            <td>${question.title}</td>
                        </c:forEach>
                        </tr> 
                        </thead>
                        <tbody>
                        <c:forEach var="ticket" items="${fundPaymentTicketList}" varStatus="status"> 
                            <c:set value="${ticket.orderCollectionSub}" var="subOrder"></c:set>
                            <tr <c:if test="${index%2!=0}">class="white"</c:if>>
                            <td>
                            <fmt:formatDate value="${subOrder.parentOrderCollection.endDate}" pattern="yyyy.MM.dd HH:mm" type="date" dateStyle="long" />
                            </td>
                            <td>
                                ${ticket.barcode}
                            </td>
                            <td>
                                ${ticket.fundCollectionPrice.name}
                            </td>
                            <td>${registerInfo[ticket.id][0]}</td>
                            <td>
                                ${registerInfo[ticket.id][1]}
                            </td>
                            <td>
                                ${registerInfo[ticket.id][2]}
                            </td>
                            <td>
                                ${registerInfo[ticket.id][3]}
                            </td>
                            <td>
                                ${registerInfo[ticket.id][4]}
                            </td>
                            <td>
                                ${subOrder.referralCode}
                            </td>
                            <td>
                                ${ticket.invalid}
                            </td>
                            <c:if test="${registerQuestions.size()>0}">
                                <c:forEach var="num" begin="0" end="${registerQuestions.size()-1}" step="1">
                                    <td>
                                        ${fn:replace(registerAnswer[ticket.id][num], newLineChar, "<br/>")}
                                    </td>
                                </c:forEach>
                            </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table> 
                </div>
            </c:when>
            <c:otherwise>
                <h3 class="nolist">列表为空</h3>
            </c:otherwise>
        </c:choose>
    </div>
</tbody>
</table>
<script type="text/javascript">
    var isShowTicketList = false;
    var isShowPaymentList = false;
    function showTicketList() {
        if(isShowTicketList){
            $('#report_ticket_list').hide();
            isShowTicketList = false;
        }else{
            $('#report_ticket_list').show();
            isShowTicketList = true;
        }
    }
    function showPaymentList(){
        if(isShowPaymentList){
            $('#report_payment_list').hide();
            isShowPaymentList = false;
        }else{
            $('#report_payment_list').show();
            isShowPaymentList = true;
        }
    }
</script>
<jsp:include page="/WEB-INF/report/z_footer.jsp"/>
