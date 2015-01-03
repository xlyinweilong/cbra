<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : feedback_message
    Created on : Jul 13, 2012, 11:08:49 AM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%
    request.setAttribute("mainMenuSelection", "FEEDBACK");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<c:if test="${postResult.success}">
    <h3 class="nolist">
        ${postResult.singleSuccessMsg}
    </h3>
</c:if>

<c:if test="${!empty postResult.singleErrorMsg}">
    <h3 class="nolist">
        ${postResult.singleErrorMsg}
    </h3>
</c:if>
<h3>${feedbackMessage}</h3>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
