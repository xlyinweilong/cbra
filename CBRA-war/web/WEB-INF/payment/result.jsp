<%-- 
    Document   : result
    Created on : Apr 18, 2011, 8:37:21 PM
    Author     : WangShuai
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:choose>
    <c:when test="${fundCollection.type == 'EVENT'}">
        <c:set var="bannerUrl" value="${fundCollection.getEventBannerUrl()}"></c:set>
        <%--活动标题、时间、地点和创建人Logo --%>
        <%--页面上方 --%>
        <c:choose>
            <c:when test="${!fundCollection.showInfoOnBanner && bannerUrl != null}">
                <div>
                    <img src="${bannerUrl}" width="960" />
                </div>
            </c:when>
            <c:otherwise>
                <div  <c:if test="${bannerUrl != null}">class="EventTitleBg" style="background-image: url('${bannerUrl}')"</c:if>>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="EventTitle">
                        <tr>
                            <td width="690" align="left" valign="bottom"  >
                                <div class="text24 bold">
                                    ${fundCollection.title}    
                                </div> 
                                <div class="text16">
                                    <div>
                                        ${eventDateDesc} 
                                    </div>
                                    <div>
                                        <c:choose>
                                            <c:when test="${not empty fundCollection.eventLocation}">
                                                ${fundCollection.eventLocation}
                                            </c:when>
                                            <c:otherwise>
                                                &nbsp;
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </td>
                            <td align="right" valign="bottom">
                                <div class="photo_1">
                                    <c:choose>
                                        <c:when test="${not empty fundCollection.ownerUser.logoUrl}">
                                            <img src="${fundCollection.ownerUser.logoUrl}" width="250"/>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
        <%--页面下方 --%>
        <div>
            <%--页面左下方 --%>
            <div class="FloatLeft MarginTop10" style=" width: 690px;">
                <%@include file="/WEB-INF/payment/z_result_event.jsp" %>
                <div class="clear"></div>
            </div>
            <%--页面左下方：活动时间和地点以及地图 --%>
            <div class="FloatRight MarginTop10" style="width: 250px;">
                <div  class="active_box">
                    <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_时间地点" bundle="${bundle}"/></div>
                    <div class="map">
                        <c:if test="${fundCollection.getEventMapUrl()!=null}">   
                            <div>
                                <a href="${fundCollection.getEventMapUrl()}" target="_blank"><img style=" width: 210px;" src="${fundCollection.getEventMapUrl()}"/></a>
                            </div>
                        </c:if>
                        <p>
                        <c:choose>
                            <c:when test="${not empty fundCollection.eventLocation}">
                                ${fundCollection.eventLocation}
                            </c:when>
                            <c:otherwise>
                                &nbsp;
                            </c:otherwise>
                        </c:choose>
                        </p>
                        <p>${eventDateDesc} </p>
                    </div>
                </div>
                <div  class="active_box">
                    <div class="money_sail"><fmt:message key="PAYMENT_DETAIL_LABEL_主办方" bundle="${bundle}"/></div>
                    <div class="map">
                        <h1>
                            ${fundCollection.eventHost}
                        </h1>
                        <input value="<fmt:message key='PAYMENT_DETAIL_LABEL_联系主办方' bundle="${bundle}"/>" class="collection_button_giay MarginBottom5" type="button" onclick="ContactHostDialog.open();">
                               <p>${fundCollection.eventHostDesc}</p>
                    </div>
                </div>
            </div>
            <div class="clear"></div>

        </div>
        <%----------------------------------------Dialog -------------------------------%>
        <div id="contactHostDialog" style="display:none">        
            <%@include  file="/WEB-INF/payment/z_contact_host.jsp"%>
        </div>
        <div id="contactHostSuccessDialog" style="display:none">        
            <fmt:message key="PAYMENT_DETAIL_LABEL_您的信息已成功发出" bundle="${bundle}"/><br>
            <p class="TextAlignRight"><input type="button" class="collection_button" onclick="ContactHostSuccessDialog.close()" value="<fmt:message key="GLOBAL_关闭" bundle="${bundle}"/>">
            </p>
        </div>

    </c:when>
    <c:otherwise>
        <%@include file="/WEB-INF/payment/z_result_service_product_member.jsp"%> 
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(
    function(){
        var type = "${fundCollection.type}";
        var gatewayPaymentId = ${gatewayPayment.id};
        if(type == "EVENT") {
            $("#ticket_download_href").click(function(){
                FundPaymentTicket.downloadForPayment(gatewayPaymentId);
            });
        }
  
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
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
