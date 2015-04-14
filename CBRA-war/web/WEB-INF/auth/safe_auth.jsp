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
        <jsp:include page="/WEB-INF/auth/z_auth_banner.jsp"><jsp:param name="page" value="2" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/auth/z_left.jsp"><jsp:param name="page" value="2" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fr-con">
                    <div class="title"><span><a href="/auth/quality_auth"><fmt:message key="INDEX_品质认证" bundle="${bundle}"/></a></span><span><a href="/auth/safe_auth" id="title-span"><fmt:message key="INDEX_安全认证" bundle="${bundle}"/></a></span></div>
                    <div class="con-single">${plateInformation.plateInformationContent.content}</div>
                </div>
                <!-- 右侧内容 end -->
                <div style="clear:both;"></div>
            </div>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
