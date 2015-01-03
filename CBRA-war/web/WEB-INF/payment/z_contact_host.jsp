<%-- 
    Document   : z_yplink_dialog
    Created on : Jul 4, 2011, 5:25:35 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="width:370px; margin: auto">
    <div class="noticeMessage" id="contactHostMessageDiv" style="display:none">
        <div class="wrongMessage" id="contactHostMessage"></div>
    </div>
    <div title="ajaxReturnSuccess" style="display:none">${postResult.success}</div>
    <div title="ajaxReturnError" style="display:none">${postResult.singleErrorMsg}</div>
    <form id="contactHost" method="post">
        <input type="hidden" name="a" value="contact_host"/>
        <input type="hidden" name="webId" value="${fundCollection.webId}"/>
        <fmt:message key='PAYMENT_DETAIL_LABEL_您的姓名' bundle='${bundle}'/>*<br/>
        <input name="fromName" id="fromName"type="text" class="Input380"/><br/>
        <fmt:message key='PAYMENT_DETAIL_LABEL_您的Email' bundle='${bundle}'/>*<br/>
        <input name="fromEmail"  id="fromEmail"type="text" class="Input380"/><br/>
        <fmt:message key='PAYMENT_DETAIL_LABEL_您的留言' bundle='${bundle}'/>*<br/>
        <textarea type="" name="msgContent" id="msgContent" style="border:2px solid #ccc;width:364px;height:120px;color:#505050;"></textarea><br/>
        <p class="TextAlignRight MarginTop10"><a href="#" onclick="ContactHostDialog.close()"></a>
            <input value="<fmt:message key='GLOBAL_提交' bundle='${bundle}'/>" type="button" class="collection_button" onclick="FundPayment.contactHost()" /></p>
    </form>
</div> 