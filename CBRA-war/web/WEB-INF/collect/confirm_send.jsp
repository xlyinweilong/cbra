<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : confirm_send
    Created on : Dec 27, 2012, 8:37:50 PM
    Author     : Yin.Weilong
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%--弹出窗口--%>
<span class="hidden_input_container">
    <c:choose>
        <%--发送邮件--%>
        <c:when test="${type == 'email' || type == 'event_email'}">
            <c:choose>
                <c:when test="${emailCount != 0}">
                    <div style="width: 620px; margin: auto">
                        <div class="promoteSMSPop">
                            <span><fmt:message key="COLLECT_EDIT_MSG_LABEL_本次推广" bundle="${bundle}"/></span>
                            <ul>
                                <li><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_有效邮件共X封" bundle="${bundle}"><fmt:param value="${emailCount}"></fmt:param></fmt:message></li>
                                <li><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_推广总费用X元" bundle="${bundle}"><fmt:param value="${totalMoney}"></fmt:param></fmt:message></li>
                            </ul>
                            <div class="clear"></div>
                            <c:if test="${notEnoughBalance}"><div><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_您的余额不足支付本次推广费用，请充值" bundle="${bundle}"/></div></c:if>
                            <p><span>*</span> <fmt:message key="COLLECT_EDIT_MSG_CONFIRM_您填写的内容将自动保存在编辑页面内" bundle="${bundle}"/></p>
                        </div>
                        <p class="MarginTop10 TextAlignRight">
                            <a href="javascript:CollectPromote.closeConfirmSend('promote_event_confirm_send')"><fmt:message key='COLLECT_EDIT_MSG_取消' bundle='${bundle}'/></a>&nbsp;&nbsp;
                        <c:if test="${!notEnoughBalance}"><input type="button" class="collection_button" onclick="CollectPromote.submitForm('collect_send','promote_event_confirm_send')" value="<fmt:message key='COLLECT_EDIT_MSG_确认发送' bundle='${bundle}'/>"/></c:if>
                        <c:if test="${notEnoughBalance}"><input type="button" class="collection_button" onclick="$(location).attr('href', '/addfund/create')" value="<fmt:message key='COLLECT_EDIT_MSG_CONFIRM_充值' bundle='${bundle}'/>"/></c:if>    
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="width: 620px; margin: auto">
                        <fmt:message key="COLLECT_EDIT_MSG_没有检测到可用的Email地址" bundle="${bundle}"/>
                        <p class="MarginTop10 TextAlignRight">
                            <a href="javascript:CollectPromote.closeConfirmSend('promote_event_confirm_send')"><fmt:message key='COLLECT_EDIT_MSG_取消' bundle='${bundle}'/></a>
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:when>
        <%--发送手机短息--%>
        <c:when test="${type == 'mobile'}">
            <c:choose>
                <c:when test="${phoneCount != 0 && totalMessage !=0}">
                    <input type="hidden" id="collect_promote_fund_collection_short_id_copy" name="" value="${fundCollectionShortId}" />
                    <div style="width: 620px; margin: auto">
                        <div class="promoteSMSPop">
                           <span><fmt:message key="COLLECT_EDIT_MSG_LABEL_本次推广" bundle="${bundle}"/></span>
                            <ul>
                                <li><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_有效号码共X个" bundle="${bundle}"><fmt:param value="${phoneCount}"></fmt:param></fmt:message></li>
                                <li><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_短信数量为X条" bundle="${bundle}"><fmt:param value="${totalMessage}"></fmt:param></fmt:message></li>
                                <li><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_推广总费用X元" bundle="${bundle}"><fmt:param value="${totalMoney}"></fmt:param></fmt:message></li>
                            </ul>
                            <div class="clear"></div>
                            <c:if test="${notEnoughBalance}"><div><fmt:message key="COLLECT_EDIT_MSG_CONFIRM_您的余额不足支付本次推广费用，请充值" bundle="${bundle}"/></div></c:if>
                            <p><span>*</span> <fmt:message key="COLLECT_EDIT_MSG_CONFIRM_您填写的内容将自动保存在编辑页面内" bundle="${bundle}"/></p>
                        </div>
                        <p class="MarginTop10 TextAlignRight">
                            <a href="javascript:CollectPromote.closeConfirmSend('confirm_send')"><fmt:message key='COLLECT_EDIT_MSG_取消' bundle='${bundle}'/></a>&nbsp;&nbsp;
                        <c:if test="${!notEnoughBalance}"><input type="button" class="collection_button" onclick="CollectPromote.submitForm('short_message_promote','confirm_send')" value="<fmt:message key='COLLECT_EDIT_MSG_确认发送' bundle='${bundle}'/>"/></c:if>
                        <c:if test="${notEnoughBalance}"><input type="button" class="collection_button" onclick="$(location).attr('href', '/addfund/create')" value="<fmt:message key='COLLECT_EDIT_MSG_CONFIRM_充值' bundle='${bundle}'/>"/></c:if>
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="width: 620px; margin: auto">
                        <c:if test="${phoneCount == 0}"><fmt:message key="COLLECT_EDIT_MSG_没有检测到可用的手机号码" bundle="${bundle}"/></c:if>
                        <p class="MarginTop10 TextAlignRight">
                            <a href="javascript:CollectPromote.closeConfirmSend('confirm_send')"><fmt:message key='COLLECT_EDIT_MSG_取消' bundle='${bundle}'/></a>
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:when>
    </c:choose>
</span>
