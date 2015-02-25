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
        <jsp:include page="/WEB-INF/join/z_join_banner.jsp"><jsp:param name="page" value="4" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/join/z_left.jsp"><jsp:param name="page" value="2" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fr-con">
                    <div class="title"><span><a id="title-span">筑誉岗位</a></span></div>
                    <div class="con-single">
                        <div class="title-gw">
                            <span class="span-1">职位名称</span><span class="span-2">工作地点</span><span class="span-2">部门</span><span>发布时间</span>
                        </div>
                    <c:forEach items="${resultList}" var="offer">
                        <div class="title-zw">
                            <a href="/join/quarters_details?id=${offer.id}"><span class="span-1">${offer.position}</span><span class="span-2">${offer.city}</span><span class="span-2">${offer.depart}</span><span><fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' /></span></a>
                        </div>
                    </c:forEach>
                    <form id="form1" action="/join/quarters" method="post">
                        <input type="hidden" name="page" id="page_num" value="${resultList.getPageIndex()}" />
                        <jsp:include page="/WEB-INF/public/z_paging.jsp">
                            <jsp:param name="totalCount" value="${resultList.getTotalCount()}" />
                            <jsp:param name="maxPerPage" value="${resultList.getMaxPerPage()}" />
                            <jsp:param name="pageIndex" value="${resultList.getPageIndex()}" />
                        </jsp:include>
                    </form>
                </div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
