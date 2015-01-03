<%-- 
    Document   : charge_result
    Created on : Dec 26, 2012, 6:36:44 PM
    Author     : wangshuai
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:choose>
    <c:when test="${apiChargeOrder.language=='zh'}">
        <fmt:setLocale value="zh_CN" scope="session" />
        <fmt:setBundle basename="message" scope="session" var="bundle"/>
        <%
            Cookie cookie = new Cookie("COOKIE_LANG", "zh");
            cookie.setPath("/");
            response.addCookie(cookie);
        %>
    </c:when>
    <c:when  test="${apiChargeOrder.language=='en'}">
        <fmt:setLocale value="en_US" scope="session" />
        <fmt:setBundle basename="message" scope="session" var="bundle"/>
        <%
            Cookie enCookie = new Cookie("COOKIE_LANG", "en");
            enCookie.setPath("/");
            response.addCookie(enCookie);
        %>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox" id="abc" cust="b">
    <c:if test="${not empty seller.apiBanner}">
        <div style = "text-align: center;"><img src="${seller.apiBanner}" width="940"/></div>
    </c:if>
    <div class="apihead"> 
        <div class="api">

            <div class="FloatLeft BlueBoxLeft">
                <c:if test="${seller.apiShowLogo == null || seller.apiShowLogo}">
                    <div class="photo">
                        <c:choose>
                            <c:when test="${not empty seller.logoUrl}">
                                <img src="${seller.logoUrl}" width="80"/>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${seller.accountType=='COMPANY'}">
                                        <img src="/images/company_logo.png" width="80"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/images/photo.png" width="80"/>
                                    </c:otherwise>
                                </c:choose> 
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <div>
                    <c:if test="${seller.sealVerified && seller.accountType=='COMPANY'}">
                        <a href="/company/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                    </c:if>
                    <c:if test="${linkUser.sealVerified && linkUser.accountType=='USER'}">
                        <a href="/user/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                    </c:if>
                </div>
            </div>
            <div class="FloatLeft" style="width: 698px;">
                <div class="sk-item2 TextAlignLeft">
                    <label class="sk-label2">
                        <fmt:message key="PAYMENT_DETAIL_TEXT_收款人" bundle="${bundle}"/>：</label>
                    <span class="text24 bold">
                        <c:choose>
                            <c:when  test="${seller.accountType=='USER'}">
                                ${seller.name}
                            </c:when> 
                            <c:when  test="${seller.accountType=='COMPANY'}">
                                ${seller.company}
                            </c:when> 
                        </c:choose>
                    </span>
                </div> 
                <div class="sk-item2 TextAlignLeft">
                    <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_转款金额" bundle="${bundle}"/>：</label>
                    <input type="hidden" name="" value="${apiChargeOrder.amount}" id="payment_amount" disabled="disabled"/>
                    <fmt:formatNumber value="${apiChargeOrder.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${apiChargeOrder.currencySign}" /> 
                </div>
                <div class="sk-item2 TextAlignLeft">
                    <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_事由" bundle="${bundle}"/>：</label>
                    ${apiChargeOrder.itemName} <br/>
                    ${apiChargeOrder.itemBody}
                </div>
            </div>            
            <div class="clear"></div>
        </div>
    </div>
    <div >         
        <div class="api" style=" margin-top: 50px;" id="payment_style_choose">
            <p><fmt:message key="PAYMENT_DETAIL_LABEL_支付结果" bundle="${bundle}"/></p>
            <c:choose>
                <c:when test="${status=='SUCCESS'}">
                    <%--支付成功 --%>
                    <div class="successMessage MarginTop10">
                        <div class="sucess_title">
                            <fmt:message key="PAYMENT_RESULT_TEXT_支付成功" bundle="${bundle}"/><br/>
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
                                <c:choose>
                                    <c:when test="${apiChargeOrder.paymentCount>=5}">
                                        <div class="tishi">
                                            <fmt:message key="PAYMENT_RESULT_TEXT_FINAL_付款失败" bundle="${bundle}"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新支付" bundle="${bundle}">
                                            <fmt:param value="/paygate_api/charge_order/${apiChargeOrder.serialId}"></fmt:param>
                                        </fmt:message>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${status=='FAILURE'}">

                    <%--支付失败 --%>
                    <c:choose>
                        <c:when test="${apiChargeOrder.paymentCount>=5}">
                            <div class="tishi">
                                <fmt:message key="PAYMENT_RESULT_TEXT_FINAL_付款失败" bundle="${bundle}"/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="sucess_title2 MarginTop10">
                                <fmt:message key="PAYMENT_RESULT_TEXT_付款失败" bundle="${bundle}"/>：<span>${gatewayPayment.paymentGatewayMsg}</span>
                                <br />
                                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新支付" bundle="${bundle}">
                                    <fmt:param value="/paygate_api/charge_order/${apiChargeOrder.serialId}"></fmt:param>
                                </fmt:message>
                            </div>
                        </c:otherwise>
                    </c:choose>

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

