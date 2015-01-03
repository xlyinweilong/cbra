<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : approval_list
    Created on : Aug 28, 2012, 2:02:01 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>
    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="APPROVALLIST"/>
            </jsp:include> 
        </div>
        <form id="approval_form" action="/collect/approval_list/${fundCollection.webId}" mothed="post">
            <input type="hidden" id="approval_form_page" name="page" value="1"/>
            <c:choose>
                <c:when test="${(empty pendingForApproval && empty approvalPass && empty approvalReject) || (pendingForApproval && approvalPass && approvalReject)}">
                    <input type="hidden" id="approval_form_pending_for_approval" name="pending_for_approval" value="true"/>
                <input type="hidden" id="approval_form_approval_pass" name="approval_pass" value="true"/>
                <input type="hidden" id="approval_form_approval_reject" name="approval_reject" value="true"/>
                </c:when>
                <c:otherwise>
                    <input type="hidden" id="approval_form_pending_for_approval" name="pending_for_approval" value="${not empty pendingForApproval && pendingForApproval && !approvalReject}"/>
                <input type="hidden" id="approval_form_approval_pass" name="approval_pass" value="${not empty approvalPass && approvalPass && !pendingForApproval}"/>
                <input type="hidden" id="approval_form_approval_reject" name="approval_reject" value="${not empty approvalReject && approvalReject && !approvalPass}"/>
                </c:otherwise>
            </c:choose>
            <div id="detail_payment_list" class="FloatLeft" style="padding-right:50px;">
                <div class="PaymentListHeader">
                    <span id="no_pay_count" style="display:none">${noPaidCount}</span>
                    <div class="FloatRight"> 
                        <%-- 过滤信息 --%>
                        <select id="approval_select" onchange="Approval.checkedOnclick('${fundCollection.webId}');">
                            <option value="0"  <c:if test="${empty pendingForApproval && empty approvalPass && empty approvalReject}">selected="selected"</c:if> ><fmt:message key='COLLECT_APPROVAL_显示全部' bundle='${bundle}'/></option>
                            <option value="1" <c:if test="${not empty pendingForApproval && pendingForApproval && !approvalReject}">selected="selected"</c:if> ><fmt:message key='COLLECT_APPROVAL_显示未处理' bundle='${bundle}'/></option>
                            <option value="2" <c:if test="${not empty approvalPass && approvalPass && !pendingForApproval}">selected="selected"</c:if> ><span><fmt:message key='COLLECT_APPROVAL_显示通过审批' bundle='${bundle}'/></option>
                                <option value="3" <c:if test="${not empty approvalReject && approvalReject && !approvalPass}">selected="selected"</c:if> ><fmt:message key='COLLECT_APPROVAL_显示未通过审批' bundle='${bundle}'/></option>
                        </select>
                        <span id="collect_payment_download" style="color: red;display: none" ></span>
                    </div> 
                    <div class="clear"></div>
                </div>
                <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table ">
                    <thead>   
                        <tr>
                            <td ><fmt:message key='COLLECT_LIST_LABEL_DATE' bundle='${bundle}'/></td> 
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_姓名' bundle='${bundle}'/></td> 
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_公司' bundle='${bundle}'/></td> 
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_职务' bundle='${bundle}'/></td> 
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_手机' bundle='${bundle}'/></td>
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_邮箱' bundle='${bundle}'/></td>
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_留言' bundle='${bundle}'/></td>
                    <td ><fmt:message key='COLLECT_EDIT_TEXT_折扣码' bundle='${bundle}'/></td>
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_渠道码' bundle='${bundle}'/></td>
                    <td ><fmt:message key='COLLECT_DETAIL_LABEL_已付款' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_结果' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_详细信息' bundle='${bundle}'/></td>
                    </tr> 
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty orderCollectionSubResultList}">
                            <c:forEach var="item" items="${orderCollectionSubResultList}" varStatus="status">
                                <tr <c:if test="${status.count%2!=0}">class="white"</c:if> <c:choose>
                                    <c:when test="${item.parentOrderCollection.status=='PENDING_FOR_APPROVAL'}">style="color:#2BA8DD;"</c:when>
                                    <c:when test="${item.parentOrderCollection.status=='APPROVAL_REJECT'}">style="color:#999;"</c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>>
                                <td><fmt:formatDate value="${item.parentOrderCollection.createDate}" type="date" pattern="yyyy.MM.dd HH:mm"/></td> 
                                <td>${item.parentOrderCollection.payerInfo.name}</td> 
                                <td>${item.parentOrderCollection.payerInfo.company}</td>  
                                <td>${item.parentOrderCollection.payerInfo.position}</td> 
                                <td>${item.parentOrderCollection.payerInfo.mobilePhone}</td> 
                                <td>${item.parentOrderCollection.payerInfo.email}</td>
                                <td>${item.parentOrderCollection.remarks}</td>
                                <td>${item.fundCollectionDiscount.code}</td>
                                <td>${item.fundCollectionReferral.code}</td>
                                <td><c:if test="${item.parentOrderCollection.status == 'SUCCESS'}">√</c:if></td>
                                <td>
                                <c:choose>
                                    <c:when test="${item.parentOrderCollection.status=='PENDING_FOR_APPROVAL'}">
                                        <input type="button" class="account_input" onclick="Approval.showApprovalOperationDialogUnprocessed('${item.subSerialId}')" value="<fmt:message key='COLLECT_DETAIL_LABEL_审批' bundle='${bundle}'/>" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${item.parentOrderCollection.status=='APPROVAL_REJECT'}">
                                                <span style="color:#999;"><fmt:message key='COLLECT_EDIT_TEXT_已拒绝' bundle='${bundle}'/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span><fmt:message key='COLLECT_EDIT_TEXT_已批准' bundle='${bundle}'/></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                                </td>
                                <td><input type="button" class="account_input" onclick="Approval.showDetiledInformation('${fundCollection.webId}','${item.subSerialId}')" value="<fmt:message key='COLLECT_DETAIL_LABEL_详细信息' bundle='${bundle}'/>" /></td>
                                </tr>
                            </c:forEach>
                        </c:when>
                    </c:choose>
                    </tbody>
                </table>
                <c:choose>
                    <c:when test="${not empty orderCollectionSubResultList}">
                        <div class="vPagging">
                            <jsp:include page="/WEB-INF/collect/z_paging.jsp">
                                <jsp:param name="totalCount" value="${requestScope.orderCollectionSubResultList.getTotalCount()}" />
                                <jsp:param name="maxPerPage" value="${requestScope.orderCollectionSubResultList.getMaxPerPage()}" />
                                <jsp:param name="pageIndex" value="${requestScope.orderCollectionSubResultList.getPageIndex()}" />
                                <jsp:param name="formId" value="approval_form" />
                                <jsp:param name="pageId" value="approval_form_page" />
                            </jsp:include>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </form>
        <div class="clear"></div>          
    </div>
