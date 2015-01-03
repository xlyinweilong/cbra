<%-- 
    Document   : z_result_service_product_member
    Created on : Jul 13, 2012, 3:22:22 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <span class="FloatLeft"><fmt:message key="PAYMENT_DETAIL_TEXT_收款链接" bundle="${bundle}"/>：<a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</a></span>
        <span class="FloatRight">
            <fmt:message key="PAYMENT_DETAIL_TEXT_收款序列号" bundle="${bundle}"/>：${fundCollection.serialId}
        </span>
        <div class="clear"></div>
    </div>
    <c:choose>
        <c:when test="${status=='SUCCESS'}">
            <%--支付成功 --%>
            <div class="successMessage MarginTop10">
                <div class="sucess_title">
                    <fmt:message key="PAYMENT_RESULT_TEXT_SERVICE_ETC_您已经成功报名参加以下活动" bundle="${bundle}"/>
                    <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_返回订购页面" bundle="${bundle}">
                        <fmt:param value="/payment/payment/${fundCollection.webId}"></fmt:param>
                    </fmt:message>
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
                            <fmt:param value="/payment/payment_order/${firstSubOrder.subSerialId}"></fmt:param>
                        </fmt:message>
                    </div>
                </div>
            </div>
        </c:when>
        <c:when test="${status=='FAILURE'}">
            <%--支付失败 --%>
            <div class="sucess_title2 MarginTop10">
                <fmt:message key="PAYMENT_RESULT_TEXT_付款失败" bundle="${bundle}"/>：<span>${gatewayPayment.paymentGatewayMsg}</span>
                <br />
                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新购买" bundle="${bundle}">
                    <fmt:param value="/payment/payment_order/${firstSubOrder.subSerialId}"></fmt:param>
                </fmt:message>
            </div>
        </c:when>
        <c:otherwise>
        </c:otherwise>
    </c:choose>
    <div class="BlueBox_Gray">
        <div class="BlueBoxContent826">
            <div class="FloatLeft BlueBoxLeft">
                <div class="photo">
                    <c:choose>
                        <c:when test="${not empty fundCollection.ownerUser.logoUrl}">
                            <img src="${fundCollection.ownerUser.logoUrl}" width="80"/>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${fundCollection.ownerUser.accountType=='COMPANY'}">
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
                    <c:if test="${fundCollection.ownerUser.sealVerified && fundCollection.ownerUser.accountType=='COMPANY'}">
                        <a href="/company/${fundCollection.ownerUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                        </c:if>
                        <c:if test="${fundCollection.ownerUser.sealVerified && ffundCollection.ownerUser.accountType=='USER'}">
                        <a href="/user/${fundCollection.ownerUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                        </c:if>
                </div>
            </div>
            <div class="FloatLeft BlueBoxContent">
                <c:choose>
                    <c:when test="${gatewayPayment.gatewayType=='FREE'}">
                        <div>
                            <span class="FloatLeft text16" style="width:500px;"><b>${fundCollection.title}</b></span>
                            <div class="clear"></div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text24 bold">
                            <fmt:formatNumber value="${gatewayPayment.totalAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${gatewayPayment.currencySign}" />    
                        </div>
                        <div>
                            <span class="FloatLeft text16" style="width:500px;">${fundCollection.title}</span>
                            <div class="clear"></div>
                        </div> 
                        <div>
                            <fmt:message key="PAYMENT_DETAIL_TEXT_收款人" bundle="${bundle}"/>：
                            <c:choose>
                                <c:when  test="${fundCollection.ownerUser.accountType=='USER'}">
                                    ${fundCollection.ownerUser.name}
                                </c:when> 
                                <c:when  test="${fundCollection.ownerUser.accountType=='COMPANY'}">
                                    ${fundCollection.ownerUser.company}
                                </c:when> 
                            </c:choose>
                            （${fundCollection.ownerUser.email}）
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
            <div class="clear"></div>
        </div>
    </div>
    <c:if test="${not empty fundCollection.detailDescHtml}">
        <div class="BlueBoxContent826">
            <div class="MarginTop20">
                ${fundCollection.detailDescHtml}
            </div>
        </div>
    </c:if>    
</div> 
