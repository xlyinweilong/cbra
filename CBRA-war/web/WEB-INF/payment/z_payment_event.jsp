<%--
    Document: Event payment page
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--判断活动是否已结束 --%>
<c:if test="${not empty fundCollection && fundCollection.status=='FINISHED'}">
    <div class="TheEndMessage">
        <fmt:message key="COLLECT_EVENT_EDIT_LABEL_此活动已结束" bundle="${bundle}"/>
    </div>
</c:if>
<%--Set page scope vars --%>
<c:set var="bannerUrl" value="${fundCollection.getEventBannerUrl()}"></c:set>
<form method="POST"  id="payment_form" enctype="multipart/form-data" action="/payment/payment/${fundCollection.webId}" target="_blank">
    <%--活动标题、时间、地点和创建人Logo --%>
    <c:choose>
        <c:when test="${!fundCollection.showInfoOnBanner && bannerUrl != null}">
            <div>
                <img src="${bannerUrl}" width="960" />
            </div>
        </c:when>
        <c:otherwise>
            <div  <c:if test="${bannerUrl != null}">class="EventTitleBg" style="background-image: url('${bannerUrl}')"</c:if>>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="EventTitle">
                    <tr>
                        <td width="690" align="left" valign="bottom"  >
                            <div class="text24 bold" id="title">
                                ${fundCollection.title}    
                            </div> 
                            <div class="text16">
                                <div>
                                    ${eventDateDesc} 
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${not empty fundCollection.eventLocation}">
                                            ${fundCollection.eventLocation}
                                        </c:when>
                                        <c:otherwise>
                                            &nbsp;
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </td>
                        <td align="right" valign="bottom">
                            <div class="photo_1">
                                <c:choose>
                                    <c:when test="${not empty fundCollection.eventLogoUrl}">
                                        <img src="${fundCollection.eventLogoUrl}" width="250"/>
                                    </c:when>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
    <div>
        <div class="FloatLeft MarginTop10" style=" width: 690px;">
            <div class="active_box">
                <div class="clear"></div>
                <div class="money_sail">
                    <div>
                        <fmt:message key="PAYMENT_DETAIL_TEXT_门票" bundle="${bundle}"/>
                    </div>
                    <div class="FloatRight" style="margin-right:25px;_margin-right:25px;">
                    </div>
                </div>
                <%------------------Payment Step 1:Select Ticket -----------------------%>
                <%@include file="/WEB-INF/payment/z_payment_step1.jsp" %>
                <div id="payment_step2_container">
                    <c:if test="${not empty subCollectionOrder}">
                        <%------------------Payment Step 2:Input Payer and Attendee Information;Gateway Select-----------------------%>
                        <%@include file="/WEB-INF/payment/z_payment_step2_basic.jsp" %>
                    </c:if>
                </div>
            </div>
            <div class="clear"></div>
            <c:if test="${!fundCollection.isEmptyDesAttach()||fundCollection.getEventPosterUrl()!=null||not empty fundCollection.detailDesc}">
                <%--收款附件--%>
                <div class="active_box">
                    <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_活动细节" bundle="${bundle}"/></div>
                    <div class="Padding5">
                        <c:if test="${!fundCollection.isEmptyDesAttach()}">
                            <dl class="AttachmentMessage">
                                <dt><fmt:message key="PAYMENT_DETAIL_LABEL_附件" bundle="${bundle}"/></dt>
                                <c:forEach var="attatch" items="${fundCollection.fundCollectionDesAttatch}" varStatus="status"> 
                                    <c:if test="${!attatch.deleted}">
                                        <dd id="attatch_${attatch.id}" class="${attatch.getFileType()}">
                                            <a href="javascript:;"onclick="Collect.downloadAttatch(${attatch.id});return false;">
                                                <c:choose>
                                                    <c:when test="${not empty attatch.customedFileName}">
                                                        ${attatch.customedFileName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${attatch.fileName}
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <input name="attatch_id" value="${attatch.id}" type="hidden"/>
                                        </dd>
                                    </c:if>
                                </c:forEach>
                                <div class="clear"></div>
                            </dl>
                        </c:if>
                        <%--收款海报和说明信息--%>
                        <c:if test="${fundCollection.type=='EVENT' && fundCollection.getEventPosterUrl()!=null}">   
                            <div class="MarginTop20"><img width="680"src="${fundCollection.getEventPosterUrl()}"/></div>
                        </c:if>
                        <c:if test="${not empty fundCollection.detailDesc}">
                            <div class="TextareaHtml">
                                ${fundCollection.detailDesc}
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
            <%--已报名参加者列表 --%>
            <c:if test="${fundCollection.showAttendeeList && not empty ticketList}">
                <div class="active_box">
                    <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_参加者列表" bundle="${bundle}"/></div>
                    <div class="Padding1020">
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
        </div>
        <%--页面右侧活动时间和地点以及地图 --%>
        <div class="FloatRight MarginTop10" style="width: 250px;">
            <div  class="active_box">
                <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_时间地点" bundle="${bundle}"/></div>
                <div class="map">
                    <c:if test="${fundCollection.getEventMapUrl()!=null}">   
                        <div>
                            <a href="${fundCollection.getEventMapUrl()}" target="_blank"><img style=" width: 210px;" src="${fundCollection.getEventMapUrl()}"/></a>
                        </div>
                    </c:if>
                    <p>
                    <c:choose>
                        <c:when test="${not empty fundCollection.eventLocation}">
                            ${fundCollection.eventLocation}
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                    </p>
                    <p>${eventDateDesc} </p>
                </div>
            </div>
            <div  class="active_box">
                <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_主办方" bundle="${bundle}"/></div>
                <div class="map">
                    <h1>
                        ${fundCollection.eventHost}
                    </h1>
                    <input value="<fmt:message key='PAYMENT_DETAIL_LABEL_联系主办方' bundle="${bundle}"/>" class="collection_button_giay MarginBottom5" type="button" onclick="ContactHostDialog.open();">
                           <p>${fundCollection.eventHostDesc}</p>
                </div>
            </div>
        </div>
        <div class="clear"></div>

    </div>
    <input type="hidden" name="cwebid" value="${fundCollection.webId}" id="cwebid"/>
    <input type="hidden" name="request_from_page" value="SOURCE_BASIC" />

</form>
<%----------------------------------------Dialog -------------------------------%>
<div id="contactHostDialog" style="display:none">        
    <%@include  file="/WEB-INF/payment/z_contact_host.jsp"%>
</div>
<div id="contactHostSuccessDialog" style="display:none">        
    <fmt:message key="PAYMENT_DETAIL_LABEL_您的信息已成功发出" bundle="${bundle}"/><br>
    <p class="TextAlignRight"><input type="button" class="collection_button" onclick="ContactHostSuccessDialog.close()" value="<fmt:message key="GLOBAL_关闭" bundle="${bundle}"/>">
    </p>
</div>

<%-----------------------------------------JavaScript templates--------------------------------------- --%>
<%@include file="/WEB-INF/payment/z_payment_javascript_template.jsp" %>

