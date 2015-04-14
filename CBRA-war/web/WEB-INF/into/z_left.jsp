<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <c:if test="${param.page <= 6}">
        <h1><a href="/public/index"><fmt:message key="INDEX_走进筑誉" bundle="${bundle}"/></a></h1>
        <ul>
            <li><a href="/into/idea" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_筑誉理念" bundle="${bundle}"/></a></li>
            <li><a href="/into/pattern" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_业务格局" bundle="${bundle}"/></a></li>
            <li><a href="/into/course " <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_发展历程" bundle="${bundle}"/></a></li>
            <li><a href="/into/speech" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_会长致辞" bundle="${bundle}"/></a></li>
            <li><a href="/into/declaration"<c:if test="${param.page == '5'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_理事宣言" bundle="${bundle}"/></a></li>
            <li><a href="/into/contact_us" <c:if test="${param.page == '6'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_联系我们" bundle="${bundle}"/></a></li>
            </ul>
    </c:if>
    <c:if test="${param.page > 6 && param.page <= 8}">
        <h1><fmt:message key="INDEX_人力资源" bundle="${bundle}"/></h1>
        <ul>
            <li><a href="/into/three_party_offer" <c:if test="${param.page == '7'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_企业人才需求" bundle="${bundle}"/></a></li>
            <li><a href="/into/our_offer" <c:if test="${param.page == '8'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_筑誉人才库" bundle="${bundle}"/></a></li>
            </ul>
    </c:if>
    <c:if test="${param.page > 8 && param.page <= 12}">
        <h1><fmt:message key="INDEX_资源信息" bundle="${bundle}"/></h1>
        <ul>
            <li><a href="/into/purchase" <c:if test="${param.page == '9'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_采购供求信息" bundle="${bundle}"/></a></li>
            <li><a href="/into/overseas" <c:if test="${param.page == '10'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_海外工程合作" bundle="${bundle}"/></a></li>
            <li><a href="/into/building" <c:if test="${param.page == '11'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_建筑产业化合作" bundle="${bundle}"/></a></li>
            <li><a href="/into/pension" <c:if test="${param.page == '12'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_养老地产合作" bundle="${bundle}"/></a></li>
            </ul>
    </c:if>
    <c:if test="${param.page > 12 && param.page <= 16}">
        <h1><fmt:message key="INDEX_前沿领域信息" bundle="${bundle}"/></h1>
        <ul>
            <li><a href="/into/material" <c:if test="${param.page == '13'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_新材料新技术" bundle="${bundle}"/></a></li>
            <li><a href="/into/industrialization" <c:if test="${param.page == '14'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_建筑产业化" bundle="${bundle}"/></a></li>
            <li><a href="/into/green" <c:if test="${param.page == '15'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_绿色建筑" bundle="${bundle}"/></a></li>
            <li><a href="/into/bim" <c:if test="${param.page == '16'}">id="fl-nav-hover"</c:if>><fmt:message key="INDEX_BIM技术" bundle="${bundle}"/></a></li>
            </ul>
    </c:if>
</div>