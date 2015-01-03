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

    <h3 class="aboutus_h3 MarginTop0"><fmt:message key="PUBLIC_RATES_LABEL_友付交易费用" bundle="${bundle}"/></h3>
    <fmt:message key="PUBLIC_WIDGET_TEXT_费率" bundle="${bundle}"/>
   
</div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
