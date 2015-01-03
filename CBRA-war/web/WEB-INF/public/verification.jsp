<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : about
    Created on : Apr 29, 2011, 2:14:21 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>
<div class="aboutus_right">    
    <fmt:message key="PUBLIC_VERIFICATION_TEXT" bundle="${bundle}"/>
</div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
