<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "WITHDRAW");
    request.setAttribute("subMenuSelection", "WITHDRAW_PROCESSED");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/processed_withdraw" />
    <jsp:param name="title" value="已处理提款记录：" />
</jsp:include>
<div>
    <c:choose>
        <c:when test="${not empty withdrawList}"> 
            <div style="text-align: right; font-size:16px;"><b>已处理提款总额：${withdrawProcessedAmount}</b></div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr>
                        <td>时间</td><td>姓名</td><td>Email</td><td>金额</td>
                        <td>账户名称</td><td>账户信息</td><td>处理时间</td><td>备注</td></tr>                        
                </thead>
                <tbody>
                <c:forEach var="withdraw" items="${withdrawList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                    <td><fmt:formatDate value='${withdraw.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${withdraw.owner.id}"></c:if>${withdraw.owner.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                    <td>${withdraw.owner.email}</td>
                    <td>${withdraw.amount}</td>
                    

                    <td>${withdraw.withdrawAccount.name}</td>
                    <td>
                    <c:if test="${withdraw.withdrawAccount.type=='ALIPAY'}">
                        支付宝账号：${withdraw.withdrawAccount.alipayAccount}
                    </c:if>
                    <c:if test="${withdraw.withdrawAccount.type=='CREDITCARD'}">
                        类别：国内信用卡<br/>
                        姓名：${withdraw.withdrawAccount.creditCardHolder}<br/>
                        开户行名称：${withdraw.withdrawAccount.creditCardBankName}<br/>
                        支行名称：${withdraw.withdrawAccount.creditCardBankBranch}<br/>
                        卡号：${withdraw.withdrawAccount.creditCardNumber}
                    </c:if>
                    <c:if test="${withdraw.withdrawAccount.type=='BANK'}">
                        姓名：${withdraw.withdrawAccount.bankUserName}
                        银行名称：${withdraw.withdrawAccount.bankName}
                        支行名称：${withdraw.withdrawAccount.bankBranch}
                        银行卡号：${withdraw.withdrawAccount.bankAccountNumber}
                    </c:if>
                    <c:if test="${withdraw.withdrawAccount.type=='PAYPAL'}">
                        PALPAY账号：${withdraw.withdrawAccount.payPalAccount}
                    </c:if>
                    <c:if test="${withdraw.withdrawAccount.type=='INT_BANK'}">
                        类型：国外银行
                        姓名：${withdraw.withdrawAccount.intBankUserName}
                        开户人地址：${withdraw.withdrawAccount.intBankUserAddress}
                        开户行：${withdraw.withdrawAccount.intBankName}
                        账户号码：${withdraw.withdrawAccount.intBankAccountNumber}
                        开户行地址：${withdraw.withdrawAccount.intBankAddress}
                        TransitNumber：${withdraw.withdrawAccount.intBankTransitNumber}
                        SwiftCode：${withdraw.withdrawAccount.intBankSwiftCode}
                    </c:if>
                    </td>
                    <td><fmt:formatDate value='${withdraw.endDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    <td>${withdraw.adminRemarks}</td>
                    </tr>
                </c:forEach>
                </body>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${withdrawList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${withdrawList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${withdrawList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
