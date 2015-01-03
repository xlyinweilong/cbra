<%-- 
    Document   : errorPage
    Created on : Apr 2, 2011, 11:19:40 AM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="collect_money_box2"> 
    <h3 class="nolist">
        <c:choose>
            <c:when test="${postResult.success}">
                ${postResult.singleSuccessMsg}
            </c:when>
            <c:otherwise> ${postResult.singleErrorMsg}</c:otherwise>
        </c:choose>
    </h3>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
