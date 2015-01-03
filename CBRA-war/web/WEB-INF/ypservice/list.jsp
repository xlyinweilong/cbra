<%-- 
    Document   : list
    Created on : Sep 11, 2012, 10:54:11 AM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.YOOPAY_SERVICE);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<table class="Rates_table" summary="Submitted table designs">
    <fmt:message key="YPSERVICE_LIST_说明_HEAD" bundle="${bundle}"/>
    <tr style="height: 60px">
        <th width="31%"><span>&nbsp;</span></th>
        <td class="td1" width="23%">&nbsp;</td>
        <td class="td2" width="23%">
            <c:choose>
                <c:when test="${not empty status1}">
                    <fmt:message key="YP_SERVICE_已购买" bundle="${bundle}"/><c:if test="${not empty status1.endDate}">,<fmt:message key="YP_SERVICE_有效期至" bundle="${bundle}"/><fmt:formatDate value="${status1.endDate}" type="date" pattern="yyyy.MM.dd"/>
                        <br /><a href="/ypservice/pay/standard"><b><fmt:message key="YP_SERVICE_延长有效期" bundle="${bundle}"/></b></a>
                    </c:if>
                </c:when>
                <c:otherwise><input type="submit" name="Submit" value="<fmt:message key="YP_SERVICE_购买" bundle="${bundle}"/>" class="ypservice_input" onclick="location.href='/ypservice/pay/standard'"></c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty status2}">
                    <fmt:message key="YP_SERVICE_已购买" bundle="${bundle}"/><c:if test="${not empty status2.endDate}">,<fmt:message key="YP_SERVICE_有效期至" bundle="${bundle}"/><fmt:formatDate value="${status2.endDate}" type="date" pattern="yyyy.MM.dd"/>
                        <br /><a href="/ypservice/pay/professional"><b><fmt:message key="YP_SERVICE_延长有效期" bundle="${bundle}"/></b></a>
                    </c:if>
                </c:when>
                <c:otherwise><input type="submit" name="Submit" value="<fmt:message key="YP_SERVICE_购买" bundle="${bundle}"/>" class="ypservice_input" onclick="location.href='/ypservice/pay/professional'"></c:otherwise>
            </c:choose>
        </td>
    </tr>
    <fmt:message key="YPSERVICE_LIST_说明_BODY" bundle="${bundle}"/>
    <tr class="borderline" style="height: 60px">
        <th width="31%"><span>&nbsp;</span></th>
        <td class="td1" width="23%">&nbsp;</td>
        <td class="td2" width="23%">
            <c:choose>
                <c:when test="${not empty status1}">
                    <fmt:message key="YP_SERVICE_已购买" bundle="${bundle}"/><c:if test="${not empty status1.endDate}">,<fmt:message key="YP_SERVICE_有效期至" bundle="${bundle}"/><fmt:formatDate value="${status1.endDate}" type="date" pattern="yyyy.MM.dd"/>
                        <br /><a href="/ypservice/pay/standard"><b><fmt:message key="YP_SERVICE_延长有效期" bundle="${bundle}"/></b></a>
                    </c:if>
                </c:when>
                <c:otherwise><input type="submit" name="Submit" value="<fmt:message key="YP_SERVICE_购买" bundle="${bundle}"/>" class="ypservice_input" onclick="location.href='/ypservice/pay/standard'"></c:otherwise>
            </c:choose>
        </td>
        <td> 
            <c:choose>
                <c:when test="${not empty status2}">
                    <fmt:message key="YP_SERVICE_已购买" bundle="${bundle}"/><c:if test="${not empty status2.endDate}">,<fmt:message key="YP_SERVICE_有效期至" bundle="${bundle}"/><fmt:formatDate value="${status2.endDate}" type="date" pattern="yyyy.MM.dd"/>
                        <br /><a href="/ypservice/pay/professional"><b><fmt:message key="YP_SERVICE_延长有效期" bundle="${bundle}"/></b></a>
                    </c:if>
                </c:when>
                <c:otherwise><input type="submit" name="Submit" value="<fmt:message key="YP_SERVICE_购买" bundle="${bundle}"/>" class="ypservice_input" onclick="location.href='/ypservice/pay/professional'"></c:otherwise>
            </c:choose>
        </td>
    </tr>

</table>

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
