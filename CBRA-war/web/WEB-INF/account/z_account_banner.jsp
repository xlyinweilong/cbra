<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="two-loc">
    <div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > <c:if test="${sessionScope.user.type == 'COMPANY' || sessionScope.user == 'SUB_COMPANY'}">企业会员中心</c:if><c:if test="${sessionScope.user.type == 'USER'}">个人会员中心</c:if></div>
</div>