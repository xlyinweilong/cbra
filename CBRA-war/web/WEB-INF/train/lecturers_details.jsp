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
        <jsp:include page="/WEB-INF/team/z_team_banner.jsp"><jsp:param name="page" value="1" /></jsp:include>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/team/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
            <!-- 左侧导航 end -->
            <!-- 右侧内容 -->
            <div class="fm-list">
                <div class="title"><span><a id="title-span">介绍</a></span></div>
                <div class="jsjs">
                    <div class="img">
                        <img style="width: 140px; height: 100px; margin-left: 35px;" src="<c:if test="${not empty plateInfo.picUrl}">${plateInfo.picUrl}</c:if><c:if test="${empty plateInfo.picUrl}">/ls/ls-123.jpg</c:if>">
                    </div>
                    <div class="detailed"><h1>${plateInfo.title}</h1>
                        ${plateInfo.plateInformationContent.content}
                    </div>
                    <div style="clear:both;"></div>
                </div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
