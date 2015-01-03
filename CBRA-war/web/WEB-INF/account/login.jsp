<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : Mar 29, 2011, 10:49:28 AM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<form method="POST" action="/account/login" onsubmit="return UserLogin.checkLoginForm();" id="loginForm">
    <input type="hidden" name="a" value="login" />
    <input type="hidden" name="urlUserWantToAccess" value="${urlUserWantToAccess}" />    	
    <div class="login_box">
        <div class="LoginLeft">
            <p class="text20 ColorBlue bold"><fmt:message key="ACCOUNT_LOGIN_LABEL_一个链接" bundle="${bundle}"/>
            </p> 
            <div class="LoginLeftText">
                <ul>
                    <fmt:message key="ACCOUNT_LOGIN_TEXT_友付帮助用户" bundle="${bundle}"/>
                </ul>
                </div>
        </div>

        <div class="loginboxcontent FloatRight">	    
            <div class="sk-item"><a href="/account/signup" title=""><fmt:message key="ACCOUNT_LOGIN_LINK_SIGNUP" bundle="${bundle}"/></a></div>
            <div class="sk-item-login"> 
                <label class="sk-label" > </label>  
                <div class="noticeMessage" <c:if test="${empty postResult.singleErrorMsg}">style="display: none" </c:if>> 
                    <div class="wrongMessage" id="login_msg">
                        <c:if test="${!empty postResult.singleErrorMsg}">
                            ${postResult.singleErrorMsg}
                        </c:if>
                    </div>	
                    <div class="loadingMessage" id="login_loading_div" style="display:none"><fmt:message key="ACCOUNT_LOGIN_MSG_WAIT" bundle="${bundle}"/><img src="/images/032.gif" alt="loading" /></div>
                </div>
            </div>
            <%-- <div class="pop_div2"><span><fmt:message key="ACCOUNT_LOGIN_LABEL_EMAIL" bundle="${bundle}"/></span><label><input type="text" id="login_email" name="email" value ="${param.email}" class="pop_input2"/></label><div class="clear"></div></div>
            <div class="pop_div2"><span><fmt:message key="ACCOUNT_LOGIN_LABEL_PASSWD" bundle="${bundle}"/></span><label><input type="password" id="login_passwd" name="passwd" class="pop_input2"/></label><div class="clear"></div></div>
            <h4><span class="login_span"><a href="/account/send_reset_passwd" title=""><fmt:message key="ACCOUNT_LOGIN_LINK_FORGET_PASSWD" bundle="${bundle}"/></a></span><label><input type="submit" name="Submit" class="pop_button2 collection_button" id="login_submit_btn" value="<fmt:message key='ACCOUNT_LOGIN_BUTTON_LOGIN' bundle='${bundle}'/>"/></label><div class="clear"></div></h4> --%>						
            <div class="sk-item">
                <label class="sk-label"><fmt:message key="ACCOUNT_LOGIN_LABEL_EMAIL" bundle="${bundle}"/></label>
                <input type="text" id="login_email" name="email" value ="${param.email}" class="pop_input2"/>                    
            </div>
            <div class="sk-item">
                <label class="sk-label"><fmt:message key="ACCOUNT_LOGIN_LABEL_PASSWD" bundle="${bundle}"/></label>
                <input type="password" id="login_passwd" name="passwd" class="pop_input2" />
            </div>                
            <div class="sk-item">
                <label class="sk-label"></label>
                <span class="login_span FloatLeft"><a href="/account/send_reset_passwd" title=""><fmt:message key="ACCOUNT_LOGIN_LINK_FORGET_PASSWD" bundle="${bundle}"/></a></span><span class="FloatRight"><input type="submit" name="Submit" class="collection_button" id="login_submit_btn" value="<fmt:message key='ACCOUNT_LOGIN_BUTTON_LOGIN' bundle='${bundle}'/>"/></span>
            </div>
        </div>
        <div class="clear"></div>
    </div>

</form>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 