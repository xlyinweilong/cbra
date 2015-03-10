<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<h1>
    <c:if test="${sessionScope.user.type == 'USER'}">个人会员中心</c:if>
    <c:if test="${sessionScope.user.type == 'COMPANY'}">企业会员中心</c:if>
    <c:if test="${sessionScope.user.type == 'SUB_COMPANY'}">企业会员中心</c:if>
</h1>
<ul>
    <li><a href="/account/overview<c:if test="${sessionScope.user.type == 'COMPANY' || sessionScope.user.type == 'SUB_COMPANY'}">_c</c:if>" <c:if test="${param.page == '1'}">id="mc-nav"</c:if>>基本信息</a></li>
    <li><a href="/account/membership_fee" <c:if test="${param.page == '2'}">id="mc-nav"</c:if>>会费</a></li>
    <li><a href="/account/my_event" <c:if test="${param.page == '3'}">id="mc-nav"</c:if>>参与的活动</a></li>
    <c:if test="${sessionScope.user.type == 'COMPANY'}">
        <li><a href="/account/agent" <c:if test="${param.page == '4'}">id="mc-nav"</c:if>>设置登录代表</a></li>
        <li><a href="/account/modify_passwd" <c:if test="${param.page == '5'}">id="mc-nav"</c:if>>修改密码</a></li>
    </c:if>
    <li><a href="/account/logout?a=logout">退出</a></li>
</ul>