<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : collect_list
    Created on : Apr 10, 2011, 8:01:36 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.TICKET);
%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:choose>
    <c:when test="${empty ticketList}"><h3 class="nolist">
            ${postResult.singleErrorMsg}</h3>
        </c:when>
        <c:otherwise>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
            <thead>
                <tr>
                    <td width="10%"><fmt:message key='ACCOUNT_TICKET_时间' bundle='${bundle}'/></td>
                    <td width="39%"><fmt:message key='ACCOUNT_TICKET_活动名称' bundle='${bundle}'/></td>
                    <td width="18%"><fmt:message key='ACCOUNT_TICKET_票种' bundle='${bundle}'/></td>
                    <td width="9%"><fmt:message key='ACCOUNT_TICKET_票价' bundle='${bundle}'/></td>
                    <td width="11%">&nbsp;</td>
                    <td width="13%">&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ticket" items="${ticketList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                        <td><fmt:formatDate value="${ticket.fundCollection.eventBeginDate}" pattern="yyyy.MM.dd" type="date" dateStyle="long" /></td>
                        <td> <a href='/pay/${ticket.fundCollection.webId}'> ${ticket.fundCollection.title}</a></td>
                        <td>${ticket.fundCollectionPrice.name}</td>
                        <td><fmt:formatNumber value="${ticket.fundCollectionPrice.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${ticket.fundCollectionPrice.currencySign}" /></td>
                        <td>
                            <div class="FloatRight" id="edit_loading_${ticket.id}" style="display:none"><img src="/images/025.gif"></div><div class="Abutton FloatLeft"><a href="#" onclick="attendeeEditDialog.loadDialog(${ticket.id});return false;"><fmt:message key="ACCOUNT_TICKET_编辑" bundle="${bundle}"/></a></div>
                        </td>
                        <td class="Abutton">
                            <a href="/account/ticket_download/${ticket.id}"  target="_blank" ><fmt:message key="ACCOUNT_OVERVIEW_LABEL_下载门票" bundle="${bundle}"/></a>
                        </td>

                    </c:forEach>
            </tbody>
        </table>

        <jsp:include page="/WEB-INF/public/z_paging.jsp">
            <jsp:param name="baseUrl" value="/account/ticket" />
            <jsp:param name="totalCount" value="${ticketList.getTotalCount()}" />
            <jsp:param name="maxPerPage" value="${ticketList.getMaxPerPage()}" />
            <jsp:param name="pageIndex" value="${ticketList.getPageIndex()}" />
        </jsp:include>

    </c:otherwise>
</c:choose>
<div id="attendeeEditDialog" style="display:none;">  
    <div id="attendeeEditDialogContent">
        <%-- Ajax display ticket attendee info --%>
    </div>
</div>
<div id="ticket_error" style="display:none">
    <fmt:message key='ACCOUNT_TICKET_票未能生成，请及时与管理员联系' bundle='${bundle}'/><br/>
    <input  class="collection_button FloatRight" type="button" value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="TicketError.close();"/>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
