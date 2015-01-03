<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 
    Document   : sigunp_select
    Created on : Jul 9, 2012, 1:03:56 PM
    Author     : Li.Ning
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="signup_select">
    <fmt:message key='SIGNUP_SELECT_个会议及活动' bundle='${bundle}'/>
    </div>

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 