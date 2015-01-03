<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%-- 
    Document   : index
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "FEEDBACK");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/feedback" />
    <jsp:param name="title" value="意见和建议：" />
</jsp:include>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty feedbackList}">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr><td>时间</td><td>姓名</td><td>Email</td><td>Subject</td><td>Message</td></tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedbackList}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                            <td><fmt:formatDate value='${feedback.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${feedback.user.id}"></c:if>${feedback.user.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                            <td>${feedback.user.email}</td>
                            <td>${feedback.subject}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:length(feedback.message)>50}">
                                        <a href="/support/feedback_message/${feedback.id}">
                                            ${fn:substring(feedback.message,0,50)}......
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        ${feedback.message}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${feedbackList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${feedbackList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${feedbackList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>