<%-- 
    Document   : 候选名单
    Created on : Jan 6, 2012, 3:38:34 PM
    Author     : Swang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>

    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="WAITINGLIST"/>
            </jsp:include>
        </div>

        <c:choose>
            <c:when test="${empty eventWaitListList &&eventWaitListList.getTotalCount()==0}">
                <h3 class="nolist"><fmt:message key="GLOBAL_MSG_BLANK_LIST" bundle="${bundle}"/></h3>
            </c:when>
            <c:otherwise>
                <div id="detail_payment_list">
                    <div class="PaymentListHeader">
                        <div class="FloatLeft text16 bold">
                            <fmt:message key="COLLECT_DETAIL_LABEL_候选人" bundle="${bundle}"/>：${eventWaitListList.getTotalCount()} <fmt:message key="COLLECT_DETAIL_LABEL_人" bundle="${bundle}"/>
                        </div>
                        <div class="FloatRight"> 
                            <a href="javascript:void(0);" onclick="Collect.downloadWaitingList(${eventWaitListList.getTotalCount()},'${fundCollection.webId}');return false;">
                                <fmt:message key="COLLECT_DETAIL_LINK_下载候选人名单" bundle="${bundle}"/>
                            </a>
                            <span id="collect_waiting_download" style="color: red;display: none" ></span>
                        </div> 
                        <div class="clear"></div>
                    </div>
                    <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table">
                        <thead>  
                            <tr>
                                <td width="14%"><fmt:message key='COLLECT_LIST_LABEL_DATE' bundle='${bundle}'/></td> 
                                <td width="8%"><fmt:message key='COLLECT_DETAIL_LABEL_姓名' bundle='${bundle}'/></td> 
                                <td width="12%"><fmt:message key='COLLECT_DETAIL_LABEL_公司' bundle='${bundle}'/></td> 
                                <td width="9%"><fmt:message key='COLLECT_DETAIL_LABEL_职务' bundle='${bundle}'/></td> 
                                <td width="12%"><fmt:message key='COLLECT_DETAIL_LABEL_手机' bundle='${bundle}'/></td>
                                <td width="17%"><fmt:message key='COLLECT_DETAIL_LABEL_邮箱' bundle='${bundle}'/></td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty eventWaitListList}">

                                    <c:forEach var="eventWaitingList" items="${eventWaitListList}" varStatus="status">
                                        <c:set var="useraccount" value="${eventWaitingList.ownerUser}"></c:set>
                                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                                            <td><fmt:formatDate value="${eventWaitingList.createDate}" type="date" pattern="yyyy.MM.dd HH:mm"/></td> 
                                            <td>${useraccount.name}</td> 
                                            <td>${useraccount.company}</td>  
                                            <td>${useraccount.position}</td> 
                                            <td>${useraccount.mobilePhone}</td> 
                                            <td>${useraccount.email}</td> 
                                        </tr>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                        </tbody>
                    </table>
                    <c:if test="${not empty eventWaitListList}">
                        <jsp:include page="/WEB-INF/public/z_paging.jsp">
                            <jsp:param name="baseUrl" value="/collect/event_waiting_list_list/${fundCollection.webId}" />
                            <jsp:param name="totalCount" value="${eventWaitListList.getTotalCount()}" />
                            <jsp:param name="maxPerPage" value="${eventWaitListList.getMaxPerPage()}" />
                            <jsp:param name="pageIndex" value="${eventWaitListList.getPageIndex()}" />
                        </jsp:include>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>


    </div>            
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
