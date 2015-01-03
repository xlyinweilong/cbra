<%-- 
    Document   : z_payment_basic_step2
    Created on : Aug 27, 2012, 12:56:06 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--Return to payment step 1 link --%>
<div  class='BlueBoxContent TextAlignRight' id="return_payment_step1_link_container">
    <c:if test="${!requireApproval}">
        <a href="/payment/payment/${fundCollection.webId}"><fmt:message key="PAYMENT_DETAIL_BUTTON_重新选择数量" bundle="${bundle}"/></a>
    </c:if>
</div>
<div class='BlueBox_Gray'>
    <div class="BlueBoxContent">
        <div class=" MarginBottom20">
            <div class="FloatLeft ColorOrange bold">* <fmt:message key="PAYMENT_DETAIL_LABEL_必填" bundle="${bundle}"/></div>
            <c:if test="${user == null}">
                <%--User login entrance link --%>
                <div class="FloatRight bold" id="user_login_link_container">
                    <fmt:message key="PAYMENT_DETAIL_LABEL_已经是友付用户请登录" bundle="${bundle}">
                        <fmt:param value="loginDialog.open();"></fmt:param>
                    </fmt:message>
                </div> 
            </c:if>
            <br class="clear"/>
        </div>
        <%@include file="/WEB-INF/payment/z_payment_step2.jsp" %>
    </div>
</div>
