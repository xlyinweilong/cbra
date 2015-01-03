<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : Mar 29, 2011, 10:49:28 AM
    Author     : HUXIAOFENG
--%>
  
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>	
<div class="login_box">
    <div class="LoginLeft">
            <p class="text24 ColorBlue bold"><fmt:message key="ACCOUNT_LOGIN_LABEL_一个链接" bundle="${bundle}"/></p> 
            <div class="LoginLeftText"><fmt:message key="ACCOUNT_LOGIN_TEXT_友付帮助用户" bundle="${bundle}"/></div>
        </div>
    <form action="/account/reset_passwd/${webUrl}" method="post" id="reset_passwd">
            <input type="hidden" name="a" value="reset_passwd"/>
            <input type="hidden" name="webUrl" value="${webUrl}"/>
            <div class="loginboxcontent FloatRight">	 
<div class="sk-item">
                   <label class="sk-label"> </label> 
                <div class="noticeMessage">
                    <div class="wrongMessage" id="login_msg">
                        <c:if test="${!empty postResult.singleErrorMsg}">
                            ${postResult.singleErrorMsg}
                        </c:if>
                    </div>	
                    <div class="successMessage" id="login_msg">
                        <c:if test="${!empty postResult.singleSuccessMsg}">
                            ${postResult.singleSuccessMsg}
                        </c:if>
                    </div>
                    <div class="loadingMessage" id="login_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="loading" /></div>
                </div></div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_RESET_PASSWD_LABEL_新密码" bundle="${bundle}"/></label> <input  class="pop_input2" type="password" name="password" id="password" autocomplete="false"/></div>
               <div class="sk-item">
                   <label class="sk-label"><fmt:message key="ACCOUNT_RESET_PASSWD_LABEL_重复密码" bundle="${bundle}"/></label><input type="password"  class="pop_input2" name="password1" id="password1"/></div>
                <div class="sk-item">
                    <label class="sk-label"></label>
                    <input type="button" name="Submit" onclick="UserUpdate.validateResetPasswd();"class="pop_button2 collection_button" value="<fmt:message key='ACCOUNT_SEND_RESET_PASSWD_提交' bundle='${bundle}'/>"/></div>           
              					
            </div>
        </form>
    <div class="clear"></div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<c:if test="${!empty postResult.singleSuccessMsg}">
    <form action="/account/login" id="redirect_after_success" method="post">
        <input type="hidden" name="email" value="${email}"/>
    </form>
    <script>
        setTimeout(function(){
            document.getElementById("redirect_after_success").submit();
        }, 3000);
        
    </script>
</c:if>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
  