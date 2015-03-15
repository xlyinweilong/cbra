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
                <form id="form1" action="/order/payment_order/${order.serialId}" method="post">
                    <input type="hidden" name="a" value="PAYMENT_ORDER" />
                    <input type="hidden" id="payment_type" name="payment_type" value="" />
                    <div class="hfcz">
                        <h1>支付金额：<span id="amount_span">¥${order.amount}元</span></h1>
                    </div>
                    <div class="xzyh">
                        <div class="biaoti">选择网上银行或平台支付</div>
                    </div>
                    <div class="xzyh-fs">
                        <ul>
                            <li><a href="javascript:void(0);" id="xzyh-fs-b">储蓄卡</a></li>
                            <li><a href="javascript:void(0);">信用卡</a></li>
                            <li><a href="javascript:void(0);">支付平台</a></li>
                            <li><a href="javascript:void(0);" data="bank_transfer" onclick="changeTable(this, 'bank_transfer');">银行转账</a></li>
                        </ul>
                    </div>
                    <table id="savings_card_table" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                        <tr>
                            <td width="190" height="50"><input type="radio" class="xuanz"><img src="/images/yh/yh-1.jpg"></td>
                            <td width="190"><input type="radio" class="xuanz"><img src="/images/yh/yh-2.jpg"></td>
                            <td width="190"><input type="radio" class="xuanz"><img src="/images/yh/yh-3.jpg"></td>
                            <td width="190"><input type="radio" class="xuanz"><img src="/images/yh/yh-4.jpg"></td>
                        </tr>
                        <tr>
                            <td width="190" height="50"><input type="radio" class="xuanz"><img src="/images/yh/yh-1.jpg"></td>
                            <td width="190"><input type="radio" class="xuanz"><img src="/images/yh/yh-2.jpg"></td>
                            <td width="190"><input type="radio" class="xuanz"><img src="/images/yh/yh-3.jpg"></td>
                            <td width="190"><input type="radio" class="xuanz"><img src="/images/yh/yh-4.jpg"></td>
                        </tr>
                    </table>
                    <table id="bank_transfer_table" style="display: none" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                        <tr>
                            <td width="190" height="50">1.银行转账是个人工流程，这意味这您需要到银行来进行操作。
                                筑誉建筑联合会不会自动从您的银行帐户扣款。</td>
                        </tr>
                        <tr>
                            <td width="190" height="50">2.您可以从任何银行进行转账。</td>
                        </tr>
                    </table>
                    <div class="xiayy"><input type="button" class="xiayy-an" value="下一步" onclick="doPanyment()"></div>
            </div>
        </form>
        <div class="news-fr">
            <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
            <h1>热门点击</h1>
            <div class="top-hits">
                <ul>
                    <c:forEach var="event" items="${hotEventList}">
                        <li><a target="_blank" href="/event/event_details?id=${event.id}">${event.title}</a></li>
                        </c:forEach>
                </ul>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <!-- 主体 end -->
    <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    <script type="text/javascript">
        function hideAllTable() {
            $("#xzyh-fs-b").removeAttr("id");
            $("#savings_card_table").hide();
            $("#bank_transfer_table").hide();
        }
        function changeTable(obj, type) {
            hideAllTable();
            $(obj).attr("id", "xzyh-fs-b");
            if (type === 'bank_transfer') {
                $("#bank_transfer_table").show();
            }
        }
        function doPanyment(){
            var data = $("#xzyh-fs-b").attr("data");
            if(data == 'bank_transfer'){
                $("#payment_type").val('BANK_TRANSFER');
                $("#form1").submit();
            }
        }
    </script>
</body>
</html>