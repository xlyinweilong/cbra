<%-- 
    Document   : z_payment_widget_step2
    Created on : Aug 27, 2012, 12:56:35 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--Return to payment step 1 link --%>
<div  class='BlueBoxContent TextAlignRight' id="return_payment_step1_link_container">
    <c:if test="${!requireApproval}">
        <a href="/payment/payment_widget/${fundCollection.webId}"><fmt:message key="PAYMENT_DETAIL_BUTTON_重新选择数量" bundle="${bundle}"/></a>
    </c:if>
</div>
<div class="BlueBoxContent" id="payment_notice">
    <div class="ColorOrange bold">*<fmt:message key="PAYMENT_DETAIL_LABEL_必填" bundle="${bundle}"/><br class="clear"/></div>
        <%--
        <div class="input_container_controler">
            <input type="radio" id="older_radio" name="input_container_control_radio"/><fmt:message key="PAYMENT_WIDGET_TEXT_已是友付用户" bundle="${bundle}"/>
        </div>  
        <dl class="dlRegister" id="payer_login_inputs_container" style="display:none">  
            <dt><fmt:message key="PAYMENT_WIDGET_TEXT_请输入您的用户名和密码" bundle="${bundle}"/></dt>
            <dd class="Padding0">
                <div class="payment_left MarginTop10" >
                    <div>
                        <fmt:message key="PAYMENT_WIDGET_TEXT_邮箱" bundle="${bundle}"/>
                        <span class="ColorOrange">*</span>
                    </div>
                    <input type="text" name="payer_login_name" id="payer_login_name" class="Input450 Input300 MarginBottom5"/>
                    <div class="TextAlignLeft"><fmt:message key="PAYMENT_WIDGET_TEXT_密码" bundle="${bundle}"/>
                        <span class="ColorOrange">*</span>
                    </div>
                    <input type="password" name="payer_login_password" id="payer_login_password" class="Input450 Input300 MarginBottom5" />
                    <div>
                        <span class="wrongMessage" id="payer_login_msg_container" style="display:none"></span>
                        <span id="payer_login_loading_container"  style="display:none"><img  src="/images/032.gif" alt="" /></span>
                        <input type="button" value="<fmt:message key="GLOBAL_提交" bundle="${bundle}"/>" class="collection_button FloatRight  MarginL7" onclick="FundPaymentWidget.loadPayerInfo();"/>
                    </div>
                </div> 
            </dd>
        </dl>    
        <div class="input_container_controler">
            <input type="radio" checked="true" id="newer_radio" name="input_container_control_radio"/><fmt:message key="PAYMENT_WIDGET_TEXT_新用户" bundle="${bundle}"/>
        </div>
        --%>
        <%@include file="/WEB-INF/payment/z_payment_step2.jsp" %>
</div>
