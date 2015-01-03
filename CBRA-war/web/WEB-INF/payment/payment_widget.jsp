<%-- 
    Document   : payment_widget
    Created on : Jan 31, 2012, 5:11:22 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--Set i18n bundle--%>

<c:choose>
    <c:when test="${fundCollection.eventLanguage=='CHINESE'}">
        <fmt:setLocale value="zh_CN" scope="session" />
        <fmt:setBundle basename="message" scope="session" var="bundle"/>
        <%
            Cookie cookie = new Cookie("COOKIE_LANG", "zh");
            cookie.setPath("/");
            response.addCookie(cookie);
        %>
    </c:when>
    <c:when test="${fundCollection.eventLanguage=='ENGLISH'}">
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

<jsp:include page="/WEB-INF/public/z_header_widget.jsp"/>
<div class="container"> 
    <div>
        <div class="active_box">
            <form method="POST"  id="payment_form" action="/payment/payment/${fundCollection.webId}" target="_blank">
                <div class="clear"></div>
                <div class="money_sail">
                    <div class="FloatLeft" style="width: 150px">
                        <fmt:message key="PAYMENT_DETAIL_TEXT_门票" bundle="${bundle}"/>
                    </div>

                    <div class="FloatRight" style="width:55px;"><a class="WidgetHeadLogo" href="https://yoopay.cn/" target="_blank"></a></div>
                    <div class="WidgetCHEN"> <a href="javascript:language.doSetChinese()">中文</a> | <a href="javascript:language.doSetEnglish()">English</a>
                    </div> 
                </div>
                <%------------------Payment Step 1:Select Ticket -----------------------%>
                <%@include file="/WEB-INF/payment/z_payment_step1.jsp" %>
                <%------------------Payment Step 2:Input Payer and Attendee Information;Gateway Select-----------------------%>
                <div  class='BlueBox_Gray' id="payment_step2_container">
                    <c:if test="${not empty subCollectionOrder}">
                        <%------------------Payment Step 2:Input Payer and Attendee Information;Gateway Select-----------------------%>
                        <%@include file="/WEB-INF/payment/z_payment_step2_widget.jsp" %>
                    </c:if>
                </div>


                <input type="hidden" name="cwebid" value="${fundCollection.webId}" id="cwebid"/>
                <input type="hidden" name="request_from_page" value="SOURCE_WIDGET" />
            </form>
            <%--已报名参加者列表 --%>
            <c:if test="${fundCollection.showAttendeeList && not empty ticketList}">
                <div class="active_box" style="margin-top: 30px">
                    <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_参加者列表" bundle="${bundle}"/></div>
                    <c:choose>
                        <c:when test="${'big' == sizeWidth}"><c:set value="640px" var="width"></c:set></c:when>
                        <c:otherwise><c:set value="540px" var="width"></c:set></c:otherwise>
                    </c:choose>
                    <div class="Padding1020" style="margin: 0px auto;width: ${width};padding:10px 20px;">
                        <c:forEach var="ticket" items="${ticketList}" varStatus="ticketStatus">
                            <c:if test="${registerInfo[ticket.id][0] != null}">
                                <div style="font-size: 12px;margin-bottom:10px; padding-bottom: 5px; border-bottom: dashed 1px #CCCCCC">
                                    <div>
                                        <c:if test="${fundCollection.eventAttendeeListOption.showName}">
                                            <c:set var="paymentInfo" value="<b>${paymentInfo}${registerInfo[ticket.id][0]}</b>"></c:set>
                                        </c:if>
                                        <c:if test="${fundCollection.eventAttendeeListOption.showCompany || fundCollection.eventAttendeeListOption.showPosition || fundCollection.eventAttendeeListOption.showTicketOrder}">
                                            <c:set var="paymentInfo" value="${paymentInfo}&nbsp;-"></c:set>
                                        </c:if>
                                        <c:if test="${fundCollection.eventAttendeeListOption.showCompany}">
                                            <c:set var="paymentInfo" value="${paymentInfo}&nbsp;${registerInfo[ticket.id][1]}"></c:set>
                                        </c:if>
                                        <c:if test="${fundCollection.eventAttendeeListOption.showPosition}">
                                            <c:if test="${fundCollection.eventAttendeeListOption.showCompany && registerInfo[ticket.id][2] != null}">
                                                <c:set var="paymentInfo" value="${paymentInfo},"></c:set>
                                            </c:if>
                                            <c:set var="paymentInfo" value="${paymentInfo}&nbsp;${registerInfo[ticket.id][2]}"></c:set>
                                        </c:if>
                                        <c:if test="${fundCollection.eventAttendeeListOption.showTicketOrder}">
                                            <c:if test="${fundCollection.eventAttendeeListOption.showPosition||fundCollection.eventAttendeeListOption.showCompany}">
                                                <c:set var="paymentInfo" value="${paymentInfo},"></c:set>
                                            </c:if>
                                            <c:set var="paymentInfo" value="${paymentInfo}&nbsp;${ticket.fundCollectionPrice.name}"></c:set>
                                            <c:if test="${registerInfo[ticket.id][5] != 1}">
                                                <c:set var="paymentInfo" value="${paymentInfo}&nbsp;&nbsp;&times;${registerInfo[ticket.id][5]}"></c:set>
                                            </c:if>
                                        </c:if>
                                        <c:set var="paymentInfo" value="${paymentInfo}<br/>"></c:set>
                                        <c:forEach var="question" items="${registerQuestions}" varStatus="rqStatus">
                                            <c:if test="${question.showOnAttendeeList && registerAnswer[ticket.id][rqStatus.index] != null}">
                                                <c:set var="paymentInfo" value="${paymentInfo}&nbsp;${fn:replace(registerAnswer[ticket.id][rqStatus.index], newLineChar, '<br/>')}"></c:set>
                                            </c:if>
                                        </c:forEach>
                                        <c:out value="${paymentInfo}" escapeXml="false"></c:out>
                                    </div>
                                </div>
                                <c:set var="paymentInfo" value=""></c:set>
                            </c:if>
                        </c:forEach>

                    </div>
                </div>
                <div class="clear"></div>
            </c:if>
            <div class="money_sail_widget_footer">
                <%--a target="_blank" href="https://yoopay.cn/"><div class="RightLogo" style="width:55px;"></div></a--%>
                <div>
                    <fmt:message key="PULIC_Z_EVENT_FOOTER_TEXT_LEFT_WIDGET" bundle="${bundle}"/>　
                </div>
            </div>
        </div>
    </div>
    <%-----------------------------------------JavaScript templates--------------------------------------- --%>
    <%@include file="/WEB-INF/payment/z_payment_javascript_template.jsp" %>
    <script type="text/javascript">
        $(document).ready(
        function(){
            //init widget
            //FundPaymentWidget.init();
        }
    );
    </script>
</div>
<%@include file="/WEB-INF/payment/z_payment_tip_dialog.jsp" %>
<jsp:include page="/WEB-INF/public/z_footer_widget.jsp"/>

