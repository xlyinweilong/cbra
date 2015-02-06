<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1>加入筑誉</h1>
    <ul>
        <li><a href="/join/membership_application" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>>会员申请</a></li>
        <li><a href="/join/quarters" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>>筑誉岗位</a></li>
        <li><a href="/join/recruit" <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>>专家招募</a></li>
        <li><a href="/join/cooperation" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>>合作伙伴招募</a></li>
    </ul>
</div>