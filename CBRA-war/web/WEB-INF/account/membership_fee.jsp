<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp" />
        <jsp:include page="/WEB-INF/account/z_account_banner.jsp" />
        <!-- 主体 -->
        <div class="mc-main">
            <table width="1000" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="fl-nav">
                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="2" /></jsp:include>
                        </td>
                        <td valign="top" class="fr-c-1">
                            <div class="tit-cz"><fmt:message key="GLOBAL_会费" bundle="${bundle}"/><input type="button" class="anniu" value="缴纳会费" onclick="location.href = '/account/pay_membership'" ></div>
                            <c:choose>
                                <c:when test="${empty resultList}">
                                <table width="760" border="0" cellspacing="0" cellpadding="0" style=" margin:20px auto;">
                                    <tr>
                                        <td width="120" height="40"><h3 class="nolist"><fmt:message key="GLOBAL_暂无信息" bundle="${bundle}"/></h3></td>
                                    </tr>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <form id="form1" action="/account/membership_fee" method="post">
                                    <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
                                    <table width="760" border="0" cellspacing="1" cellpadding="0" class="biaog" >
                                        <tr>
                                            <td width="120" height="42" bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_日期" bundle="${bundle}"/></strong></td>
                                            <td bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_缴纳方式" bundle="${bundle}"/></strong></td>
                                            <td width="200" bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_筑誉确认" bundle="${bundle}"/></strong></td>
                                        </tr>
                                        <c:forEach var="order" items="${resultList}" varStatus="varStatus">
                                            <tr>
                                                <td height="30" bgcolor="#FFFFFF" class="biaog-bt"><fmt:formatDate value='${order.createDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' /></td>
                                                <td bgcolor="#FFFFFF" class="biaog-bt">
                                                    <c:choose>
                                                        <c:when test="${order.lastGatewayPayment.gatewayType == 'ALIPAY'}"><fmt:message key="GLOBAL_支付宝" bundle="${bundle}"/></c:when>
                                                        <c:when test="${order.lastGatewayPayment.gatewayType == 'BANK_TRANSFER'}"><fmt:message key="GLOBAL_其他支付方式" bundle="${bundle}"/></c:when>
                                                        <c:when test="${order.lastGatewayPayment.gatewayType == 'UNIONPAY'}"><fmt:message key="GLOBAL_银联在线" bundle="${bundle}"/></c:when>
                                                    </c:choose>
                                                </td>
                                                <td bgcolor="#FFFFFF" class="biaog-bt">
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PENDING_PAYMENT'}"><span class="luz"><fmt:message key="GLOBAL_待支付" bundle="${bundle}"/></span></c:when>
                                                        <c:when test="${order.status == 'SUCCESS'}"><span class="luz"><fmt:message key="GLOBAL_已到帐" bundle="${bundle}"/></span></c:when>
                                                        <c:when test="${order.status == 'FAILURE' || order.status == 'INVALID'}"><span class="hongz"><fmt:message key="GLOBAL_失败" bundle="${bundle}"/></span></c:when>
                                                        <c:otherwise><span class="chengz"><fmt:message key="GLOBAL_确认中" bundle="${bundle}"/></span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                    <jsp:include page="/WEB-INF/public/z_paging.jsp">
                                        <jsp:param name="totalCount" value="${resultList.getTotalCount()}" />
                                        <jsp:param name="maxPerPage" value="${resultList.getMaxPerPage()}" />
                                        <jsp:param name="pageIndex" value="${resultList.getPageIndex()}" />
                                    </jsp:include>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>