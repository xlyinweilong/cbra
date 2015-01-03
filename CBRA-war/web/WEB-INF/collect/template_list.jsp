<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : 收款列表
    Created on : Apr 10, 2011, 8:01:36 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_TEMPLATE_LIST);
%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:choose>
    <c:when test="${empty fundCollectionList}">
        <h3 class="nolist">${postResult.singleErrorMsg}</h3>
    </c:when>
    <c:otherwise>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
            <thead>
                <tr>
                    <td width="10%"><fmt:message key="COLLECT_LIST_LABEL_DATE" bundle="${bundle}"/></td>
                    <td width="15%"><fmt:message key="COLLECT_LIST_LABEL_SERAIL" bundle="${bundle}"/></td>
                    <td width="10%"><fmt:message key="COLLECT_LIST_LABEL_类型" bundle="${bundle}"/></td>
                    <td width="35%"><fmt:message key="COLLECT_LIST_LABEL_名称" bundle="${bundle}"/></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="fundCollection" items="${fundCollectionList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                        <td><fmt:formatDate value="${fundCollection.createDate}" pattern="yyyy.MM.dd" type="date" dateStyle="long" /></td>
                        <td>${fundCollection.serialId}</td>
                        <td><fmt:message key="COLLECT_EDIT_LABEL_活动收款" bundle="${bundle}"/></td>
                        <td><a href="/collect/edit/${fundCollection.webId}" title="">${fundCollection.title}</a></td>
                    </tr>
                    </c:forEach>
            </tbody>
        </table>
        <%--Set page jump base url --%>
        <c:set value="/collect/list/event" var="pageBaseUrl" scope="page"/>

        <jsp:include page="/WEB-INF/public/z_paging.jsp">
            <jsp:param name="baseUrl" value="${pageBaseUrl}" />
            <jsp:param name="totalCount" value="${fundCollectionList.getTotalCount()}" />
            <jsp:param name="maxPerPage" value="${fundCollectionList.getMaxPerPage()}" />
            <jsp:param name="pageIndex" value="${fundCollectionList.getPageIndex()}" />
        </jsp:include>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
