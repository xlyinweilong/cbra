<%-- 
    Document   : home
    Created on : Mar 29, 2011, 11:12:27 AM
    Author     : HUXIAOFENG
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_REG_INFO);
%>
<%-- 设置MenuSelection参数结束 --%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="collect_money_box2"> 
    <h3 class="nolist">
        <c:choose>
            <c:when test="${postResult.success}">
                ${postResult.singleSuccessMsg}
            </c:when>
            <c:otherwise> ${postResult.singleErrorMsg}</c:otherwise>
        </c:choose>
    </h3>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
