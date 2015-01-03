<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
    Document   : search
    Created on : Nov 15, 2012, 12:39:10 PM
    Author     : Yin.Weilong
--%>

<%
    request.setAttribute("mainMenuSelection", "SEARCH");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%pageContext.setAttribute("newLineChar", "\n");%>
<jsp:include page="/WEB-INF/checkin/z_header.jsp"/>
<style type="text/css">
    .highlight {font-weight:bold;background-color:#FFFF00;}
</style>
<div class="BlueBox">
    <input type="hidden" id="checkin_webId" value="${fundCollection.webId}" />
    <c:choose>
        <c:when test="${empty ticketList}">
            <h3 class="nolist"><fmt:message key="GLOBAL_MSG_BLANK_LIST" bundle="${bundle}"/></h3>
        </c:when>
        <c:otherwise>
            <div id="detail_payment_list">
                <div <%--class="PaymentListHeader"--%>>
                    <span id="no_pay_count" style="display:none">${noPaidCount}</span>
                    <div>
                        <form id="search_form">
                            <fmt:message key='COLLECT_TICKET_门票搜索' bundle='${bundle}'/>：<input type="text" size="35" onfocus="FundPaymentTicket.hideTextDefaultMsg()" onblur="FundPaymentTicket.showTextDefaultMsg()" style="color:#999999;" name="" value="<fmt:message key='COLLECT_DETAIL_LABEL_TEXT_搜索灰字' bundle='${bundle}'/>" value="" autocomplete="off" id="search_input"/>
                            <select style="float:right" id="checkin_select" onchange="Checkin.checkinSelectOnchange('${fundCollection.webId}');">
                                <option value=""  <c:if test="${empty selectflag}">selected="selected"</c:if> >显示全部</option>
                                <option value="true" <c:if test="${not empty selectflag && selectflag}">selected="selected"</c:if> >显示已经签到</option>
                                <option value="false" <c:if test="${not empty selectflag && !selectflag}">selected="selected"</c:if> ><span>显示未签到</option>
                            </select>
                        </form>
                    </div>
                    <div class="clear"></div>
                </div>
                            <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table" style="margin-top:10px" id="ticket_list_table">
                    <thead>   
                        <tr>
                            <td><fmt:message key='COLLECT_LIST_LABEL_DATE' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_门票ID' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_门票种类' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_姓名' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_公司' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_职务' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_手机' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_邮箱' bundle='${bundle}'/></td>
                    <%--<td><fmt:message key='COLLECT_DETAIL_LABEL_渠道码' bundle='${bundle}'/></td>--%>
                    <c:forEach var="question" items="${registerQuestions}">
                        <td>${question.title}</td>
                    </c:forEach>
                    <td>操作</td>
                    <%--<td>取消签到</td>--%>
                    </tr> 
                    </thead>
                    <tbody>
                    <c:set  var="index" value="0"></c:set>  
                    <c:forEach var="ticket" items="${ticketList}" varStatus="status"> 
                        <c:set value="${ticket.orderCollectionSub}" var="subOrder"></c:set>
                        <c:set var="index" value="${index+1}"></c:set> 
                        <tr <c:if test="${index%2!=0}">class="white"</c:if>>
                        <td>
                        <fmt:formatDate value="${subOrder.parentOrderCollection.endDate}" pattern="yyyy.MM.dd HH:mm" type="date" dateStyle="long" />
                        </td>
                        <td>
                            ${ticket.barcode}
                        </td>
                        <td>
                            ${ticket.fundCollectionPrice.name}
                        </td>
                        <td>${registerInfo[ticket.id][0]}</td>
                        <td>
                            ${registerInfo[ticket.id][1]}
                        </td>
                        <td>
                            ${registerInfo[ticket.id][2]}
                        </td>
                        <td>
                            ${registerInfo[ticket.id][3]}
                        </td>
                        <td>
                            ${registerInfo[ticket.id][4]}
                        </td>
                        <%--<td>
                            ${subOrder.referralCode}
                        </td>--%>
                        <%-- 
                        <c:if test="${registerQuestions.size()>0}">
                            <c:forEach var="num" begin="0" end="${registerQuestions.size()-1}" step="1">
                                <td>
                                    ${fn:replace(registerAnswer[ticket.id][num], newLineChar, "<br/>")}
                                </td>
                            </c:forEach>
                        </c:if>
                        --%>
                        <c:if test="${registerQuestions.size()>0}">
                            <c:forEach var="rquestion" items="${registerQuestions}" varStatus="status"> 
                                <td>
                                    ${fn:replace(registerAnswer[ticket.id][rquestion.id], newLineChar, "<br/>")}
                                </td>
                            </c:forEach>
                        </c:if>
                        <td>
                        <input id="checkin_on_${ticket.barcode}" type="button" <c:if test="${ticket.checkin}">style="display:none"</c:if> onclick="Checkin.doCheckin('${ticket.barcode}','true')" value="签到" />
                        <a id="checkin_off_${ticket.barcode}" <c:if test="${!ticket.checkin}">style="display:none"</c:if> href="javascript:Checkin.doCheckin('${ticket.barcode}','false')">取消签到</a>
                        </td>
                        <%--<td><input id="checkin_off_${ticket.barcode}" type="button" <c:if test="${!ticket.checkin}">class="gray" disabled="disabled"</c:if> onclick="Checkin.doCheckin('${ticket.barcode}','false')" value="取消签到" /></td>--%>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>  
                <div style="margin-top: 10px;text-align: center;"><span id="show_all_tickets_span" style="display: none"><a href="javascript:void(0);" id="show_all_tickets_btn" onclick="FundPaymentTicket.showAllTicketList();"><fmt:message key='COLLECT_TICKET_显示所有门票' bundle='${bundle}'/></a></span></div>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="clear"></div>           
</div>            
</div>

<jsp:include page="/WEB-INF/checkin/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(
    function(){
        var ticketListTable = $('#ticket_list_table')
        var showAllTicketsSpan = $("#show_all_tickets_span");
        var lastTime = new Date().getTime();
        $("#search_input").keyup(function() {
            var now = new Date().getTime();
            if(now - lastTime > 50 || this.value == "") {
                lastTime = now;
                if($('#search_input').val() == ''){
                    showAllTicketsSpan.css("display","none"); 
                }else{
                    showAllTicketsSpan.css("display",""); 
                }
                ticketListTable.removeHighlight();
                $.uiTableFilter(ticketListTable, this.value);
            } 
        });
    });   
</script>
