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
                    <div class="title"><span><a id="title-span">筑誉人才库</a></span></div>
                    <div class="con-single">
                        <div class="title-gw">
                            <a href="/into/offer_details"><span class="span-1">职位名称</span><span class="span-2">工作地点</span><span class="span-2">部门</span><span>发布时间</span></a>
                        </div>
                    <c:forEach begin="1" end="15" step="1">
                        <div class="title-zw">
                            <span class="span-1">助理咨询师</span><span class="span-2">北京市</span><span class="span-2">和君咨询</span><span>2015-01-29</span>
                        </div>
                        <div class="title-zw">
                            <a href="/into/offer_details"><span class="span-1">人力资源与企业文化方向 高级咨询师</span><span class="span-2">北京市</span><span class="span-2">和君咨询</span><span>2015-01-29</span></a>
                        </div>
                    </c:forEach>
                    <jsp:include page="/WEB-INF/public/z_paging.jsp">
                        <jsp:param name="totalCount" value="200" />
                        <jsp:param name="maxPerPage" value="15" />
                        <jsp:param name="pageIndex" value="1" />
                    </jsp:include>
                </div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
