<%-- 
    Document   : 收款详细信息Header模版：收款链接和统计信息
    Created on : Dec 31, 2011, 11:25:06 AM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:choose>
    <c:when test="${fundCollection.type=='EVENT'}">
        <span class="FloatLeft" id="collect_link">
            <fmt:message key="COLLECT_EDIT_TEXT_活动链接" bundle="${bundle}"/>：<a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</a>
        </span>
        <span class="FloatRight">
            <jsp:include page="/WEB-INF/collect/z_collect_header_right.jsp"/>
        </span>
    </c:when>
    <c:otherwise>
        <span class="FloatLeft" id="collect_link">
            <fmt:message key="COLLECT_EDIT_TEXT_收款链接" bundle="${bundle}"/>：<a href="/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</a>
        </span>
        <span class="FloatRight">
            <jsp:include page="/WEB-INF/collect/z_collect_header_right.jsp"/>
        </span>
    </c:otherwise>
</c:choose>
