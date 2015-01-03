<%-- 
    Document   : add_waiting_list_result
    Created on : Jan 6, 2012, 2:41:47 PM
    Author     : Swang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:set var="useraccount" value="${eventWaitingList.ownerUser}"></c:set>
<c:set var="fundCollection" value="${eventWaitingList.fundCollection}"></c:set>
    <div class="BlueBox">
        <div class="BlueBoxTitle">
            <span class="FloatLeft"><fmt:message key="PAYMENT_DETAIL_TEXT_收款链接" bundle="${bundle}"/>：<a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</a></span>
        <span class="FloatRight">
            <fmt:message key="PAYMENT_DETAIL_TEXT_收款序列号" bundle="${bundle}"/>：${fundCollection.serialId}
        </span>
        <div class="clear"></div>
    </div>
    <div class="successMessage">
        <div class="sucess_title">  
            <fmt:message key="PAYMENT_RESULT_TEXT_您已经在候选名单上了" bundle="${bundle}"/>
        </div>
    </div>
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
                        <c:if test="${fundCollection.ownerUser.sealVerified && fundCollection.ownerUser.accountType=='USER'}">
                        <a href="/user/${fundCollection.ownerUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                        </c:if>
                </div>
            </div>
            <div class="FloatLeft BlueBoxContent">
                <div>
                    <fmt:message key="COLLECT_EDIT_TEXT_活动时间" bundle="${bundle}"/>：
                    ${eventDateDesc} 
                </div>
                <div>
                    <label class="sk-label3 "><fmt:message key="COLLECT_EDIT_TEXT_活动地点" bundle="${bundle}"/>：</label>
                    <c:choose>
                        <c:when test="${not empty fundCollection.eventLocation}">
                            ${fundCollection.eventLocation}
                            <c:if test="${fundCollection.getEventMapUrl()!=null}">
                                <a href="${fundCollection.getEventMapUrl()}" class="MarginL7" target="_blank"><fmt:message key="COLLECT_EDIT_TEXT_查看地图" bundle="${bundle}"/></a> 
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <fmt:message key="COLLECT_EVENT_EDIT_TEXT_主办方" bundle="${bundle}"/>
                    ：${fundCollection.ownerUser.getDisplayName()}（${fundCollection.ownerUser.email}）
                </div>
            </div>
            <div class="Calendar">
                <p class="Month"><fmt:formatDate value="${fundCollection.eventBeginDate}" type="date" pattern="${eventMonthDayParseStyle}"/></p>
                <p class="Day">${eventWeekday}</p>
            </div>     
            <div class="clear"></div>
        </div>
    </div>
</div> 
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 

