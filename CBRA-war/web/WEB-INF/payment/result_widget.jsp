<%-- 
    Document   : result_widget
    Created on : Feb 6, 2012, 2:12:27 PM
    Author     : Swang
--%>
<%--Note ： Now is only for event payment--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header_widget.jsp"/>
<div class="container">
    <%@include file="/WEB-INF/payment/z_result_event.jsp" %>
</div>
<script type="text/javascript">
    $(document).ready(
    function(){
        var gatewayPaymentId = ${gatewayPayment.id};
        $("#ticket_download_href").click(function(){
            FundPaymentTicket.downloadForPayment(gatewayPaymentId);
        });
        var statusDetection = ${statusDetection != null ? true : false};
        if(statusDetection) {
            $("#result_progressbar").progressbar({
                value: 10
            });
            FundPayment.detectCount = 0;
            FundPayment.detectResult(gatewayPaymentId);
        }
    }); 
</script>
<jsp:include page="/WEB-INF/public/z_footer_widget.jsp"/>
