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
        </div>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 详细信息 -->
            <div class="zfcg">
                <p class="czcg">您已成功提交报名申请，等待管理员审核通知，请留意您的邮箱或登录查看您的订单。订单号：${serialId}</p>
                <p class="czcg"><a href="/public/index">返回首页</a></p>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
