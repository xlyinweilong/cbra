<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<h1>
    <c:if test="${sessionScope.user.type == 'USER'}"><fmt:message key="GLOBAL_个人会员中心" bundle="${bundle}"/></c:if>
    <c:if test="${sessionScope.user.type == 'COMPANY'}"><fmt:message key="GLOBAL_企业会员中心" bundle="${bundle}"/></c:if>
    <c:if test="${sessionScope.user.type == 'SUB_COMPANY'}"><fmt:message key="GLOBAL_企业会员中心" bundle="${bundle}"/></c:if>
    </h1>
    <ul>
        <li><a href="/account/overview<c:if test="${sessionScope.user.type == 'COMPANY' || sessionScope.user.type == 'SUB_COMPANY'}">_c</c:if>" <c:if test="${param.page == '1'}">id="mc-nav"</c:if>><fmt:message key="GLOBAL_基本信息" bundle="${bundle}"/></a></li>
    <li><a href="/account/membership_fee" <c:if test="${param.page == '2'}">id="mc-nav"</c:if>><fmt:message key="GLOBAL_会费" bundle="${bundle}"/></a></li>
    <li><a href="/account/my_event" <c:if test="${param.page == '3'}">id="mc-nav"</c:if>><fmt:message key="GLOBAL_参与的活动" bundle="${bundle}"/></a></li>
        <c:if test="${sessionScope.user.type == 'COMPANY'}">
        <li><a href="/account/agent" <c:if test="${param.page == '4'}">id="mc-nav"</c:if>><fmt:message key="GLOBAL_设置登录代表" bundle="${bundle}"/></a></li>
        </c:if>
        <li><a href="/account/modify_passwd" <c:if test="${param.page == '5'}">id="mc-nav"</c:if>><fmt:message key="GLOBAL_修改密码" bundle="${bundle}"/></a></li>
    <li><a href="/account/logout?a=logout"><fmt:message key="GLOBAL_退出" bundle="${bundle}"/></a></li>
</ul>