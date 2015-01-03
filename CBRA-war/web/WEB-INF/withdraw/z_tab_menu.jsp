<%-- 
    Document   : z_tab_menu
    Created on : Oct 26, 2011, 2:56:46 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="DetailHeader" style="margin-top: 0px;">
    <ul id="detail_tab">
        <li <c:if test="${param.menu_highlight eq 'create'}">class="nowpage"</c:if>><a href="/withdraw/create"><fmt:message key='GLOBAL_MENU_WITHDRAW_CREATE' bundle='${bundle}'/></a></li>
        <li <c:if test="${param.menu_highlight eq 'manager'}">class="nowpage"</c:if>><a href="/withdraw/manager"><fmt:message key='GLOBAL_MENU_WITHDRAW_ACCOUNT_CREATE' bundle='${bundle}'/></a></li>
        <li <c:if test="${param.menu_highlight eq 'list'}">class="nowpage"</c:if>><a href="/withdraw/list"><fmt:message key='GLOBAL_MENU_WITHDRAW_ACCOUNT_LIST' bundle='${bundle}'/></a></li>
<!--        <li <c:if test="${param.menu_highlight eq 'rate'}">class="nowpage"</c:if>><a href="/withdraw/rate"><fmt:message key='GLOBAL_MENU_WITHDRAW_ACCOUNT_费用优惠' bundle='${bundle}'/></a></li>-->
    </ul>
</div>
