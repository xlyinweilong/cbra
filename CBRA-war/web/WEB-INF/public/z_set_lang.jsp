<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
<fmt:setBundle basename="message" scope="session" var="bundle"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div>
    <div title="ajaxReturn" style="display:none">${postResult.success}</div>
</div>