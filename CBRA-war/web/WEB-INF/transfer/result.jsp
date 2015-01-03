<%-- 
    Document   : result
    Created on : Apr 18, 2011, 8:37:21 PM
    Author     : WangShuai
    转款支付结果页面
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox" id="abc" cust="b">
    <div class="BlueBoxTitle">
        <span class="FloatLeft">
            <c:set var="linkUser" value="${transferOrder.toUser}"/>
            <fmt:message key="TRANSFER_LINKTRANSFER_TEXT_友付链接" bundle="${bundle}">
                <fmt:param value="${transferOrder.toUser.displayName}"/>
            </fmt:message>
            <c:choose>
                <c:when test="${transferOrder.toUser.accountType=='USER'}">
                    <a href="/p/${transferOrder.toUser.ypLinkId}">https://yoopay.cn/p/${transferOrder.toUser.ypLinkId}</a>
                </c:when>
                <c:otherwise>
                    <a href="/o/${transferOrder.toUser.ypLinkId}">https://yoopay.cn/o/${transferOrder.toUser.ypLinkId}</a>
                </c:otherwise>
            </c:choose>
        </span>
        <div class="clear"></div>
    </div>
    <div class="BlueBox_Gray">
        <div class="BlueBoxContent826">
            <div class="FloatLeft BlueBoxLeft">
                <div class="photo">
                    <c:choose>
                        <c:when test="${not empty linkUser.logoUrl}">
                            <img src="${linkUser.logoUrl}" width="80"/>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${linkUser.accountType=='COMPANY'}">
                                    <img src="/images/company_logo.png" width="80"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="/images/photo.png" width="80"/>
                                </c:otherwise>
                            </c:choose> 
                        </c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <c:if test="${linkUser.sealVerified && linkUser.accountType=='COMPANY'}">
                        <a href="/company/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                        </c:if>
                        <c:if test="${linkUser.sealVerified && linkUser.accountType=='USER'}">
                        <a href="/user/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                        </c:if>
                </div>
            </div>
            <div class="FloatLeft BlueBoxContent">
                <div class="sk-item2 TextAlignLeft">
                    <label class="sk-label2">
                        <fmt:message key="PAYMENT_DETAIL_TEXT_收款人" bundle="${bundle}"/>：</label>
                    <span  class="text24 bold">
                        <c:choose>

                            <c:when  test="${linkUser.accountType=='USER'}">
                                ${linkUser.name}
                            </c:when> 
                            <c:when  test="${linkUser.accountType=='COMPANY'}">
                                ${linkUser.company}
                            </c:when> 

                        </c:choose>
                    </span>
                    <c:choose>
                        <c:when test="${linkUser.sealVerified && linkUser.accountType=='COMPANY'}">
                            （<a href="/company/${linkUser.sealWebId}">${linkUser.email}</a>）
                        </c:when>
                        <c:when test="${linkUser.sealVerified && linkUser.accountType=='USER'}">
                            （<a href="/user/${linkUser.sealWebId}">${linkUser.email}</a>）
                        </c:when>
                        <c:otherwise>
                            （${linkUser.email}）
                        </c:otherwise>
                    </c:choose>
                </div> 

                <div class="sk-item2 TextAlignLeft">
                    <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_转款金额" bundle="${bundle}"/>：</label>
                    <fmt:formatNumber value="${transferOrder.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${transferOrder.currencySign}" />
                </div>
                <div class="sk-item2 TextAlignLeft">
                    <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_事由" bundle="${bundle}"/>：</label>
                    ${transferOrder.title}
                </div>
            </div>            
            <div class="clear"></div>
        </div>
    </div>
</div>
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
                                    <fmt:param value="/transfer/create/${transferOrder.toUser.ypLinkId}"></fmt:param>
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
                            <fmt:param value="/transfer/create/${transferOrder.toUser.ypLinkId}"></fmt:param>
                        </fmt:message>
                    </div>
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
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
