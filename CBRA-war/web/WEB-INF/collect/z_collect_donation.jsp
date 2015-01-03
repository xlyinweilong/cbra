<%-- 
    Document   : z_collect_donation
    Created on : Mar 30, 2012, 10:25:12 AM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<dl class="dlEdit">
    <dt><fmt:message key="COLLECT_EDIT_LABEL_基本信息" bundle="${bundle}"/></dt>
    <dd class="left">
        <input type="hidden" name="type" value="DONATION"/>
        <div class="sk-item-edit TextAlignLeft "> 
            <label class="sk-label-edit "><fmt:message key="COLLECT_EDIT_LABEL_募捐金额" bundle="${bundle}"/></label>
            <input type="text" id="collect_amount" class="Input144 shortInput FloatLeft" name="unitAmount" value="<fmt:formatNumber value="${fundCollection.unitAmount}" type="number"  pattern="0.##"/>" />
            <select class="Input184 Select199 FloatLeft MarginL7" name="currency_type" id="currency_type">
                <option value="CNY"><fmt:message key="COLLECT_EDIT_LABEL_UNIT" bundle="${bundle}"/></option>
                <option value="USD"><fmt:message key="COLLECT_EDIT_LABEL_元/美元" bundle="${bundle}"/></option>
            </select> 
            <select name="unit_amount_type" class="Input184 Select199 FloatRight"  id="unit_amount_type" onchange="Collect.changeUnitAmountType();">
                <option value="SUGGEST"><fmt:message key="COLLECT_EDIT_TEXT_建议金额，可多可少" bundle="${bundle}"/></option>
                <option value="FREEWILL"><fmt:message key="COLLECT_EDIT_TEXT_由捐款者自定" bundle="${bundle}"/></option>
                <option value="MINIMAL"><fmt:message key="COLLECT_EDIT_TEXT_最少这个金额" bundle="${bundle}"/></option>
                <option value="FIXED"><fmt:message key="COLLECT_EDIT_TEXT_只接受这个金额" bundle="${bundle}"/></option>
            </select>
            <div class="clear"></div>
        </div>

        <div class="sk-item-edit">
            <label class="sk-label-edit "><fmt:message key="COLLECT_EDIT_LABEL_募捐理由" bundle="${bundle}"/></label>
            <input type="text" id="collect_reason" class="Input450" name="title" value="${fundCollection.title}"/>
        </div>           
        <div class="sk-item-edit TextAlignLeft"> 
            <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_募捐链接" bundle="${bundle}"/></label>
            <div class="MarginL7">
                <span id="collect_default_webId_span" style="font-size: 16px;">
                    https://yoopay.cn/${payLinkVal}/<input type="text" class="Input154" id="customed_webid" name="customed_webid"value="<c:choose><c:when test="${not empty fundCollection}">${fundCollection.webId}</c:when><c:otherwise>${uniqueWebCollectionWebId}</c:otherwise></c:choose>" />
                    <a href="javascript:;" onclick="Collect.checkCollectWebId('${fundCollection.webId}')" class="MarginL7">
                        <fmt:message key="GLOBAL_保存" bundle="${bundle}"/>
                    </a>
                </span>
                <div class="wrongMessage" id="customed_webid_message" <c:if test="${ empty  webIdExist}">style="display:none"</c:if>>${webIdExist}</div>
                </div>
            </div>
        </dd>
        <dd class="right">
        <fmt:message key="COLLECT_DONATION_EDIT_TEXT_请填写收款金额与理由" bundle="${bundle}"/>
    </dd>
    <div class="clear"></div>
</dl>