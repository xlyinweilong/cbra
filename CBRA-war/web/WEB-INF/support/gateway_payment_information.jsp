<%-- 
    Document   : gateway_payment_information
    Created on : Oct 29, 2012, 11:07:09 AM
    Author     : Yin.Weilong
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<h3 align="left">交易信息</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
    <tbody>
    <div class="admin-content">
        <c:choose>
            <c:when test="${null != gatewayPayment}">                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                    <c:if test="${gatewayPayment.purposeType == 'FUND_PAYMENT'}">
                        <c:forEach var="order" items="${requestScope.orderList}" varStatus="status">
                            <tr>
                                活动名称：<a href="/${order.fundCollection.type}/${order.fundCollection.webId}">${order.fundCollection.title}</a><br/>
                            收款方式：${order.fundCollection.allowPayGateType}<br/>
                            活动地址：${order.fundCollection.eventLocation}<br/>
                            姓名：<c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${order.fundCollection.ownerUser.id}"></c:if>${order.fundCollection.ownerUser.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></br>
                            邮箱：${order.fundCollection.ownerUser.email}<br/>
                            <tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${gatewayPayment.purposeType == 'FUND_ADD_FUND'}">
                        充值
                    </c:if>
                    <c:if test="${gatewayPayment.purposeType == 'FUND_YOOPAY_SERVICE'}">
                        友付服务：${gatewayPayment.orderMain.yoopayService.serviceName}
                    </c:if>
                </table>
            </c:when>
            <c:otherwise>
                <h3 class="nolist">列表为空</h3>
            </c:otherwise>
        </c:choose>
    </div>
</tbody>
</table>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>

