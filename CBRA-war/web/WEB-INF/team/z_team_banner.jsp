<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 团队风采 > 理事成员</div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 团队风采 > 委员会</div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 团队风采 > 各地分会</div></c:if>
    <c:if test="${param.page == '4'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 团队风采 > 专家顾问</div></c:if>
    <c:if test="${param.page == '5'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 团队风采 > 部分会员风采</div></c:if>
</div>