<%-- 
    Document   : z_yplink_dialog
    Created on : Jul 4, 2011, 5:25:35 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="yplinkDialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
    <div class="noticeMessage" id="yplink_notice_msg">
        <div class="wrongMessage" id="yplink_msg">
            <c:if test="${!empty postResult.singleErrorMsg}">
                <div>${postResult.singleErrorMsg}</div> 
            </c:if>
        </div>	
        <div class="loadingMessage" id="yplink_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
    </div>
    <div id="set_yplink_msg">
        <c:choose>
            <c:when test="${user.accountType=='USER'}">
                <span class="text16 ColorBlue MarginR10 bold"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_您的个人友付链接' bundle='${bundle}'/></span><span class="text12"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_即可向您付款' bundle='${bundle}'/></span> 
                <div class="color1_links_span MarginTop10" style="background:#EBEBEB">https://yoopay.cn/p/ <input type="text" id="yplink_input" value="${user.ypLinkId}" /></div>
                </c:when>
                <c:otherwise>
                <span class="text16 ColorBlue MarginR10 bold"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_您的公司友付链接' bundle='${bundle}'/></span><span class="text12"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_即可向您公司付款' bundle='${bundle}'/></span> 
                <div class="color1_links_span MarginTop10" style="background:#EBEBEB">https://yoopay.cn/o/ <input type="text" id="yplink_input" value="${user.ypLinkId}" /></div>
                </c:otherwise>
            </c:choose>
        <div class="TextAlignRight MarginTop10"><input type="submit" value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" class="collection_button" onclick="yplinkDialog.submit();"/></div>
    </div>
    <div id="set_yplink_success" style="display: none;">
        <fmt:message key="ACCOUNT_YPLINK_MSG_设置成功" bundle="${bundle}"/>
    </div>
</div>