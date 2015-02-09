<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '1'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 认证体系 > 个人认证</div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 认证体系 > 企业认证</div></c:if>
</div>