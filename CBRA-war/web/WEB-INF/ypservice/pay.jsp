<%-- 
    Document   : pay
    Created on : Sep 11, 2012, 10:56:22 AM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.YOOPAY_SERVICE);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        &nbsp;&nbsp;<fmt:message key="YP_SERVICE_NAME_${dictYoopayService.serviceName}" bundle="${bundle}"/>
    </div>
    <div class="noticeMessage" style="display:none">
        <div class="successMessage" style="display:none"></div>
        <div class="wrongMessage" style="display:none" id="ypservice_wrong_msg_container"></div>
        <div class="loadingMessage" style="display:none" id="ypservice_loading_container"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
    </div>
    <div class="BlueBoxContent">
        <form method="POST" id="ypservice_form" action="/ypservice/pay/" onsubmit="return YpService.checkForm();" target="_blank">
            <div style="background:#EFEFEF; padding: 10px 0px; margin-top:30px;">
                <div class="sk-item  TextAlignLeft">
                    <label class="sk-label"><b><fmt:message key="YP_SERVICE_服务名称" bundle="${bundle}"/></b>: </label>
                    <fmt:message key="YP_SERVICE_NAME_${dictYoopayService.serviceName}" bundle="${bundle}"/>
                </div>
                <div class="sk-item  TextAlignLeft">
                    <label class="sk-label"><b><fmt:message key="YP_SERVICE_金额" bundle="${bundle}"/></b>: </label>
                    <fmt:formatNumber value="${dictYoopayService.serviceAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                    <input type="hidden" name="" value="${dictYoopayService.serviceAmount}" id="payment_amount" disabled="disabled"/>
                    <input type="hidden" name="service_id" value="${dictYoopayService.id}" />
                    <input type="hidden" id="payment_balance_toggle_amount" disabled="disabled"/>
                    <input type="hidden" name="" value="CNY" id="currency_type" disabled="disabled"/>
                </div>
                <div class="sk-item TextAlignLeft" id="balance_lack_container" style="display: none">
                    <input type="checkbox" name="balance_lack_payment" value="true" onclick="GatewayPayment.toggleBalancePayment();"/>
                    <span id="balance_lack_text">
                        <c:choose>
                            <c:when test="${fundCollection.currencyType=='USD'}" >
                                <fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元XXX美元,剩余YYY美元用其他方式' bundle='${bundle}'></fmt:message>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元,剩余YYY元用其他方式' bundle='${bundle}'></fmt:message>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="sk-item TextAlignLeft">
                    <div>
                        <label class="sk-label"><b><fmt:message key="PAYMENT_DETAIL_LABEL_选择支付方式" bundle="${bundle}"/></b></label>
                        <c:set var="gateway_type_init" value="PAYMENT_DETAIL_LABEL_请选择"></c:set>
                        <input type="hidden" id="currency_type" name="currency_type" value="CNY" disabled="true"/>
                        <div  class="MarginTop20">
                            <!-- 支付方式下拉列表信息-->
                            <span class="FloatLeft"><jsp:directive.include file="/WEB-INF/paygate/z_gateway_select.jsp"></jsp:directive.include></span>
                            <div class="clear"></div>
                        </div>
                        <div class="noteMessage MarginTop10" style="display:none" id="zhao_shang_caution">
                            <fmt:message key="PAYMENT_GATEWAY_NOTICE_注意：在使用招商银行信用卡支付时，招行需要电话联系您来确认，请留意接听" bundle="${bundle}"/>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>

            </div>

            <div> <div class="charge_form" id="credit_card_input_div" style="display: none">
                    <!-- 信用卡输入信息-->
                    <jsp:directive.include file="/WEB-INF/paygate/z_creditcard_input.jsp" />
                </div>

                <div id="bank_transfer" style="display:none">
                    <!-- 银行转账输入信息-->
                    <jsp:directive.include file="/WEB-INF/paygate/z_bank_transfer.jsp" />
                </div> 

                <div id="bank_list_div" style="display: none;border: solid 1px #999; padding: 15px 3px; ">
                    <!-- 银行列表信息-->
                    <jsp:directive.include file="/WEB-INF/paygate/z_bank_list.jsp" />
                    <div class="clear"></div>
                </div> 

                <input type="hidden"  name="card_type" id="card_type" value="VISA"/>
                <input type="hidden" name="pmode_id" id="pmode_id" value="-1"/>    
                <input type="hidden" name="chinabank_credit_card_sub" id="chinabank_credit_card_sub" value="-1"/>
                <input type="hidden" name="gateway_type" id="gateway_type" value="-1"/>
                <input type="hidden" name="a" value="INIT_PAY_ORDER" />
                <input type="hidden" name="urlUserWantToAccess" value="/ypservice/pay/${dictYoopayService.serviceType}" />
            </div>

            <div >  
                <input type="submit" id="payment_btn" value="<fmt:message key='YP_SERVICE_付款' bundle='${bundle}'/>" class="collection_button FloatRight MarginL7 MarginTop20"/>
                <div id="currency_convert_tip"  class="FloatRight MarginR10 MarginTop20" style=" line-height:34px;">
                    <div style="display:none" id="usd_tip">
                    </div>
                    <div style="display:none" id="cny_tip">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    $(document).ready(
    function(){
        // init gateway selects 
        GatewayPayment.initGatewaySelect("yp_service",${rateCNY2USD},${rateUSD2CNY},null,${user.totalBalance});
        //init credit card expdate 
        var creditCardDiv = $("#credit_card_input_div");
        if(creditCardDiv.length>0){
            CreditCard.initExpdateDate();
        }
            
        //init bank list click event
        ChinaBank.initClickEvent();
        $('#payment_type').bgiframe();//在ie6下确保弹出层能盖住select内容     
    }
);
</script>
<%@include file="/WEB-INF/payment/z_payment_javascript_template.jsp" %>
<c:set var="scriptVarName" value="YpService"></c:set>
<%@include file="/WEB-INF/payment/z_payment_tip_dialog.jsp" %>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
