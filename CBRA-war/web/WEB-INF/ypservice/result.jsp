<%-- 
    Document   : result
    Created on : Sep 11, 2012, 10:56:30 AM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.YOOPAY_SERVICE);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxContent">
         <%-------------------------支付结果信息 -------------------------------%>
        <div>
            <c:choose>
                <c:when test="${status=='SUCCESS'}">
                    <%--支付成功 --%>
                    <div class="successMessage MarginTop10">
                        <div class="sucess_title">
                            <fmt:message key="PAYMENT_RESULT_TEXT_付款成功" bundle="${bundle}"/><br/>
                        </div>
                    </div>
                </c:when>
                <c:when test="${status=='PENDING_PAYMENT_CONFIRM'}">
                    <%--支付成功，但需要审批确认：银行转账 --%>
                    <div class="noticeMessage MarginTop10">
                        <div class="loadingMessage" style="padding-bottom: 10px">
                            <fmt:message key="PAYMENT_RESULT_TEXT_审批中" bundle="${bundle}"/>
                        </div>
                    </div>
                </c:when>
                <c:when test="${status=='PENDING_PAYMENT'}">
                    <%--待支付状态：正在处理支付结果中 --%>
                    <div class="noticeMessage MarginTop10">
                        <div class="loadingMessage" style="padding-bottom: 10px">
                            <%--发送连续的请求检测支付结果 --%>
                            <c:set value="true" var="statusDetection"></c:set>
                            <div id="result_progressmsg">
                                <fmt:message key="PAYMENT_RESULT_TEXT_正在处理支付结果" bundle="${bundle}"/>
                            </div>
                            <div id="result_progressbar"></div>
                            <div style="display: none;" id="result_back_msg">
                                <%--支付失败时，显示重新支付链接 --%>
                                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新购买" bundle="${bundle}">
                                    <fmt:param value="/ypservice/pay/${ypService.serviceType}"></fmt:param>
                                </fmt:message>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${status=='FAILURE'}">
                    <%--支付失败 --%>
                    <div class="sucess_title2 MarginTop10">
                        <fmt:message key="PAYMENT_RESULT_TEXT_充值失败" bundle="${bundle}"/>：<span>${gatewayPayment.paymentGatewayMsg}</span>
                        <br />
                        <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新购买" bundle="${bundle}">
                            <fmt:param value="/ypservice/pay/${ypService.serviceType}"></fmt:param>
                        </fmt:message>
                    </div>
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
        </div>
        <div style="text-align: center;font-size:16px; background:#EFEFEF; padding: 10px 0px;">
            <div class="sk-item  TextAlignLeft">
                <label class="sk-label"><fmt:message key="YP_SERVICE_服务名称" bundle="${bundle}"/>：</label>
                <fmt:message key="YP_SERVICE_NAME_${ypService.serviceName}" bundle="${bundle}"/>
            </div>
            <div class="sk-item  TextAlignLeft">
                <label class="sk-label"><fmt:message key="YP_SERVICE_金额" bundle="${bundle}"/>：</label>
                <fmt:formatNumber value="${ypServiceOrder.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
            </div>
        </div>
       
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(
    function(){
        var gatewayPaymentId = ${gatewayPayment.id};
        var statusDetection = ${statusDetection != null ? true : false};
        if(statusDetection) {
            $("#result_progressbar").progressbar({
                value: 10
            });
            FundPayment.detectCount = 0;
            FundPayment.detectResult(gatewayPaymentId);
        }
    }); 
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
