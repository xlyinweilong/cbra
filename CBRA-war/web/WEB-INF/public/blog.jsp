<%-- 
    Document   : blog
    Created on : Nov 30, 2012, 4:52:19 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>
<div class="aboutus_right">
    <c:choose>
        <c:when test="${not empty articleList}"> 
            <c:forEach var="article" items="${articleList}" varStatus="status">
                <span class="aboutus_h3" style="width:600px">${article.title}</span><span style="float: right"><fmt:formatDate value='${article.createDate}' type='date' pattern='yyyy/MM/dd' /></span>
                <p style="margin-top: 10px;line-height: 2">${article.content}</p>
                <div class="aboutus_blank"/></div>
            </c:forEach>
        </c:when>
        <c:otherwise>
        Coming Soon
    </c:otherwise>
</c:choose>

</div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
