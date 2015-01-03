<%-- 
    Document   : 收款详细信息导航菜单
    Created on : Jan 6, 2012, 3:42:12 PM
    Author     : Swang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<ul id="detail_tab">
    <%--收款预览 --%>
    <li name="detail_event" <c:if test="${param.menuType=='PREVIEW'}">class="nowpage"</c:if>>
    <a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}" target="_blank">
        <fmt:message key='COLLECT_DETAIL_HEADER_活动' bundle='${bundle}'/>
    </a>
</li>
<li id="tab_edit" <c:if test="${param.menuType=='EDIT'}">class="nowpage"</c:if>><a href="/collect/edit/${fundCollection.webId}"><fmt:message key='COLLECT_DETAIL_HEADER_编辑' bundle='${bundle}'/></a></li>
<li <c:if test="${param.menuType=='PROMOTE_INDEX'}">class="nowpage"</c:if>><a href="/collect/promote_index/${fundCollection.webId}"><fmt:message key='COLLECT_DETAIL_HEADER_邮件邀请' bundle='${bundle}'/></a></li>
<li <c:if test="${param.menuType=='PAYLIST'}">class="nowpage"</c:if>>
<a href="/collect/payment_list/${fundCollection.webId}">
    <c:choose>
        <c:when test="${fundCollection.type=='EVENT'}">
            <fmt:message key='COLLECT_DETAIL_HEADER_EVENT_定单' bundle='${bundle}'/>
        </c:when>
        <c:otherwise>
            <fmt:message key='COLLECT_DETAIL_HEADER_名单' bundle='${bundle}'/>
        </c:otherwise>
    </c:choose>
</a>
</li>
<c:if test="${fundCollection.type=='EVENT'}">
    <li <c:if test="${param.menuType=='TICKETLIST'}">class="nowpage"</c:if>><a href="/collect/ticket_list/${fundCollection.webId}"><fmt:message key='COLLECT_DETAIL_HEADER_EVENT_名单' bundle='${bundle}'/></a></li>
</c:if>
<%--<c:if test="${fundCollection.type=='EVENT'}">
    <li <c:if test="${param.menuType=='WAITINGLIST'}">class="nowpage"</c:if>><a href="/collect/event_waiting_list_list/${fundCollection.webId}"><fmt:message key='COLLECT_MENU_候选' bundle='${bundle}'/></a></li>
</c:if>--%>
<li <c:if test="${param.menuType=='INVOICELIST'}">class="nowpage"</c:if>><a href="/collect/invoice_list/${fundCollection.webId}"><fmt:message key='COLLECT_DETAIL_HEADER_发票' bundle='${bundle}'/></a></li>
<c:if test="${fundCollection.type=='EVENT'}">
    <li <c:if test="${param.menuType=='WIDGET'}">class="nowpage"</c:if>><a href="/collect/widget/${fundCollection.webId}"><fmt:message key='COLLECT_DETAIL_HEADER_微件' bundle='${bundle}'/></a></li>
</c:if>
<c:if test="${fundCollection.type=='EVENT'}">
    <li <c:if test="${param.menuType=='APPROVALLIST'}">class="nowpage"</c:if>><a href="/collect/approval_list/${fundCollection.webId}"><fmt:message key='COLLECT_MENU_审批列表' bundle='${bundle}'/></a></li>
</c:if>
<c:if test="${fundCollection.type=='EVENT'}">
    <li <c:if test="${param.menuType=='CHECKIN'}">class="nowpage"</c:if>><a href="/collect/checkin/${fundCollection.webId}"><fmt:message key='COLLECT_MENU_签到系统' bundle='${bundle}'/></a></li>
</c:if>
</ul>

