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
        <jsp:include page="/WEB-INF/event/z_event_banner.jsp"><jsp:param name="page" value="1" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <form id="form1" action="/event/near_future" method="post">
                    <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
                <div class="news-list">
                    <div class="title"><span><a href="/event/near_future" id="title-span"><fmt:message key="INDEX_近期活动" bundle="${bundle}"/></a></span><span><a href="/event/period"><fmt:message key="INDEX_往期活动" bundle="${bundle}"/></a></span></div>
                    <ul>
                        <c:forEach var="fundCollection" items="${resultList}">
                            <li>
                                <div class="img"><a href="/event/event_details?id=${fundCollection.id}" target="_blank"><img style="width: 140px; height: 100px;" src="<c:if test="${not empty fundCollection.imageUrl}">${fundCollection.imageUrl}</c:if><c:if test="${empty fundCollection.imageUrl}">/ls/ls-19.jpg</c:if>"></a></div>
                                <div class="con"><a href="/event/event_details?id=${fundCollection.id}" target="_blank">
                                        <p class="p1">${fundCollection.title}</p>
                                        <p class="p2">地点：${fundCollection.eventLocation}</p></a>
                                    <p class="p2"><%--<span class="span1"><a href="#">[筑誉动态]</a></span>--%><span>
                                            <fmt:formatDate value='${fundCollection.eventBeginDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />
                                        </span><span class="span2"><a href="/event/event_details?id=${fundCollection.id}" target="_blank" >[阅读全文]</a></span></p>
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
                <h1><fmt:message key="INDEX_合作伙伴活动" bundle="${bundle}"/></h1>
                <div class="top-hits">
                    <ul>
                        <c:forEach var="event" items="${hotEventList}">
                            <li><a target="_blank" href="/event/event_details?id=${event.id}">${event.title}</a></li>
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
