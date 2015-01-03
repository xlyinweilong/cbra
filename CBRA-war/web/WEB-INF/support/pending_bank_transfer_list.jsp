<%-- 
    Document   : pending_bank_transfer_list
    Created on : Oct 8, 2011, 5:00:26 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "BANK_TRANSFER");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>
<script type="text/javascript">
    function confirmBankTransfer(gatewayPaymentId) {
        if(confirm("请确认已核实此转账!")) {
            var comment = $("#comment").val();
            $.getJSON('/support/pending_bank_transfer_list', 
                    
            { a: "CONFIRM_BANK_TRANSFER",gatewayPaymentId: gatewayPaymentId, comment: comment },
            function(json) {
                if(json.success) {
                    $("#msgDiv").text(json.singleSuccessMsg);
                    setTimeout(function(){document.location.href = "/support/pending_bank_transfer_list"},2000);
                } else {
                    alert(json.singleErrorMsg)
                }
            });
        }
    }
    function cancelBankTransfer(gatewayPaymentId) {
        if(confirm("请确认取消此转账!")) {
            var comment = $("#comment").val();
            $.getJSON('/support/pending_bank_transfer_list', 
            { a: "CANCEL_BANK_TRANSFER",gatewayPaymentId: gatewayPaymentId, comment: comment },
            function(json) {
                if(json.success) {
                    $("#msgDiv").text("SUCCESS!");
                    setTimeout(function(){document.location.href = "/support/pending_bank_transfer_list"},2000);
                } else {
                    alert(json.message)
                }
            });
        }
    }
</script>

<form id="search_form" action="/support/pending_bank_transfer_list" method="POST">
    <input type="hidden" id="page_num" name="page" value="1"/>
</form>

<div class="support-content">
    <div id="msgDiv">
        <c:if test="${!empty postResult.singleErrorMsg}"> 
            ${postResult.singleErrorMsg}
        </c:if> 
        <c:if test="${postResult.success}"> 
            ${postResult.singleSuccessMsg}
        </c:if> 
    </div>
    <c:choose>
        <c:when test="${not empty gatewayPaymentList}">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <tr>
                    <td>时间</td>
                    <td>查看交易信息</td>
                    <td>银行类型</td>
                    <td>银行卡号</td>
                    <td>银行名称</td>
                    <td>姓名</td>
                    <td>电话</td>
                    <td>金额</td>
                    <td>交易类型</td>
                    <td>订单序列号</td>
                    <td>操作</td>
                </tr>                        
                <c:forEach var="gatewayPayment" items="${gatewayPaymentList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">style="background-color: #DBDBDB"</c:if>>
                        <td><fmt:formatDate value='${gatewayPayment.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                        <td width="30px"><a href="/support/gateway_payment_information/${gatewayPayment.id}">查看</a></td>
                        <td width="40px">
                            <c:choose>
                                <c:when test="${gatewayPayment.gmbTransfer.bankInternational}">国外</c:when>
                                <c:otherwise>国内</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            ${gatewayPayment.gmbTransfer.bankAccountNumber}
                        </td>
                        <td>${gatewayPayment.gmbTransfer.bankName}</td>
                        <td>${gatewayPayment.gmbTransfer.bankUserName}</td>

                        <td>${gatewayPayment.gmbTransfer.userPhone}</td>
                        <td>${gatewayPayment.getCNYGatewayAmount()}</td>
                        <td width="110px">
                            <c:choose>
                                <c:when test="${gatewayPayment.purposeType == 'FUND_PAYMENT'}">付款</c:when>
                                <c:when test="${gatewayPayment.purposeType == 'FUND_API_CHARGE'}">友付API付款</c:when>
                                <c:when test="${gatewayPayment.purposeType == 'FUND_TRANSFER'}">转款</c:when>
                                <c:when test="${gatewayPayment.purposeType == 'FUND_ADD_FUND'}">充值</c:when>
                                <c:when test="${gatewayPayment.purposeType == 'FUND_YOOPAY_SERVICE'}">友付服务：${gatewayPayment.orderMain.yoopayService.serviceName}</c:when>
                            </c:choose>
                        </td>
                        <td>
                            ${gatewayPayment.orderMain.serialId}
                        </td>
                        <td><input type="text" name="comment" id="comment" /><input type="button" value="确认" onclick="confirmBankTransfer('${gatewayPayment.id}')"/><input type="button" value="取消" onclick="cancelBankTransfer('${gatewayPayment.id}')"/></td>
                    </tr>
                </c:forEach>
                </body>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${gatewayPaymentList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${gatewayPaymentList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${gatewayPaymentList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>

