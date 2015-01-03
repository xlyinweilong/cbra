<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
<fmt:setBundle basename="message" scope="session" var="bundle"/>
<%-- 
    Document   : z_login_dialog
    Created on : Apr 20, 2011, 7:01:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div>
    <div title="ajaxReturn" style="display:none"></div>
</div>