<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_新闻中心" bundle="${bundle}"/> > <fmt:message key="INDEX_筑誉新闻" bundle="${bundle}"/></div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_新闻中心" bundle="${bundle}"/> > <fmt:message key="INDEX_行业新闻" bundle="${bundle}"/></div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="INDEX_新闻中心" bundle="${bundle}"/> > <fmt:message key="GLOBAL_详细信息" bundle="${bundle}"/></div></c:if>
</div>