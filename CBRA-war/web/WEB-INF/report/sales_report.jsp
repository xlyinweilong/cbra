<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : sales_report
    Created on : Apr 17, 2012, 3:11:33 PM
    Author     : Yin.Weilong
    应用于销售报告页面,提供显示
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
request.setAttribute("mainMenuSelection", "SALES_REPORT");
request.setAttribute("subMenuSelection", "");
%>
<%@include file="/WEB-INF/report/z_header.jsp"%>
<style type="text/css">
    .history_table tbody tr.boldred td {font-weight:bold;background-color:#cccccc;}
    .history_table tbody tr.boldlightred td {font-weight:bold;}
</style>
<jsp:include page="/WEB-INF/report/z_date_form.jsp">
    <jsp:param name="action" value="/report/sales_report" />
    <jsp:param name="title" value="销售报告：" />
</jsp:include>
<div class="admin-content">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
        <tr class="boldred">
            <td>活动总数</td><td>${SalesReportTotal['times']}</td><td><a href="/report/sales_report?start=<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>&end=<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>&a=DOWNLOAD_SALES_REPORT">下载CSV文件</a></td><td></td>
        </tr>
        <tr class="boldlightred">
            <td>售出票数</td><td>${SalesReportTotal['totalguests']}</td><td>购买次数</td><td>${SalesReportTotal['totalorders']}</td>
        </tr>
        <tr class="boldred">
            <td>人民币总收入</td><td>${SalesReportTotal['cny_payment_total']}</td><td>美元总收入</td><td>${SalesReportTotal['usd_payment_total']}</td>
        </tr>
    </table>
</div>
<br/>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty requestScope.SalesReport}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr><td>主办方</td><td>活动名称</td><td>费率</td><td>售出票数</td><td>购买次数</td><td>人民币收入总额</td><td>美元收入总额</td></tr>
                </thead>
                <tbody>
                    <c:forEach var="report" items="${requestScope.SalesReport}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if> >
                            <td>${report.event_host}</td>
                            <td><a href="${report.web_id}">${report.title}</a></td>
                            <td>${report.withdraw_rate}</td>
                            <td>${report.guests}</td>
                            <td>${report.orders}</td>
                            <td>${report.cny_payment_total}</td>
                            <td>${report.usd_payment_total}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/report/z_paging.jsp">
                    <jsp:param name="totalCount" value="${requestScope.SalesReport.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${requestScope.SalesReport.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${requestScope.SalesReport.getPageIndex()}" />
                </jsp:include>
            </div>
            <br/>

        </c:when>
        <c:otherwise>
        </c:otherwise>
    </c:choose>
</div>
<script>
    $( "#startDate" ).datepicker();
    $( "#startDate" ).datepicker("option", "dateFormat", "yy-mm-dd");
    $( "#endDate" ).datepicker();
    $( "#endDate" ).datepicker("option", "dateFormat", "yy-mm-dd");
    $( "#startDate" ).val($('#start').val());
    $( "#endDate" ).val($('#end').val());
</script>
<jsp:include page="/WEB-INF/report/z_footer.jsp"/>