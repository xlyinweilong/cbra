<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : payment_due_list
    Created on : Apr 10, 2011, 8:18:10 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDWITHDRAW);
%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/withdraw/z_tab_menu.jsp">
    <jsp:param name="menu_highlight" value="list"/>
</jsp:include>
<c:choose>
    <c:when test="${empty withdrawAccounts}">
        <h3 class="nolist"><fmt:message key='WITHDRAW_ACCOUNT_LIST_MSG_列表为空' bundle='${bundle}'/></h3>
    </c:when>
    <c:otherwise>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table" widtd="100%">
            <thead>
                <tr>
                    <td width="25%"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_名称" bundle="${bundle}"/></td>
                    <td width="15%"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_类别" bundle="${bundle}"/></td> 
                    <td width="45%"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_账户信息" bundle="${bundle}"/></td>
                    <td width="15%"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_操作" bundle="${bundle}"/></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="withdrawAccount" items="${withdrawAccounts}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                        <td>${withdrawAccount.name}</td>
                        <c:choose>
                            <c:when test="${withdrawAccount.type=='ALIPAY'}">
                                <td><fmt:message key='WITHDRAW_ACCOUNT_TEXT_TYPE_支付宝' bundle='${bundle}'/></td>
                                <td>${withdrawAccount.alipayAccount}</td>  
                            </c:when>
                            <c:when test="${withdrawAccount.type=='PAYPAL'}">
                                <td class="record_dd2">PAYPAL</td>
                                <td class="withdrawal_dd">${withdrawAccount.payPalAccount}</td>  
                            </c:when>
                            <c:when test="${withdrawAccount.type=='BANK'}">
                                <td class="record_dd2"><fmt:message key='WITHDRAW_ACCOUNT_TEXT_TYPE_国内银行' bundle='${bundle}'/></td>
                                <td class="withdrawal_dd">${withdrawAccount.bankAccountNumber}</td>  
                            </c:when>
                            <c:when test="${withdrawAccount.type=='CREDITCARD'}">
                                <td><fmt:message key='WITHDRAW_ACCOUNT_LABEL_信用卡账户' bundle='${bundle}'/></td>
                                <td>${withdrawAccount.creditCardNumber}</td>  
                            </c:when>
                            <c:when test="${withdrawAccount.type=='INT_BANK'}">
                                <td><fmt:message key='WITHDRAW_ACCOUNT_LABEL_国外银行' bundle='${bundle}'/></td>
                                <td>${withdrawAccount.intBankAccountNumber}</td>  
                            </c:when>
                        </c:choose>
                        <td>
                            <input class="account_input" value="<fmt:message key='WITHDRAW_ACCOUNT_LINK_编辑' bundle='${bundle}'/>" name="Submit" type="button" onclick="redirect('/withdraw/list/${withdrawAccount.id}/update')"/>
                            <input class="account_input" value="<fmt:message key='WITHDRAW_ACCOUNT_LINK_删除' bundle='${bundle}'/>" name="Submit" type="button" onclick="Withdraw.deleteWithdrawAccount(${withdrawAccount.id});"/>
                    </tr>
                </c:forEach>  
            </tbody>
        </table>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
