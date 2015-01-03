<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : Mar 29, 2011, 10:49:28 AM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_MODIFY_PASSWORD);
%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="noticeMessage" style="display:none">
        <div class="successMessage" style="display:none"></div>
        <div class="wrongMessage" style="display:none"></div>
        <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
        
    </div>
    <div class="BlueBoxContent">
        <form action="/account/modify_passwd" method="POST" id="account_modify_password">
            <input type="hidden" name="a" value="modify_passwd"/>
            <div class="sk-item MarginTop30">
                 <label class="sk-label"><fmt:message key="ACCOUNT_MODIFYPASSWD_原密码" bundle="${bundle}"/></label>
                 <input type="password" class="Input450" name="password"id="password" value="" autocomplete="off"/><span id="modify_password_notice" style=" position:absolute;color:red">${postResult.errorMsgs['password']}</span>
            </div>
            <div class="sk-item">
                 <label class="sk-label"><fmt:message key="ACCOUNT_MODIFYPASSWD_新密码" bundle="${bundle}"/></label>
                 <input type="password" class="Input450" name="password1" id="password1"/><span id="modify_password1_notice" style="color:red">${postResult.errorMsgs['password1']}</span>
            </div>
            <div class="sk-item">
                 <label class="sk-label"><fmt:message key="ACCOUNT_MODIFYPASSWD_重复新密码" bundle="${bundle}"/></label>
                 <input type="password" class="Input450" name="password2" id="password2"/><span id="modify_password2_notice" style="color:red">${postResult.errorMsgs['password2']}</span>
            </div>
            <div class="sk-item">
                 <label class="sk-label"></label>
                 <input type="button" name="Submit" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button" onclick="UserUpdate.validateModifyPassword();"/>
            </div>           
        </form>
       </div>
    
    
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
 