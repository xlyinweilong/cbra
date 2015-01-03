<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : widget
    Created on : Jul 27, 2012, 12:37:32 PM
    Author     : Li.Ning
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>

<div class="aboutus_right">
<fmt:message key="PUBLIC_WIDGET_TEXT_什么是友付微件" bundle="${bundle}"/>
</div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
