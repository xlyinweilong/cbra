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
        <jsp:include page="/WEB-INF/join/z_join_banner.jsp"><jsp:param name="page" value="1" /></jsp:include>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/join/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
            <!-- 左侧导航 end -->
            <!-- 右侧内容 -->
            <div class="fr-con">
                <div class="title"><span><a href="/join/membership_application" id="title-span">会员守则</a></span><span><a href="/join/join_reg">个人会员申请</a></span><span><a href="/join/join_reg_c">企业会员申请</a></span></div>
                <div class="con-single">${plateInformation.plateInformationContent.content}</div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
