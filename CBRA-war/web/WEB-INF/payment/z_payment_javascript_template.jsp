<%-- 
    Document   : z_payment_javascript_template
    Created on : Apr 23, 2012, 6:05:51 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="javascript_payment_templates" style="display:none">
    <%--Currency convert tip template --%>
    <div id="currency_convert_tip_template" style="display:none">
        <div style="display:none" id="usd_tip_template">
            <fmt:message key="GLOBAL_CURRENCY_MSG_美元人民币汇率" bundle="${bundle}">
                <fmt:param value="${rateUSD2CNY}" />
            </fmt:message>
        </div>
        <div style="display:none" id="cny_tip_template">
            <fmt:message key="GLOBAL_CURRENCY_MSG_人民币美元汇率" bundle="${bundle}">
                <fmt:param value="${rateCNY2USD}" />
            </fmt:message>
        </div>
    </div>
</div>
