<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <c:if test="${param.page <= 6}">
        <h1>专题培训</h1>
        <ul>
            <li><a href="/into/idea" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>>筑誉理念</a></li>
            <li><a href="/into/pattern" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>>业务格局</a></li>
            <li><a href="/into/course " <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>>发展历程</a></li>
            <li><a href="/into/speech" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>>会长致辞</a></li>
            <li><a href="/into/declaration"<c:if test="${param.page == '5'}">id="fl-nav-hover"</c:if>>理事宣言</a></li>
            <li><a href="/into/contact_us" <c:if test="${param.page == '6'}">id="fl-nav-hover"</c:if>>联系我们</a></li>
            </ul>
    </c:if>
    <c:if test="${param.page > 6 && param.page <= 8}">
        <h1>人力资源</h1>
        <ul>
            <li><a href="/into/three_party_offer" <c:if test="${param.page == '7'}">id="fl-nav-hover"</c:if>>企业人才需求</a></li>
            <li><a href="/into/our_offer" <c:if test="${param.page == '8'}">id="fl-nav-hover"</c:if>>筑誉人才库</a></li>
            </ul>
    </c:if>
    <c:if test="${param.page > 8 && param.page <= 12}">
        <h1>资源信息</h1>
        <ul>
            <li><a href="/into/purchase" <c:if test="${param.page == '9'}">id="fl-nav-hover"</c:if>>采购供求信息</a></li>
            <li><a href="/into/overseas" <c:if test="${param.page == '10'}">id="fl-nav-hover"</c:if>>海外工程合作</a></li>
            <li><a href="/into/building" <c:if test="${param.page == '11'}">id="fl-nav-hover"</c:if>>建筑产业化合作</a></li>
            <li><a href="/into/pension" <c:if test="${param.page == '12'}">id="fl-nav-hover"</c:if>>养老地产合作</a></li>
            </ul>
    </c:if>
    <c:if test="${param.page > 12 && param.page <= 16}">
        <h1>前沿领域信息</h1>
        <ul>
            <li><a href="/into/material" <c:if test="${param.page == '13'}">id="fl-nav-hover"</c:if>>新材料新技术</a></li>
            <li><a href="/into/industrialization" <c:if test="${param.page == '14'}">id="fl-nav-hover"</c:if>>建筑产业化</a></li>
            <li><a href="/into/green" <c:if test="${param.page == '15'}">id="fl-nav-hover"</c:if>>绿色建筑</a></li>
            <li><a href="/into/bim" <c:if test="${param.page == '16'}">id="fl-nav-hover"</c:if>>BIM技术</a></li>
            </ul>
    </c:if>
</div>