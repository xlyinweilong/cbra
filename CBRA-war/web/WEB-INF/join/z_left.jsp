<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1><fmt:message key="INDEX_加入筑誉" bundle="${bundle}"/></h1>
    <ul>
        <li><a href="/join/membership_application" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_会员申请" bundle="${bundle}"/></a></li>
        <li><a href="/join/quarters" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_筑誉岗位" bundle="${bundle}"/></a></li>
        <li><a href="/join/recruit" <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_专家招募" bundle="${bundle}"/></a></li>
        <li><a href="/join/cooperation" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_合作伙伴招募" bundle="${bundle}"/></a></li>
    </ul>
</div>