<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : contact
    Created on : May 4, 2011, 4:13:00 PM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>
<div class="aboutus_right">
    <fmt:message key="PUBLIC_CONTACT_TEXT" bundle="${bundle}"/>
</div>
<div class="clear"></div> 

<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
