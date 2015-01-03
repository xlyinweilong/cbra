<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="BlueBox" id="abc" cust="b">
    <div class="BlueBoxTitle">
        <span class="FloatLeft">
            <fmt:message key="PAYMENT_DETAIL_TEXT_收款链接" bundle="${bundle}"/>：<a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</a>
        </span>
        <span class="FloatRight">
            <fmt:message key="PAYMENT_DETAIL_TEXT_收款序列号" bundle="${bundle}"/>：${fundCollection.serialId}
        </span>
        <div class="clear"></div>
    </div>
    <form method="POST"  id="payment_form" action="/payment/payment/${fundCollection.webId}" target="_blank">
        <div class="BlueBox_Gray">
            <div class="BlueBoxContent826">
                <div class="FloatLeft BlueBoxLeft">
                    <%--收款人Logo--%>
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
                    <%--收款人认证信息 --%>
                    <div style="float: right;width: 86px;text-align: center">
                        <c:choose>
                            <c:when test="${fundCollection.ownerUser.sealVerified && fundCollection.ownerUser.accountType=='COMPANY'}">
                                <a href="/company/${fundCollection.ownerUser.sealWebId}">
                                    <img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" />
                                </a>
                            </c:when>
                            <c:when test="${fundCollection.ownerUser.sealVerified && fundCollection.ownerUser.accountType=='USER'}">
                                <a href="/user/${fundCollection.ownerUser.sealWebId}">
                                    <img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" />
                                </a>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
                <%--收款名称和主办方名称--%>
                <div class="FloatLeft BlueBoxContent">
                    <div class="text24 bold">
                        ${fundCollection.title}    
                    </div>
                    <div class="text16">
                        <div class="sk-item3 TextAlignLeft">
                            <label class="sk-label3">
                                <c:choose>
                                    <c:when test="${fundCollection.type=='SERVICE'}">
                                        <fmt:message key="COLLECT_SERVICE_EDIT_TEXT_主办方" bundle="${bundle}"/>
                                    </c:when>
                                    <c:when test="${fundCollection.type=='MEMBER'}">
                                        <fmt:message key="COLLECT_MEMBER_EDIT_TEXT_主办方" bundle="${bundle}"/>
                                    </c:when>
                                    <c:when test="${fundCollection.type=='PRODUCT'}">
                                        <fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_主办方" bundle="${bundle}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="COLLECT_EVENT_EDIT_TEXT_主办方" bundle="${bundle}"/>
                                    </c:otherwise>
                                </c:choose>
                                ：</label>${fundCollection.ownerUser.getDisplayName()}
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="BlueBoxContent826" >
            <div class="active_box">
                <div class="money_sail">
                    <div class="FloatLeft">
                        <c:choose>
                            <c:when test="${fundCollection.type=='SERVICE'}">
                                <fmt:message key="COLLECT_SERVICE_EDIT_TEXT_服务费说明" bundle="${bundle}"/>
                            </c:when>
                            <c:when test="${fundCollection.type=='MEMBER'}">
                                <fmt:message key="COLLECT_MEMBER_EDIT_TEXT_会员费说明" bundle="${bundle}"/>
                            </c:when>
                            <c:when test="${fundCollection.type=='PRODUCT'}">
                                <fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_产品费用说明" bundle="${bundle}"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="COLLECT_EVENT_EDIT_TEXT_费用说明" bundle="${bundle}"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="FloatRight" style="margin-right:93px;_margin-right:46px;">
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
            <%--Attachment--%>
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
            <%--收款海报--%>
            <c:if test="${fundCollection.getEventPosterUrl()!=null}">   
                <div class="MarginTop20"><img width="826"src="${fundCollection.getEventPosterUrl()}"/></div>
            </c:if>
            <c:if test="${not empty fundCollection.detailDesc}">
                <div class="TextareaHtml">
                    ${fundCollection.detailDesc}
                </div>
            </c:if>
        </div>
        <input type="hidden" name="cwebid" value="${fundCollection.webId}" id="cwebid"/>
        <input type="hidden" name="request_from_page" value="SOURCE_BASIC" />
    </form>
</div>
<%-----------------------------------------JavaScript templates--------------------------------------- --%>
<%@include file="/WEB-INF/payment/z_payment_javascript_template.jsp" %>
