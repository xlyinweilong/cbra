<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 加入筑誉 > 会员守则</div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 加入筑誉 > 申请个人会员</div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 加入筑誉 > 申请企业会员</div></c:if>
    <c:if test="${param.page == '4'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 加入筑誉 > 筑誉岗位</div></c:if>
    <c:if test="${param.page == '5'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 加入筑誉 > 专家招募</div></c:if>
    <c:if test="${param.page == '6'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 加入筑誉 > 合作伙伴招募</div></c:if>
</div>