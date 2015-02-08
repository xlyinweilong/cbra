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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="6" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="6" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fr-con">
                    <div class="title"><span><a id="title-span">联系我们</a></span></div>
                    <div class="con-lxwm">
                        <h1>筑誉建筑联合会</h1>
                        公司总部联系方式<br>
                        地址：上海市普陀区真光路1219号新长征中环大厦23层<br>
                        总机：021-61550302  传真：021-61550302<br>
                        业务咨询：400-610-3699（免话费直线）<br>
                        媒体采访：021-61550302<br>
                        官方微信：cbra_cbra<br>
                        邮件：cbra_cbra@cbra.com  网址：http://www.cbra.com/<br>
                        <br>
                        <img src="/ls/map.png">
                    </div>
                </div>
                <!-- 右侧内容 end -->
                <div style="clear:both;"></div>
            </div>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
