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
        <form id="form1" action="/account/my_event" method="post">
            <input type="hidden" id="page_num" name="page" value="${resultList.getPageIndex()}" />
            <div class="mc-main">
                <table width="1000" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" class="fl-nav">
                            <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="3" /></jsp:include>
                            </td>
                            <td valign="top" class="fr-c-1">
                                <div class="tit-cz"><fmt:message key="GLOBAL_参与的活动" bundle="${bundle}"/></div>
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
                                                <td width="120" height="42" bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_活动主题" bundle="${bundle}"/></strong></td>
                                                <td bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_活动日期" bundle="${bundle}"/></strong></td>
                                                <td bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_地点" bundle="${bundle}"/></strong></td>
                                                <td bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_费用" bundle="${bundle}"/></strong></td>
                                                <td bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_报名状态" bundle="${bundle}"/></strong></td>
                                                <td width="200" bgcolor="efefef" class="biaog-bt"><strong><fmt:message key="GLOBAL_活动状态" bundle="${bundle}"/></strong></td>
                                            </tr>
                                            <c:forEach var="order" items="${resultList}" varStatus="varStatus">
                                                <tr>
                                                    <td height="30" <c:choose><c:when test="${status.count%2==0}">bgcolor="#FFFFFF"</c:when><c:otherwise>bgcolor="#f8f8f8"</c:otherwise></c:choose> class="biaog-bt">${order.fundCollection.title}</td>
                                                    <td <c:choose><c:when test="${status.count%2==0}">bgcolor="#FFFFFF"</c:when><c:otherwise>bgcolor="#f8f8f8"</c:otherwise></c:choose> class="biaog-bt"><fmt:formatDate value='${order.fundCollection.eventBeginDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' /></td>
                                                    <td <c:choose><c:when test="${status.count%2==0}">bgcolor="#FFFFFF"</c:when><c:otherwise>bgcolor="#f8f8f8"</c:otherwise></c:choose> class="biaog-bt">${order.fundCollection.eventLocation}</td>
                                                    <td <c:choose><c:when test="${status.count%2==0}">bgcolor="#FFFFFF"</c:when><c:otherwise>bgcolor="#f8f8f8"</c:otherwise></c:choose> class="biaog-bt">${order.amount}</td>
                                                    <td <c:choose><c:when test="${status.count%2==0}">bgcolor="#FFFFFF"</c:when><c:otherwise>bgcolor="#f8f8f8"</c:otherwise></c:choose> class="biaog-bt"><c:choose><c:when test="${order.status == 'SUCCESS'}"><fmt:message key="GLOBAL_已支付" bundle="${bundle}"/></c:when><c:otherwise><fmt:message key="GLOBAL_已报名" bundle="${bundle}"/></c:otherwise></c:choose></td>
                                                    <td <c:choose><c:when test="${status.count%2==0}">bgcolor="#FFFFFF"</c:when><c:otherwise>bgcolor="#f8f8f8"</c:otherwise></c:choose> class="biaog-bt"><span <c:choose><c:when test="${order.fundCollection.statusBoolean}">class="luz"</c:when><c:otherwise>class="chengz"</c:otherwise></c:choose>>${order.fundCollection.status}</span></td>
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
        </form>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
