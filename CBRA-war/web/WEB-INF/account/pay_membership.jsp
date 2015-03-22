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
        <!-- 主体 -->
        <div class="mc-main">
            <form id="form1" action="/account/pay_membership" method="post">
                <input type="hidden" name="a" value="PAYMENT_ORDER" />
                <input type="hidden" id="payment_type" name="payment_type" value="" />
                <table width="1000" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" class="fl-nav">
                            <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="2" /></jsp:include>
                            </td>
                            <td valign="top" class="fr-c-1">
                                <div class="tit-cz">会　费</div>
                                <div class="hfcz">
                                    <h1>支付金额：<span>¥${membership_fee}元</span></h1>
                                <%--<p>收款方：筑誉建筑联合会　　类型：缴费</p>--%>
                                <%--<p><input type="checkbox" class="fuxk">是否开发票</p>--%>
                            </div>
                            <div class="xzyh">
                                <div class="biaoti">选择网上银行或平台支付</div>
                            </div>
                            <div class="xzyh-fs">
                                <ul>
                                    <li><a href="javascript:void(0);" data="bank" id="xzyh-fs-b" onclick="changeTable(this, 'bank');">储蓄卡</a></li>
                                    <li><a href="javascript:void(0);">信用卡</a></li>
                                    <li><a href="javascript:void(0);" data="platform" onclick="changeTable(this, 'platform');">支付平台</a></li>
                                    <li><a href="javascript:void(0);" data="bank_transfer" onclick="changeTable(this, 'bank_transfer');">银行转账</a></li>
                                </ul>
                            </div>
                            <table id="bank_table" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
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
                            <table id="platform_table" style="display: none" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                                <tr>
                                    <td width="190" height="50"><input type="radio" id="zhifubao_radio" class="xuanz"><img src="/images/yh/zhifubao.png"  style="width: 145px;"></td>
                                    <td width="190" height="50"></td>
                                    <td width="190" height="50"></td>
                                    <td width="190" height="50"></td>
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
                            <div class="xiayy"><input type="button" class="xiayy-an" value="下一步" onclick="doPanyment()" style="margin-left: 600px;"></div>
                        </td>
                    </tr>
                </table>
            </form>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
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
                    $("#payment_type").val('ALIPAY');
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
                            location.href = "/account/result/${order.serialId}";
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
