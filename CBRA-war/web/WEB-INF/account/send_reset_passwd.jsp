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
        <form action="/account/send_reset_passwd" method="post" id="send_reset_passwd">
            <div class="loginboxcontent" style="float:right">	

               <div class="sk-item">
                   <label class="sk-label"> </label>  <div class="noticeMessage">
                    <div class="wrongMessage" >
                        <c:if test="${!empty postResult.singleErrorMsg}">
                            ${postResult.singleErrorMsg}
                        </c:if>
                    </div>	
                    <div class="successMessage" >
                        <c:if test="${!empty postResult.singleSuccessMsg}">
                            ${postResult.singleSuccessMsg}
                        </c:if>
                    </div>
                    <div class="loadingMessage"style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="loading" /></div>
                </div></div>

                    <input type="hidden" name="a" value="send_reset_passwd"/>
                    <%-- <div class="pop_div2"><span><fmt:message key="ACCOUNT_SEND_RESET_PASSWD_注册邮箱" bundle="${bundle}"/></span><label><input type="text"  class="pop_input2" name="email" id="email"value="${email}"/></label><div class="clear"></div></div>
                    <div class="pop_div2"><span><fmt:message key="ACCOUNT_SEND_RESET_PASSWD_验证码" bundle="${bundle}"/></span><label><input type="text"  class="pop_input2" name="verifycode" id="verifycode"/></label><div class="clear"></div></div>
                    <div class="pop_div2"><span></span><label><input type="button" onclick="UserUpdate.validateSendResetPasswd();" name="Submit" class="pop_button2 collection_button" value="<fmt:message key='ACCOUNT_SEND_RESET_PASSWD_提交' bundle='${bundle}'/>"/></label><label><img width="177" height="40" src="/RandImgServlet" class="ensure_img"/></label><div class="clear"></div><div class="clear"></div></div>	--%>			
                    <div class="sk-item">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEND_RESET_PASSWD_注册邮箱" bundle="${bundle}"/></label>
                        <input type="text"  class="pop_input2" name="email" id="email"value="${email}"/>
                    </div>
                    <div class="sk-item">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEND_RESET_PASSWD_验证码" bundle="${bundle}"/></label>
                        <input type="text"  class="pop_input2" name="verifycode" id="verifycode"/>
                    </div>
                    <div class="sk-item">
                        <input type="button" onclick="UserUpdate.validateSendResetPasswd();" name="Submit" class="pop_button2 collection_button" value="<fmt:message key='ACCOUNT_SEND_RESET_PASSWD_提交' bundle='${bundle}'/>"/>
                        <img width="156" height="40" src="/RandImgServlet" class="ensure_img FloatLeft"/>
                    </div>
            </div>
        </form>
        <div class="clear"></div>
    </div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 

