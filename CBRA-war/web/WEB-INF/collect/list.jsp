<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : 收款列表
    Created on : Apr 10, 2011, 8:01:36 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%
    FundCollection fundCollection = (FundCollection) request.getAttribute("fundCollection");
    String collectionType = null;
    if(fundCollection == null) {
        collectionType = (String)request.getAttribute("collectionType");
    } else {
        collectionType = fundCollection.getType().toString();
    }
    if ("EVENT".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_LIST);
    } else if ("DONATION".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_DONATION);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_DONATION_LIST);
    } else if ("SERVICE".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_SERVICE);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_SERVICE_LIST);
    } else if ("PRODUCT".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_PRODUCT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_PRODUCT_LIST);
    } else if ("MEMBER".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_MEMBER);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_MEMBER_LIST);
    } else {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_LIST);
    }
%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:choose>
    <c:when test="${empty fundCollectionList}">
        <h3 class="nolist">${postResult.singleErrorMsg}</h3>
    </c:when>
    <c:otherwise>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
            <thead>
                <tr>
                    <td width="10%"><fmt:message key="COLLECT_LIST_LABEL_DATE" bundle="${bundle}"/></td>
                    <td width="15%"><fmt:message key="COLLECT_LIST_LABEL_SERAIL" bundle="${bundle}"/></td>
                    <td width="10%"><fmt:message key="COLLECT_LIST_LABEL_类型" bundle="${bundle}"/></td>
                    <td width="13%"><fmt:message key="COLLECT_LIST_LABEL_AMOUNT" bundle="${bundle}"/></td>
                    <td width="35%"><fmt:message key="COLLECT_LIST_LABEL_REASON" bundle="${bundle}"/></td>
                    <td width="17%"><fmt:message key="COLLECT_LIST_LABEL_COLLECTED" bundle="${bundle}"/></td> 
                </tr>
            </thead>
            <tbody>
                <c:forEach var="fundCollection" items="${fundCollectionList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                        <td><fmt:formatDate value="${fundCollection.createDate}" pattern="yyyy.MM.dd" type="date" dateStyle="long" /></td>
                        <td>${fundCollection.serialId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${fundCollection.type == 'DONATION'}"><fmt:message key="COLLECT_EDIT_LABEL_募捐" bundle="${bundle}"/></c:when>
                                <c:when test="${fundCollection.type == 'EVENT'}"><fmt:message key="COLLECT_EDIT_LABEL_活动收款" bundle="${bundle}"/></c:when>
                                <c:when test="${fundCollection.type == 'SERVICE'}"><fmt:message key="COLLECT_EDIT_LABEL_服务收款" bundle="${bundle}"/></c:when>
                                <c:when test="${fundCollection.type == 'PRODUCT'}"><fmt:message key="COLLECT_EDIT_LABEL_产品收款" bundle="${bundle}"/></c:when>
                                <c:when test="${fundCollection.type == 'MEMBER'}"><fmt:message key="COLLECT_EDIT_LABEL_会员收款" bundle="${bundle}"/></c:when>
                                <c:otherwise><fmt:message key="COLLECT_EDIT_LABEL_普通收款" bundle="${bundle}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${fundCollection.unitAmountType == 'FIXED'}">
                                    <fmt:formatNumber value="${fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />
                                </c:when>
                                <c:when test="${fundCollection.unitAmountType == 'MINIMAL'}"><fmt:formatNumber value="${fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />&nbsp;<fmt:message key="PAYMENT_DETAIL_TEXT_起" bundle="${bundle}"/></c:when>
                                <c:when test="${fundCollection.unitAmountType == 'FREEWILL'}"><fmt:message key="PAYMENT_LIST_TEXT_自定" bundle="${bundle}"/></c:when>
                                <c:when test="${fundCollection.unitAmountType == 'SUGGEST'}"><fmt:message key="PAYMENT_LIST_TEXT_建议" bundle="${bundle}"/><fmt:formatNumber value="${fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" /></c:when>
                                <c:when test="${fundCollection.unitAmountType == 'MULTIPLE'}">
                                    <c:forEach var="price" items="${fundCollection.getAvailableFundCollectionPriceList()}" varStatus="status">
                                            <p>
                                                <fmt:formatNumber value="${price.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${price.currencySign}" />
                                            </p>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>

                        </td>
                        <td><a href="/collect/payment_list/${fundCollection.webId}" title="">${fundCollection.title}</a></td>
                        <td>
                            <c:choose>
                                <c:when test="${fundCollection.paymentAmountUSD.intValue() == 0 && fundCollection.paymentAmountCNY.intValue() == 0}">
                                    <fmt:formatNumber value="${fundCollection.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${fundCollection.paymentAmountCNY.intValue()>0}">
                                        <fmt:formatNumber value="${fundCollection.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                                    </c:if>
                                    <c:if test="${fundCollection.paidCountCNY>0}"><font style="font-weight:100">（${fundCollection.paidCountCNY}<fmt:message key="ACCOUNT_OVERVIEW_TEXT_笔" bundle="${bundle}"/>）</font> <br /></c:if>
                                    <c:if test="${fundCollection.paymentAmountUSD.intValue()>0}"><fmt:formatNumber value="${fundCollection.paymentAmountUSD}" type="currency"  pattern="¤#,##0.##" currencySymbol="$" /></c:if>
                                    <c:if test="${fundCollection.paidCountUSD>0}"><font style="font-weight:100">（${fundCollection.paidCountUSD}<fmt:message key="ACCOUNT_OVERVIEW_TEXT_笔" bundle="${bundle}"/>）</font></c:if>

                                </c:otherwise>
                            </c:choose>
                        </td>                        
                    </c:forEach>
                </tbody>
            </table>
            <%--Set page jump base url --%>
            <c:choose>
                <c:when test="${'EVENT'==collectionType}">
                    <c:set value="/collect/list/event" var="pageBaseUrl" scope="page"/>
                </c:when>
                <c:when test="${'DONATION'==collectionType}">
                    <c:set value="/collect/list/donation" var="pageBaseUrl" scope="page"/>
                </c:when>
                <c:when test="${'SERVICE'==collectionType}">
                    <c:set value="/collect/list/service" var="pageBaseUrl" scope="page"/>
                </c:when>
                <c:when test="${'PRODUCT'==collectionType}">
                    <c:set value="/collect/list/product" var="pageBaseUrl" scope="page"/>
                </c:when>
                <c:when test="${'MEMBER'==collectionType}">
                    <c:set value="/collect/list/member" var="pageBaseUrl" scope="page"/>
                </c:when>
            </c:choose>

            <jsp:include page="/WEB-INF/public/z_paging.jsp">
                <jsp:param name="baseUrl" value="${pageBaseUrl}" />
                <jsp:param name="totalCount" value="${fundCollectionList.getTotalCount()}" />
                <jsp:param name="maxPerPage" value="${fundCollectionList.getMaxPerPage()}" />
                <jsp:param name="pageIndex" value="${fundCollectionList.getPageIndex()}" />
            </jsp:include>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
