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
                <div class="hfcz">
                    <h1>重要信息：<span id="amount_span">订单号：${order.serialId}</span></h1>
                </div>
                <table id="bank_transfer_table" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                    <tr>
                        <td width="190" height="50"><b>注意：</b>您还没有完成付款 </td>
                    </tr>
                    <tr>
                        <td width="190" height="50">
                            请将${order.amount}元转到以下账户。请牢记您的转账ID(${order.serialId})，并将其填写在汇款的附加信息中。<br/>
                            我们将会在确认款项到账后，给您发送通知。 
                        </td>
                    </tr>
                    <tr>
                        <td width="190" height="50"><b>金额</b>&nbsp;&nbsp;&nbsp;&nbsp;￥${order.amount}</td>
                    </tr>
                    <tr>
                        <td width="190" height="50"><b>账户名称</b>&nbsp;&nbsp;&nbsp;&nbsp;上海筑誉建筑联合会科技有限公司</td>
                    </tr>
                    <tr>
                        <td width="190" height="50"><b>银行账号</b>&nbsp;&nbsp;&nbsp;&nbsp;11090 62075 10801</td>
                    </tr>
                    <tr>
                        <td width="190" height="50"><b>开户银行</b>&nbsp;&nbsp;&nbsp;&nbsp;招商银行上海分行华贸中心支行</td>
                    </tr>
                    <tr>
                        <td width="190" height="50"><b>补充信息</b>&nbsp;&nbsp;&nbsp;&nbsp;${order.serialId}</td>
                    </tr>
                </table>
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
