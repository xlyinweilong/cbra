<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 新闻中心 > 筑誉新闻</div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 新闻中心 > 行业新闻</div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 新闻中心 > 详细信息</div></c:if>
</div>