<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_login_dialog
    Created on : Apr 20, 2011, 7:01:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div onkeydown="if(event.keyCode == 13){signupDialog.doSignup();}">
    <div title="ajaxReturn" style="display:none">${postResult.success}</div>
    <div class="yui-panel-container yui-dialog shadow" id="hzLoginSignupDialog_c" style="visibility: visible; left: 260px; top: 121px; ">
        <form id="signupForm">
            <input type="hidden" name="a" value="signup_ajax" />
            <div id="main3">	
                <div><a href="javascript:void(0)" title="" onclick="signupDialog.close();loginDialog.open();"><fmt:message key="ACCOUNT_Z_SIGNUP_DIALOG_TEXT_请登录" bundle="${bundle}"/></a></div>	
                <div class="noticeMessage" <c:if test="${empty postResult.singleErrorMsg}">style="display:none"</c:if>  >
                    <div class="wrongMessage" id="pop_signup_msg">
                        <c:if test="${!empty postResult.singleErrorMsg}"> 
                            ${postResult.singleErrorMsg}
                        </c:if> 
                    </div>
                    <div class="loadingMessage" style="display: none" id="pop_signup_loading_div">
                        <fmt:message key="ACCOUNT_Z_SIGNUP_DIALOG_TEXT_注册中请稍候" bundle="${bundle}"/><img src="/images/032.gif" alt="" />
                    </div>
                </div>
                <div><fmt:message key="COLLECT_DETAIL_LABEL_姓名" bundle="${bundle}"/></div>	
                <div><input type="text" name="name" class="pop_input4" value ="${param.name}" id="pop_signup_name"/></div>	
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_邮件地址" bundle="${bundle}"/><em class="sign_up_em"><fmt:message key="ACCOUNT_SIGNUP_TEXT_系统将向" bundle="${bundle}"/></em></div>	
                <div><input type="text" name="signupEmail" class="pop_input4" value ="${param.email}" id="pop_signup_email"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_手机" bundle="${bundle}"/></div>	
                <div><input type="text" name="signupMobilePhone" class="pop_input4" value ="${param.mobilePhone}" id="pop_signup_mobile"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_密码" bundle="${bundle}"/><em class="sign_up_em"><fmt:message key="ACCOUNT_SIGNUP_TEXT_不少于6位" bundle="${bundle}"/></em></div>	
                <div><input type="password" name="passwd1" class="pop_input4" id="pop_signup_passwd"/></div>	
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_重复密码" bundle="${bundle}"/></span></p></div>	
                <div><input type="password" name="passwd2" class="pop_input4" id="pop_signup_passwd2"/></div>	
                <div class="MarginTop10">                   
                    <input type="hidden" name="pop_signup_payid" value="-1" id="pop_signup_payid"/>
                    <input type="button" name="Submit" value="<fmt:message key='GLOBAL_HEADER_LINK_SIGNUP' bundle='${bundle}'/>" class="pop_button4 collection_button" onclick="signupDialog.doSignup();return false;" id="pop_signup_submit_btn"/>                    
                </div>						
            </div>
            <div style="display:none" id="event_addition_info_signup"><%--未登录时 活动 付款--%>
            </div>
        </form>
    </div>
</div>