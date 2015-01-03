<%-- 
    Document   : processedInvoice
    Created on : Sep 18, 2012, 4:24:38 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "INVOICE");
    request.setAttribute("subMenuSelection", "PROCESSED_INVOICE");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/processed_invoice" />
    <jsp:param name="title" value="已处理的友付代开发票：" />
</jsp:include>
<c:if test="${not empty orderCollectionSubList}"><div style=""><a href="/support/un_processed_invoice?start=<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>&end=<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>&a=DOWNLOAD_INVOICE&isProcessed=true">下载CSV文件</a></div></c:if>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty orderCollectionSubList}">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead><tr>
                        <td>订单完成时间</td>
                        <td>订单号</td>
                        <td>订单拥有者</td>
                        <td>活动名称</td>
                        <td>活动创建者</td>
                        <td>已付金额</td>
                        <td>发票抬头</td>
                        <td>收件人</td>
                        <td>电话</td>
                        <td>地址</td>
                        <td>省市</td>
                        <td>邮编</td>
                    </tr> </thead>                       
                <c:forEach var="order" items="${orderCollectionSubList}" varStatus="status">
                    <c:set var="invoice" value="${order.parentOrderCollection.userInvoice}"></c:set>
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                    <td><fmt:formatDate value='${order.parentOrderCollection.endDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    <td>${order.subSerialId}</td>
                    <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${order.parentOrderCollection.owner.id}"></c:if>${order.parentOrderCollection.owner.name}</a></td>
                    <td><a href="/${order.fundCollection.type}/${order.fundCollection.webId}">${order.fundCollection.title}</a></td>
                    <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${order.fundCollection.ownerUser.id}"></c:if>${order.fundCollection.ownerUser.name}</a></td>
                    <td>
                    <fmt:formatNumber value="${order.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${order.parentOrderCollection.currencySign}" />
                    </td>
                    <td>
                        ${invoice.invoiceTitle}
                    </td>
                    <td>
                        ${invoice.recipientName}
                    </td>
                    <td>
                        ${invoice.recipientPhone}
                    </td>
                    <td>
                        ${invoice.recipientAddress}
                    </td>
                    <td>
                        ${invoice.recipientProvince}
                    </td>
                    <td>
                        ${invoice.recipientPostcode}
                    </td>
                </c:forEach>
                </body>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${orderCollectionSubList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${orderCollectionSubList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${orderCollectionSubList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
