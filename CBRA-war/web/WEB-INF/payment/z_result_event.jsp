<%-- 
    Document   : result_event
    Created on : Jul 11, 2012, 11:05:52 AM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="active_box">

    <div class="clear"></div>
    <div class="money_sail">
        <div class="FloatLeft" style="width: 150px">
            <fmt:message key="PAYMENT_DETAIL_TEXT_订单信息" bundle="${bundle}"/>
        </div>
        <div class="FloatRight" style="width:55px;">
            <c:if test="${gatewayPayment.source== 'SOURCE_WIDGET'}">
                <a class="headEventImgLogo" href="https://yoopay.cn/" target="_blank"></a>
            </c:if>
        </div>
        <c:if test="${gatewayPayment.source== 'SOURCE_WIDGET'}"><div class="WidgetCHEN"> <a href="javascript:language.doSetChinese()">中文</a> | <a href="javascript:language.doSetEnglish()">English</a></div></c:if>

    </div>
    <div class="BlueBoxContent">
        <%-------------------------支付结果信息 -------------------------------%>
        <div>
            <c:choose>
                <c:when test="${status=='SUCCESS'}">
                    <%--支付成功 --%>
                    <div class="successMessage MarginTop10">
                        <div class="sucess_title">
                            <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_您已经报名成功" bundle="${bundle}"/><br/>
                            <p class="Color333 text12 MarginTop10">
                            <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_一封确认邮件已发送" bundle="${bundle}">
                                <fmt:param value="${mainOrder.owner.email}"></fmt:param>
                                <c:choose>
                                    <c:when test="${gatewayPayment.source== 'SOURCE_BASIC'}">
                                        <fmt:param value="<a href='javascript:void(0);' onclick='ContactHostDialog.open();'>"></fmt:param>
                                        <fmt:param value="</a>"></fmt:param>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:param value=""></fmt:param>
                                        <fmt:param value=""></fmt:param>
                                    </c:otherwise>
                                </c:choose>
                            </fmt:message>
                            </p>
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
                                    <c:when test="${firstSubOrder.parentOrderCollection.paymentCount>=5}">
                                        <fmt:message key="PAYMENT_RESULT_TEXT_FINAL_付款失败" bundle="${bundle}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新购买" bundle="${bundle}">
                                            <fmt:param value="/payment/payment_order/${firstSubOrder.subSerialId}"></fmt:param>
                                        </fmt:message>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${status=='PAYMENT_TIMEOUT'}">
                    <%--支付失败 --%>
                    <div class="sucess_title2 MarginTop10">
                        <c:choose>
                            <c:when test="${firstSubOrder.parentOrderCollection.paymentCount>=5}">
                                <fmt:message key="PAYMENT_RESULT_TEXT_FINAL_付款失败" bundle="${bundle}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="PAYMENT_RESULT_TEXT_付款超时" bundle="${bundle}"/>：<span>${gatewayPayment.paymentGatewayMsg}</span>
                                <br />
                                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新购买" bundle="${bundle}">
                                    <fmt:param value="/payment/payment_order/${firstSubOrder.subSerialId}"></fmt:param>
                                </fmt:message>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:when test="${status=='FAILURE'}">
                    <%--支付失败 --%>
                    <div class="sucess_title2 MarginTop10">
                        <c:choose>
                            <c:when test="${firstSubOrder.parentOrderCollection.paymentCount>=5}">
                                <fmt:message key="PAYMENT_RESULT_TEXT_FINAL_付款失败" bundle="${bundle}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="PAYMENT_RESULT_TEXT_付款失败" bundle="${bundle}"/>：<span>${gatewayPayment.paymentGatewayMsg}</span>
                                <br />
                                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_重新购买" bundle="${bundle}">
                                    <fmt:param value="/payment/payment_order/${firstSubOrder.subSerialId}"></fmt:param>
                                </fmt:message>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
        </div>
        <%--------------------------------------------订单Items列表 ---------------------------------------------------------%>
        <dl>
            <dd class="ticket">
                <span class="spanOne"><fmt:message key="PAYMENT_DETAIL_LABEL_种类" bundle="${bundle}"/></span>
                <span class="spanFour TextAlignCenter">&nbsp;</span>
                <span class="spanFour TextAlignCenter">&nbsp;</span>
                <span class="spanTwo TextAlignCenter"><fmt:message key="PAYMENT_DETAIL_LABEL_价格" bundle="${bundle}"/></span>
                <span class="spanThree TextAlignRight"><fmt:message key="PAYMENT_DETAIL_LABEL_数量" bundle="${bundle}"/></span>
            </dd>
        </dl>
        <dl class="active_dl">
            <c:forEach var="item" items="${itemList}" varStatus="status">
                <c:set value="${item.price}" var="price"/>
                <dd>
                    <%--门票名称 --%>
                    <span class="spanOne">
                        <span>
                            <c:choose>
                                <c:when test="${empty price.name}"><fmt:message key="COLLECT_EDIT_TEXT_票价" bundle="${bundle}"/>${status.count}</c:when>
                                <c:otherwise>${price.name}</c:otherwise>
                            </c:choose>
                        </span>
                        <c:if test="${not empty price.description && !price.showDescription}"><a href="javascript:void(0)" onclick="FundPayment.togglePriceDescrpiton(this);"><fmt:message key="GLOBAL_详情" bundle="${bundle}"/></a></c:if>
                    </span>
                    <span class="spanFour TextAlignCenter">&nbsp;</span>
                    <span class="spanFour TextAlignCenter">&nbsp;</span>
                    <%--价格 --%>
                    <span class="spanTwo TextAlignCenter">
                        <c:choose>
                            <c:when test="${price.isFree()}">
                                <fmt:message key="PAYMENT_PRICE_免费" bundle="${bundle}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${price.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${price.currencySign}" />
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <%--选择数量 --%>
                    <span class="spanThree TextAlignRight ">
                        <label>
                            <b>${item.quantity}</b>
                        </label>
                    </span>
                <c:if test="${not empty price.description}">
                    <div class="TicketDescription" style="<c:if test="${!price.showDescription}">display: none</c:if>">
                    ${price.escapeNRDescription}
                </div>
                </c:if>
                <div class="clear"></div>
                </dd>
            </c:forEach>
        </dl>  
        <%---------------------------价钱总计------------------------------------%>
        <c:if test="${subTotalAmount != '0.00'}">
            <div class="MarginBottom5 MarginTop10 ">
                <%--价钱总计 --%>
                <div class="FloatRight TextAlignRight count_right">
                    <%--未用折扣码前总计 --%>
                    <p>
                        <span><fmt:message key="PAYMENT_DETAIL_TEXT_小计" bundle="${bundle}"/>：</span>
                    <fmt:formatNumber value="${subTotalAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />
                    </p>
                    <c:if test="${discountTotalAmount != '0.00'}">
                        <div id="payment_amount_after_discount_container">
                            <%--折扣总计 --%>
                            <p>
                                <span><fmt:message key="PAYMENT_DETAIL_TEXT_折扣" bundle="${bundle}"/>：</span>
                                -<fmt:formatNumber value="${discountTotalAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />
                            </p>
                            <%--使用折扣码后总计 --%>
                            <p class="yellow">
                                <span><fmt:message key="PAYMENT_DETAIL_TEXT_总计" bundle="${bundle}"/>：</span>
                            <fmt:formatNumber value="${totalAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />
                            </p>

                        </div>
                    </c:if>
                </div>
                <div class="clear"></div>
            </div>
        </c:if>
        <%---------------------------门票下载/返回活动报名页面/联系主办方------------------------------------%>
        <c:if test="${gatewayPayment.status == 'PAYMENT_SUCCESS' || gatewayPayment.hintStatus == 'PAYMENT_PENDING'}">
            <c:if test="${gatewayPayment.status == 'PAYMENT_SUCCESS'}">
                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_请点击这里下载活动门票" bundle="${bundle}"></fmt:message>
                <div class="noticeMessage" style="padding-bottom: 10px;"> 
                    <div id="ticket_prepare_msg" style="display:none" class="loadingMessage">
                        <fmt:message key="PAYMENT_RESULT_TEXT_正在生成门票" bundle="${bundle}"/>
                    </div>
                    <div id="ticket_prepare_progress"></div>
                    <form id="ticket_download_form" action="/payment/ticket_download/${gatewayPayment.id}" method="POST">
                        <input type="hidden" name="ticket_download_filename" id="ticket_download_filename"/>
                    </form>
                </div>
            </c:if>
            <div style="margin-bottom: 10px;">
                <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_返回活动报名页面" bundle="${bundle}">
                    <c:choose>
                        <c:when test="${gatewayPayment.source== 'SOURCE_WIDGET'}">
                            <fmt:param value="/payment/payment_widget/${fundCollection.webId}"></fmt:param>
                        </c:when>
                        <c:otherwise>
                            <fmt:param value="/event/${fundCollection.webId}"></fmt:param>
                        </c:otherwise>
                    </c:choose>
                </fmt:message>
            </div>
            <c:if test="${gatewayPayment.source== 'SOURCE_BASIC'}">
                <div style="margin-top:15px;margin-bottom: 10px">
                    <fmt:message key="PAYMENT_RESULT_TEXT_EVENT_如果您对本活动有任何疑问，请联系主办方" bundle="${bundle}" />
                </div>
            </c:if>
        </c:if>
    </div>
    <c:if test="${gatewayPayment.source== 'SOURCE_WIDGET'}">
        <div class="money_sail RightText">
            <div class="FloatLeft" style="width: 450px;font-size: 12px">
                <fmt:message key="PULIC_Z_EVENT_FOOTER_TEXT_LEFT_WIDGET" bundle="${bundle}"/>
            </div>
            <div class="FloatRight" style="width:55px;"><a class="headEventImgLogo" href="https://yoopay.cn/" target="_blank"></a></div>

        </div>
    </c:if>
</div>