<%-- 
    Document   : api
    Created on : Jan 11, 2013, 10:11:27 AM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>
<div class="aboutus_right">

<fmt:message key="PUBLIC_API_TEXT" bundle="${bundle}"/>

</div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
