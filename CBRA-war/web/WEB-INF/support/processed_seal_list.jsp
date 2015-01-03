<%-- 
    Document   : processed_seal_list
    Created on : May 27, 2011, 4:03:27 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "SEAL");
    request.setAttribute("subMenuSelection", "SEAL_PROCESSED");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/processed_seal_list" />
    <jsp:param name="title" value="已处理实名认证：" />
</jsp:include>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty sealList}">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead><tr>
                    <td>认证时间</td>
                    <td>时间</td>
                    <td>账户类型</td>
                    <td>认证名</td>
                    <td>认证状态</td>
                    <td>操作</td>
                </tr> </thead>                       
                <c:forEach var="seal" items="${sealList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                        <td><fmt:formatDate value='${seal.processDate}'type='date' pattern='yyyy.MM.dd'/></td>
                        <td><fmt:formatDate value='${seal.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                        <td>
                            <c:choose>
                                <c:when test="${seal.user.accountType == 'USER'}">个人</c:when>
                                <c:otherwise>公司</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${seal.userName}${seal.companyName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${seal.processStatus == 'PENDING'}">认证中</c:when>
                                <c:when test="${seal.processStatus == 'REJECT'}">认证拒绝</c:when>
                                <c:when test="${seal.processStatus == 'APPROVE'}">认证通过</c:when>
                                <c:when test="${seal.processStatus == 'APPROVE_OLD'}">认证通过(旧认证)</c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </td>
                        <td><a href="/support/detail_seal/${seal.id}">详细信息</a></td>
                    </tr>
                </c:forEach>
                </body>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${sealList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${sealList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${sealList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
