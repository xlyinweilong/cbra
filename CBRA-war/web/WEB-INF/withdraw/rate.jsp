<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : rate
    Created on : Aug 2, 2011, 3:30:55 PM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDWITHDRAW);
%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/withdraw/z_tab_menu.jsp">
    <jsp:param name="menu_highlight" value="rate"/>
</jsp:include>
<c:choose>
    <c:when test="${empty rateList}">
        <h3 class="nolist"><fmt:message key='WITHDRAW_ACCOUNT_LIST_MSG_列表为空' bundle='${bundle}'/></h3>
    </c:when>
    <c:otherwise>
<!--        <div class="successMessage MarginBottom20 Padding1020"> 
            <fmt:message key='WITHDRAW_RATE_友付提供4种优惠套餐计划' bundle='${bundle}'/>
        </div>
        <table class="history_table" width="100%" cellspacing="0" cellpadding="0" border="0" widtd="100%">
            <thead>
                <tr>
                    <td width="20%"><fmt:message key='WITHDRAW_RATE_LABEL_套餐种类' bundle='${bundle}'/></td>
                    <td width="19%"> <fmt:message key='WITHDRAW_RATE_LABEL_预付金额' bundle='${bundle}'/></td>
                    <td width="17%"><fmt:message key='WITHDRAW_RATE_LABEL_包额度' bundle='${bundle}'/></td>
                    <td width="14%"><fmt:message key='WITHDRAW_RATE_LABEL_额度内提款费用' bundle='${bundle}'/></td>
                    <td width="14%"><fmt:message key='WITHDRAW_RATE_LABEL_超出额度提款费率' bundle='${bundle}'/></td>
                    <td width="15%"><fmt:message key='WITHDRAW_RATE_LABEL_操作' bundle='${bundle}'/></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="rate" items="${rateList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                        <td id="rate_name_${rate.id}">
                            <c:choose>
                                <c:when test="${status.count==1}">
                                    <fmt:message key='WITHDRAW_RATE_TABLE_TEXT_套餐一' bundle='${bundle}'/>
                                </c:when>
                                <c:when test="${status.count==2}">
                                    <fmt:message key='WITHDRAW_RATE_TABLE_TEXT_套餐二' bundle='${bundle}'/>
                                </c:when>
                                <c:when test="${status.count==3}">
                                    <fmt:message key='WITHDRAW_RATE_TABLE_TEXT_套餐三' bundle='${bundle}'/>
                                </c:when>
                                <c:when test="${status.count==4}">
                                    <fmt:message key='WITHDRAW_RATE_TABLE_TEXT_套餐四' bundle='${bundle}'/>
                                </c:when>
                                <c:when test="${status.count==5}">
                                    <fmt:message key='WITHDRAW_RATE_TABLE_TEXT_套餐五' bundle='${bundle}'/>
                                </c:when>
                                <c:otherwise>
                                    套餐
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatNumber value="${rate.prepaidAmount}" type="number"  pattern="#,##0.##"/> <fmt:message key='GLOBAL_元/年' bundle='${bundle}'/></td>
                        <td><fmt:formatNumber value="${rate.volumeBalance}" type="number"  pattern="#,##0.##"/> <fmt:message key='GLOBAL_元/年' bundle='${bundle}'/></td> 
                        <td>0%</td>           
                        <td>2.6%</td>
                        <td>
                            <input class="account_input" type="button"  value="<fmt:message key='WITHDRAW_RATE_BUTTON_选择此套餐' bundle='${bundle}'/>" onclick="Withdraw.jumpToPayment(${rate.id},'${forwardUrl}')">
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>-->
        <div class="MarginTop10 bold"><fmt:message key='WITHDRAW_RATE_TEXT_如果您有更高额度需求' bundle='${bundle}'/></div>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
