<%-- 
    Document   : seal
    Created on : May 26, 2011, 2:15:00 PM
    Author     : WangShuai
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_SEAL);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="noticeMessage">
        <div class="successMessage" id="seal_success_msg_div"><span class="FloatLeft"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_申请实名认证" bundle="${bundle}"/></span><span class="FloatRight why_verify"><a href="/public/verification" title="" target="_blank">
<fmt:message key="ACCOUNT_SEAL_USER_LINK_为什么要实名认证？" bundle="${bundle}"/></a></span><div class="clear"></div></div>
        <div class="wrongMessage" style="display:none" id="seal_wrong_msg_div">
        </div>
        <c:if test="${!empty postResult.singleErrorMsg}"> 
            <div style="background:#F8E1E1; color:#BD2C2C;">
                ${postResult.singleErrorMsg}
            </div>
        </c:if> 
        <div class="loadingMessage" style="display:none" id="seal_loading_div"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
    </div>
    <div class="BlueBoxContent826">
    
    <div class="Padding30">
        <form method="POST" action="${formAction}" enctype="multipart/form-data" onsubmit="return UserSeal.checkSealForm(${user.logoUrl == null});">
            <div class="FloatLeft BlueBoxLeft">
                <div class="photo">
                    <c:choose>
                        <c:when test="${not empty user.logoUrl}"> <img src="${user.logoUrl}" width="80" /></c:when>
                        <c:otherwise><img src="/images/photo.png" width="80" /></c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="FloatLeft BlueBoxContent">

                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_REGINFO_LABEL_上传头像" bundle="${bundle}"/></label>
                    <input name="logo" type="file" class="Input450 Input461"id="seal_logo"/>
                    <div class="sk-explain"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_最佳80x80像素，最大1MB" bundle="${bundle}"/></div>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_姓名" bundle="${bundle}"/></label>
                    <input type="text" class="Input450" name="user_name" id="seal_name" value="${user.name}"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_邮箱" bundle="${bundle}"/></label>
                    <input type="text" class="Input450" name="user_email" id="seal_email" value="${user.email}" readonly="readonly" style="color:#9D9D9D"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_手机" bundle="${bundle}"/></label>
                    <input type="text" class="Input450" name="user_mobile" id="seal_mobile" value="${user.mobilePhone}"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件种类" bundle="${bundle}"/></label>  
                    <select name="ctype" class="Input450 Select465" id="seal_ctype">
                        <option value="-1"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_请选择" bundle="${bundle}"/></option>
                        <option value="IDENTITY_CARD"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_身份证" bundle="${bundle}"/></option>
                        <option value="PASSPORT"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_护照" bundle="${bundle}"/></option>
                        <option value="GAT_TWT"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_港澳台居民大陆通行证" bundle="${bundle}"/></option>
                        <option value="SOLDIER_IDENTITY_CARD"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_军官证" bundle="${bundle}"/></option>
                    </select>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件号码" bundle="${bundle}"/></label> 
                    <input type="text" class="Input450" name="cnumber" id="seal_cnumber"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_TEXT_上传证件扫描件" bundle="${bundle}"/></label>
                    <input name="cimg" type="file" class="Input450 Input461" id="seal_cimg"/>
                    <div class="sk-explain"><fmt:message key="ACCOUNT_SEAL_COMPANY_TEXT_文件最大5MB" bundle="${bundle}"/></div>
                </div>
                <div class="sk-item">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_补充说明" bundle="${bundle}"/></label>
                      <textarea name="addition_notes" class="textareaH50" id="textarea" cols="45" rows="5"></textarea>
                </div>
                <div class="sk-item"> 
                    <label class="sk-label"></label>
                    <input type="hidden" name="a" value="CREATE_SEAL" />
                    <c:choose>
                        <c:when test="${user.verified}">
                            <input type="submit" name="Submit" value="<fmt:message key='ACCOUNT_SEAL_COMPANY_BUTTON_申请认证' bundle='${bundle}'/>" class="collection_button" id="seal_submit_btn"/>
                        </c:when>
                        <c:otherwise>
                            <input type="button" name="Submit" value="<fmt:message key='ACCOUNT_SEAL_COMPANY_BUTTON_申请认证' bundle='${bundle}'/>" class="collection_button" id="seal_submit_btn" onclick="verifyDialog.open();"/>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div> 
            <div class="clear"></div>
        </form>
    </div>
</div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<c:if test="${!user.verified}">
    <script type="text/javascript">
        window.onload = function() {
            verifyDialog.open();
        }
    </script>
</c:if>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 