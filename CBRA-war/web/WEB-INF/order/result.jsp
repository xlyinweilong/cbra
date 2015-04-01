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
                            <p class="czcg">支付成功，请查收您的邮箱，获得门票号。</p>
                            <p class="czcg"><a href="/public/index">返回首页</a></p>
                        </div>
                    </c:when>
                    <c:when test="${order.status == 'PENDING_PAYMENT_CONFIRM'}">
                        <div class="hfcz">
                            <h1>重要信息：<span id="amount_span">订单号：${order.serialId}</span></h1>
                        </div>
                        <table id="bank_transfer_table" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                            <tr>
                                <td width="190" height="50"><b style="color: red">【银行转账】</b> </td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b>注意：</b>您还没有完成付款 </td>
                            </tr>
                            <tr>
                                <td width="190" height="50">
                                    请将${order.amount}元转到以下账户。请牢记您的转账ID(${order.serialId})，并将其填写在汇款的附加信息中。<br/>
                                    并在转账完成后联系筑誉工作人员进行确认。
                                </td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b>金额</b>&nbsp;&nbsp;&nbsp;&nbsp;￥${order.amount}</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b>账户名称</b>&nbsp;&nbsp;&nbsp;&nbsp;上海铸誉企业管理咨询有限公司</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b>银行账号</b>&nbsp;&nbsp;&nbsp;&nbsp;03 4321 0004 0006 264</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b>开户银行</b>&nbsp;&nbsp;&nbsp;&nbsp;农业银行上海分行马当路支行</td>
                            </tr>
                            <tr>
                                <td width="190" height="50"><b>补充信息</b>&nbsp;&nbsp;&nbsp;&nbsp;个人姓名或企业名称 + 转账ID(${order.serialId})</td>
                            </tr>
                        </table>
                        <table width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                            <tr>
                                <td width="190" height="50"><b style="color: red">【其他支付方式】</b> </td>
                            </tr>
                            <tr>
                                <td width="190" height="50">请提前联系筑誉工作人员，联系电话：021-61550302</td>
                            </tr>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="zfcg" style="width: 750px;">
                            <p class="czcg">支付失败，请返回订单支付页。</p>
                            <p class="czcg"><a href="/order/payment_order/${order.serialId}">返回订单支付页</a></p>
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
