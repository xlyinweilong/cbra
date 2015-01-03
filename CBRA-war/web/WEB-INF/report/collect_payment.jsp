<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    request.setAttribute("mainMenuSelection", "COLLECT_PAYMENT");
    request.setAttribute("subMenuSelection", "");
%>
<%@include file="/WEB-INF/report/z_header.jsp"%>
<jsp:include page="/WEB-INF/report/z_date_form.jsp">
    <jsp:param name="action" value="/report/collect_payment" />
    <jsp:param name="title" value="收款到账：" />
</jsp:include>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty orderCollectionSubList}">                
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr>
                        <td colspan="11" align="left">
                            已收款：<fmt:formatNumber value="${cny}" type="currency"  pattern="￥#,##0.##"  />&nbsp;
                <fmt:formatNumber value="${usd}" type="currency"  pattern="$#,##0.##"  />
                <a  style="float:right" href="/report/collect_payment?start=<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>&end=<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>&a=DOWNLOAD_COLLECTION_PAYMENT_QUERY">下载CSV文件</a>
                </td></tr>
                <tr>
                    <td>收款时间</td>
                    <td>收款人</td>
                    <td>类型</td>
                    <td>收款金额</td>
                    <td>付款金额</td>
                    <td>付款方式</td>
                    <td>活动URL</td>
                    <td>活动详情</td>
                    <td>已收数目</td>
                    <td>付款时间</td>
                    <td>付款人</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="orderCollectionSub" items="${orderCollectionSubList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                    <td><fmt:formatDate value='${orderCollectionSub.fundCollection.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    <td>${orderCollectionSub.fundCollection.ownerUser.name}</br>(${orderCollectionSub.fundCollection.ownerUser.email})</td>
                    <td>${orderCollectionSub.fundCollection.type}</td>
                    <td>
                    <c:choose>
                        <c:when test="${orderCollectionSub.fundCollection.unitAmountType == 'FIXED'}"><fmt:formatNumber value="${orderCollectionSub.fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${orderCollectionSub.fundCollection.currencySign}" /></c:when>
                        <c:when test="${orderCollectionSub.fundCollection.unitAmountType == 'MINIMAL'}">最少<fmt:formatNumber value="${orderCollectionSub.fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${orderCollectionSub.fundCollection.currencySign}" /></c:when>
                        <c:when test="${orderCollectionSub.fundCollection.unitAmountType == 'FREEWILL'}">由捐款者自定</c:when>
                        <c:when test="${orderCollectionSub.fundCollection.unitAmountType == 'SUGGEST'}">建议<fmt:formatNumber value="${orderCollectionSub.fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${orderCollectionSub.fundCollection.currencySign}" /></c:when>
                        <c:when test="${orderCollectionSub.fundCollection.unitAmountType == 'MULTIPLE'}">
                            <c:forEach var="price" items="${orderCollectionSub.fundCollection.getAvailableFundCollectionPriceListAndNoRepeatPrice()}" varStatus="status">
                                <p>
                                <fmt:formatNumber value="${price.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${price.currencySign}" />
                                </p>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    </td>
                    <td><fmt:formatNumber value="${orderCollectionSub.parentOrderCollection.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${orderCollectionSub.fundCollection.currencySign}" /></td>
                    <td>${orderCollectionSub.parentOrderCollection.lastGatewayPayment.source}<br/>${orderCollectionSub.parentOrderCollection.lastGatewayPayment.gatewayType}</td>
                    <td><a href="/pay/${orderCollectionSub.fundCollection.webId}">${orderCollectionSub.fundCollection.webId}</a></td>
                    <td><c:if test="${reportAccountPermit.collectInformationPermit}"><a href="/report/collect_information/${orderCollectionSub.fundCollection.webId}"></c:if>查看详情</td>
                    <td>
                    <c:choose>
                        <c:when test="${orderCollectionSub.fundCollection.paymentAmountCNY>0}">
                            ￥${orderCollectionSub.fundCollection.paymentAmountCNY} &nbsp; 共${orderCollectionSub.fundCollection.paidCountCNY}笔<br />
                        </c:when>
                        <c:when test="${orderCollectionSub.fundCollection.paymentAmountUSD>0}">
                            $ ${orderCollectionSub.fundCollection.paymentAmountUSD}&nbsp;共${orderCollectionSub.fundCollection.paidCountUSD}笔<br />
                        </c:when>
                        <c:otherwise>
                            &nbsp;共${orderCollectionSub.fundCollection.paidCountCNY + orderCollectionSub.fundCollection.paidCountUSD}笔<br />
                        </c:otherwise>
                    </c:choose>
                    </td>
                    <td><fmt:formatDate value='${orderCollectionSub.parentOrderCollection.endDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    <td>${orderCollectionSub.parentOrderCollection.owner.name}</br>(${orderCollectionSub.parentOrderCollection.owner.email})</td>                    
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/report/z_paging.jsp">
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
<jsp:include page="/WEB-INF/report/z_footer.jsp"/>