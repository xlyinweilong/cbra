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
        <div class="two-loc">
            <div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="GLOBAL_用户注册" bundle="${bundle}"/></div>
        </div>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 详细信息 -->
            <div class="zfcg">
                <p class="czcg"><img src="/images/zccg.png"></p>
                <p class="czcg"><fmt:message key="GLOBAL_您已成功提交入会申请，审核结果将在3-5个工作日内以邮件形式通知您，请注意查收邮件" bundle="${bundle}"/></p>
                <p class="czcg"><a href="/public/index"><fmt:message key="GLOBAL_返回首页" bundle="${bundle}"/></a></p>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
