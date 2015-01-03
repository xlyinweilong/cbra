<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : newjsp
    Created on : May 23, 2011, 4:42:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="login_box">
        <div class="LoginLeft">
            <p class="text20 ColorBlue bold"><fmt:message key="ACCOUNT_LOGIN_LABEL_一个链接" bundle="${bundle}"/></p>
            <div class="LoginLeftText Height192">
                <ul><fmt:message key="ACCOUNT_LOGIN_TEXT_友付帮助用户" bundle="${bundle}"/></ul>
            </div>
        </div>

        <div id="main3" style="float:right">
            <form action="/account/signup_c" method="POST" onsubmit=" return UserSignup.checkSignUpCompany();">
                <input type="hidden" name="a" value="signup_c"/>
                <div class="TextAlignRight"><a href="/account/signup" class="FloatRight"><fmt:message key="ACCOUNT_SIGNUPC_LINK_个人用户注册" bundle="${bundle}"/></a><br clear="clear"/></div> 
                <div class="noticeMessage" style="display: none">
                    <div class="wrongMessage"  id="signup_wrong_msg_div" style="display: none">    
                    </div>
                    <div class="loadingMessage" id="signup_loading_div" style="display: none">
                        <fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" />
                    </div>
                </div>
                <div><fmt:message key="ACCOUNT_SIGNUPC_LABEL_公司团体名称" bundle="${bundle}"/></div>
                <div><input type="text" class="pop_input4" name="company" id="company"/></div>
                <div style="line-height:26px;"><fmt:message key="ACCOUNT_SIGNUPC_LABEL_联系人姓名" bundle="${bundle}"/></div>
                <div style="line-height:20px;"><em class="sign_up_em" style="margin-left:0px;"><fmt:message key="ACCOUNT_SIGNUPC_TEXT_管理此账户人的姓名" bundle="${bundle}"/></em></div>
                <div><input type="text" class="pop_input4" name="name" id="name"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUPC_LABEL_手机" bundle="${bundle}"/></div>
                <div><input type="text" class="pop_input4" name="mobile" id="mobile"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUPC_LABEL_联系人职务" bundle="${bundle}"/><em class="sign_up_em"><fmt:message key="ACCOUNT_SIGNUPC_TEXT_管理此账户人的职务" bundle="${bundle}"/></em></div>
                <div><input type="text" class="pop_input4" name="position" id="position"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUPC_LABEL_邮箱地址" bundle="${bundle}"/></div>
                <div><input type="text" class="pop_input4" name="email" id="email"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUPC_LABEL_密码" bundle="${bundle}"/></div>
                <div><input type="password" class="pop_input4" name="passwd1" id="passwd1"/></div>
                <div><fmt:message key="ACCOUNT_SIGNUPC_LABEL_重复密码" bundle="${bundle}"/></div>
                <div><input type="password" class="pop_input4" name="passwd2" id="passwd2"/> </div>
                <div><a href="/account/login" class="FloatLeft"><fmt:message key="ACCOUNT_SIGNUPC_LINK_友付用户请登录" bundle="${bundle}"/></a><input type="submit" value="<fmt:message key='GLOBAL_HEADER_LINK_SIGNUP' bundle='${bundle}'/>" class="pop_button4 collection_button"/></div>
            </form>
        </div>
        <div class="clear"></div>
    </div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<c:if test="${not empty postResult.singleSuccessMsg}">
    <script>   
        $(document).ready(function(){
            var successMessage='${postResult.singleSuccessMsg}';
            if(successMessage!=''){
                MessageShow.showSuccessMessage(successMessage);
            }
        });
    </script>
</c:if>
<c:if test="${not empty postResult.singleErrorMsg}">
    <script>   
        $(document).ready(function(){
            var wrongMessage='${postResult.singleErrorMsg}';
            if(wrongMessage!=''){
                MessageShow.showWrongMessage(wrongMessage);
            }
        });
    </script>
</c:if>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 