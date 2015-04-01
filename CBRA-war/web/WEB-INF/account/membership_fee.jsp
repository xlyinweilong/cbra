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
                        <c:if test="${sessionScope.userStatus == 'ASSOCIATE_MEMBER'}">
                            <div class="tit-cz">会　费<input type="button" class="anniu" value="缴纳会费" onclick="location.href = '/account/pay_membership'" ></div>
                            </c:if>
                            <c:choose>
                                <c:when test="${empty resultList}">
                                <table width="760" border="0" cellspacing="0" cellpadding="0" style=" margin:20px auto;">
                                    <tr>
                                        <td width="120" height="40"><h3 class="nolist">暂无信息</h3></td>
                                    </tr>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <form id="form1" action="/account/membership_fee" method="post">
                                    <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
                                    <table width="760" border="0" cellspacing="1" cellpadding="0" class="biaog" >
                                        <tr>
                                            <td width="120" height="42" bgcolor="efefef" class="biaog-bt"><strong>日期</strong></td>
                                            <td bgcolor="efefef" class="biaog-bt"><strong>缴纳方式</strong></td>
                                            <td width="200" bgcolor="efefef" class="biaog-bt"><strong>筑誉确认</strong></td>
                                        </tr>
                                        <c:forEach var="order" items="${resultList}" varStatus="varStatus">
                                            <tr>
                                                <td height="30" bgcolor="#FFFFFF" class="biaog-bt"><fmt:formatDate value='${order.createDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' /></td>
                                                <td bgcolor="#FFFFFF" class="biaog-bt">
                                                    <c:choose>
                                                        <c:when test="${order.lastGatewayPayment.gatewayType == 'ALIPAY'}">支付宝</c:when>
                                                        <c:when test="${order.lastGatewayPayment.gatewayType == 'BANK_TRANSFER'}">其他支付方式</c:when>
                                                    </c:choose>
                                                </td>
                                                <td bgcolor="#FFFFFF" class="biaog-bt">
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PENDING_PAYMENT'}"><span class="luz">待支付</span></c:when>
                                                        <c:when test="${order.status == 'SUCCESS'}"><span class="luz">已到帐</span></c:when>
                                                        <c:when test="${order.status == 'FAILURE' || order.status == 'INVALID'}"><span class="hongz">失败</span></c:when>
                                                        <c:otherwise><span class="chengz">确认中</span></c:otherwise>
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