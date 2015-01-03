<%-- 
    Document   : paypal
    Created on : Mar 11, 2011, 10:51:35 AM
    Author     : WangShuai
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*,cc.hengzhi.paygate.*,cn.yoopay.Config,cn.yoopay.support.Tools,cn.yoopay.entity.GatewayPayment"%> 
<%
    GatewayPayment payment = (GatewayPayment) request.getAttribute("gatewayPayment");
    String gatewayPaymentSource = payment.getSource().toString();
    pageContext.setAttribute("gatewayPaymentSource", gatewayPaymentSource);
%>
<c:choose>
    <c:when test="${not empty gatewayPaymentSource && gatewayPaymentSource eq 'SOURCE_WIDGET'}">
        <jsp:include page="/WEB-INF/public/z_header_widget.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${success}">
        <div style="text-align: center"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/> <img src="/images/032.gif" width="100" height="9" /> </div>
        </c:when>
        <c:otherwise>
            ${gatewayPayment.paymentGatewayMsg}
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${not empty gatewayPaymentSource && gatewayPaymentSource eq 'SOURCE_WIDGET'}">
            <jsp:include page="/WEB-INF/public/z_footer_widget.jsp"/>
        <script type="text/javascript">
            window.onload = function(){
                top.location.href = "${rUrl}" ;
            }
            
        </script>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/public/z_footer.jsp"/>
        <script type="text/javascript">
            window.onload = function(){
                window.location.href = "${rUrl}" ;
            }
        </script>
        <%@include file="/WEB-INF/public/z_footer_close.html" %> 
    </c:otherwise>
</c:choose>