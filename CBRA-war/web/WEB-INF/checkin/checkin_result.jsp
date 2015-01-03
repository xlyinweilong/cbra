<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : checkin_result
    Created on : Nov 14, 2012, 6:45:06 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<input type="hidden" id="checkin_result_flag" value="${result}" />
<div <c:choose>
        <c:when test="${result == 'success'}">id="ok"</c:when>
        <c:when test="${result == 'invalid' || result == 'noTicket'}">id="wrong"</c:when>
        <c:when test="${result == 'checked'}">id="Repeat"</c:when>
    </c:choose>>
    <div class="header">
        <c:choose>
            <c:when test="${result == 'success'}"><img src="/images/checkin/ok.gif" width="91" height="91" />成功签到<br/><span>门票ID:${fundPaymentTicket.barcode}</span></div><input type="hidden" id="update_checked_ticket_account" value="${updateCheckedTicketAccount}"/></c:when>
            <c:when test="${result == 'invalid'}"><img src="/images/checkin/wrong.jpg" width="86" height="86" />门票已作废<br/><span>门票ID:${fundPaymentTicket.barcode}</span></div></c:when>
            <c:when test="${result == 'noTicket'}"><img src="/images/checkin/wrong.jpg" width="86" height="86" />门票不存在<br/><span>门票ID:${ticketBarcode}</span></div></c:when>
            <c:when test="${result == 'checked'}"><img src="/images/checkin/repeat.jpg" width="86" height="86" />重复签到<br/><span>门票ID:${fundPaymentTicket.barcode}</span></div></c:when>
        </c:choose>
        <c:if test="${result == 'checked' || result == 'invalid' || result == 'success'}">
            <div class="body">
                <ul>
                    <li><span>姓名：</span>${registerPersonalInfo.name  == null ? userAccount.name:registerPersonalInfo.name}</li>
                    <li class="right"><span>票种：</span>${fundPaymentTicket.priceName == null ? fundPaymentTicket.fundCollectionPrice.name:fundPaymentTicket.priceName}</li>
                    <li><span>公司：</span>${registerPersonalInfo.company == null ? userAccount.company:registerPersonalInfo.company}</li>
                    <li class="right"><span>职位：</span>${registerPersonalInfo.position == null ? userAccount.position:registerPersonalInfo.position}</li>
                    <li><span>手机：</span>${registerPersonalInfo.mobilePhone == null ? userAccount.mobilePhone:registerPersonalInfo.mobilePhone}</li>
                    <li class="right"><span>邮箱：</span>${registerPersonalInfo.email == null ? userAccount.email:registerPersonalInfo.email}</li>
                </ul>
                <br class="clear">
                <c:set value="0" var="index"></c:set>
                <c:forEach var="question" items="${registerQuestions}">
                    <p> 
                        <span>${question.title}：</span> 
                        <span>${RegisterQuestionAnswers[index]}</span>
                    <c:set value="${index+1}" var="index"></c:set>
                    </p>
                </c:forEach>
            </div>
        </c:if>
    </div>
