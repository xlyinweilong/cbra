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
        <jsp:include page="/WEB-INF/news/z_news_banner.jsp"><jsp:param name="page" value="2" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <form id="form1" action="/news/news_list" method="post">
                    <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
                <div class="news-list">
                    <div class="title"><span><a href="/news/news_list">筑誉新闻</a></span><span><a id="title-span" href="/news/industry_list">行业新闻</a></span></div>
                    <ul>
                        <c:forEach var="plateInformation" items="${resultList}">
                            <li>
                                <div class="img"><a href="details" target="_blank"><img style="width: 140px; height: 100px;" src="<c:if test="${not empty plateInformation.picUrl}">${plateInformation.picUrl}</c:if><c:if test="${empty plateInformation.picUrl}">/ls/ls-19.jpg</c:if>"></a></div>
                                <div class="con"><a href="/news/details?id=${plateInformation.id}" target="_blank">
                                        <p class="p1">${plateInformation.title}</p>
                                        <p class="p2">${plateInformation.introduction}</p></a>
                                    <p class="p2"><%--<span class="span1"><a href="#">[筑誉动态]</a></span>--%><span>
                                            <fmt:formatDate value='${plateInformation.pushDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />
                                        </span><span class="span2"><a href="/news/details?id=${plateInformation.id}" target="_blank" >[阅读全文]</a></span></p>
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
                </div>
            </form>
            <div class="news-fr">
                <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
                <h1>热门点击</h1>
                <div class="top-hits">
                    <ul>
                        <c:forEach var="palteInfo" items="${plateInfoHots}">
                            <li><a href="/news/details?id=${palteInfo.id}" target="_blank">${palteInfo.titleIndexStr3}</a></li>
                            </c:forEach>
                    </ul>
                </div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
