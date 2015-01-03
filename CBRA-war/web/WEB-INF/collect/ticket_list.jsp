
<%-- 
    Document   : collect_detail
    Created on : Apr 10, 2011, 8:01:46 PM
    Author     : HUXIAOFENG
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%pageContext.setAttribute("newLineChar", "\n");%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>

    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="TICKETLIST"/>
            </jsp:include> 
        </div>

        <c:choose>
            <c:when test="${empty ticketList}">
                <h3 class="nolist"><fmt:message key="GLOBAL_MSG_BLANK_LIST" bundle="${bundle}"/></h3>
            </c:when>
            <c:otherwise>
                <div id="detail_payment_list" class="FloatLeft" style="padding-right:50px;">
                    <div class="PaymentListHeader">
                        <span id="no_pay_count" style="display:none">${noPaidCount}</span>
                        <div>
                            <form id="search_form">
                                <strong><fmt:message key='COLLECT_TICKET_门票搜索' bundle='${bundle}'/></strong>&nbsp;<input type="text" size="50" onfocus="FundPaymentTicket.hideTextDefaultMsg()" onblur="FundPaymentTicket.showTextDefaultMsg()" style="color:#999999;" name="" value="<fmt:message key='COLLECT_DETAIL_LABEL_TEXT_搜索灰字' bundle='${bundle}'/>" id="search_input"/>
                                <%-- 名单下载的链接 --%>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <a class="" href="javascript:void(0);" title="" onclick="Collect.downloadTicketList(${ticketList.size()},'${fundCollection.webId}');return false;">
                                    <fmt:message key="COLLECT_DETAIL_LINK_下载报名人名单" bundle="${bundle}"/>
                                </a>
                                <span class="FloatRight" id="ticket_list_down_msg" style="color: red;display: none" ></span>
                            </form>
                        </div> 
                        <div class="clear"></div>
                    </div>

                    <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table " id="ticket_list_table">
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
                        <td><fmt:message key='COLLECT_DETAIL_LABEL_渠道码' bundle='${bundle}'/></td>
                        <c:forEach var="question" items="${registerQuestions}">
                            <td>${question.title}</td>
                        </c:forEach>
                        </tr> 
                        </thead>
                        <tbody>
                        <c:set value="0" var="index"></c:set>  
                        <c:forEach var="ticket" items="${ticketList}" varStatus="status"> 
                            <c:set value="${ticket.orderCollectionSub}" var="subOrder"></c:set>
                            <c:set value="${index+1}" var="index"></c:set>  
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
                            <td>
                                ${subOrder.referralCode}
                            </td>
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

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
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
                $.uiTableFilter(ticketListTable, this.value );
            }
        });

    });
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
