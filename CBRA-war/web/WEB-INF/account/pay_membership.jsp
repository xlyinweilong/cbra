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
                                <div class="tit-cz"><fmt:message key="GLOBAL_会费" bundle="${bundle}"/></div>
                                <div class="hfcz">
                                    <h1><fmt:message key="GLOBAL_支付金额" bundle="${bundle}"/>：<span>¥${membership_fee}<fmt:message key="GLOBAL_元" bundle="${bundle}"/></span></h1>
                                <%--<p>收款方：筑誉建筑联合会　　类型：缴费</p>--%>
                                <%--<p><input type="checkbox" class="fuxk">是否开发票</p>--%>
                            </div>
                            <div class="xzyh">
                                <div class="biaoti"><fmt:message key="GLOBAL_选择网上银行或平台支付" bundle="${bundle}"/></div>
                            </div>
                            <div class="xzyh-fs">
                                <ul>
                                    <!--                                    <li><a href="javascript:void(0);" data="bank" id="xzyh-fs-b" onclick="changeTable(this, 'bank');">储蓄卡</a></li>
                                                                        <li><a href="javascript:void(0);">信用卡</a></li>-->
                                    <li><a href="javascript:void(0);" data="platform" id="xzyh-fs-b" onclick="changeTable(this, 'platform');"><fmt:message key="GLOBAL_支付平台" bundle="${bundle}"/></a></li>
                                    <li><a href="javascript:void(0);" data="bank_transfer" onclick="changeTable(this, 'bank_transfer');"><fmt:message key="GLOBAL_其他支付方式" bundle="${bundle}"/></a></li>
                                </ul>
                            </div>
                            <table id="bank_table" style="display: none" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
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
                                    <td width="190" height="50"><input type="radio" name="platform_zhifu" id="unionpay_radio" value="UNIONPAY" class="xuanz"><img src="/images/yh/yinlianzaixian.png"  style="width: 145px;"></td>
                                    <td width="190" height="50"></td>
                                    <td width="190" height="50"></td>
                                </tr>
                            </table>
                            <table id="bank_transfer_table" style="display: none" width="740" border="0" cellspacing="0" cellpadding="0" class="yhimg">
                                <tr>
                                    <td width="190" height="50"><fmt:message key="GLOBAL_其他支付方式是个人工流程" bundle="${bundle}"/></td>
                                </tr>
                                <tr>
                                    <td width="190" height="50"><fmt:message key="GLOBAL_您可以选择以下任意支付方式" bundle="${bundle}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="190" height="50"><fmt:message key="GLOBAL_选择其他方式支付完成后请主动联系筑誉工作人员进行到账确认" bundle="${bundle}"/>
                                    </td>
                                </tr>
                            </table>
                            <div class="xiayy"><input type="button" class="xiayy-an" value="<fmt:message key="GLOBAL_确认选择支付方式" bundle="${bundle}"/>" onclick="doPanyment()" style="margin-left: 600px;width: 120px;"></div>
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
                        "<fmt:message key="GLOBAL_支付完成" bundle="${bundle}"/>": function () {
                            location.href = "/account/result/${order.serialId}";
                        },
                        "<fmt:message key="GLOBAL_其他方式支付" bundle="${bundle}"/>": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }
        </script>
    </body>
</html>
