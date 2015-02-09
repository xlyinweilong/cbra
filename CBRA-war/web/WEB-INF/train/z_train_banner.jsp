<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 专题培训 > 培训理念</div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 专题培训 > 近期培训</div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 专题培训 > 往期培训</div></c:if>
    <c:if test="${param.page == '4'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 专题培训 > 讲师团队</div></c:if>
</div>