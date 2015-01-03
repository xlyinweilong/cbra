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
    request.setAttribute("mainMenuSelection", "REG_REPORT");
    request.setAttribute("subMenuSelection", "");
%>
<%@include file="/WEB-INF/report/z_header.jsp"%>       
<jsp:include page="/WEB-INF/report/z_date_form.jsp">
    <jsp:param name="action" value="/report/reg" />
    <jsp:param name="title" value="注册：" />
</jsp:include>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty userList}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr><td>时间</td><td>姓名</td><td>Email</td></tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if> >
                            <td><fmt:formatDate value='${user.enableDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td>${user.name}</td><td>${user.email}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/report/z_paging.jsp">
                    <jsp:param name="totalCount" value="${userList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${userList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${userList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/report/z_footer.jsp"/>
