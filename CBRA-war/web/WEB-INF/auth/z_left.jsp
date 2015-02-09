<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1>认证体系</h1>
    <ul>
        <li><a href="/auth/design" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>>个人认证</a></li>
        <li><a href="/auth/quality_auth" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>>企业认证</a></li>
    </ul>
</div>