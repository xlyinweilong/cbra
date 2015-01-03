<%-- 
    Document   : charge
    Created on : Dec 26, 2012, 6:36:20 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:choose>
    <c:when test="${apiChargeOrder.language=='zh'}">
        <fmt:setLocale value="zh_CN" scope="session" />
        <fmt:setBundle basename="message" scope="session" var="bundle"/>
        <%
            Cookie cookie = new Cookie("COOKIE_LANG", "zh");
            cookie.setPath("/");
            response.addCookie(cookie);
        %>
    </c:when>
    <c:when  test="${apiChargeOrder.language=='en'}">
        <fmt:setLocale value="en_US" scope="session" />
        <fmt:setBundle basename="message" scope="session" var="bundle"/>
        <%
            Cookie enCookie = new Cookie("COOKIE_LANG", "en");
            enCookie.setPath("/");
            response.addCookie(enCookie);
        %>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox" id="abc" cust="b">
    <c:if test="${not empty seller.apiBanner}">
        <div style = "text-align: center;"><img src="${seller.apiBanner}" width="940"/></div>
        </c:if>
    <form method="POST" id="payment_form" action="/paygate_api/charge" onsubmit="return APIChargeOrder.checkForm();" target="_blank">
        <div class="apihead"> 
            <div class="api">

                <div class="FloatLeft BlueBoxLeft">
                    <c:if test="${seller.apiShowLogo == null || seller.apiShowLogo}">
                        <div class="photo">
                            <c:choose>
                                <c:when test="${not empty seller.logoUrl}">
                                    <img src="${seller.logoUrl}" width="80"/>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${seller.accountType=='COMPANY'}">
                                            <img src="/images/company_logo.png" width="80"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/images/photo.png" width="80"/>
                                        </c:otherwise>
                                    </c:choose> 
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <div>
                        <c:if test="${seller.sealVerified && seller.accountType=='COMPANY'}">
                            <a href="/company/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                            </c:if>
                            <c:if test="${linkUser.sealVerified && linkUser.accountType=='USER'}">
                            <a href="/user/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                            </c:if>
                    </div>
                </div>
                <div class="FloatLeft" style="width: 698px;">
                    <div class="sk-item2 TextAlignLeft">
                        <label class="sk-label2">
                            <fmt:message key="PAYMENT_DETAIL_TEXT_收款人" bundle="${bundle}"/>：</label>
                        <span class="text24 bold">
                            <c:choose>
                                <c:when  test="${seller.accountType=='USER'}">
                                    ${seller.name}
                                </c:when> 
                                <c:when  test="${seller.accountType=='COMPANY'}">
                                    ${seller.company}
                                </c:when> 
                            </c:choose>
                        </span>
                    </div> 
                    <div class="sk-item2 TextAlignLeft">
                        <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_转款金额" bundle="${bundle}"/>：</label>
                        <input type="hidden" name="" value="${apiChargeOrder.amount}" id="payment_amount" disabled="disabled"/>
                        <fmt:formatNumber value="${apiChargeOrder.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${apiChargeOrder.currencySign}" /> 
                    </div>
                    <div class="sk-item2 TextAlignLeft">
                        <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_事由" bundle="${bundle}"/>：</label>
                        ${apiChargeOrder.itemName} <br/>
                        ${apiChargeOrder.itemBody}
                    </div>
                </div>            
                <div class="clear"></div>
            </div>
        </div>
        <c:if test="${seller.apiInvoiceProvider == 'YOOPAY' || seller.apiInvoiceProvider == 'HOST'}">
            <div class="api">
                <p> <fmt:message key="COLLECT_INOVICE_发票信息" bundle="${bundle}"/></p>
                <span class="Padding0"><input type="checkbox" name="need_invoice" id="need_invoice" onclick="FundPayment.showInvoiceDiv();" value="true" <c:if test="${not empty userInvoice}">checked="checked"</c:if>/><fmt:message key="PAYMENT_DETAIL_LABEL_我需要发票" bundle="${bundle}"/></span>

                <div style="background:#DADADA">
                    <div class="BlueBoxContent"><div  class="charge_form " id="need_invoice_div" style="display:none;">
                            <div><fmt:message key="COLLECT_INOVICE_发票抬头" bundle="${bundle}"/>：</div><input type="text" name="invoice_title" id="invoice_title" class="TextareaInvoice MarginBottom5" value="${userInvoice.invoiceTitle}"/>
                            <div class="FloatLeft" >
                                <div> <fmt:message key="COLLECT_INOVICE_收件人" bundle="${bundle}"/>：</div><input type="text" name="invoice_name" id="invoice_name" class="Input285 MarginBottom5" value="${userInvoice.recipientName}"/>
                            </div>
                            <div class="FloatRight">
                                <div><fmt:message key="COLLECT_INOVICE_电话" bundle="${bundle}"/>：</div><input type="text" name="invoice_phone" id="invoice_phone" class="Input285  MarginBottom5" value="${userInvoice.recipientPhone}"/>
                            </div>
                            <div class="clear"></div> 
                            <div><fmt:message key="COLLECT_INOVICE_地址" bundle="${bundle}"/>：</div><input type="text" name="invoice_address" id="invoice_address" class="TextareaInvoice MarginBottom5" value="${userInvoice.recipientAddress}"/>
                            <div class="FloatLeft" >
                                <div><fmt:message key="COLLECT_INOVICE_省市" bundle="${bundle}"/>：</div><input type="text" name="invoice_province" id="invoice_province" class="Input285 MarginBottom5" value="${userInvoice.recipientProvince}"/>
                            </div>
                            <div class="FloatRight">
                                <div><fmt:message key="COLLECT_INOVICE_邮编" bundle="${bundle}"/>：</div><input type="text" name="invoice_postcode" id="invoice_postcode" class="Input285 MarginBottom5" value="${userInvoice.recipientPostcode}"/>
                            </div>
                            <div class="clear"></div> 
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <%--支付方式选择--%>
        <div >         
            <div class="api" style=" margin-top: 50px;" id="payment_style_choose">
                <p><fmt:message key="PAYMENT_DETAIL_LABEL_支付方式" bundle="${bundle}"/><img src="/images/<fmt:message key='API_CHARGE_GATEWAY_IMG_NAME' bundle='${bundle}'/>" /></p>


                <c:set var="gateway_type_init" value="PAYMENT_DETAIL_LABEL_请选择"></c:set>
                <div  class="MarginBottom20">
                    <!-- 支付方式下拉列表信息-->
                    <span class="FloatLeft" style=" line-height:32px;height:32px;"><fmt:message key="PAYMENT_DETAIL_LABEL_选择支付方式" bundle="${bundle}" /></span>
                    <span class="FloatLeft"><jsp:directive.include file="/WEB-INF/paygate/z_gateway_select.jsp"></jsp:directive.include></span>
                    <div class="clear"></div>
                </div>
                <div style="background:#DADADA;" >   
                    <div class="BlueBoxContent826" style="width: 640px;">
                        <div class="charge_form" id="credit_card_input_div" style="display: none">
                            <!-- 信用卡输入信息-->
                            <jsp:directive.include file="/WEB-INF/paygate/z_creditcard_input.jsp" />
                        </div>

                        <div id="bank_transfer" style="display:none">
                            <!-- 银行转账输入信息-->
                            <jsp:directive.include file="/WEB-INF/paygate/z_bank_transfer.jsp" />
                        </div>    
                        <div id="bank_list_div" style="display: none;">
                            <!-- 银行列表信息-->
                            <jsp:directive.include file="/WEB-INF/paygate/z_bank_list.jsp" />
                        </div>
                        <div class="noteMessage MarginTop10" style="display:none" id="zhao_shang_caution">
                            <fmt:message key="PAYMENT_GATEWAY_NOTICE_注意：在使用招商银行信用卡支付时，招行需要电话联系您来确认，请留意接听" bundle="${bundle}"/>
                        </div>
                        <br class="clear"/>
                    </div></div>

            </div>
            <div class="BlueBoxContent826 TextAlignRight" style="line-height:36px;">
                <span id="payment_not_free">  
                    <input type="submit" name="Submit" class="collection_button FloatRight  MarginL7" value="<fmt:message key='TRANSFER_LINKTRANSFER_BUTTON_转款' bundle='${bundle}'/>" id="payment_btn"/> 
                </span>
                <input type="hidden" id="currency_type" name="currency_type" value="${apiChargeOrder.currencyType}" disabled="true"/>
                <input type="hidden" name="order_serial_id" value="${apiChargeOrder.serialId}" />
                <input type="hidden" name="pmode_id" id="pmode_id" value="-1"/>    
                <input type="hidden" name="gateway_type" id="gateway_type" value="-1"/>
                <input type="hidden" name="chinabank_credit_card_sub" id="chinabank_credit_card_sub" value="-1"/>
                <input type="hidden" name="a" value="PAY_ORDER" />
                <%-- 操作成功、错误信息--%>
                <div class="noticeMessage FloatRight" id="payment_notice_div" style="display: none">
                    <div class="wrongMessage" id="payment_wrong_msg_div" style="display: none"></div>
                    <div class="loadingMessage" style="display: none" id="payment_loading_div">
                        <fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" />
                    </div>
                </div>
                <%-- 币种转换提示信息--%>
                <div id="currency_convert_tip"  class="FloatRight MarginR10" style=" line-height:34px;">
                    <div style="display:none" id="usd_tip">
                    </div>
                    <div style="display:none" id="cny_tip">
                    </div>
                </div>
                <div class="clear"></div>
            </div> 
        </div>
    </form>
