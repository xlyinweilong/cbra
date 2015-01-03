<%-- 
    Document   : create
    Created on : Jul 5, 2011, 2:27:03 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDTRANSFER);
%>
<%-- 设置MenuSelection参数结束 --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page  import="cn.yoopay.Config" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<div class="BlueBox" id="abc" cust="b">
    <div class="BlueBoxTitle">
        <span class="FloatLeft">
            <fmt:message key="TRANSFER_LINKTRANSFER_TEXT_友付链接" bundle="${bundle}">
                <fmt:param value="${linkUser.displayName}"/>
            </fmt:message>
            <c:choose>
                <c:when test="${linkUser.accountType=='USER'}">
                    <a href="/p/${linkUser.ypLinkId}">https://yoopay.cn/p/${linkUser.ypLinkId}</a>
                </c:when>
                <c:otherwise>
                    <a href="/o/${linkUser.ypLinkId}">https://yoopay.cn/o/${linkUser.ypLinkId}</a>
                </c:otherwise>
            </c:choose>
        </span>
        <div class="clear"></div>
    </div>
    <form method="POST" id="payment_form" action="/transfer/create/${linkUser.ypLinkId}" onsubmit="return FundTransfer.checkLinkTransferForm(<%=Config.MIN_TRANSFER_AMOUNT%>);" target="_blank">
        <div class="BlueBox_Gray">
            <div class="BlueBoxContent826" style="width: 640px;">
                <div class="FloatLeft BlueBoxLeft">
                    <div class="photo">
                        <c:choose>
                            <c:when test="${not empty linkUser.logoUrl}">
                                <img src="${linkUser.logoUrl}" width="80"/>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${linkUser.accountType=='COMPANY'}">
                                        <img src="/images/company_logo.png" width="80"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/images/photo.png" width="80"/>
                                    </c:otherwise>
                                </c:choose> 
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <c:if test="${linkUser.sealVerified && linkUser.accountType=='COMPANY'}">
                            <a href="/company/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                            </c:if>
                            <c:if test="${linkUser.sealVerified && linkUser.accountType=='USER'}">
                            <a href="/user/${linkUser.sealWebId}"><img src="<fmt:message key='GLOBAL_IMG_S_认证图片' bundle='${bundle}'/>" /></a>
                            </c:if>
                    </div>
                </div>
                <div class="FloatLeft">
                    <div class="sk-item2 TextAlignLeft">
                        <label class="sk-label2">
                            <fmt:message key="PAYMENT_DETAIL_TEXT_收款人" bundle="${bundle}"/>：</label>
                        <span  class="text24 bold">
                            <c:choose>

                                <c:when  test="${linkUser.accountType=='USER'}">
                                    ${linkUser.name}
                                </c:when> 
                                <c:when  test="${linkUser.accountType=='COMPANY'}">
                                    ${linkUser.company}
                                </c:when> 

                            </c:choose>
                        </span>
                        <c:choose>
                            <c:when test="${linkUser.sealVerified && linkUser.accountType=='COMPANY'}">
                                （<a href="/company/${linkUser.sealWebId}">${linkUser.email}</a>）
                            </c:when>
                            <c:when test="${linkUser.sealVerified && linkUser.accountType=='USER'}">
                                （<a href="/user/${linkUser.sealWebId}">${linkUser.email}</a>）
                            </c:when>
                            <c:otherwise>
                                （${linkUser.email}）
                            </c:otherwise>
                        </c:choose>
                    </div> 

                    <div class="sk-item2 TextAlignLeft">
                        <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_转款金额" bundle="${bundle}"/>：</label>
                        <input type="text" class="Input100 FloatLeft" name="transfer_amount" id="transfer_amount" onblur="FundTransfer.setTransferAmount(${user.totalBalance},${rateCNY2USD},${rateUSD2CNY});"/>
                        <select class="Input184 Select199 MarginL7 FloatLeft" name="currency_type" id="currency_type">
                            <option value="CNY"><fmt:message key="COLLECT_EDIT_LABEL_UNIT" bundle="${bundle}"/></option>
                            <option value="USD"><fmt:message key="COLLECT_EDIT_LABEL_元/美元" bundle="${bundle}"/></option>
                        </select> 
                    </div>
                    <div class="sk-item2 TextAlignLeft">
                        <label class="sk-label2"><fmt:message key="TRANSFER_LINKTRANSFER_LABEL_事由" bundle="${bundle}"/>：</label>
                        <input type="text" class="Input100 FloatLeft" style="width:450px;" name="transfer_title" id="transfer_title"/>
                    </div>
                </div>            
                        <div class="clear"></div></div>
                
                </div>
                        
               <div class="BlueBoxContent826" style="width: 640px;">         
                <dl class="dlRegister">  
                    <dt style="background: none"><fmt:message key="PAYMENT_DETAIL_您的信息" bundle="${bundle}"/></dt>
                    <dd class="Padding0">
                        <div class="payment_left FloatLeft MarginTop10" >
                            <div><fmt:message key="PAYMENT_DETAIL_LABEL_姓名" bundle="${bundle}"/>
                                <c:if test="${user==null}"> 
                                    <span class="ColorOrange">*</span>
                                </c:if>
                            </div>
                            <c:if test="${not empty payer}">
                                <input type="hidden" name="register_personal_info[0].id" value="${payer.id}" />
                            </c:if>
                            <input type="hidden" name="register_personal_info[0].type" value="PAYER" />
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].name" id="payer_name" class="Input450 Input300 MarginBottom5"
                                   value="${payer != null ? payer.name : user.name}"/>

                            <div class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_手机" bundle="${bundle}"/>
                            </div>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].mobile_phone" id="payer_mobilePhone" class="Input450 Input300 MarginBottom5"
                                   value="${payer != null ? payer.mobilePhone : user.mobilePhone}"/>

                            <div class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_公司" bundle="${bundle}"/>
                            </div>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].company" id="payer_company" class="Input450 Input300 MarginBottom5"
                                   value="${payer != null ? payer.company : user.company}"/> 

                            <div><fmt:message key="PAYMENT_DETAIL_LABEL_职务" bundle="${bundle}"/>
                            </div>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].position" id="payer_position" class="Input450 Input300 MarginBottom5"
                                   value="${payer != null ? payer.position : user.position}" />
                        </div> 
                        <div class="payment_right FloatRight TextAlignRight MarginTop10">
                            <div class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_邮箱" bundle="${bundle}"/>
                                <c:if test="${user==null}">
                                    <span class="ColorOrange">*</span>
                                </c:if>
                            </div>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].email" id="payer_email" class="Input450 Input300 MarginBottom5" 
                                   value="${payer != null ? payer.email : user.email}" />
                            <textarea <c:if test="${requireApproval}">disabled="disabled"</c:if> class="TextareaPaymentMessage" id="payer_msg" name="payer_msg" onblur="YpEffects.toggleFocus('payer_msg', 'blurs','<fmt:message key="PAYMENT_DETAIL_MSG_给收款人留言" bundle="${bundle}"/>','', '#909ea4');" onfocus="YpEffects.toggleFocus('payer_msg','focus','<fmt:message key="PAYMENT_DETAIL_MSG_给收款人留言" bundle="${bundle}"/>', '', 'black');"><fmt:message key="PAYMENT_DETAIL_MSG_给收款人留言" bundle="${bundle}"/></textarea>
                            </div>
                            <div class="clear"></div>
                        </dd>
                    </dl>
                    <dl class="dlRegister" id="payment_style_choose">
                        <dt style="background: none"><fmt:message key="PAYMENT_DETAIL_LABEL_支付方式" bundle="${bundle}"/></dt>
                    <dd class="Padding0">
                        <c:if test="${user != null}">
                            <div id="balance_lack_container" style="display: none">
                                <input type="checkbox" name="balance_lack_payment" value="true" onclick="GatewayPayment.toggleBalancePayment();"/>
                                <span id="balance_lack_text_usd" style="display:none"><fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元XXX美元,剩余YYY美元用其他方式' bundle='${bundle}'></fmt:message></span>
                                <span id="balance_lack_text_cny" style="display:none"><fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元,剩余YYY元用其他方式' bundle='${bundle}'></fmt:message></span>
                                    <span id="balance_lack_text">

                                    </span>
                                </div>
                        </c:if>
                        <div>
                            <c:set var="gateway_type_init" value="PAYMENT_DETAIL_LABEL_请选择"></c:set>
                                <div  class="MarginTop20">
                                    <!-- 支付方式下拉列表信息-->
                                    <span class="FloatLeft" style=" line-height:32px;height:32px;"><fmt:message key="PAYMENT_DETAIL_LABEL_选择支付方式" bundle="${bundle}" /></span>
                                <span class="FloatLeft"><jsp:directive.include file="/WEB-INF/paygate/z_gateway_select.jsp"></jsp:directive.include></span>
                                    <div class="clear"></div>
                                </div>
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
                        </div>
                    </dd>
                    <div class="line"></div>
                </dl>
                <div class="BlueBoxContent826 TextAlignRight" style=" width:640px;line-height:36px; margin:15px 0px;">
                    <span id="payment_not_free">  
                        <input type="submit" name="Submit" class="collection_button FloatRight  MarginL7" value="<fmt:message key='TRANSFER_LINKTRANSFER_BUTTON_转款' bundle='${bundle}'/>" id="payment_btn"/> 
                    </span>
                    <input type="hidden" name="to_user_id" value="${linkUser.id}" />
                    <input type="hidden" name="pmode_id" id="pmode_id" value="-1"/>    
                    <input type="hidden" name="gateway_type" id="gateway_type" value="-1"/>
                    <input type="hidden" name="chinabank_credit_card_sub" id="chinabank_credit_card_sub" value="-1"/>
                    <input id="detail_pay_order" type="hidden" name="a" value="INIT_PAY_ORDER" />
                    <input type="hidden" name="urlUserWantToAccess" id="login_redirect_url_field" value="/transfer/create/${linkUser.ypLinkId}" />
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
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    $(document).ready(
    function(){
        // init gateway selects 
        GatewayPayment.initGatewaySelect("link_transfer",${rateCNY2USD},${rateUSD2CNY},null,${user.totalBalance == null ? 0 : user.totalBalance});
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
<c:set var="scriptVarName" value="FundTransfer"></c:set>
<%@include file="/WEB-INF/payment/z_payment_tip_dialog.jsp" %>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 