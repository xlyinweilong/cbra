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
        <jsp:include page="/WEB-INF/train/z_train_banner.jsp"><jsp:param name="page" value="3" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/train/z_left.jsp"><jsp:param name="page" value="3" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fm-list">
                    <form id="form1" action="/train/period_train" method="post">
                        <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
                    <div class="title"><span><a id="title-span"><fmt:message key="INDEX_往期培训" bundle="${bundle}"/></a></span></div>
                    <ul>
                        <c:forEach var="fundCollection" items="${resultList}">
                            <li>
                                <div class="img"><a href="/train/train_details?id=${fundCollection.id}" target="_blank"><img style="width: 140px; height: 100px;" src="<c:if test="${not empty fundCollection.imageUrl}">${fundCollection.imageUrl}</c:if><c:if test="${empty fundCollection.imageUrl}">/ls/ls-19.jpg</c:if>"></a></div>
                                <div class="con"><a href="/train/train_details?id=${fundCollection.id}" target="_blank">
                                        <p class="p1">${fundCollection.title}</p>
                                        <p class="p2">地点：${fundCollection.eventLocation}</p></a>
                                    <p class="p2"><%--<span class="span1"><a href="#">[筑誉动态]</a></span>--%><span>
                                            <fmt:formatDate value='${fundCollection.eventBeginDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />
                                        </span><span class="span2"><a href="/train/train_details?id=${fundCollection.id}" target="_blank" >[阅读全文]</a></span></p>
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
