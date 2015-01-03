<%-- 
    Document   : z_calendar_menu
    Created on : Jan 16, 2013, 2:50:53 PM
    Author     : Yin.Weilong
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<ul id="detail_tab">
    <li id="tab_edit" <c:if test="${param.menuType=='WIDGET'}">class="nowpage"</c:if>><a href="/calendar/widget"><fmt:message key='COLLECT_CALENDAR_TITLE_我的活动日历' bundle='${bundle}'/></a></li>
<li <c:if test="${param.menuType=='EDIT'}">class="nowpage"</c:if>><a href="/calendar/edit"><fmt:message key='COLLECT_CALENDAR_TITLE_日历引用' bundle='${bundle}'/></a></li>
</ul>
