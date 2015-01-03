<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : login
    Created on : Mar 29, 2011, 11:10:23 AM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<form action="/account/signup" method="POST" onsubmit="return UserSignup.checkSignupForm();" id="signupForm">
    <input type="hidden" name="a" value="signup" />
    <input type="hidden" name="urlUserWantToAccess" value="${urlUserWantToAccess}" />
        <div class="login_box">
            <div class="LoginLeft">
                <p class="text20 ColorBlue bold"><fmt:message key="ACCOUNT_LOGIN_LABEL_一个链接" bundle="${bundle}"/></p>
                <div class="LoginLeftText Height192">
                    <ul>
                    <fmt:message key="ACCOUNT_LOGIN_TEXT_友付帮助用户" bundle="${bundle}"/>
                    </ul>
                </div>
            </div>
            <div id="main3" style="float:right">
                <div class="TextAlignRight"><a href="/account/signup_c" class="FloatRight"><fmt:message key="ACCOUNT_SIGNUP_LINK_公司用户注册" bundle="${bundle}"/>
</a><br clear="clear"/></div>
                <div class="noticeMessage" style="display: none">
                    <div class="wrongMessage"  id="signup_wrong_msg_div">                       
                    </div>
                    <div class="loadingMessage" style="display: none" id="signup_loading_div">
                        <fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" />
                    </div>
                </div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_姓名" bundle="${bundle}"/></div>
                <div><input type="text" name="name" value ="${param.name}" id="signup_name" class="pop_input4"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_邮件地址" bundle="${bundle}"/><em class="sign_up_em"><fmt:message key="ACCOUNT_SIGNUP_TEXT_系统将向" bundle="${bundle}"/></em></div>
                <div><input type="text" name="email" value ="${param.email}" id="signup_email" class="pop_input4"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_手机" bundle="${bundle}"/></div>
                <div><input type="text" name="mobilePhone" value ="${param.mobilePhone}" id="signup_mobile" class="pop_input4"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_密码" bundle="${bundle}"/><em class="sign_up_em"><fmt:message key="ACCOUNT_SIGNUP_TEXT_不少于6位" bundle="${bundle}"/></em></div>
                <div><input type="password" name="passwd1" id="signup_passwd" class="pop_input4"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUP_LABEL_重复密码" bundle="${bundle}"/></div>
                <div><input type="password" name="passwd2" id="signup_passwd2" class="pop_input4"/></div>
                <div class="MarginTop10"><a href="/account/login" class="FloatLeft"><fmt:message key="ACCOUNT_SIGNUP_LINK_友付用户请登录" bundle="${bundle}"/></a><input type="submit" value="<fmt:message key='GLOBAL_HEADER_LINK_SIGNUP' bundle='${bundle}'/>" class="pop_button4 collection_button" id="signup_submit_btn"/></div>					
            </div>
            <div class="clear"></div>
        </div>
</form>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<c:if test="${!empty postResult.singleErrorMsg}"> 
    <script>
        MessageShow.showWrongMessage('${postResult.singleErrorMsg}');
    </script>
</c:if> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 

