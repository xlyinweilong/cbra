<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : 历史记录
    Created on : Apr 10, 2011, 8:18:10 PM
    Author     : HUXIAOFENG
--%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.TRANSACTION);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.TRANSACTION_VOLUME_LIST);
%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:if test="${postResult.success}">
    <h3 class="nolist">
        ${postResult.singleSuccessMsg}
    </h3>
</c:if>

<c:if test="${!empty postResult.singleErrorMsg}">
    <h3 class="nolist">
        ${postResult.singleErrorMsg}
    </h3>
</c:if>
<c:if test="${transactionVolumeList != null}">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
        <thead>
            <tr>
                <td width="8%"><fmt:message key="TRANSACTION_LABEL_时间" bundle="${bundle}"/></td>
                <td width="13%"><fmt:message key="TRANSACTION_VOLUME_订单号" bundle="${bundle}"/></td> 
                <td width="12%"><fmt:message key="GLOBAL_MENU_套餐流量" bundle="${bundle}"/></td> 
                <td width="10%"><fmt:message key="TRANSACTION_VOLUME_类型" bundle="${bundle}"/></td>
                <td width="42%"><fmt:message key="TRANSACTION_LABEL_事由" bundle="${bundle}"/></td>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="transaction" items="${transactionVolumeList}" varStatus="status">
                <c:set var="mainOrder" value="${transaction.orderMain}"></c:set>
                <c:set var="gatewayPayment" value="${mainOrder.lastGatewayPayment}"></c:set>
                <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                    <td><fmt:formatDate value="${transaction.createDate}" type="date" pattern="yyyy.MM.dd"/></td>
                    <td>
                        ${mainOrder.serialId}
                    </td>
                    <td>
                        <fmt:formatNumber value="${transaction.volumeAmount}" type="currency"  pattern="#,##0.##"/>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${transaction.type == 'VOLUME_OUT'}">
                                <fmt:message key="TRANSACTION_VOLUME_支出" bundle="${bundle}"/>
                            </c:when>
                            <c:when test="${transaction.type == 'VOLUME_IN'}">
                                <fmt:message key="TRANSACTION_VOLUME_充值" bundle="${bundle}"/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${transaction.type == 'VOLUME_OUT'}">
                                ${transaction.remarks}
                            </c:when>
                            <c:when test="${transaction.type == 'VOLUME_IN'}">
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/WEB-INF/public/z_paging.jsp">
        <jsp:param name="baseUrl" value="/transaction/list_volume" />
        <jsp:param name="totalCount" value="${transactionVolumeList.getTotalCount()}" />
        <jsp:param name="maxPerPage" value="${transactionVolumeList.getMaxPerPage()}" />
        <jsp:param name="pageIndex" value="${transactionVolumeList.getPageIndex()}" />
    </jsp:include>

</c:if>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
