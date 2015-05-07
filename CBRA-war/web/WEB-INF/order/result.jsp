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
        <!-- 主体 -->
        <div class="two-main">
            <!-- 详细信息 -->
            <div class="hd-detailed">
                <c:choose>
                    <c:when test="${order.status == 'SUCCESS'}">
                        <div class="zfcg" style="width: 750px;">
                            <p class="czcg"><fmt:message key="GLOBAL_支付成功，请查收您的邮箱，获得门票号" bundle="${bundle}"/></p>
                            <p class="czcg"><a href="/public/index"><fmt:message key="GLOBAL_返回首页" bundle="${bundle}"/></a></p>
                        </div>
                    </c:when>
                    <c:when test="${order.status == 'PENDING_PAYMENT_CONFIRM'}">
                        <div class="hfcz">
                            <h1><fmt:message key="GLOBAL_重要信息" bundle="${bundle}"/>：<span id="amount_span"><fmt:message key="GLOBAL_订单号" bundle="${bundle}"/>：${order.serialId}</span></h1>
                        </div>
                        <table id="bank_transfer_table" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                            <tr>
                                <td width="190" height="50"><b style="color: red">【<fmt:message key="GLOBAL_银行转账" bundle="${bundle}"/>】</b> </td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><fmt:message key="GLOBAL_您还没有完成付款" bundle="${bundle}"/></td>
                            </tr>
                            <tr>
                                <td width="190" height="50">
                                    <fmt:message key="GLOBAL_银行转账信息" bundle="${bundle}"><fmt:param value="${order.amount}"/><fmt:param value="${order.serialId}"/></fmt:message>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="190" height="50"><b><fmt:message key="GLOBAL_金额" bundle="${bundle}"/></b>&nbsp;&nbsp;&nbsp;&nbsp;￥${order.amount}</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b><fmt:message key="GLOBAL_账户名称" bundle="${bundle}"/></b>&nbsp;&nbsp;&nbsp;&nbsp;上海铸誉企业管理咨询有限公司</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b><fmt:message key="GLOBAL_银行账号" bundle="${bundle}"/></b>&nbsp;&nbsp;&nbsp;&nbsp;03 4321 0004 0006 264</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b><fmt:message key="GLOBAL_开户银行" bundle="${bundle}"/></b>&nbsp;&nbsp;&nbsp;&nbsp;农业银行上海分行马当路支行</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b><fmt:message key="GLOBAL_补充信息" bundle="${bundle}"/></b>&nbsp;&nbsp;&nbsp;&nbsp;个人姓名或企业名称 + 转账ID(${order.serialId})</td>
                            </tr>
                        </table>
                        <table width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                            <tr>
                                <td width="190" height="50"><b style="color: red">【<fmt:message key="GLOBAL_其他支付方式" bundle="${bundle}"/>】</b> </td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><fmt:message key="GLOBAL_请提前联系筑誉工作人员" bundle="${bundle}"/></td>
                            </tr>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="zfcg" style="width: 750px;">
                            <p class="czcg"><fmt:message key="GLOBAL_支付失败，请返回订单支付页" bundle="${bundle}"/></p>
                            <p class="czcg"><a href="/order/payment_order/${order.serialId}"><fmt:message key="GLOBAL_返回" bundle="${bundle}"/></a></p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="news-fr">
                <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript">
        </script>
    </body>
</html>
