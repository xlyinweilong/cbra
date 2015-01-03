<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "ORDER_REFUND");
    request.setAttribute("subMenuSelection", "ORDER_REFUND_LIST_CONFIRMED");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>
<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/order_refund_list_confirmed" />
    <jsp:param name="title" value="已处理的退款：" />
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
                        <td>备注</td>
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
                        ${orderRefund.confirmNote}
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

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
