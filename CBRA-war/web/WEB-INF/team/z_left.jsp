<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1><fmt:message key="INDEX_团队风采" bundle="${bundle}"/></h1>
    <ul>
        <li><a href="/team/director" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_理事成员" bundle="${bundle}"/></a></li>
        <%--<li><a href="/team/committee" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>>委员会</a></li>--%>
        <li><a href="/team/branch " <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_各地分会" bundle="${bundle}"/></a></li>
        <li><a href="/team/expert" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_专家顾问" bundle="${bundle}"/></a></li>
        <li><a href="/team/style" <c:if test="${param.page == '5'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_部分会员风采" bundle="${bundle}"/></a></li>
    </ul>
</div>