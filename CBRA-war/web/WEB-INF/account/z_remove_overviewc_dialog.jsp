<%-- 
    Document   : z_remove_overview_collect_dialog
    Created on : Jan 9, 2012, 2:06:03 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="overviewCollectDialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px;">
    <div class="noticeMessage" id="yplink_notice_msg">
        <div class="wrongMessage" id="yplink_msg">
            <c:if test="${!empty postResult.singleErrorMsg}">
                <div>${postResult.singleErrorMsg}</div> 
            </c:if>
        </div>	
        <div class="loadingMessage" id="yplink_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
    </div>
    <div id="set_yplink_msg">
        <span class="text16 MarginR10">
            <div id="account_overview_text_hide_msg"></div>
        </span>
        <div class="TextAlignRight MarginTop10">
            <input type="hidden" id="overview_c_webid" value="-1"/>
            <a href="javascript:OverviewCollectDialog.close();"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
            <input type="submit" value="<fmt:message key='ACCOUNT_OVERVIEW_BUTTON_隐藏' bundle='${bundle}'/>" class="collection_button" onclick="OverviewCollectDialog.submit();"/>
        </div>
    </div>
    <div id="set_yplink_success" style="display: none;">
        <fmt:message key="ACCOUNT_YPLINK_MSG_设置成功" bundle="${bundle}"/>
    </div>
</div>
