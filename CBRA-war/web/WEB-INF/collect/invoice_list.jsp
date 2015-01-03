<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : collect_detail
    Created on : Apr 10, 2011, 8:01:46 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>

    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="INVOICELIST"/>
            </jsp:include> 
        </div>
        <div id="detail_invoice">
            <c:choose>
                <c:when test="${empty orderListWithInvoice||orderListWithInvoice.size()==0}">
                    <h3 class="nolist"><fmt:message key="GLOBAL_MSG_BLANK_LIST" bundle="${bundle}"/></h3>
                </c:when>
                <c:otherwise>
                    <div class="PaymentListHeader">
                        <div class="FloatLeft text16 bold">
                            <span class="MarginR10">
                                <fmt:message key='COLLECT_INVOICE_发票总计' bundle='${bundle}'> 
                                    <fmt:param value="${orderListWithInvoice.size()}"></fmt:param>
                                </fmt:message>
                            </span>
                        </div>
                        <div class="FloatRight"> 
                            <a href="javascript:void(0);" title=""  onclick="Collect.downloadInvoiceList(${orderListWithInvoice.size()},'${fundCollection.webId}');return false;">
                                <fmt:message key='COLLECT_DETAIL_LABEL_下载发票列表' bundle='${bundle}'/>
                            </a>
                            <span id="collect_invoice_download" style="color: red;display: none" ></span>
                        </div> 
                        <div class="clear"></div>
                    </div> 
                    <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="history_table">
                        <thead>  
                            <tr>
                                <td width="7%"><fmt:message key='COLLECT_DETAIL_LABEL_已付金额' bundle='${bundle}'/></td>
                        <td width="20%"><fmt:message key='COLLECT_INOVICE_发票抬头' bundle='${bundle}'/></td> 
                        <td width="10%"><fmt:message key='COLLECT_INOVICE_收件人' bundle='${bundle}'/></td> 
                        <td width="8%"><fmt:message key='COLLECT_INOVICE_电话' bundle='${bundle}'/></td>
                        <td width="20%"><fmt:message key='COLLECT_INOVICE_地址' bundle='${bundle}'/></td>
                        <td width="19%"><fmt:message key='COLLECT_INOVICE_省市' bundle='${bundle}'/></td>
                        <td width="7%"><fmt:message key='COLLECT_INOVICE_邮编' bundle='${bundle}'/></td>
                        <td width="8%"><fmt:message key='COLLECT_INOVICE_开票者' bundle='${bundle}'/></td>
                        </tr> 
                        </thead>
                        <tbody>
                        <c:forEach var="order" items="${orderListWithInvoice}" varStatus="status"> 
                            <c:set var="invoice" value="${order.parentOrderCollection.userInvoice}"></c:set>
                            <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                            <td>
                            <fmt:formatNumber value="${order.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${order.parentOrderCollection.currencySign}" />
                            </td>
                            <td>
                                ${invoice.invoiceTitle}
                            </td>
                            <td>
                                ${invoice.recipientName}
                            </td>
                            <td>
                                ${invoice.recipientPhone}
                            </td>
                            <td>
                                ${invoice.recipientAddress}
                            </td>
                            <td>
                                ${invoice.recipientProvince}
                            </td>
                            <td>
                                ${invoice.recipientPostcode}
                            </td>
                            <td>
                            <c:choose>
                                <c:when test="${order.invoiceStatus == 'YOOPAY_UN_PROCESSED'||order.invoiceStatus == 'YOOPAY_PROCESSED'}">
                                    <fmt:message key='COLLECT_INOVICE_友付' bundle='${bundle}'/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key='COLLECT_INOVICE_主办方' bundle='${bundle}'/>
                                </c:otherwise>
                            </c:choose>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>    
                </c:otherwise>
            </c:choose>

        </div>
    </div>            
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    $(document).ready(
    function(){
        //upload logo tooltip
        UserLogo.initToolTips();
    });   
</script>

<%@include file="/WEB-INF/public/z_footer_close.html" %> 
