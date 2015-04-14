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
        <jsp:include page="/WEB-INF/join/z_join_banner.jsp"><jsp:param name="page" value="2" /></jsp:include>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/join/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
            <!-- 左侧导航 end -->

            <!-- 右侧内容 -->
            <div class="fr-con">
                <div class="title"><span><a href="/join/membership_application"><fmt:message key="JOIN_会员守则" bundle="${bundle}"/></a></span><span><a href="/join/join_reg" id="title-span"><fmt:message key="JOIN_申请个人会员" bundle="${bundle}"/></a></span><span><a href="/join/join_reg_c"><fmt:message key="JOIN_申请企业会员" bundle="${bundle}"/></a></span></div>
                <div class="con-single">${plateInformation.plateInformationContent.content}</div>
                <div style="text-align:center;"><input type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key='JOIN_申请个人会员' bundle='${bundle}'/>" onclick="location.href = '/account/signup'"></div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
