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
                            <!--                            <li><a href="javascript:void(0);" data="bank" id="xzyh-fs-b" onclick="changeTable(this, 'bank');">储蓄卡</a></li>
                                                        <li><a href="javascript:void(0);">信用卡</a></li>-->
                            <li><a href="javascript:void(0);" data="platform" id="xzyh-fs-b" onclick="changeTable(this, 'platform');">支付平台</a></li>
                            <li><a href="javascript:void(0);" data="bank_transfer" onclick="changeTable(this, 'bank_transfer');">其他支付方式</a></li>
                        </ul>
                    </div>
                    <table id="bank_table" style="display: none"  width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
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
                    <table id="platform_table"  width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                        <tr>
                            <td width="190" height="50"><input type="radio" name="platform_zhifu" id="zhifubao_radio" value="ALIPAY" class="xuanz"><img src="/images/yh/zhifubao.png"  style="width: 145px;"></td>
                            <td width="190" height="50"><input type="radio" name="platform_zhifu" id="unionpay_radio" value="UNIONPAY" class="xuanz"><img src="/images/yh/zhifubao.png"  style="width: 145px;"></td>
                            <td width="190" height="50"></td>
                            <td width="190" height="50"></td>
                        </tr>
                    </table>
                    <table id="bank_transfer_table" style="display: none" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                        <tr>
                            <td width="190" height="50">1.其他支付方式是个人工流程。</td>
                        </tr>
                        <tr>
                            <td width="190" height="50">2.您可以选择以下任意支付方式：<br/>
                                网上银行转账<br/>
                                到银行柜台办理转账<br/>
                                缴纳现金<br/>
                                微信转账<br/>
                                其他支付方式（请事前联系筑誉工作人员）
                            </td>
                        </tr>
                        <tr>
                            <td width="190" height="50">3.选择其他方式支付完成后请主动联系筑誉工作人员进行到账确认。
                            </td>
                        </tr>
                    </table>
                    <div class="xiayy"><input type="button" class="xiayy-an" value="确认选择支付方式" onclick="doPanyment()" style="margin-left: 600px;"></div>
            </div>
        </form>
        <div class="news-fr">
            <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
            <h1>热门点击</h1>
            <div class="top-hits">
                <ul>
                    <c:forEach var="event" items="${hotEventList}">
                        <li><a target="_blank" href="/event/event_details?id=${event.id}">${event.titleIndexStr3}</a></li>
                        </c:forEach>
                </ul>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <!-- 主体 end -->
    <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    <div style="display: none" id="dialog-confirm" title="支付结果">
        <p>支付已经完成？</p>
    </div>
    <script type="text/javascript">
        function hideAllTable() {
            $("#xzyh-fs-b").removeAttr("id");
            $("#bank_table").hide();
            $("#bank_transfer_table").hide();
            $("#platform_table").hide();
        }
        function changeTable(obj, type) {
            hideAllTable();
            $(obj).attr("id", "xzyh-fs-b");
            if (type === 'bank_transfer') {
                $("#bank_transfer_table").show();
            } else if (type === 'platform') {
                $("#platform_table").show();
                $("#zhifubao_radio").attr("checked", "checked");
            } else if (type === 'bank') {
                $("#bank_table").show();
            }
        }
        function doPanyment() {
            var data = $("#xzyh-fs-b").attr("data");
            if (data == 'bank_transfer') {
                $("#payment_type").val('BANK_TRANSFER');
                $("#form1").submit();
            } else if (data == 'platform') {
                var val = $('input:radio[name="platform_zhifu"]:checked').val();
                if (val == null) {
                    val = "ALIPAY";
                }
                $("#payment_type").val(val);
                showDialog();
                $("#form1").attr("target", "_blank");
                $("#form1").submit();
            } else if (data == 'bank') {
                $("#payment_type").val('ALIPAY_BANK');
                showDialog();
                $("#form1").attr("target", "_blank");
                $("#form1").submit();
            }
        }
        function showDialog() {
            $("#dialog-confirm").dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    "支付完成": function () {
                        location.href = "/order/result/${order.serialId}";
                    },
                    "其他方式支付": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }
    </script>
</body>
</html>
