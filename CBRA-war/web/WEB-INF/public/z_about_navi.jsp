<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_about_navi
    Created on : Jul 20, 2012, 1:06:02 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pathInfo", request.getRequestURI());
%>
<div class="aboutus_left">
    <dl>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/about.jsp'}">class="active"</c:if>><a href="/public/about" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_关于友付" bundle="${bundle}"/></a></dd> 
        <dd <c:if test="${pathInfo=='/WEB-INF/public/user.jsp'}">class="active"</c:if>><a href="/public/user" title=""><fmt:message key="PULIC_Z_FOOTER_TEXT_用户评价" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/alliance.jsp'}">class="active"</c:if>><a href="/public/alliance" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_活动云平台" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/widget.jsp'}">class="active"</c:if>><a href="/public/widget" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_友付微件" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/api.jsp'}">class="active"</c:if>><a href="/public/api" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_友付API" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/faq.jsp'}">class="active"</c:if>><a href="/public/faq" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_常见问题" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/campaign.jsp'}">class="active"</c:if>><a href="/public/campaign" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_支付方式" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/verification.jsp'}">class="active"</c:if>><a href="/public/verification" title=""><fmt:message key="GLOBAL_MENU_ACCOUNT_SEAL" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/rates.jsp'}">class="active"</c:if>><a href="/public/rates" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_友付费率" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/promotion.jsp'}">class="active"</c:if>><a href="/public/promotion" title=""><fmt:message key="PUBLIC_PROMOTION_TEXT_活动营销" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/legal.jsp'}">class="active"</c:if>><a href="/public/legal" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_法律声明" bundle="${bundle}"/></a></dd>
        <dd <c:if test="${pathInfo=='/WEB-INF/public/contact.jsp'}">class="active"</c:if>><a href="/public/contact" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_联系友付" bundle="${bundle}"/></a></dd>

        <%--<dd <c:if test="${pathInfo=='/WEB-INF/public/blog.jsp'}">class="active"</c:if>><a href="/public/blog" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_友付博客" bundle="${bundle}"/></a></dd>--%>
    </dl>
</div>