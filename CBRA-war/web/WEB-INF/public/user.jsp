<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : campaign
    Created on : Apr 29, 2011, 2:23:47 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>
<div class="aboutus_right">
    <ul class="User">
    <fmt:message key="PULIC_USER_TEXT_友付让活动规模翻倍" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付帮助大型活动的报名注册" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付解决了收取" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付使用起来非常简单" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付支持多种门票" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_不花一分钱" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付帮助提前确认" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付支持活动邀请码" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付支持门票团购" bundle="${bundle}"/>
    <fmt:message key="PULIC_USER_TEXT_友付支持中英文" bundle="${bundle}"/>
</ul>
</div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
