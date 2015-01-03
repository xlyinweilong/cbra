<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : paypal_transaction
    Created on : Jul 13, 2012, 3:15:55 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html >
<%
    request.setAttribute("mainMenuSelection", "PAYPAL");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<form action="paypal_transaction" method="post">
    <div class="search bold"><input type="hidden" name="a" value="paypal_transaction"/>
        paypal 或者 creditcard 的id:<input type="text" name="transactionId" value="${transactionId}"/>
        用户的email:<input type="text" name="transactionEmail" value="${transactionEmail}"/>
        <input type="submit" value="确定" class="button"/>
    </div>
</form>
<form id="search_form" action="paypal_transaction" method="POST">
    <input type="hidden" id="page_num" name="page" value="1"/>
    <input type="hidden" name="a" value="paypal_transaction"/>
    <input type="hidden" name="transactionId" value="${transactionId}"/>
    <input type="hidden" name="transactionEmail" value="${transactionEmail}"/>
</form>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty requestScope.resultlist}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr>
                        <td>时间</td>
                        <td>姓名</td>
                        <td>邮箱</td>
                        <td>方式</td>
                        <td>详细信息</td>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="gatewayPayment" items="${requestScope.resultlist}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if> >
                    <td><fmt:formatDate value='${gatewayPayment.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${gatewayPayment.orderMain.owner.id}"></c:if>${gatewayPayment.orderMain.owner.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                    <td>${gatewayPayment.orderMain.owner.email}</td>
                    <td>${gatewayPayment.gatewayType}</td>
                    <td><a href="paypal_transaction_information/${gatewayPayment.id}">详细信息</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${requestScope.resultlist.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${requestScope.resultlist.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${requestScope.resultlist.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            ${requestScope.noResult}
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>

