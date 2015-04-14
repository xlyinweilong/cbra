<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp" />
        <jsp:include page="/WEB-INF/public/z_banner.jsp" />
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="12" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="12" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fm-list">
                    <div class="title"><span><a id="title-span"><fmt:message key="INDEX_养老地产合作" bundle="${bundle}"/></a></span></div>
                    <form id="form1" action="/into/pension" method="post">
                        <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
                    <ul>
                        <c:forEach var="plateInformation" items="${resultList}">
                            <li>
                                <div class="img"><a href="/into/details?id=${plateInformation.id}" target="_blank"><img style="width: 140px; height: 100px;" src="<c:if test="${not empty plateInformation.picUrl}">${plateInformation.picUrl}</c:if><c:if test="${empty plateInformation.picUrl}">/ls/ls-19.jpg</c:if>"></a></div>
                                <div class="con"><a href="/into/details?id=${plateInformation.id}" target="_blank">
                                        <p class="p1">${plateInformation.title}</p>
                                        <p class="p2">${plateInformation.introduction}</p></a>
                                    <p class="p2"><%--<span class="span1"><a href="#">[筑誉动态]</a></span>--%><span>
                                            <fmt:formatDate value='${plateInformation.pushDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />
                                        </span><span class="span2"><a href="/into/details?id=${plateInformation.id}" target="_blank" >[阅读全文]</a></span></p>
                                </div>
                                <div style="clear:both;"></div>
                            </li>
                        </c:forEach>
                    </ul>
                    <div style="clear:both;"></div>
                    <jsp:include page="/WEB-INF/public/z_paging.jsp">
                        <jsp:param name="totalCount" value="${resultList.getTotalCount()}" />
                        <jsp:param name="maxPerPage" value="${resultList.getMaxPerPage()}" />
                        <jsp:param name="pageIndex" value="${resultList.getPageIndex()}" />
                    </jsp:include>
                </form>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
