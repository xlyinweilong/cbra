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
        <jsp:include page="/WEB-INF/account/z_account_banner.jsp" />
        <div class="two-loc">
            <div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 用户注册</div>
        </div>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 详细信息 -->
            <div class="zfcg">
                <p class="czcg"><img src="/images/zccg.png"></p>
                <p class="czcg">您已成功提交注册申请，等待管理员审核通知！</p>
                <p class="czcg"><a href="/public/index">返回首页</a></p>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>