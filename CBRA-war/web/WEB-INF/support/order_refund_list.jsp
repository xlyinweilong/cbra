<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "ORDER_REFUND");
    request.setAttribute("subMenuSelection", "ORDER_REFUND_LIST");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>
<script type="text/javascript">
    function showConfirmRefundDialog(id){
        $('#order_refund_confirm_id').val(id);
        $('#order_refund_confirm').dialog({
            autoOpen: false, 
            width:660,
            show: 'fade',
            modal: true,
            title: "退款操作"
        });
        $('#order_refund_confirm').dialog('open');
    }
    function closeConfirmRefundDialog(){
        $('#order_refund_textarea').text("");
        $('#order_refund_confirm').dialog('close');
    }
    function confirmRefund(id) {
        var id = $('#order_refund_confirm_id').val();
        var note = $("#order_refund_textarea").val();
        $.getJSON('/support/order_refund_list',     
        { a:"CONFIRM_REFUND",id:id,note:note},
        function(json) {
            if(json.success) {
                closeConfirmRefundDialog();
                document.getElementById("msgDiv").innerHTML = "<h5>操作成功</h5>";
                setTimeout(function(){redirect("/support/order_refund_list?start=<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>&end=<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>");},2000);
            } else {
                alert(json.singleErrorMsg)
            }
        });
    }
</script>
<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/order_refund_list" />
    <jsp:param name="title" value="未处理的退款：" />
</jsp:include>
<div id="msgDiv">
</div>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty orderRefundList}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr>
                        <td>订单拥有者</td>
                        <td>拥有者账户余额</td>
                        <td>拥有者邮件</td>
                        <td>拥有者电话</td>
                        <td>订单生成时间</td>
                        <td>订单号</td>
                        <td>退款获得者</td>
                        <td>获得者邮件</td>
                        <td>获得者电话</td>
                        <td>退款金额</td>
                        <td>退款人民币金额</td>
                        <td>操作</td>
                    </tr> 
                </thead>                       
                <c:forEach var="orderRefund" items="${orderRefundList}" varStatus="status">
                    <c:set var="owner" value="${orderRefund.owner}"></c:set>
                    <c:set var="targetUser" value="${orderRefund.targetUser}"></c:set>
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                    <td>
                    <c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${owner.id}"></c:if>${owner.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if>
                    </td>
                    <td>
                        ${owner.totalBalance}
                    </td>
                    <td>
                        ${owner.email}
                    </td>
                    <td>
                        ${owner.mobilePhone}
                    </td>
                    <td>
                    <fmt:formatDate value='${orderRefund.createDate}'type='date' pattern='yyyy.MM.dd'/>
                    </td>
                    <td>
                        ${orderRefund.serialId}
                    </td>
                    <td>
                    <c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${targetUser.id}"></c:if>${targetUser.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if>
                    </td>
                    <td>
                        ${targetUser.email}
                    </td>
                    <td>
                        ${targetUser.mobilePhone}
                    </td>
                    <td>
                    <fmt:formatNumber value="${orderRefund.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${orderRefund.currencyType}" />
                    </td>
                    <td>
                        ${orderRefund.getCNYAmount()}
                    </td>
                    <td>
                        <input type="button" onclick="showConfirmRefundDialog('${orderRefund.id}');" value="处理" />
                    </td>
                </c:forEach>
                </body>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${orderRefundList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${orderRefundList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${orderRefundList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<div id="order_refund_confirm" style="display: none">
    <input type="hidden" id="order_refund_confirm_id" value="" />
    <span class="hidden_input_container">
        <div style="width: 620px; margin: auto">
            备注:<br/>
            <textarea style="width: 500px;height: 90px" id="order_refund_textarea"></textarea>
            <p style="margin-top:10px;text-align:right">
                <a href="javascript:closeConfirmRefundDialog()">取消</a>&nbsp;&nbsp;
                <input type="button" style="cursor:pointer;outline:none;border:none;vertical-align:baseline;height:39px;font-weight:bold;color:#fff;padding-left:15px; padding-bottom:5px; _padding-bottom:0px;line-height:37px;padding-right:15px; font-size:14px;background: #2BA8DD;*border:0;*overflow:visible;" onclick="confirmRefund()" value="确认"/>
            </p>
        </div>
    </span>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
