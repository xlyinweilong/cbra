<%-- 
    Document   : z_api_tab_menu
    Created on : Dec 26, 2012, 4:15:31 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="DetailHeader" style="margin-top: 0px;">
    <ul id="detail_tab">
        <li <c:if test="${param.menu_highlight eq 'app_key'}">class="nowpage"</c:if>><a href="/ypservice/api_app_key"><fmt:message key='GLOBAL_MENU_YPSERVICE_API_KEY' bundle='${bundle}'/></a></li>
        <li <c:if test="${param.menu_highlight eq 'allow_ip_list'}">class="nowpage"</c:if>><a href="/ypservice/api_allow_ip_list"><fmt:message key='GLOBAL_MENU_YPSERVICE_API_IP地址列表' bundle='${bundle}'/></a></li>
        <li <c:if test="${param.menu_highlight eq 'return_url'}">class="nowpage"</c:if>><a href="/ypservice/api_return_url"><fmt:message key='GLOBAL_MENU_YPSERVICE_API_回调URL' bundle='${bundle}'/></a></li>
    </ul>
</div>
