<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    request.setAttribute("mainMenuSelection", "COLLECT_REPORT");
    request.setAttribute("subMenuSelection", "");
%>
<%@include file="/WEB-INF/report/z_header.jsp"%>         
<jsp:include page="/WEB-INF/report/z_date_form.jsp">
    <jsp:param name="action" value="/report/collect" />
    <jsp:param name="title" value="收款：" />
</jsp:include>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty collectionList}">                
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <%--
                    <tr>
                        <td colspan="8" align="left">
                            已收款：<fmt:formatNumber value="${cny}" type="currency"  pattern="￥#,##0.##"  />&nbsp;
                            <fmt:formatNumber value="${usd}" type="currency"  pattern="$#,##0.##"  />
                        </td></tr>
                    --%>
                    <tr>
                        <td>时间</td>
                        <td>姓名</td>
                        <td>Email</td>
                        <td>类型</td>
                        <td>金额</td>
                        <td>URL</td>
                        <td>已收数目</td>
                        <td>通过友付发送</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="collect" items="${collectionList}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                            <td><fmt:formatDate value='${collect.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td>${collect.ownerUser.name}</td>
                            <td>${collect.ownerUser.email}</td>
                            <td>${collect.type}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${collect.unitAmountType == 'FIXED'}"><fmt:formatNumber value="${collect.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${collect.currencySign}" /></c:when>
                                    <c:when test="${collect.unitAmountType == 'MINIMAL'}">最少<fmt:formatNumber value="${collect.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${collect.currencySign}" /></c:when>
                                    <c:when test="${collect.unitAmountType == 'FREEWILL'}">由捐款者自定</c:when>
                                    <c:when test="${collect.unitAmountType == 'SUGGEST'}">建议<fmt:formatNumber value="${collect.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${collect.currencySign}" /></c:when>
                                    <c:when test="${collect.unitAmountType == 'MULTIPLE'}">
                                        <c:forEach var="price" items="${collect.getAvailableFundCollectionPriceList()}" varStatus="status">
                                            <p>
                                                <fmt:formatNumber value="${price.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${price.currencySign}" />
                                            </p>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>
                            </td>
                            <c:choose>
                                <c:when test="${collect.type=='EVENT'}">
                                    <c:set var="payLinkVal" value="event"></c:set>
                                </c:when>
                                <c:when test="${collect.type=='SERVICE'}">
                                    <c:set var="payLinkVal" value="service"></c:set>
                                </c:when>
                                <c:when test="${collect.type=='PRODUCT'}">
                                    <c:set var="payLinkVal" value="product"></c:set>
                                </c:when>
                                <c:when test="${collect.type=='MEMBER'}">
                                    <c:set var="payLinkVal" value="membership"></c:set>
                                </c:when>
                                <c:when test="${collect.type=='DONATION'}">
                                    <c:set var="payLinkVal" value="donation"></c:set>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="payLinkVal" value="pay"></c:set>
                                </c:otherwise>
                            </c:choose>
                            <td><a href="/${payLinkVal}/${collect.webId}">
                                    https://yoopay.cn/${payLinkVal}/${collect.webId}
                                </a></td>
                            <td>
                                <c:if test="${collect.paymentAmountCNY>0}">
                                    ￥${collect.paymentAmountCNY} &nbsp; 共${collect.paidCountCNY}笔<br />
                                </c:if>
                                <c:if test="${collect.paymentAmountUSD>0}">
                                    $ ${collect.paymentAmountUSD}&nbsp;共${collect.paidCountUSD}笔
                                </c:if>


                            </td>
                            <td>${collect.sendCount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/report/z_paging.jsp">
                    <jsp:param name="totalCount" value="${collectionList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${collectionList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${collectionList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/report/z_footer.jsp"/>
