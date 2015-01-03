<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "FUND_TRANSFER");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/transfer" />
    <jsp:param name="title" value="转款：" />
</jsp:include>
<div class="support-content">
    <c:choose>
        <c:when test="${not empty transferList}">    
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr><td colspan="8" align="left">转款成功：${transferSuccessAmount}</td></tr>
                    <tr>
                        <td width="10%">时间</td>
                        <td width="12%">转款人姓名</td>
                        <td width="10%">转款人Email</td>
                        <td width="12%">收款人姓名</td>
                        <td width="10%">收款人Email</td>
                        <td width="10%">金额</td>
                        <td width="26%">理由</td>
                        <td width="10%">支付状态</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="transfer" items="${transferList}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                            <td><fmt:formatDate value='${transfer.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${transfer.fromUser.id}"></c:if>${transfer.fromUser.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                            <td>
                                ${transfer.fromUser.email} 
                            </td>
                            <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${transfer.toUser.id}"></c:if>${transfer.toUser.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                            <td>
                                ${transfer.toUser.email}
                            </td>
                            <td>${transfer.amount}</td><td>${transfer.detailDesc}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${transfer.status=='WAIT_FOR_RECEIVE'}">
                                        等待接收
                                    </c:when>
                                    <c:when test="${transfer.status=='RECEIVED'}">
                                        已接收
                                    </c:when>   
                                    <c:when test="${transfer.status=='BOUNCED'}">
                                        已接收
                                    </c:when> 
                                    <c:otherwise>
                                        未付款
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${transferList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${transferList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${transferList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>

