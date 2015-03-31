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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="8" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="8" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fr-con">
                    <form id="form1" action="/into/our_offer" method="post">
                        <div class="title"><span><a id="title-span">筑誉人才库</a></span><div class="Search"><input type="text" name="searchName" value="${searchName}" class="se-k"><input type="submit" class="se-a" value="搜索"></div></div>
                        <div class="con-single">
                            <div class="title-rc">
                                <span class="span-1">姓名</span><span class="span-2">当前就职公司</span><span class="span-1">从业年限</span><span class="span-1">职务</span><span class="span-1">手机</span><span class="span-1">创建时间</span>
                            </div>
                        <c:forEach items="${resultList}" var="offer">
                            <div class="title-rcxx">
                                <a href="/into/offer_details?id=${offer.id}"><span class="span-1">${offer.name}</span><span class="span-2">${offer.company}</span><span class="span-1">${offer.obtain}年</span><span class="span-1">${offer.position}</span><span class="span-1">${offer.mobile}</span><span class="span-1"><fmt:formatDate value="${offer.createDate}" pattern="yyyy-MM-dd" type="date" dateStyle="long" /></span></a>
                            </div>
                        </c:forEach>
                    </div>
                    <input type="hidden" name="page" id="page_num" value="${resultList.getPageIndex()}" />
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
