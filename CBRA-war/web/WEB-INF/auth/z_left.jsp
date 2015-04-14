<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1><fmt:message key="INDEX_认证体系" bundle="${bundle}"/></h1>
    <ul>
        <li><a href="/auth/design" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_个人认证" bundle="${bundle}"/></a></li>
        <li><a href="/auth/quality_auth" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_企业认证" bundle="${bundle}"/></a></li>
    </ul>
</div>