</div>
<div id="paymentTipDialog" style="display:none;text-align: center">
    <div>
        <fmt:message key="PAYMENT_DETAIL_LABEL_请您在新打开的页面进行支付，支付完成前请不要关闭该窗口" bundle="${bundle}"/>
    </div>
    <div style="margin-top: 20px;font-size: 12px">
        <input type="button" onclick="APIChargeOrder.redirectToResult(true);" class="collection_button" value="<fmt:message key='PAYMENT_BUTTON_已完成支付' bundle='${bundle}'/>"/>
        <input type="button" onclick="APIChargeOrder.redirectToResult(false);" class="collection_button" value="<fmt:message key='PAYMENT_BUTTON_支付遇到问题' bundle='${bundle}'/>"/>
    </div>
</div>
<%@include file="/WEB-INF/payment/z_payment_javascript_template.jsp" %>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(
    function(){
        // init gateway selects 
        GatewayPayment.initGatewaySelect("api_payment",${rateCNY2USD},${rateUSD2CNY},'<fmt:message key="PAYMENT_DETAIL_LABEL_请选择" bundle="${bundle}"/>',0);
        //init credit card expdate 
        var creditCardDiv = $("#credit_card_input_div");
        if(creditCardDiv.length>0){
            CreditCard.initExpdateDate();
        }
        //init bank list click event
        ChinaBank.initClickEvent();
    }
);
</script>

<%@include file="/WEB-INF/public/z_footer_close.html" %>
