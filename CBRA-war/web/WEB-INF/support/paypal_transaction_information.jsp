<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html >
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<div class="admin-content">
    <c:choose>
        <c:when test="${not empty requestScope.gatewayPayment}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <tr class="white">
                    <td>交易ID</td>
                    <td>
                <c:if test="${gatewayPayment.gatewayType eq 'PAYPAL_CREDITCARD_MASTERCARD' || gatewayPayment.gatewayType eq 'PAYPAL_CREDITCARD_VISA'}">${gatewayPayment.gatewayPaymentCc.transId}</c:if>
                <c:if test="${gatewayPayment.gatewayType eq 'PAYPAL'}">${paypalTranId}</c:if>
                </td>
                </tr>
                <tr>
                    <td>时间</td>
                    <td><fmt:formatDate value='${gatewayPayment.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                </tr>
                <tr class="white">
                    <td>谁</td>
                    <td>
                        姓名：<c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${gatewayPayment.orderMain.owner.id}"></c:if>${gatewayPayment.orderMain.owner.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if><br/>
                邮箱：${gatewayPayment.orderMain.owner.email}
                </td>
                </tr>
                <tr>
                    <td>方式</td>
                    <td>${gatewayPayment.gatewayType}</td>
                </tr>
                <tr class="white">
                    <td>付给了谁（为了支持购物车，这个的付款是对购物车，所以可能有多个活动;如果是用信用卡支付的充值等，暂时不能查询）</td>
                    <td>
                <c:forEach var="order" items="${requestScope.orderList}" varStatus="status">
                    活动名称：<a href="/${order.fundCollection.type}/${order.fundCollection.webId}">${order.fundCollection.title}</a><br/>
                    收款方式：${order.fundCollection.allowPayGateType}<br/>
                    活动地址：${order.fundCollection.eventLocation}<br/>
                    姓名：<c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${order.fundCollection.ownerUser.id}"></c:if>${order.fundCollection.ownerUser.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if><br/>
                    邮箱：${order.fundCollection.ownerUser.email}<br/>
                </c:forEach>
                </td>
                </tr>
                <tr>
                    <td>金额</td>
                    <td>
                        付款方式:${gatewayPayment.gatewayType}<br/>
                        付款金额:${gatewayPayment.gatewayAmount}<br/>
                        付款币种:${gatewayPayment.currencyType}
                    </td>
                </tr>
            </table>
        </c:when>
        <c:otherwise>
            ${requestScope.noResult}
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>