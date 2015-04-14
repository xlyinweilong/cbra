<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_团队风采" bundle="${bundle}"/> > <fmt:message key="INDEX_理事成员" bundle="${bundle}"/></div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_团队风采" bundle="${bundle}"/> > <fmt:message key="INDEX_委员会" bundle="${bundle}"/></div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_团队风采" bundle="${bundle}"/> > <fmt:message key="INDEX_各地分会" bundle="${bundle}"/></div></c:if>
    <c:if test="${param.page == '4'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_团队风采" bundle="${bundle}"/> > <fmt:message key="INDEX_专家顾问" bundle="${bundle}"/></div></c:if>
    <c:if test="${param.page == '5'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_团队风采" bundle="${bundle}"/> > <fmt:message key="INDEX_部分会员风采" bundle="${bundle}"/></div></c:if>
</div>