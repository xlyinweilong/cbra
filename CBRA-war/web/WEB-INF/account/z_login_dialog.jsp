<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_login_dialog
    Created on : Apr 20, 2011, 7:01:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div onkeydown="if(event.keyCode == 13){loginDialog.doLogin();}">
    <div title="ajaxReturn" style="display:none">${postResult.success}</div>
    <div class="yui-panel-container yui-dialog shadow" id="hzLoginSignupDialog_c" style="visibility: visible; left: 20px; top: 121px;margin:0 auto;">
        <form id="loginForm">
            <input type="hidden" name="a" value="login_ajax" />
            <input type="hidden" name="urlUserWantToAccess" value="${urlUserWantToAccess}" />
            <div class="FloatLeft" style="width:270px;">
                <div class="LoginPop"><p class="bold text16 MarginBottom5"><fmt:message key="ACCOUNT_LOGIN_POP_LABER_请在登录后付款" bundle="${bundle}"/></p><p><fmt:message key="ACCOUNT_LOGIN_POP_LABER_如果您还没有友付账户" bundle="${bundle}"/></p></div>	</div>
            <div class="FloatRight" style="width:280px;">	

                <div class="sk-item-login-pop">
                    <label class="sk-label-login-pop"> </label> 
                    <div class="noticeMessage">
                        <div class="wrongMessage" id="pop_login_msg" style="display: none"></div>	
                        <div class="loadingMessage" id="pop_login_loading_div" style="display:none"><fmt:message key="ACCOUNT_LOGIN_MSG_WAIT" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
                    </div>
                </div>
                <div class="sk-item-login-pop">
                    <label class="sk-label-login-pop"><fmt:message key="ACCOUNT_LOGIN_LABEL_EMAIL" bundle="${bundle}"/></label>
                    <input type="text" name="email" class="pop_input" value ="${param.email}" id="pop_login_email"/>
                </div>
                <div class="sk-item-login-pop">
                    <label class="sk-label-login-pop"><fmt:message key="ACCOUNT_SIGNUP_LABEL_密码" bundle="${bundle}"/></label>
                    <input type="password" name="passwd" class="pop_input" id="pop_login_passwd"/>
                </div>
                <div class="sk-item-login-pop">
                    <label class="sk-label-login-pop"></label>
                    <span class="login_span FloatLeft" ><a href="/account/send_reset_passwd" title=""><fmt:message key="ACCOUNT_LOGIN_LINK_FORGET_PASSWD" bundle="${bundle}"/></a></span><label><input type="button" name="Submit" value="<fmt:message key='ACCOUNT_LOGIN_BUTTON_LOGIN' bundle='${bundle}'/>" class="pop_button2 collection_button" onclick="loginDialog.doLogin();return false;" id="pop_login_submit_btn"/></label>
                </div>
            </div>
            <div class="clear"></div>
        </form>
    </div>
</div>