</div>
<input type="hidden" name="subSerial_id" value="">
<%--JavaScript HTML模版 --%>
<div id="approval_html_templates" style="display:none">
    <%--操作处理、详细信息模版--%>
    <div class="approval_operation" id="approval_operation_template_unprocessed">
        <%--未经过处理--%>
        <span class="hidden_input_container">
            <div style="width: 620px; margin: auto">
                <fmt:message key='COLLECT_APPROVAL_备注信息' bundle='${bundle}'/>：<br class="clear"/>
                <textarea  type="text" name="" class="TextareaInvoice" style="height: 150px;" id="approval_unoperated_textarea_message_unp" style="width:600px"></textarea><br/>
                <input type="checkbox" name="approval_operatin_is_send_email" id="approval_operatin_is_send_email" checked="checked" onclick="Approval.onclickIsSendEmail()"/><fmt:message key='COLLECT_APPROVAL_发送邮件通知' bundle='${bundle}'/>
                <input type="checkbox" name="" id="approval_operatin_is_send_note_message_unp" value="true" disabled="none"/><fmt:message key='COLLECT_APPROVAL_邮件通知中显示备注信息' bundle='${bundle}'/><br/>
                <!--            <hr/>-->
                <p class="MarginTop10 TextAlignRight">
                    <a href="javascript:Approval.operationApproval('REFUSE')"><fmt:message key='COLLECT_APPROVAL_拒绝' bundle='${bundle}'/></a>&nbsp;&nbsp;
                    <input type="button" class="collection_button" onclick="Approval.operationApproval('PASS')" value="<fmt:message key='COLLECT_APPROVAL_批准' bundle='${bundle}'/>"/>
                </p></div>
        </span>

    </div>
</div>
<div id="approval_list_detailed_information" style="display:none">
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %>
