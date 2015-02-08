<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1>专题培训</h1>
    <ul>
        <li><a href="/into/director" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>>理事成员</a></li>
        <li><a href="/into/committee" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>>委员会</a></li>
        <li><a href="/into/branch " <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>>各地分会</a></li>
        <li><a href="/into/expert" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>>领域专家</a></li>
        <li><a href="/into/style" <c:if test="${param.page == '5'}">id="fl-nav-hover"</c:if>>部分会员风采</a></li>
    </ul>
</div>